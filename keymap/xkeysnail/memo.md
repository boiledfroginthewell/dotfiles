Xkeysnail
============
modmap系
---------
* define_modmap
* define_conditional_modmap
* define_conditional_multipurpose_modmap
キーコードを単純に置き換えるのみ．K("...") は使えない．　


define_keymap
-----------------
KeyComboを出力する．　K("...")を使う．　
modmap系の変換が行われたあとに機能する．　
Modifierキーとの組み合わせは全て個別に指定する必要がある．　


multipurpose
-----------------
Modifierキーにしか対応していない. 普通のキーだと押しっぱなしになる.

MultipurposeとModifierキーは `_pressed_modifier_key` に設定されている. `Event.RELEASE` で更新されるのはModifierの場合のみ.
https://github.com/mooz/xkeysnail/blob/bf3c93b4fe6efd42893db4e6588e5ef1c4909cfb/xkeysnail/transform.py#L420-L421
https://github.com/mooz/xkeysnail/blob/bf3c93b4fe6efd42893db4e6588e5ef1c4909cfb/xkeysnail/output.py#L37-L42
