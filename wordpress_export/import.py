##############################################################################
# Pelican Markdown importer
#
# This script fixes Markdown files so they may be safely imported into Pelican
# structures.
#
# Those Markdown files should be generated from Wordpress XML export via
# command:
#
#   $ pelican-import --wpfile export.xml -o output -m markdown
#
# Usage:
#
#   In order to import Markdown files from "output" directory use following
#   command:
#
#   $ python import.py --src_dir=output --trg_dir=fixed
#
##############################################################################


import os.path
import click
import fnmatch
import re
import urllib
from retry import retry
from PIL import Image

@click.command()
@click.option(
    '--src_dir',
    default='output',
    prompt='Plz enter source directory path (with md files exported from XML)',
    help='Directory with Markdown files exported from Wordpress [default: '
         'output]'
)
@click.option(
    '--trg_dir',
    default='fixed',
    prompt='Plz enter directory where to save fixed files',
    help='Directory where to save fixed files [default: fixed]'
)
@click.option(
    '--overwrite/--no-overwrite',
    default=False,
    help='If you wanna overwrite already existing files [default: overwrite]'
)
@click.option(
    '--img_width',
    default=0,
    help='If specified all downloaded images embeded in given blogpost will be '
         'resized to this width [default: 0 - no resize]'
)
def import_files(src_dir, trg_dir, overwrite, img_width):
    importer = Importer(src_dir, trg_dir, overwrite, img_width)
    importer.fix_files()


class Importer(object):
    __filtered_files = []

    def __init__(self, src_dir, trg_dir, overwrite, img_width):
        self.src_dir = os.path.join(os.getcwd(), src_dir)
        self.trg_dir = os.path.join(os.getcwd(), trg_dir)
        self.overwrite = overwrite
        self.img_width = img_width

    def fix_files(self):
        self.__sanitize_trg_dir()
        self.__sanitize_src_dir()
        for root, dirs, files in os.walk(self.src_dir):
            for _file in files:
                if fnmatch.fnmatch(_file, '*.md'):
                    self.__parse_file_and_save_output(
                        src_file_path=os.path.join(root, _file),
                        file_name=os.path.join(self.trg_dir, _file)
                    )
                else:
                    self.__filtered_files.append(_file)
                # break   # testing on 1 file for now

        if len(self.__filtered_files) > 0:
            print('Filtered (not fixed) files: {0}'.
                  format(self.__filtered_files))

    def __parse_file_and_save_output(self, src_file_path, file_name):
        try:
            with open(src_file_path, 'r') as src_file_handler:
                # we don't assume too large files here, no need for generators:
                content = src_file_handler.readlines()

                # read year from metadata - we'll use it later for target
                # directory
                [year, content] = self.__fix_file_content(content)

                # strip unused tags: <!--:-->
                content = [re.sub('<!--:-->', '', x) for x in content]

                # remove PL versions (yup, let's use EN only):
                content = ''.join(content)
                if '<!--:pl-->' in content:
                    content = content[:content.index('<!--:pl-->')]

                # finally remove that unused EN tags <!--:en-->
                content = re.sub('<!--:en-->', '', content)

                # todo: fetching and saving images to image content directory
                img_urls = re.findall('(maciek.lasyk.info/sysop/wp-content/uploads/[^)|^\s]+)', content)
                self.fetch_and_resize_images(img_urls)
                # todo: resizing images
                # todo: fixing images Markdown tags

                content = re.sub('{.aligncenter', '', content)
                content = re.sub('height="\d+"}', '', content)
                content = re.sub("\n.size-medium .wp-image-(\d+) width=\"(\d+)\"\n", '', content)
                if not re.search('^Summary:', content):
                    content = re.sub(
                        "\nCategory: ",
                        "\nSummary: .\nCategory: ",
                        content
                    )

                try:
                    with open(
                            os.path.join(self.trg_dir, file_name), "w"
                    ) as trg_file_handler:
                        trg_file_handler.write(''.join(content))
                except IOError:
                    self.__filtered_files.append(file_name)
                    print(os.path.join(self.trg_dir, file_name))
                    pass

        except IOError:
            self.__filtered_files.append(file_name)
            pass

    def fetch_and_resize_images(self, img_urls):
        for url in img_urls:
            filename = url.split('/')[-1]
            filepath = os.path.join(self.trg_dir, 'images', filename)
            # download image only when it doesn't exist:
            if not os.path.exists(filepath):
                self.get_image('http://' + url, filepath)

            # resize images to given width:
            if self.img_width is not 0:
                self.resize_image(filepath)

    def resize_image(self, file):
        try:
            with Image.open(file) as img:
                # don't resize when there's no such need:
                if img.size[0] != self.img_width:
                    print("Resizing {0} from {1} to {2}\n".format(
                        file, img.size[0], self.img_width)
                    )
                    wpercent = (self.img_width / float(img.size[0]))
                    hsize = int((float(img.size[1]) * float(wpercent)))
                    img = img.resize((self.img_width, hsize), Image.ANTIALIAS)
                    img.save(file)
        except IOError:
            print("Can't open {0} for resize!".format(file))
            pass

    @retry(Exception, tries=5, delay=3, backoff=2)
    def get_image(self, img_url, path):
        try:
            print("Fetching image {0} to {1}\n".format(img_url, path))
            urllib.urlretrieve(img_url, path)
        except:
            return False

        return True

    @staticmethod
    def __fix_file_content(content):
        new_content = []
        # year should be in file, if not let's guess it's 2016 ;)
        year = 2016
        for line in content:
            # Get Year from Date tag:
            result = re.findall("^Date: ([0-9]{4})", line)
            if result:
                year = result[0]
            new_content.append(line)

        return [year, new_content]

    def __sanitize_trg_dir(self):
        if os.path.exists(self.trg_dir):
            if not self.overwrite:
                if len(os.listdir(self.trg_dir)) > 0:
                    exit('Target directory exists and is not empty, plz remove'
                         ' or empty it manually: {0}'.format(self.trg_dir))
        else:
            try:
                os.mkdir(self.trg_dir)
            except Exception as e:  # nopep8 generic exception here for a reason
                exit('Couldn\'t create target directory {0}: {1}'
                     .format(self.trg_dir, e))
            try:
                os.mkdir(os.path.join(self.trg_dir, 'images'))
            except Exception as e:  # nopep8 generic exception here for a reason
                exit('Couldn\'t create image directory {0}: {1}'
                     .format(self.trg_dir, e))

    def __sanitize_src_dir(self):
        if os.path.exists(self.src_dir):
            if len(os.listdir(self.src_dir)) == 0:
                exit('Source directory {0} is empty! It should consists of '
                     'Markdown files (see documentation for pelican-import)'
                     .format(self.src_dir))
        else:
            exit('Source directory {0} doesn\'t exist or is inaccesible!'.
                 format(self.src_dir))


if __name__ == '__main__':
    import_files()
