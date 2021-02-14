;Don't insert this as blocks, this code is intended for UberASM
;to show the number of keys on status bar/HUD. Insert this code
;in statusbar_code.asm (do not use this if using the super
;status bar patch) or level_code.asm.

;Note: due to the YXPCCCTT format of the status bar/HUD, if one
;of its properties bit is set will also effect the number tile
;(so if you place this on an x-flipped tile, that graphic will
;also be x-flipped).

!FreeRamAlttpKey =	$0DA1
!status_pos =		$0F09	;>ram address position of status
				; bar/HUD, set this to $0000
				; (scratch ram) for super status
				; bar patch and scroll down to
				; where it store the scratch ram
				; data into assb's ram.
!key_symbol	= $4E		;>tile number for key icon.

	LDA #$FC		;\show nothing.
	STA !status_pos		;|(placed here so it can get overwritten
	STA !status_pos+1	;|when greater than zero).
	STA !status_pos+2	;|
	STA !status_pos+3	;/

	LDA !FreeRamAlttpKey	;\if zero keys
	BEQ scratch2HUD		;/then show nothing.

	LDA #!key_symbol	;\display key symbol.
	STA !status_pos		;/

	LDA !FreeRamAlttpKey
	CMP #$01		;\if there is only 1 key, then write only 1 key.
	BEQ scratch2HUD		;/(while leaving the key symbol above).

	LDA #$26		;\show "X" symbol.
	STA !status_pos+1	;/

	LDA !FreeRamAlttpKey
	CMP #$0A		;\if 2-9 keys, then show one digit.
	BCC OneDigitKey		;/
	CMP #$64		;\if 10-99 keys, then show two digits.
	BCC TwoDigitKey		;/
	JMP scratch2HUD

OneDigitKey:
	LDA !FreeRamAlttpKey
	STA !status_pos+2	;>1st digit (ones place)
	JMP scratch2HUD

TwoDigitKey:
	JSR HexDec
	STA !status_pos+3	;>2nd digit (ones place)
	STX !status_pos+2	;>1st digit (tens place)

scratch2HUD:
;--------------------------------------------------------
;This will write the tiles into super status bar's tiles.
;Remove semicolons if using it (if changing the ram it
;uses or wanted in a different position, you gunna need
;to change "STA $XXXXXX+Y")
;--------------------------------------------------------
;	LDA $0000
;	STA $7FA040
;	LDA $0001
;	STA $7FA040+2
;	LDA $0002
;	STA $7FA040+4
;	LDA $0003
;	STA $7FA040+6
key_return:
	RTS
;---------------------------------------------------------------------------------
;Hex->Dec subroutine below, if have code below here, move this to the very bottom.
;---------------------------------------------------------------------------------
HexDec:
	LDX #$00
-
	CMP #$0A
	BCC +
	SBC #$0A
	INX
	BRA -
+
	RTS