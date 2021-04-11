#!/usr/bin/env python

from xkeysnail.transform import *

# Simple Kecode translation
define_modmap({
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
	Key.MINUS: Key.LEFT_BRACE,
	# Key.EQUAL: Key.EQUL,
	# Key.YEN: Key.YEN,

	# 1st row
	Key.Q: Key.APOSTROPHE,
	Key.W: Key.COMMA,
	Key.E: Key.DOT,
	Key.R: Key.P,
	Key.T: Key.Y,

	Key.Y: Key.F,
	Key.U: Key.G,
	Key.I: Key.C,
	Key.O: Key.R,
	Key.P: Key.L,
	Key.LEFT_BRACE: Key.SLASH,
	# Key.RIGHT_BRACE: Key.RIGHT_BRACE,

	# 2nd row
	Key.A: Key.A,
	Key.S: Key.O,
	Key.D: Key.E,
	Key.F: Key.U,
	Key.G: Key.I,

	Key.H: Key.D,
	Key.J: Key.H,
	Key.K: Key.T,
	Key.L: Key.N,
	Key.SEMICOLON: Key.S,
	Key.APOSTROPHE: Key.MINUS,
	Key.GRAVE: Key.RIGHT_BRACE,

	# 3rd row
	Key.Z: Key.SEMICOLON,
	Key.X: Key.Q,
	Key.C: Key.J,
	Key.V: Key.K,
	Key.B: Key.X,

	Key.N: Key.B,
	Key.M: Key.M,
	Key.COMMA: Key.W,
	Key.DOT: Key.V,
	Key.SLASH: Key.Z,
	# Key.BACKSLASH: Key.BACKSLASH,

	Key.CAPSLOCK: Key.BACKSPACE,
	Key.KATAKANAHIRAGANA: Key.RIGHT_ALT,
})

# Transform Combinations
define_keymap(None, {
	K("Shift-Key_0"): K("Shift-Yen"),
})

# Logical Shift
logical_shift_layer: bool = False

def set_layer(enabled: bool, key):
	global logical_shift_layer
	logical_shift_layer = enabled
	return key

def switch_logical_shift_layer(action):
	global logical_shift_layer
	logical_shift_layer = action.is_pressed()

def is_ls(_):
	global logical_shift_layer
	return logical_shift_layer

define_timeout(200)

define_multipurpose_modmap({
	Key.MUHENKAN: [
		Key.MUHENKAN,
		{
			"mod_key": Key.ISO,
			"hook": switch_logical_shift_layer
		}
	],
	Key.SPACE: [Key.SPACE, Key.LEFT_SHIFT],
	Key.HENKAN: [Key.HENKAN, Key.RIGHT_CTRL],
	Key.HIRAGANA: [Key.HIRAGANA, Key.RIGHT_ALT],
	Key.COMPOSE: [Key.ENTER, Key.RIGHT_META],
})

define_conditional_modmap(
		is_ls,
	# lambda wm_class: is_ls(wm_class), #logical_shift_layer,
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
		# Key.A: K("C-a"),
		# Key.S: K("C-o"),
		Key.D: Key.PAGE_UP,
		Key.F: Key.PAGE_DOWN,
		# Key.G: K("i"),

		Key.H: Key.LEFT,
		Key.J: Key.DOWN,
		Key.K: Key.UP,
		Key.L: Key.RIGHT,
		Key.SEMICOLON: Key.RIGHT,
		# Key.APOSTROPHE: Key.MINUS,
		# Key.GRAVE: Key.RIGHT_BRACE,
		# K("Shift-h"): K("Shift-LEFT"),
		# K("Shift-j"): K("Shift-DOWN"),
		# K("Shift-k"): K("Shift-UP"),
		# K("Shift-l"): K("Shift-RIGHT"),

		# 3rd row
		# Key.Z: K("C-z"),
		# Key.X: K("C-x"),
		# Key.C: K("C-c"),
		# Key.V: K("C-v"),
		# Key.B: K("x"),

		# Key.N: K("b"),
		# Key.M: K("m"),
		# Key.COMMA: K("w"),
		# Key.DOT: K("v"),
		# Key.SLASH: K("z"),
		# Key.BACKSLASH: Key.BACKSLASH,


		Key.KATAKANAHIRAGANA: Key.RIGHT_ALT,
	}
)

define_keymap(is_ls, {
	K("A"): K("C-a"),
	K("S"): K("C-o"),

	K("Z"): K("C-z"),
	K("X"): K("C-x"),
	K("C"): K("C-c"),
	K("V"): K("C-v"),
})
