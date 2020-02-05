#!/usr/bin/env python

import sys, configparser

config = configparser.ConfigParser()
config.read_file(sys.stdin)

for sec in config.sections():
    for key, val in config.items(sec):
        print('export %s_%s=%s' % (sec, key, val))
