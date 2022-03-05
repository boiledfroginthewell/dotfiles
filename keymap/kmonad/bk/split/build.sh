< dvorak-logicalshift.kbd grep -v usb-0566_3107-event-kbd \
	| sed -e '/Dumang_left/ s/;;//' -e '/;;input/d' > .dumang_left.kbd
< dvorak-logicalshift.kbd grep -v usb-0566_3107-event-kbd \
	| sed -e '/Dumang_right/ s/;;//' -e '/;;input/d' > .dumang_right.kbd

