; This uberasm will turn all vanilla ON/OFF blocks to used brown blocks after they've been hit once, making them one-time use blocks.

; What block the ON/OFF turns into.
; For valid values, see https://smwc.me/m/smw/ram/7E009C/
!HitBlock = $0D

main:
	lda $9D
	ora $13D4|!addr
	bne .return
	stz $59
	ldy #$03
-	lda $1699|!addr,y
	cmp #$06
	bne +
	lda $16C5|!addr,y
	cmp #$01
	bne +
	inc $59
	lda #$00
	sta $1699|!addr,y
	sta $16C5|!addr,y
	lda $16A1|!addr,y
	and #$F0
	clc
	adc #$10
	sta $98
	lda $16A9|!addr,y
	adc #$00
	sta $99
	lda $16A5|!addr,y
	and #$F0
	sta $9A
	lda $16AD|!addr,y
	sta $9B
	lda $16C9|!addr,y
	asl
	rol
	and #$01
	sta $1933|!addr
	lda #!HitBlock
	sta $9C
	phy
	jsl $00BEB0|!bank
	ply
+	dey
	bpl -
	lda $59
	beq .return
	lda $14AF|!addr
	eor #$01
	sta $14AF|!addr
.return
	rtl
