#!/bin/sh

pkill wallpaper.sh

clickLeft() {
  notify-send "Changing Wallpaper!"
  $(dirname $0)/wallpaper.sh random
}

clickMiddle() {
  pkill wallpaper.sh
}

clickRight() {
  # $(dirname $0)/wallpaper.sh random
  :
}

scrollUp() {
  $(dirname $0)/wallpaper.sh presetgif &
}

scrollDown() {
  $(dirname $0)/wallpaper.sh randomgif &
}

case $1 in
clickleft)
  clickLeft
  ;;
clickmiddle)
  clickMiddle
  ;;
clickright)
  clickRight
  ;;
scrollup)
  scrollUp
  ;;
scrolldown)
  scrollDown
  ;;
esac
