#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = u'Maciej Lasyk'
SITENAME = u'Many craft. Wow. Such create'
SITEURL = 'http://maciej.lasyk.info'

HOME_URL = 'http://maciej.lasyk.info'

TIMEZONE = 'Europe/Paris'

DEFAULT_LANG = u'en'

THEME = "themes/docent"

STATIC_PATHS = ['images', 'pdfs']

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None

# Blogroll
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

TAG_CLOUD_STEPS = 8
TAG_CLOUD_MAX_ITEMS = 20
