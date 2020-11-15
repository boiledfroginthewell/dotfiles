#!/usr/bin/env python

import re
from xkeysnail.transform import *
from xkeysnail.transform import *


# Dvorak Mapping
define_keymap(None, {
	# number row
	# Key.KEY_1: Key.KEY_1,
	# Key.KEY_2: Key.KEY_2,
	# Key.KEY_3: Key.KEY_3,
	# Key.KEY_4: Key.KEY_4,
	# Key.KEY_5: Key.KEY_5,
	# Key.KEY_6: Key.KEY_6,
	# Key.KEY_7: Key.KEY_7,
	# Key.KEY_8: Key.KEY_8,
	# Key.KEY_9: Key.KEY_9,
	# Key.KEY_0: Key.KEY_0,
	K("MINUS"): Key.SLASH,
	# Key.EQUAL: Key.EQUL,
	# Key.YEN: Key.YEN,

	# 1st row
	K("q"): Key.APOSTROPHE,
	K("w"): Key.COMMA,
	K("e"): Key.DOT,
	K("r"): K("p"),
	K("t"): K("y"),

	K("y"): K("f"),
	K("u"): K("g"),
	K("i"): K("c"),
	K("o"): K("r"),
	K("p"): K("l"),
	K("LEFT_BRACE"): Key.SLASH,
	K("RIGHT_BRACE"): Key.LEFT_BRACE,

	# 2nd row
	K("a"): K("a"),
	K("s"): K("o"),
	K("d"): K("e"),
	K("f"): K("u"),
	K("g"): K("i"),

	K("h"): K("d"),
	K("j"): K("h"),
	K("k"): K("t"),
	K("l"): K("n"),
	K("SEMICOLON"): K("s"),
	K("APOSTROPHE"): Key.MINUS,
	K("GRAVE"): Key.RIGHT_BRACE,

	# 3rd row
	K("z"): Key.SEMICOLON,
	K("x"): K("q"),
	K("c"): K("j"),
	K("v"): K("k"),
	K("b"): K("x"),

	K("n"): K("b"),
	K("m"): K("m"),
	K("COMMA"): K("w"),
	K("DOT"): K("v"),
	K("SLASH"): K("z"),
	# Key.BACKSLASH: Key.BACKSLASH,
# })

# define_keymap(None, {
	K("Shift-Key_0"): K("Shift-Yen"),
	K("CAPSLOCK"): Key.BACKSPACE,
})

define_multipurpose_modmap({
	# K("MUHENKAN"): [Key.MUHENKAN, lambda: [logical_shift_layer := True]],
	Key.SPACE: [Key.SPACE, Key.LEFT_SHIFT],
	Key.HENKAN: [Key.HENKAN, Key.RIGHT_CTRL],
	Key.HIRAGANA: [Key.HIRAGANA, Key.RIGHT_ALT],
	Key.COMPOSE: [Key.ENTER, Key.RIGHT_META],
})

# Logical Shift
logical_shift_layer: bool = False
# define_keymap({
#	K("MUHENKAN"): lambda: logical_shift_layer= True,
# })
define_conditional_modmap(
	lambda wm_class, device_name: logical_shift_layer,
	{
		K("KEY_1"): Key.F1,
		K("KEY_2"): Key.F2,
		K("KEY_3"): Key.F3,
		K("KEY_4"): Key.F4,
		K("KEY_5"): Key.F5,
		K("KEY_6"): Key.F6,
		K("KEY_7"): Key.F7,
		K("KEY_8"): Key.F8,
		K("KEY_9"): Key.F9,
		K("KEY_0"): Key.F10,
		K("MINUS"): Key.F11,
		K("EQUAL"): Key.F12,

		# 2nd row
		K("a"): K("C-a"),
		K("s"): K("C-o"),
		K("d"): K("e"),
		K("f"): K("u"),
		K("g"): K("i"),

		K("h"): Key.LEFT,
		K("j"): Key.UP,
		K("k"): Key.DOWN,
		K("l"): Key.RIGHT,
		K("SEMICOLON"): K("s"),
		K("APOSTROPHE"): Key.MINUS,
		K("GRAVE"): Key.RIGHT_BRACE,

		# 3rd row
		# K("z"): Key.SEMICOLON,
		# K("x"): K("q"),
		# K("c"): K("j"),
		# K("v"): K("k"),
		# K("b"): K("x"),
		# 
		# K("n"): K("b"),
		# K("m"): K("m"),
		# K("COMMA"): K("w"),
		# K("DOT"): K("v"),
		# K("SLASH"): K("z"),
		# # Key.BACKSLASH: Key.BACKSLASH,
	}
)


