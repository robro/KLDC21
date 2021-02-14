if read1($00FFD5) == $23		; check if the rom is sa-1
	sa1rom
	!Base2 = $6000
else
	lorom
	!Base2 = $0000
endif

!FreeRam = $1DEF|!Base2	; Remember: it MUST be cleared by overworld but NOT by level load.

ORG $008E5B
autoclean JSL Routine
NOP

;=========================
freecode
Routine:
;=========================
; LDA !FreeRam		; If the "free ram" is set...
; BNE Return		; ... return.
; INC !FreeRam
; LDA #$99		; SFX for "Time is running out".
; STA $1DF9|!Base2
Return:
RTL
