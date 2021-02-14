; single screen code by TheBiob
!true = 1
!false = 0
!pause_transition = 0
!disable_pause = 1

!RAM_l1HorzTo = $60	; 2 byte freeram
!RAM_l1VertTo = $62 ; 2 byte freeram

; Pause behavior
!DEF_pause_behavior = !pause_transition
;!pause_transition will allow pausing the game during a screen transition
;!disable_pause will not allow you to pause at all during a screen transition (for example when the !DEF_blackout option is set)

!DEF_blackout = !false			; make the screen black while it's scrolling
!DEF_vert_scrolling = !true		; enable vertical single screen scrolling
!DEF_horz_scrolling = !true 	; enable horizontal single screen scrolling
!DEF_vert_align = !false		; align the camera to the nearest vertical screen and center it there (Note: The screen must start close to that border or graphical glitches may occur)
!DEF_horz_align = !false		; align the camera to the nearest horizontal screen and center it there (Note: The screen must start close to that border or graphical glitches may occur)

!DEF_x_offset = #$0008			; x offset that triggers the screen moving
!DEF_y_offset = #$0020			; y offset that triggers the screen moving

!DEF_screen_width = $100		; scroll width
!DEF_screen_height = $100		; scroll height

!DEF_vert_scroll_speed = $08	; vertical scroll speed, !DEF_screen_height must be divisible by this value. It's not recommended to go above $10 due to sprite loading issues
!DEF_horz_scroll_speed = $08	; horizontal scroll speed, !DEF_screen_width must be divisible by this value It's not recommended to go above $10 due to sprite loading issues

pushpc	; required hijack, apply remove.asm using asar if you remove this uberasm code from your hack.
org $00E98C
	JML SideExit
pullpc
SideExit:
	LDA $1B96|!addr
	BEQ +
	CMP #$AC
	BEQ ++
	REP #$20
	JML $00E993|!bank
+	JML $00E9A1|!bank
++	JML $00E9FB|!bank

init:
	REP #$20
	if !DEF_horz_scrolling == !true
		if !DEF_horz_align == !true
			LDA $94
			AND #$FF00
			STA $1462|!addr
			STA $1A
		else
			LDA $1462|!addr
		endif
		STA !RAM_l1HorzTo
	endif

	if !DEF_vert_scrolling == !true
		if !DEF_vert_align == !true
			LDA $96
			AND #$FF00
			CLC : ADC #$0010
			STA $1464|!addr
			STA $1C
		else
			LDA $1464|!addr
		endif
		STA !RAM_l1VertTo
	endif

	if !DEF_vert_scrolling == !true && !DEF_horz_scrolling == !true
		STZ $1411|!addr	; > Disable horz&vert scrolling
		SEP #$20
	else
		SEP #$20
		if !DEF_vert_scrolling == !true
			STZ $1412|!addr	; > Disable vert scrolling
		endif

		if !DEF_horz_scrolling == !true
			STZ $1411|!addr	; > Disable horz scrolling
		endif
	endif

	LDA #$AC	    ; \ enable side exits hijack to ensure the player is able to leave the screen
	STA $1B96|!addr	; /
return:
RTL

main:
if !DEF_pause_behavior == !pause_transition
	LDA $13D4|!addr ; don't run the routine when the game is paused
	BNE return
endif
	LDA #$01
	STA $9D

if !DEF_blackout == !true
	STZ $0DAE|!addr
endif

	REP #$20
if !DEF_vert_scrolling == !true
		LDA $1464|!addr
		CMP !RAM_l1VertTo
		BEQ +
		BCC .addVrt
		SEC : SBC.w #!DEF_vert_scroll_speed
		BRA .strVrt
.addVrt	CLC : ADC.w #!DEF_vert_scroll_speed
.strVrt	STA $1464|!addr
	SEP #$20
	if !DEF_pause_behavior == !disable_pause
	LDA #$02 ; prevent pausing during a transition
	STA $13D3|!addr
	endif
	RTL
endif

if !DEF_horz_scrolling == !true
+		LDA $1462|!addr
		CMP !RAM_l1HorzTo
		BEQ +
		BCC .addHrz
		SEC : SBC.w #!DEF_horz_scroll_speed
		BRA .strHrz
.addHrz	CLC : ADC.w #!DEF_horz_scroll_speed
.strHrz	STA $1462|!addr
	SEP #$20
	if !DEF_pause_behavior == !disable_pause
	LDA #$02 ; prevent pausing during a transition
	STA $13D3|!addr
	endif
	RTL
endif

; vertical screen scrolling
if !DEF_vert_scrolling == !true
+		LDA $96
		CLC : ADC.w !DEF_y_offset
		STA $00
		LDA !RAM_l1VertTo
		CMP $00
		BPL .subtractVert
		CLC : ADC.w #!DEF_screen_height
		CMP $00
		BMI .storeVert
		BRA .skipVert
.subtractVert
		SEC : SBC.w #!DEF_screen_height
.storeVert
		CMP #$0000
		BMI .skipVert
		CLC : ADC #$00E0
		CMP $13D7|!addr
		BCS .skipVert
		SEC : SBC #$00E0
		STA !RAM_l1VertTo
.skipVert
endif

; horizontal screen scrolling
if !DEF_horz_scrolling == !true
+		LDA $94
		CLC : ADC.w !DEF_x_offset
		STA $00
		LDA !RAM_l1HorzTo
		CMP $00
		BPL .subtractHorz
		CLC : ADC.w #!DEF_screen_width
		CMP $00
		BMI .storeHorz
		BRA .skipHorz
.subtractHorz
		SEC : SBC.w #!DEF_screen_width
.storeHorz
		CMP #$0000
		BMI .skipHorz	; don't store if the result is before screen 0
		STA !RAM_l1HorzTo
.skipHorz
endif

; side border code
+		LDA $1462|!addr
		SEC : SBC.w #!DEF_screen_width
		BPL .noBorderLeft
		LDA $94
		SEC : SBC $1462|!addr
		CMP #$0080
		BCC .activeBorder
.noBorderLeft
		LDA $5B
		AND #$0001
		TAX
		LDA $5E,x
		AND #$00FF
		XBA
		SEC : SBC #$0100
		SEC : SBC.w #!DEF_screen_width
		CMP $1462|!addr
		BPL .noBorderRight
		LDA $94
		SEC : SBC $1462|!addr
		CMP #$0080
		BPL .activeBorder
.noBorderRight
	SEP #$20

;.disableBorder
	LDA #$AC
	STA $1B96|!addr
	BRA .done
.activeBorder
	SEP #$20
	STZ $1B96|!addr
.done
if !DEF_blackout == !true
	LDA #$0F
	STA $0DAE|!addr
endif
	STZ $9D	; > Unpause game
RTL

assert !DEF_screen_width%!DEF_horz_scroll_speed == 0, "The horizontal scroll speed must be divisible by the screen width."
assert !DEF_screen_height%!DEF_vert_scroll_speed == 0, "The vertical scroll speed must be divisible by the screen height."
