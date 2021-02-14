;customisation start

;DIRECTION OF VERTICAL AUTO-SCROLL:

	!Direction = 0		;0 = up, 1 = down

;NOTES ON UP SCROLLING:
;	when dying, Mario falls for 3 subscreens (F2 in Lunar Magic to see) minus 5 tiles approximately.
;	make sure there's enough valid layer 2 for Mario to scroll down past, or glitches will be seen!
;	that, or hex edit $00F619 to $12,$14 to prevent the camera from scrolling down when dying.

;SPEED:

	!Speed = $00

;VALID SPEED VALUES:
;	$00 (fast), $01 (normal), $03 (slow), $07 (very slow), $0F (extremely slow)
;	$1F, $3F, $8F, $FF are valid as well, but too slow to be useful at all in my opinion

;	explanation: layer 2 will only auto-scroll every few frames, which depends on the value above.
;	every next valid value is twice the amount of frames to wait for the next layer 2 auto movement.
;	i.e. $00 moves every frame, so $01 moves every second frame, $03 every fourth frame and so on.
;	don't try broken values as the math only works specifically for these!

;TO MAKE IT EVEN FASTER WITH SPEED $00: increase the amount of pixels it moves per frame below.
;	note that +$0001 doubles the speed! so be cautious with this.

	!PixelsPer = $0001

;customisation end

main:
	LDA $89			;\ignore yoshi intros
	ORA $13D4|!addr	;|and don't do any math at all during pause
	ORA $1493|!addr ;|or during the level end sequence
	BNE Return		;/
	
	;store layer 1 displacement in $00 (16-bit)
	LDX #$00		;high byte of sum
	LDA $17BC|!addr	;check layer 1 displacement
	BPL +
	LDX #$FF		;high byte of sum (essentially invert signal)
+	STA $00
	STX $01
	
	;add layer 1 displacement
	REP #$20
	LDA $1468|!addr
	CLC
	ADC $00
	STA $1468|!addr	;store to layer 2 position
	SEP #$20
	
	;only do the autoscrolling outside of freeze times and every few frames (speed-dependent)
	LDA $14
	AND #!Speed		;frame filter
	ORA $9D			;freeze check
	BNE Return
	
	;auto-scroll
	REP #$20
	LDA $1468|!addr
	if !Direction
		SEC
		SBC.w #!PixelsPer
	else
		CLC
		ADC.w #!PixelsPer
	endif
	STA $1468|!addr
	SEP #$20
	
Return:
	RTL 