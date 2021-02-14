;acts like $025
;if mairo touches this block, it will disappear and increment
;the key counter, allowing mario to open lock gates. If mario
;have 99, it will do nothing (to prevent overflow or wasting).

!sfx		= $15
!RAM_port	= $1DFC

db $42
JMP main : JMP main : JMP main : JMP ret : JMP ret : JMP ret
JMP ret : JMP main : JMP main : JMP main

incsrc "KeyBlkDef.txt"

main:
	LDA !FreeRamAlttpKey	;\if player have 99 keys
	CMP #$63		;|then return (don't even just disappear.
	BCS ret			;/its a waste).
	INC A			;\"pick up the key"
	STA !FreeRamAlttpKey	;/
	LDA #!sfx		;\play sound
	STA !RAM_port		;/
	LDA #$02		;\and make block disappear (uses stack to
	STA $9C			;|prevent behavor problems)
	PHY			;|
	JSL $00BEB0		;|
	PLY			;/
ret:
RTL