;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Win by dying
;Instead of simply returning to OW, death will activate event on OW.
;By RussianMan, credit is unecessary.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

!Exit = #$01		;01 - Normal exit, 02 - Secret exit 1, 03 - Secret exit 2, 04 - Secret exit 3.

!WinSound = $0B		;plays music/sound effect when dead. 0 - leave original audio (death jingle)
!WinBank = $1DFB|!addr	;

main:
LDA $71			;check if player's dying
CMP #$09		;
BNE .No			;

LDA !Exit		;
STA $13CE|!addr 	;set event
STA $0DD5|!addr	 	;which event

INC $1DE9|!addr 	;activate event

LDA #$0B 		;
STA $0100|!addr	 	;quickly return to OW.

If !WinSound
  LDA #!WinSound	;play different song/sound effect if applicable.
  STA !WinBank		;
endif

.No
RTL			;