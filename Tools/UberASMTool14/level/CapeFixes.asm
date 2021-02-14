;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Cape Bug-Fix Collection - A series of cape-related bug fixes I ported over to UberASM.
;;
;; Original Patches by:
;; Dtothefourth, GreenHammerBro, Alcaro, and Betalogic 
;; UberASM Version by West
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


!FreeRAM = $140B			 ;Uses the same FreeRAM as the Cape-Direction patch. (2 bytes)

!CapeTurnaroundFix = !yes	 ;Enable this to allow mario to always switch direction when X or Y are pressed. 
!FloatDelayFix = !yes		 ;Enable this to remove the delay between releasing the jump button and floating with the cape.
!CapeSpinWallRunFix = !yes   ;Fixes the glitch where you can cape spin while wall-running.
!CapeClimbFix = !yes		 ;Fixes the glitch where you could maintain flight after jumping off a net or vine. 

!yes = 1
!no = 0

main:
if  !CapeTurnaroundFix
LDA $1407|!addr      	; \ If Mario is in flight
BEQ ++              	; / 
LDA $76      			; Load marios facing direction
LDY $14A6|!addr      	; \ Load flight-spinning timer into Y
BEQ +              		; /
LDA !FreeRAM|!addr  	; Load the current flight direction
+	
EOR #$01           		; \ Set the flight direction to be
STA !FreeRAM|!addr      ; / opposite the loaded value
CPY #$01           		; \ Compare flight-spinning timer
BNE ++              	; | And if the capespin timer is at 1,
STZ $14A6|!addr  		; | Clear the capespin timer
LDA !FreeRAM|!addr  	; \ And load the saved flight direction	  
STA $76  				; / Set Mario's direction to the loaded value
++
endif
if !FloatDelayFix
LDA $187A|!addr	        ; If Mario is not riding Yoshi with wings...
AND $141E|!addr			;
BNE +
STZ $14A5|!addr         ; Disable the float timer 
+ 
endif 
if !CapeSpinWallRunFix
LDA $13E3|!addr 		;\ If Player is wall-running
BEQ +					;/
LDA #$40				;\ Disable pressing X/Y
TRB $16					;/
+
endif
if !CapeClimbFix
LDA $74					;\ If player is climbing
BEQ +					;/
STZ $1407|!addr			;\ Disable flight
+						;/
endif 
RTL
