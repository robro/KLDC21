;This piece of ASM makes the player instantly die, when he loses his powerup.
;This ASM is meant to be inserted as gamemode 14 or as level-asm. It runs on every (sub)screen in a level.
;See idoplLevel.asm for more customizability (Should be chosen, if you need the extra options).
;Version 2.1
;Created by Badummzi, small optimizations by Maarfy

;===Customizable===

!sfx = $20			;"get hurt" sfx overwrite. See section $7E:1DF9 of this thread: https://www.smwcentral.net/?p=viewthread&t=6665 (If set to $00, the sfx will not get overwritten.)

;===End of customizable stuff===

;Code begins below

main:
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