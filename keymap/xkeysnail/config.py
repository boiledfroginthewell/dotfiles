#!/usr/bin/env python

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
		Key.KEY_1: Key.F1,
		Key.KEY_2: Key.F2,
		Key.KEY_3: Key.F3,
		Key.KEY_4: Key.F4,
		Key.KEY_5: Key.F5,
		Key.KEY_6: Key.F6,
		Key.KEY_7: Key.F7,
		Key.KEY_8: Key.F8,
		Key.KEY_9: Key.F9,
		Key.KEY_0: Key.F10,
		Key.MINUS: Key.F11,
		Key.EQUAL: Key.F12,

		# 1st row
		Key.Q: Key.ESC,
		Key.W: Key.DELETE,
		Key.E: Key.HOME,
		Key.R: Key.END,
		# Key.T: K("y"),

		# Key.Y: K("f"),
		# Key.U: K("g"),
		Key.I: Key.ENTER,
		Key.O: Key.ENTER,
		# Key.P: K("l"),
		# Key.LEFT_BRACE: Key.SLASH,
		# Key.RIGHT_BRACE: Key.LEFT_BRACE,

		# 2nd row
		Key.A: K("C-a"),
		Key.S: K("C-o"),
		Key.D: Key.PAGE_UP,
		Key.F: Key.PAGE_DOWN,
		# Key.G: K("i"),

		Key.H: Key.LEFT,
		Key.J: Key.UP,
		Key.K: Key.DOWN,
		Key.L: Key.RIGHT,
		# Key.SEMICOLON: K("s"),
		# Key.APOSTROPHE: Key.MINUS,
		# Key.GRAVE: Key.RIGHT_BRACE,

		# 3rd row
		Key.Z: K("C-z"),
		Key.X: K("C-x"),
		Key.C: K("C-c"),
		Key.V: K("C-v"),
		# Key.B: K("x"),

		# Key.N: K("b"),
		# Key.M: K("m"),
		# Key.COMMA: K("w"),
		# Key.DOT: K("v"),
		# Key.SLASH: K("z"),
		# Key.BACKSLASH: Key.BACKSLASH,
	}
)


