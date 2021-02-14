;SOLID IF RUNNING BLOCK
;This block is inspired by the sheer ramps seen in some levels of Sonic Chaos.
;For best results, set this to act like Tile 25 in Lunar Magic.

print "Is solid if Mario is running"

db $42
JMP Nope : JMP RUN : JMP Nope
JMP Nope : JMP Nope : JMP Nope : JMP Nope
JMP Nope : JMP Nope : JMP Nope

Nope:
RTL
RUN:
	LDA $7B	;Check the player's X Speed
	BPL ClockIt
	EOR #$FF	;Make the value positive if it isn't (ie if the player is running left).
	INC
		ClockIt:
		CMP #$20
		BCC FallThrough	
		LDY #$01	;\
		LDA #$30	; |Act like a blank block
		STA $1693	;/
	FallThrough:
	RTL
RTL