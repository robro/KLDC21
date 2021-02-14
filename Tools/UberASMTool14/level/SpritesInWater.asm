;Sprites In Water - A Darkbloom Production
;(I think. I'm pretty sure I got help from someone in the discord for the main loop but I'm not sure who >_>
;Telinc1 provided the code for disabling water splashes. )
;Basically if you combine this with sprite buoyancy you can recreate that glitch
;that causes sprites to act like they're in water even when they're on land.

if read1($00FFD5) == $23
!SpriteCount = 22	;in decimal
else
!SpriteCount = 12
endif

main:
LDX #!SpriteCount	; sprite count
.loop
LDA !166E,x : ORA #$40 : STA !166E,x
LDA #$01
STA !164A,x
DEX
BPL .loop
RTL

