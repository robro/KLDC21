; restore hijack that the patch uses.
!addr = $0000
if read1($00FFD5) == $23
	sa1rom
	!addr = $6000
endif

org $00E98C
	LDA.W $1B96|!addr
	BEQ $10
