;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	Shared GFX subroutine
;
;	Input:	A = How many tiles to draw.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Shared_GFX:
		DEC
		STA $04
	
		%GetDrawInfo()
	
		LDA !15F6,x
		ORA $64
		STA $03
		
		PHX

GraphicLoop:
		LDX $04
		INX
	-
		DEX
		BMI +
		
		GetTileNumber:
			CPX $04
			BNE ++
				LDA #$62	; Right edge of the platform
				BRA Draw
				
		++
			CPX #$00
			BNE ++
				LDA #$60	; Left edge of the platform
				BRA Draw
				
		++
			LDA #$61		; middle of the platform
			
		Draw:
			STA $02			; store which tile here
				
			TXA				; x times 16 = tile x-disp
			ASL				
			ASL
			ASL
			ASL
			
			CLC 
			ADC $00
			STA $0300|!Base2,y	; X disp
			
			LDA $01
			STA $0301|!Base2,y	; Y Disp
			
			LDA $02
			STA $0302|!Base2,y	; Tile
			
			LDA $03
			STA $0303|!Base2,y	; Props
			
			INY
			INY
			INY
			INY
			BRA -
			
	+	
		PLX
	
FinishGFX:
		LDA $04
		LDY #$02
		JSL $01B7B3		; Finish OAM write
		
		RTS