#!/bin/sh

FAVORITE=$(dirname $0)/favorite.xmodmap
< reset_pm.xmodmap grep -e ^clear > $FAVORITE
xmodmap -pke >> $FAVORITE
< reset_pm.xmodmap grep -e ^add >> $FAVORITE
cp $FAVORITE ~/.Xmodmap
