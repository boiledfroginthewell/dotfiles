;Convert Dvorak keystrokes to their correct letters on a QWERTY-configured OS
;Script instructions:

#SingleInstance force
#MaxHotkeysPerInterval 100
#UseHook
Process, Priority,, Realtime
SetKeyDelay -1

; The top row
;vk1Dsc07B & -::@
;vk1Dsc07B & =::`

; The first row
;vk1Dsc07B & q:::
vk1Dsc07B & w::Send, {Delete}
vk1Dsc07B & e::Send, {Home}
vk1Dsc07B & r::Send, {End}
;vk1Dsc07B & t::y
vk1Dsc07B & y::Send, {PgDn}
;vk1Dsc07B & u::g
vk1Dsc07B & i::Send, {vk1Dsc07B}
vk1Dsc07B & o::Send, {vk1Csc079}
;vk1Dsc07B & p::l
;vk1Dsc07B & @::/
;vk1Dsc07B & [::Send, 

; The second row
;vk1Dsc07B & a::o
vk1Dsc07B & s::Send, ^s
vk1Dsc07B & d::Send, {Blind}^{Left}
vk1Dsc07B & f::Send, {Blind}^{Right}
;vk1Dsc07B & g::i
vk1Dsc07B & h::Send, {Blind}{Left}
vk1Dsc07B & j::Send, {Blind}{Down}
vk1Dsc07B & k::Send, {Blind}{Up}
vk1Dsc07B & l::Send, {Blind}{Right}
vk1Dsc07B & vkBBsc027::Send, {Blind}{Enter}
;vk1Dsc07B & :::
;vk1Dsc07B & ]::

; The third row
vk1Dsc07B & z::Send, ^z
vk1Dsc07B & x::Send, ^x
vk1Dsc07B & c::Send, ^c
vk1Dsc07B & v::Send, ^v
; alt + ctrl + v alternative
;vk1Dsc07B & g::Send,^!v
;vk1Dsc07B & b::x
vk1Dsc07B & n::Send, {PgUp}
;vk1Dsc07B & m::m
;vk1Dsc07B & ,::w
;vk1Dsc07B & .::v
;vk1Dsc07B & /::z

; The fourth row
; Henkan to Muhenkan
vk1Dsc079 ::Send, {vk1Dsc07B}
; Muhenkan and Henkan
vk1Dsc07B & vk1Dsc079 ::Send, {vk1Dsc079}
; Hiragana-Katakana 
vkF2sc070::Send {RCtrl}

#c::c