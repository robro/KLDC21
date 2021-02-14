!Y_speed = $7D
!RisingSpeedCap = #$DF
!FallingSpeedCap = #$20
!Timer_1 = $1406|!addr	; This address is also related to springboards. Did you know?


dontgrav:
	STZ !Timer_1
	RTL

Timerdec:
db #$03,#$05
	
main:

	LDA $9D
	BNE dontgrav	; animations are locked
	
	LDA $74				
	BNE dontgrav	; Mario is climbing

	LDA $72
	BEQ dontgrav 	; Mario is on the ground
	
	LDA $75
	BNE dontgrav 	; Mario is in water
	
	LDA !Y_speed														;	?) If Mario is falling
	BPL Label_1															;		-> [1-A] Branch to <Label 1>
;[1-A]
																		;	vvv
	
;	--- Mario is rising

	CMP !RisingSpeedCap														;	?) If Mario's rising speed is faster than #RisingSpeedCap:
	BCS	Label_2 
;[2-A]																	;		-> [2-A] Branch to <Label 2> 

																		;	vvv
	
;	--- Mario's rising speed is faster than #RisingSpeedCap

	LDA !Timer_1
	BPL +
	
	LDA #$FF
	STA !Timer_1
	BRA ++
+
	LDA #80	
	STA !Timer_1														;	[] Set Timer 1
++
;	vvv

;---


Label_2:
		;<-				<-				<- [2-A] Mario's rising speed is slower than or equal to #RisingSpeedCap

	LDY #$00	
	LDA $15
	BMI +
	INY
+
	
	LDA !Timer_1
	SEC
	SBC Timerdec,y
	BCS +
	LDA #$00
	+
	STA !Timer_1
				
																		;	[] Tick down Timer 1	
	;LDA !Timer_1
	;DEC
	;DEC
	;DEC
	;STA !Timer_1  
	
	;LDA $15
	;BMI +
	;DEC !Timer_1
	;DEC !Timer_1
	;+
		

;[3-A]
																		;	vvv
																		;	[] Set Mario's rising speed to #RisingSpeedCap

	LDA !Timer_1
	BEQ +														
				
	LDA !RisingSpeedCap
	STA !Y_speed														
+
;---



	BRA Label_3	;	<-			<-			<- [3-A] Timer 1 currently isn't running down

	
;---

Label_1:
;		<- [1-A] Mario is falling
													;	[] Decrease Mario's falling speed by a small amount
	
	CMP !FallingSpeedCap							;	?) If Mario's falling speed is lesser than #FallingSpeedCap
	BCC Label_4												;		-> [4-A] Branch to <Label 4>

	;	vvv
	
													;	[] Set Mario's falling speed to #FallingSpeedCap
	LDA !FallingSpeedCap
	STA !Y_speed

Label_3:
	LDA !Y_speed
	SEC
	SBC #$02
	STA !Y_speed
	
Label_4:
;	<-			<-			<- [4-A] Mario's falling speed is lesser than #FallingSpeedCap
	
	RTL
;	<> Code ends
	
;-------------------------------