#!/usr/bin/env python
# encoding: utf-8

"""
Config for Willie-Lumberjack web server.
"""

PROJECT = 'Willie-Lumberjack'
APPNAME = PROJECT

#. bottle
BIND_HOST = '127.0.1.1'
BIND_PORT = 8080
LOGFILE = '/tmp/web.log'
PIDFILE = '/tmp/web.pid'

#. redis
REDIS_HOST = '10.10.5.32'
REDIS_PORT = 6379
REDIS_DBID = 0

#. log
LOG_PATH = '/tmp/lumberjack/'

#. theme
DEFAULT_THEME = 'readable'
WIDGET_THEME= 'spacelab'
BOOTSWATCH_THEMES = {
    #'amelia' : 'Sweet and cheery',
    'cerulean' : 'A calm, blue sky',
    #'cosmo' : 'An ode to Metro',
    #'cyborg' : 'Jet black and electric blue',
    'flatly' : 'Flat and modern',
    'journal' : 'Crisp like a new sheet of paper',
    'readable' : 'Optimized for legibility',
    'simplex' : 'Mini and minimalist',
    #'slate' : 'Shades of gunmetal gray',
    'spacelab' : 'Silvery and sleek',
    'united': 'Ubuntu orange and unique font',
}

