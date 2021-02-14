;This piece of ASM makes the player instantly die, when he loses his powerup.
;This ASM is meant to be inserted as level-asm. It can be customized to not/only run on certain (sub)screens.
;See idopl.asm for less customizability and Gamemode 14 "support".
;Version 2.1
;Created by Badummzi, small optimizations by Maarfy

;===Customizable===

!sfx = $20			;"get hurt" sfx overwrite. See section $7E:1DF9 of this thread: https://www.smwcentral.net/?p=viewthread&t=6665 (If set to $00, the sfx will not get overwritten.)

;*****

!mode = 00			;00 = RunOnScreen refers to horizontal screen-numbers (Ram Adress: $D1+#$1F00, In Lunar Magic, referred to as "Screens"), 01 = RunOnScreen refers to vertical screen-numbers (Ram Adress: $D3+#$1F00, In Lunar Magic, referred to as "Subscreens")

RunOnScreen:
;   0   1   2   3   4   5   6   7   8   9   A   B   C   D   E   F	<In Lunar Magic: Top = 00 and Bottom = 01 (Only useful when !mode = 01)
db $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01	;(Sub)screen 00 - 0F | $01 = Run on this screen, $00 = Don't run on this screen
db $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01	;(Sub)screen 10 - 1F | /
									;etc. | You can ignore or delete unnecessary screens. If you need more screens, just add as many more screens in the "table-format" (db $01, $01, ...), after the existing ones, as you like! (the length of the table doesn't really matter in this manner, you can end it even after one entry (db $01)

;===End of customizable stuff===

;Code begins below

main:
	if !mode == 00
		LDX $D2
	else
		REP #$20
		LDA $D3
		CLC
		ADC #$001F
		SEP #$20
		XBA
		TAX
	endif
	LDA RunOnScreen,x
	BEQ return
	LDA $71
	CMP #$01
	BNE return

death:
	if !sfx != $00
		LDA #!sfx
		STA $1DF9|!addr
	endif
	JSL $00F606|!bank

return:
	RTL