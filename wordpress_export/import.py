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


@click.command()
@click.option(
    '--src_dir',
    default='output',
    prompt='Plz enter source directory path (with md files exported from XML)',
    help='Directory with Markdown files exported from Wordpress'
)
@click.option(
    '--trg_dir',
    default='fixed',
    prompt='Plz enter directory where to save fixed files',
    help='Directory where to save fixed files'
)
def import_files(src_dir, trg_dir):
    importer = Importer(src_dir, trg_dir)
    importer.fix_files()


class Importer(object):
    __filtered_files = []

    def __init__(self, src_dir, trg_dir):
        self.src_dir = os.path.join(os.getcwd(), src_dir)
        self.trg_dir = os.path.join(os.getcwd(), trg_dir)

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
                break   # testing on 1 file for now

        if len(self.__filtered_files) > 0:
            print('Filtered (not fixed) files: {0}'.
                  format(self.__filtered_files))

    def __parse_file_and_save_output(self, src_file_path, file_name):
        try:
            with open(src_file_path, 'r') as src_file_handler:
                # we don't assume too large files here, no need for generators:
                content = src_file_handler.readlines()
                [year, fixed_content] = self.__fix_file_content(content)
                try:
                    with open(
                            os.path.join(self.trg_dir, file_name), "w"
                    ) as trg_file_handler:
                        trg_file_handler.write(fixed_content)
                        # TODO writing data to file
                except IOError:
                    self.__filtered_files.append(file_name)
                    print(os.path.join(self.trg_dir, file_name))
                    pass

        except IOError:
            self.__filtered_files.append(file_name)
            pass

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
            if len(os.listdir(self.trg_dir)) > 0:
                exit('Target directory exists and is not empty, plz remove or '
                     'empty it manually: {0}'.format(self.trg_dir))
        else:
            try:
                os.mkdir(self.trg_dir)
            except Exception as e:  # nopep8 generic exception here for a reason
                exit('Couldn\'t create target directory {0}: {1}'
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
