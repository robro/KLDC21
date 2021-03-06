!switch		= $14AD		; $14AD = Blue P-Switch,	$14AE = Silver P-Switch
				; $14AF = ON/OFF Switch,	$1F27 = Green Switch
				; $1F28 = Yellow Switch,	$1F29 = Blue Switch
				; $1F2A = Red Switch
!reversed	= 0		; Reversed conditions? 0 = false, 1 = true.

db $37
JMP main : JMP main : JMP main : JMP return : JMP return : JMP return : JMP return
JMP main : JMP main : JMP main : JMP main : JMP main

if !switch == $14AF
	!inverted = 1
else
	!inverted = 0
endif

main:	LDA !switch|!addr
if !reversed^!inverted
	BNE return
else
	BEQ return
endif
	
	LDA $71
	ORA $1490|!addr
	ORA $1493|!addr
	ORA $1497|!addr
	BNE return
	
	JSL $00F606|!bank
	
return:	RTL

if !reversed
	print "Kills the player if a specific switch isn't active."
else
	print "Kills the player if a specific switch is active."
endif