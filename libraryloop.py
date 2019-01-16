#!/usr/bin/python

import os
import re

p = re.compile('(.+)\.\d(\.[flac|mp3|jpg|png]+)')

r = ''

for subdir, dirs, files in os.walk(os.getcwd()):
    for file in files:
        f = os.path.join(subdir, file)
        m = p.match(file)
        if m:
            o = os.path.join(subdir, m.group(1) + m.group(2))
            if os.path.isfile(o):
                if r != subdir:
                    print "============================================================"
                    print subdir
                r = subdir
                print "============================================================"
                print "Duplicate  | " + file
                print f
                print "Original   | " + m.group(1) + m.group(2)
                print o

                # Keep larger file if duplicate
                if os.path.getsize(f) <= os.path.getsize(o):
                    print "Duplicate has equal or lesser size. Deleting."
                    os.system('beet rm -f "' + f + '"')
                    os.system('rm -rf "' + f + '"')
                else:
                    print "Original has lesser size. Replacing."
                    os.system('beet rm -f "' + o + '"')
                    os.system('rm -rf "' + o + '"')
                    os.system('mv "' + f + '" "' + o + '"')

                # Delete duplicate only if equal size

                # if os.path.getsize(f) == os.path.getsize(o):
                #     print "Duplicate has equal size. Deleting."
                #     os.system('beet rm -f "' + f + '"')
                #     os.system('rm -rf "' + f + '"')
