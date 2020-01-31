#!/usr/bin/env python

import sys, configparser

config = configparser.ConfigParser()
config.readfp(sys.stdin)

for sec in config.sections():
    print("declare -A %s" % (sec))
    for key, val in config.items(sec):
        print('%s[%s]=%s' % (sec, key, val))
