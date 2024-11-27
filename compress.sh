#!/bin/sh

find build -type f \( -name '*.html' -o -name '*.css' \) -exec gzip -kf {} +

