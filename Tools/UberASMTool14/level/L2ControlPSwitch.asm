;POW-based Layer 2 Control by Blind Devil
;This code controls the height of Layer 2 depending on the blue/silver POW status.

;Configurable defines:

;P-SWITCH TO USE
;What P-Switch timer to use to move layer 2.
;Possible values: 0 for blue, 1 for silver.
	!POWType = 0

;LAYER 2 HEIGHTS
;The start (POW not active) and end (POW active) possible levels for Layer 2.
;Starting value is also set as initial layer 2 Y-pos.
;The lower the value, the higher layer 2 will be.
;If !EndL2 value is greater than !StartL2, it'll move upwards when the
;respective POW is pressed.
	!StartL2 = $00C0
	!EndL2 = $0050

;Don't change this.
!POWAddr = $14AD
if !POWType
!POWAddr = $14AE
endif

if !StartL2 > !EndL2
!NoPOWCmp = BCS
!NoPOWIncDec = INC
!POWCmp = BCC
!POWIncDec = DEC
else
!NoPOWCmp = BCC
!NoPOWIncDec = DEC
!POWCmp = BCS
!POWIncDec = INC
endif

;LOAD/INIT CODES START HERE!
load:
REP #$20		;16-bit A
LDA #!StartL2		;load value
STA $20			;store to layer 2 Y-pos current frame.
STA $1468|!addr		;store to layer 2 Y-pos next frame.
SEP #$20		;8-bit A

init:
STZ $1414|!addr		;set layer 2 vertical scroll to none.
RTL			;return.

;MAIN CODE STARTS HERE!
main:
LDA $13D4|!addr		;load game paused flag
ORA $9D			;OR with sprites/animation frozen flag
BNE .ret		;if result isn't zero, return. don't move layer 2.

LDA !POWAddr|!addr	;load respective POW timer
BNE .moveit		;if not equal zero, move layer down/up.

REP #$20		;16-bit A
LDA $1468|!addr		;load layer 2 Y-pos, next frame
CMP #!StartL2		;compare with high height value
!NoPOWCmp .ret16	;if equal or higher/equal or lower, stop moving.

!NoPOWIncDec $1468|!addr;increment/decrement layer 2 Y-pos, next frame, by one every frame.

.ret16
SEP #$20		;8-bit A
.ret
RTL			;return.

.moveit
REP #$20		;16-bit A
LDA $1468|!addr		;load layer 2 Y-pos, next frame
CMP #!EndL2		;compare with low height value
!POWCmp .ret16		;if equal or lower/equal or higher, stop moving.

!POWIncDec $1468|!addr	;decrement/increment layer 2 Y-pos, next frame, by one every frame.
SEP #$20		;8-bit A
RTL			;return.