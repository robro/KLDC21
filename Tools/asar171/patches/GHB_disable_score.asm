;Score remover, By GreenHammerBro. Credit goes to me and WhiteYoshiEgg.

;This patch will remove the score entirely, similar to how JackTheSpades remove the level
;time limit. Unlike Iceguy's anti-score patch, this one also remove some unessary things
;that he left out:

;-Not to store tile #$FC to the status bar/HUD every frame, this is noticeable if you
;are using a custom counter/meter on that space the score was on, then the custom
;counter gets overwritten by the "invisible" score that *was* there, making that space
;Unusable even though its not there. With this patch, now you CAN use that space for
;something else.

;-Don't show sprite score numbers, even if the score numbers on the HUD is "invisible"
;the numbers that still appear if you damage a sprite are now pointless (whats the point
;of showing the numbers if they are not going to be used?!?). With this patch, you
;don't need to erase the score sprite graphic tile, you can now use that tile for
;something else.

;Note: All smw's score related data is removed, but other codes not from smw's aren't.
;This means if you are using a custom sprite, blocks (the brick block) or any others that
;uses the score routine, will still have in effect as the sprite numbers may still appear
;depending on which code, in this case, look for a comment by pressing CTRL+F to
;find the phrase and type "score" or something similar or related and remove that
;line.

!drumroll = 1	;>set to 0 to remove all drumroll sfx that happens when beating the level
		;(also applies to getting bonus stars). I put this here because if the player
		;doesn't hit the goal tape (which mario will miss the bonus stars), it still
		;play the drumroll effect (once or shortly in duration).


;-------------------------------------------------------------------------------------
;this code below is made by WhiteYoshiEgg (from the DKC sprite status bar patch),
;this code removes the score sprite that appears when killing or damaging a sprite
;(the 200, 400, 800, 1000, 2000, 4000, 8000 points) and removing the score tally at
;level end, except the 1-ups.

; lorom
; 	!addr = $0000
; 	!bank = $800000
; if read1($00FFD6) == $15
; 	sfxrom
; 	!addr = $6000
; 	!bank = $000000
; elseif read1($00FFD5) == $23
; 	sa1rom
; 	!addr = $6000
; 	!bank = $000000
; endif

; org $02ADBD             	;\remove score sprites (that appears when hurting
;         JML DisableScore	;|or defeating enemies), but leave the 1-up.
; org $00F9F5			;|You can replace/overwrite the sprite score numbers
; DisableScore:			;|graphics with something else since its now an unused
;         LDA $16E1|!addr,x	;|graphic.
;         CMP #$0D		;|
;         BCC .no1Up		;|
;         JML $02ADC2|!bank	;|
; .no1Up				;|
;         JML $02ADC5|!bank	;/

; org $05CC42            				;\Remove endlevel score tally.
;         db $FC,$38,$FC,$38,$FC,$38,$FC,$38	;|
;         db $FC,$38,$FC,$38,$FC,$38,$FC,$38	;|
;         db $FC,$38,$FC,$38,$FC,$38,$FC,$38	;|
;         db $FC,$38,$FC,$38,$FC,$38,$FF		;/

; org $05CC77			;other score stuff (possibly the calculations and other score-related things?)
;         BRA + : NOP #11 : +	;It will not remove the bonus star stuff.
; org $05CCAA
;         BRA + : NOP #76 : +
; org $05CE4C
;         JMP + : NOP #83 : +
; org $05CEAF
;         db $FC
; org $05CCFB
;         BRA + : NOP #41 : +
; org $05CECF
;         BRA + : NOP #52 : +
; org $05CF36
;         NOP #3
; org $05CF78
;         BRA + : NOP #38 : +
; org $05CDFD
;         JMP + : NOP #57 : +
;WhiteYoshiEgg's code ends here-------------------------------------------------------
;org $008EDB		;\disable code from writing score tiles to status bar, this means
;	db $EA,$EA,$EA	;|you are free to use that space the score was on without having
;org $008F09		;|it overwritten by blank tiles!!
;	db $EA,$EA,$EA	;/

;^2020/01/24 EDIT: There is a bug that the game will still write blank tiles (#$FC)
; due to this code that should also be disabled/skipped:
;CODE_008EDE:        A2 00         LDX.B #$00                ; \  
;CODE_008EE0:        BD 29 0F      LDA.W $0F29,X             ;  | 
;CODE_008EE3:        D0 0A         BNE CODE_008EEF           ;  | 
;CODE_008EE5:        A9 FC         LDA.B #$FC                ;  |Replace all leading zeroes in the score with spaces 
;CODE_008EE7:        9D 29 0F      STA.W $0F29,X             ;  | 
;CODE_008EEA:        E8            INX                       ;  | 
;CODE_008EEB:        E0 06         CPX.B #$06                ;  | 
;CODE_008EED:        D0 F1         BNE CODE_008EE0           ;  | 
;
;This means that if RAM $0F29-$0F2E contains tile #$00 (the "0" graphic) on the first n tiles/byte,
;they will be replaced with #$FC. A HUGE jump would not only skip these tile blank-ers, but also
;save some performance.
org $008E95
	JMP.w $008F1D

org $008CF5		;\remove the last 0 that isn't controlled by routine.
	db $FC		;/

if !drumroll = 0
org $05CDE4		;\remove drumroll sfx (even if you get bonus stars, sorry).
	db $00		;|
org $05CF49		;|
	db $00		;/
else
org $05CDE4		;\reenable drumroll sfx
	db $11		;|
org $05CF49		;|
	db $12		;/
endif
