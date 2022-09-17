;Convert Dvorak keystrokes to their correct letters on a QWERTY-configured OS
;Script instructions:

#SingleInstance force
#MaxHotkeysPerInterval 100
#UseHook
Process, Priority,, Realtime
SetKeyDelay -1
 
vkF0sc03A::BS
Capslock::Backspace

;RWin::Suspend, Toggle


; QWERTY Mapping with Win key



; The first row
-::@
=::`
q:::
w::,
e::.
r::p
t::y
y::f
u::g
i::c
o::r
p::l
@::/

; The second row
a::a
s::o
d::e
f::u
g::i
h::d
j::h
k::t
l::n
vkBBsc027::s
vkBAsc028::-

; The third row
z::`;
x::q
c::j
v::k
b::x
n::b
m::m
,::w
.::v
/::z
