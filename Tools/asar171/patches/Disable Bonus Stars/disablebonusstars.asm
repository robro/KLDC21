;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;
; Disable Bonus Stars, by Aiyo and imamelia
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


lorom
!addr = $0000

if read1($00FFD5) == $23
	sa1rom
	!addr = $6000
endif

org $008F9D
	LDA #$FC
	STA $0F03|!addr
	STA $0F04|!addr
	STA $0F1B|!addr
	STA $0F1C|!addr
	STA $0F1E|!addr
	STA $0F1F|!addr
	BRA $12
	NOP #18

org $05CF1B
	NOP #3

org $009053
	NOP #3

org $009068
	NOP #3

; org $01C11F ; remove bonus stars count on score tally
; 	BRA $07

; org $01C178 ; remove bonus stars graphic when getting the goal tape
; 	db $80



