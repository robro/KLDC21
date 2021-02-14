db $42

JMP Return : JMP Return : JMP Return : JMP SpriteCheck : JMP SpriteCheck : JMP Return : JMP Return : JMP Return : JMP Return : JMP Return

!NumberOfSpritesToCheck		= SpriteTableEnd-SpriteTableStart+1				;	don't change this!
!NumberOfCustomSpritesToCheck	= CustomSpriteTableEnd-CustomSpriteTableStart+1			;	don't change this!


SpriteTableStart:						;	edit these values (sprite number, makes it not die if it hits the muncher)
db $35,$2F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
SpriteTableEnd:

CustomSpriteTableStart:						;	and these values (custom sprite number, makes it not die if it hits the muncher)
db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
CustomSpriteTableEnd:

SpriteCheck:
	LDA !7FAB10,x
	AND #$08
	BNE .customsprite

	LDA !9E,x

	PHX
	LDX.b #!NumberOfSpritesToCheck

.loop
	CMP SpriteTableStart,x
	BEQ .dontkill

	DEX
	BPL .loop

.back
	PLX
	LDA #$04
	STA !14C8,x

	LDA #$1F
	STA !1540,x

	PHY
	JSL $07FC3B|!bank
	PLY

	LDA #$08
	STA $1DF9|!addr
	RTL

.dontkill
	PLX
	RTL

.customsprite
	LDA !7FAB9E,x

	PHX
	LDX.b #!NumberOfCustomSpritesToCheck

.loop2
	CMP CustomSpriteTableStart,x
	BEQ .dontkill

	DEX
	BPL .loop2

	BRA .back
	
Return:
	RTL

print "A muncher that kills sprites."