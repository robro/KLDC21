;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Spinjump<->Jump
;Allows to change jumping state mid-air.
;Pressing A while jumping causes player to spin
;and pressing B while spinjumping causes playet to stop spinning.
;By RussianMan. Credit is optional.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

!SpinJumpSound = $04		;sound effect for spinjump
!SpinJumpBank = $1DFC

!JumpSound = $01		;sound effect for normal jump
!JumpSoundBank = $1DFA		;you must change those if using addmusic
				;by default those can be !JumpSound = $2B and !JumpSoundBank = $1DF9
				;Or !JumpSound = $35 and !JumpSoundBank = $1DFC

main:
LDA $9D				;don't do things when freeze flag is set
ORA $75				;can't perform change underwater
ORA $1470|!addr			;\don't run when carrying item.
ORA $148F|!addr			;/
ORA $187A|!addr			;and not when riding yoshi also don't run
ORA $13D4|!addr			;and not when game is paused
BNE .Re				;return if any of above is true

LDA $72				;if not in air
BEQ .Re				;don't run code

LDA $140D|!addr			;check jump type
BNE .SpinJumping		;if non-0, spinjumping

BIT $18				;if pressing A
BPL .Re				;change jump to spinjump

LDA #!SpinJumpSound		;sound effect
STA !SpinJumpBank|!addr		;

.Change
LDA $140D|!addr			;spinjump into jump or vice versa
EOR #$01			;
STA $140D|!addr			;

.Re
RTL				;

.SpinJumping
BIT $16				;if pressing B
BPL .Re				;change spinjump to jump

LDA #!JumpSound			;sound effect
STA !JumpSoundBank|!addr	;
BRA .Change			;