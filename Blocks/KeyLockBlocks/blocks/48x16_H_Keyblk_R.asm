;Behaves $130
;This is the bottom block of the 1x3 block gate.

db $42
JMP MarioBelow : JMP MarioAbove : JMP MarioSide : JMP SpriteV : JMP SpriteH
JMP MarioCape : JMP MarioFireBall : JMP TopCorner : JMP BodyInside : JMP HeadInside

incsrc KeyBlkDef.txt

;-------------------------------------------------
;check if player presses up or down depending on
;what side
;-------------------------------------------------
TopCorner:
MarioAbove:
	LDA $15
	AND.b #%00000100
	BNE Unlock
	RTL
MarioBelow:
	LDA $15
	AND.b #%00001000
	BNE Unlock
	RTL
;-------------------------------------------------
;check if player unlocks it facing correctly.
;-------------------------------------------------
MarioSide:
HeadInside:

;left_side:			;\Player should face towards block when touching side.
	LDA $76			;|
	BNE Return		;/
SideDone:
;-------------------------------------------------
;This checks what sprite number and deletes key.
;-------------------------------------------------
Unlock:
if !custom_type == 0 || !custom_type == 1
	LDA $1470		;\Return if carrying nothing.
	ORA $148F		;|
	BEQ Return		;/
	PHX
	LDX.b #!NumbOfSa1Slots-1
-
	LDA $14C8,x		;\If sprite status = not carried then next slot
	CMP #$0B		;|
	BNE NextSlot		;/

	LDA $7FAB10,x		;\Check if its a custom sprite
	AND #$08		;|
	if !custom_type = 0	;|
		BNE ReturnPull	;|
	else			;|
		BEQ ReturnPull	;|
	endif			;/
	LDA !SpriteTyp,x	;\If sprite number doesn't match, then next slot
	CMP #!SpriteNum		;|
	BNE NextSlot		;/
	JMP match_sprite	;>if match, then proceed.
NextSlot:
	DEX
	BPL -
ReturnPull:
	PLX
	RTL			;>if all slots checked and still didn't find, return.
match_sprite:
	STZ $14C8,x		;>erase key.
	PLX			;>done with slots.
	LDA #$40		;\Fix a bug that if you unlock the block and kick it
	TSB $15			;/at the same frame makes deleting the key not function.
;--------------------------------------
;This code below is for using ALTTP key
;--------------------------------------
else
	LDA !FreeRamAlttpKey
	BEQ Return
	DEC A
	STA !FreeRamAlttpKey
endif
;---------------------------------
;Erase block.
;---------------------------------
	LDY #$00		;\Right when it disappears, shouldn't stop the player's
	LDA #$25		;|movement.
	STA $1693		;/

	%create_smoke()		;>smoke
	%erase_block()		;>Delete self (bottom)

	PHY
	REP #$30
	LDY #$0002		;>Start loop
-
	PHP			;>protect processor mode.
	PHY			;>This subroutine should not mess with Y as a loop counter.
	SEP #$30		;>Because this subroutine is 8-bit mode
	JSR SwapXYHigh		;>Vertical levels have their $99 and $9B swapped.
	REP #$30		;>Even with PLP, this needed to prevent game crashes.
	PLY			;>Now use Y as a loop counter index
	PLP			;>restore processor mode.

	LDA $9A			;\Shift X position
	CLC			;|
	ADC #$FFF0		;|
	STA $9A			;/

	PHY
	SEP #$30
	%create_smoke()		;>smoke
	%erase_block()		;>Remove tile
	REP #$30
	PLY

	DEY			;\next pair of bytes
	DEY			;/
	BPL -			;>if >= 0, loop.
	SEP #$30
	PLY

	LDA #!sfx_open		;\Play sfx.
	STA !RAM_port_open	;/
SpriteV:
SpriteH:
MarioCape:
MarioFireBall:
BodyInside:
Return:
	RTL

SwapXYHigh:
	LDA $5B				;\Check if vertical level = true
	AND #$01			;|
	BEQ +				;/
	LDA $99				;\Fix the $99 and $9B from glitching up if placed
	LDY $9B				;|other than top-left subscreen boundaries of vertical
	STY $99				;|levels!!!!! (barrowed from the map16 change routine of GPS).
	STA $9B				;|(this switch values $99 <-> $9B, since the subscreen boundaries are sideways).
+					;/
	RTS

print "The right of the 3x1 key block."