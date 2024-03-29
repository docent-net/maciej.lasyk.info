#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = u'Maciej Lasyk'
SITENAME = u'Many craft<br>Wow<br>Such create'
SITEURL = 'http://127.0.0.1:8000'

HOME_URL = 'http://127.0.0.1:8000'

TIMEZONE = 'Europe/Warsaw'

DEFAULT_LANG = u'en'

THEME = "themes/docent"
PLUGIN_PATHS=["plugins"]
PLUGINS=["tag_cloud", "image_process", "sitemap"]

STATIC_PATHS = [
    'images',
    'slides',
    'keybase.txt',
    'static',
    'favicon.ico'
    ]

ARTICLE_EXCLUDES = [
    'slides',
    'static'
]

EXTRA_PATH_METADATA = {
    'static/google95d51144019ab367.html': {'path': 'google95d51144019ab367.html'}
}

# Feed generation is usually not desired when developing
FEED_DOMAIN = SITEURL
FEED_ATOM = 'feeds/atom.xml'
FEED_ALL_ATOM = 'feeds/all.atom.xml'
CATEGORY_FEED_ATOM = 'feeds/{%s}.atom.xml'
FEED_RSS = 'feeds/rss.xml'
FEED_ALL_RSS = 'feeds/all.rss.xml'
CATEGORY_FEED_RSS = 'feeds/%s.rss.xml'
TAG_FEED_ATOM = 'feeds/tag/%s.atom.xml'
TAG_FEED_RSS = 'feeds/tag/%s.rss.xml'

# Blogrol
LINKS =  (('Pelican', 'http://getpelican.com/'),
          ('Python.org', 'http://python.org/'),
          ('Jinja2', 'http://jinja.pocoo.org/'),
          ('You can modify those links in your config file', '#'),)

# Social widget
SOCIAL = (('You can add links in your config file', '#'),
          ('Another social link', '#'),)

DEFAULT_PAGINATION = False

# Uncomment following line if you want document-relative URLs when developing
RELATIVE_URLS = True

ARTICLE_URL = '{date:%Y}/{date:%b}/{date:%d}/{slug}/'
ARTICLE_SAVE_AS = '{date:%Y}/{date:%b}/{date:%d}/{slug}/index.html'

DISQUS_SITENAME='manycraft'
GOOGLE_ANALYTICS='UA-61452-19'
#GOOGLE_TAGMANAGER="GTM-56PJ72"

TAG_CLOUD_STEPS = 8
TAG_CLOUD_MAX_ITEMS = 15
TAG_CLOUD_SORTING = 'alphabetically'
TAG_CLOUD_BADGE = False

#PIWIK_URL='analytics.lasyk.info'
#PIWIK_SITE_ID=1

#GITHUB_URL='https://github.com/docent-net'

# common image size via plugin
# https://github.com/whiskyechobravo/image_process
IMAGE_PROCESS = {
    'article-image': ["scale_in 300 300 False"]
    }

# sitemap configuration:
SITEMAP = {
    'format': 'xml',
    'priorities': {
        'articles': 0.9,
        'indexes': 0.9,
        'pages': 0.1
    },
    'changefreqs': {
        'articles': 'monthly',
        'indexes': 'daily',
        'pages': 'monthly'
    },
    'exclude': ['tag/', 'category/', 'static', 'slides']
}
