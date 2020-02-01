#!/usr/bin/env python

import sys, configparser

config = configparser.ConfigParser()
config.readfp(sys.stdin)

for sec in config.sections():
    for key, val in config.items(sec):
        print('%s_%s=%s' % (sec, key, val))
