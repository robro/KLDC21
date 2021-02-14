;Cutscene mode - by Blind Devil
;Placing this in a level will prevent you from pausing/moving/jumping and so on,
;allowing the creation of custom cutscenes.
;It will require either a button input or waiting a certain time to advance the cutscene.

;Below are lots of configurable defines, such as what button to press or time to wait before warping,
;warp to screen exit/beat level/OW warp to coordinated/title screen warp, SFX to play and so on.

;~LOCK SPRITES AND ANIMATION~
;If non-zero, all sprites and animations will be frozen. Useful if you want to place Mario in the cutscene.
;If zero, everything but Mario will move.
;0 = sprites and animations will run. 1 = sprites and animations will be locked.
	!CutLockAnimations = 1

;~MARIO POSE AND FACING DIRECTION~
;What pose Mario will be doing.
;Useful if you want to place him in the cutscene, as he'll be shown with his current powerup.
;For possible values, check: http://www.smwiki.net/wiki/Player_poses - $00 will use regular game pose.
;For facing direction:
;0 = facing left. 1 = facing right.
;Caution: If you're riding Yoshi, these won't work properly.
	!CutPlayerPose = $00
	!CutPlayerFacingDir = 1

;~TIME TO WAIT~
;How long to wait before advancing the cutscene. Button inputs won't work if this is used.
;Possible values: $01-$FF. (e.g. $1F would be approx. 2 seconds, $FF would be 16 seconds.)
;It uses one of the unused decrementing RAM addresses, precisely $14AC.
;If you want to use button input instead, leave this as $00.
	!CutTimeToWait = $00

;~BUTTON TO PRESS~
;What button to press to advance the cutscene. Won't work if the timer is used.
;Depending on the Button RAM, they can be:
;if RAM = $16: B=$80, Y=$40, Select=$20, Start=$10, Up=$08, Down=$04, Left=$02, Right=$01. 
;if RAM = $18: A=$80, X=$40, L=$20, R=$10.
;Caution: Make sure it's not the same button to press as the skipping button!
;Also, button RAM is what index to use for the button input, as mentioned above.
;Can be either $16 or $18. Do not use other values!
	!CutButton1 = $80
	!Button1RAM = $16

;~SOUND EFFECT~
;What SFX to play when the above configured button is pressed.
;Use $00 to use no sound effect.
;Note that no SFX will play at all if you're using the timer.
	!CutButtonSFX = $29

;~SOUND EFFECT BANK~
;What SFX bank to use for the above configured SFX.
;Can be either $1DF9 or $1DFC.
	!CutButSFXBank = $1DFC

;~ACTION~
;What action to take once the button is pressed or the timer reaches zero.
;0 = Regular teleport. Will teleport to the configured screen exit in LM.
;1 = Side exit. Will bring you back to the OW without activating any events.
;2 = Beat the level, normal exit. Will bring you back to the OW but will activate the normal exit.
;3 = Beat the level, secret exit. Will bring you back to the OW but will activate the secret exit.
;4 = OW warp. Will bring you to the OW, with pre-configured coordinates without activating any events.
;5 = OW warp + beat level. Will bring you to the OW with pre-configured coordinates and activate the normal exit.*
;6 = OW warp + beat level. Will bring you to the OW with pre-configured coordinates and activate the secret exit.*
;7 = Title screen teleport. Will bring you to the title screen, but it won't trigger any exit nor save progress.
;8 = Credits teleport. Will bring you to the credits, but it won't trigger any exit nor save progress.
;*recommended to insert 'OWTilePropFix.asm' in Gamemode E if using this.
	!CutMainAction = 0

;~OVERWORLD WARP (BOTH)~
;Where to warp Mario/Luigi in the OW if action of ANY buttons is set to 4, 5 or 6.
;The coordinates are shared for buttons to keep it consistent,
;in order to avoid regular button sending to a place and skip button to another.
;To find out X and Y coordinates, you can take a look at this diagram:
;https://s19.postimg.org/fehrrn94j/OWCoord_Diagram.png
;Submap values can be:
;$00=Main map, $01=Yoshi's Island, $02=Vanilla Dome, $03=Forest of Illusion,
;$04=Valley of Bowser, $05=Special World, $06=Star World.
	!CutOWSubmap = $04
	!CutOWXCoord = $0198
	!CutOWYCoord = $0058

;~BUTTON TO PRESS TO SKIP CUTSCENE~
;What button to press to skip* the cutscene. Won't work if the timer is used.
;*it doesn't really skip, just does a different action depending on your configuration.
;Depending on the Button RAM, they can be:
;if RAM = $16: B=$80, Y=$40, Select=$20, Start=$10, Up=$08, Down=$04, Left=$02, Right=$01. 
;if RAM = $18: A=$80, X=$40, L=$20, R=$10.
;Also, if you don't want the skip button enabled, use $00.
;Caution: Make sure it's not the same button to press as the regular advancing button!
;Button RAM is what index to use for the button input.
;Can be either $16 or $18. Do not use other values!
	!CutButton2 = $10
	!Button2RAM = $16

;~SKIP SOUND EFFECT~
;What SFX to play when the above configured button is pressed.
;Note that no SFX will play if you're using the timer instead.
;Use $00 to use no sound effect.
	!CutButton2SFX = $2A

;~SKIP SOUND EFFECT BANK~
;What SFX bank to use for the above configured SFX.
;Can be either $1DF9 or $1DFC.
	!CutBut2SFXBank = $1DF9

;~SKIP ACTION~
;What action to take once the skip button is pressed.
;0 = LEVEL-SPECIFIC teleport. Will teleport to the main/midway/secondary entrance determined in this ASM file!
;1 = Side exit. Will bring you back to the OW without activating any events.
;2 = Beat the level, normal exit. Will bring you back to the OW but will activate the normal exit.
;3 = Beat the level, secret exit. Will bring you back to the OW but will activate the secret exit.
;4 = OW warp. Will bring you to the OW, with pre-configured coordinates without activating any events.
;5 = OW warp + beat level. Will bring you to the OW with pre-configured coordinates and activate the normal exit.*
;6 = OW warp + beat level. Will bring you to the OW with pre-configured coordinates and activate the secret exit.*
;7 = Title screen teleport. Will bring you to the title screen, but it won't trigger any exit nor save progress.
;8 = Credits teleport. Will bring you to the credits, but it won't trigger any exit nor save progress.
;*recommended to insert 'OWTilePropFix.asm' in Gamemode E if using this.
	!CutSkipAction = 0

;~LEVEL TELEPORT SETUP (FOR SKIP)~
;If the skip button action above is set to 0, teleport to the specified level/secondary entrance.
;Secondary and Underwater flags can either be 0 or 1.
;Also, Underwater flag only applies to secondary entrances.
;To use a midway entrance, set the Secondary flag to 0 and the Underwater flag to 1,
;and make sure that the target level has the new separate settings for midway entrance enabled.
;0 = false. 1 = true.
	!CutSkipTeleLevel = $00D2
	!CutSkipIsSecondary = 1
	!CutSkipIsUnderwater = 0

;That should be all.
;Also, thanks to Mathos for the $1DEA->$1F02 bit check conversion code. You rock, bro!
;Thanks to HuFlungDu, too, for reporting the controller input = $40 error. It's hopefully fixed.

;Actual codes go below. Do not change anything there, unless you know what you're doing.

init:
;Tests. They're used because of shared subroutines.
;If a certain action is not used, subroutines won't be inserted.
;That was done in order to reduce insertion size.
;The code handles these flags automatically, so don't change them.
!UseCheckNormalEvent = 0
!UseCheckSecretEvent = 0
!UseEndLevelAction = 0
!UseBeatenProp = 0
!UseOWTeleport = 0
!UseCredits = 0
!UseBitTable = 0

if !CutTimeToWait != $00
	LDA #!CutTimeToWait	;Load amount of fourth frames to wait.
	STA $14AC|!addr		;Store to unused decrementer.
endif
if !CutPlayerPose != $00
	LDA #!CutPlayerPose	;Load new pose value for Mario
	STA $13E0|!addr		;and store it.
endif
if !CutPlayerFacingDir == 0
	STZ $76			;Make the player face left.
endif

LDA #$0D		;Load this value into player animation
STA $71			;to freeze him.

if !CutLockAnimations
	STA $9D			;Store previous A value here as well to lock all animations.
endif
RTL				;Return.

main:
if !CutLockAnimations == 0
		LDA #$2C		;Load value
		STA $0F30|!addr		;Store to timer's timer to freeze it. You wouldn't want to die from time up in a cutscene, would you?
endif

if !CutTimeToWait != $00
	LDA $14AC|!addr			;Load decrementer value.
	BEQ +				;If equal zero, positive branch.
	if !CutLockAnimations
		LDA $13				;Load normal frame counter
		AND #$03			;Check fourth frames
		BNE .return			;Branch to .return if they're set.
		DEC $14AC|!addr			;Decrement $14AC by one manually (address is locked by $9D).
		.return
	endif
	REP #$20			;16-bit A
	STZ $15				;Disable all controller data 1 inputs.
	STZ $17				;Disable all controller data 2 inputs.
	SEP #$20			;8-bit A
	RTL				;Return.
else
	if !CutButton1 == $40
		if !Button1RAM == $16
			LDA $0DA0|!addr			;load controllers plugged in
			AND #$80			;check if both controllers are plugged
			BEQ .regular			;if only one is plugged, use regular addressing.
			LDA $0DB3|!addr			;load current character in play
			ASL				;multiply value
			TAX				;transfer A to X
			LDA $4219,x			;Load respective direct SNES register controller data input
			AND #!CutButton1		;Check if respective bit is set.
			BNE +				;If button is pressed, positive branch.
			.regular
			LDA !Button1RAM			;Load configured controller data RAM for action.
			AND #!CutButton1		;Check if respective bit is set.
			BNE +				;If button is pressed, positive branch.
		else
			LDA $0DA0|!addr			;load controllers plugged in
			AND #$80			;check if both controllers are plugged
			BEQ .regular			;if only one is plugged, use regular addressing.
			LDA $0DB3|!addr			;load current character in play
			ASL				;multiply value
			TAX				;transfer A to X
			LDA $4218,x			;Load respective direct SNES register controller data input
			AND #!CutButton1		;Check if respective bit is set.
			BNE +				;If button is pressed, positive branch.
			.regular
			LDA !Button1RAM			;Load configured controller data RAM for action.
			AND #!CutButton1		;Check if respective bit is set.
			BNE +				;If button is pressed, positive branch.		
		endif
	else
		LDA !Button1RAM			;Load configured controller data RAM for action.
		AND #!CutButton1		;Check if respective bit is set.
		BNE +				;If button is pressed, positive branch.
	endif
	if !CutButton2 != $00
		if !CutButton2 == $40
			if !Button2RAM == $16
				LDA $0DA0|!addr			;load controllers plugged in
				AND #$80			;check if both controllers are plugged
				BEQ .regskip			;if only one is plugged, use regular addressing.
				LDA $0DB3|!addr			;load current character in play
				ASL				;multiply value
				TAX				;transfer A to X
				LDA $4219,x			;Load respective direct SNES register controller data input
				AND #!CutButton2		;Check if respective bit is set.
				BNE .CutSkipAction		;If button is pressed, branch to .CutSkipAction.
				.regskip
				LDA !Button2RAM			;Load configured controller data RAM for action.
				AND #!CutButton2		;Check if respective bit is set.
				BNE .CutSkipAction		;If button is pressed, branch to .CutSkipAction.
			else
				LDA $0DA0|!addr			;load controllers plugged in
				AND #$80			;check if both controllers are plugged
				BEQ .regskip			;if only one is plugged, use regular addressing.
				LDA $0DB3|!addr			;load current character in play
				ASL				;multiply value
				TAX				;transfer A to X
				LDA $4218,x			;Load respective direct SNES register controller data input
				AND #!CutButton2		;Check if respective bit is set.
				BNE .CutSkipAction		;If button is pressed, branch to .CutSkipAction.
				.regskip
				LDA !Button2RAM			;Load configured controller data RAM for action.
				AND #!CutButton2		;Check if respective bit is set.
				BNE .CutSkipAction		;If button is pressed, branch to .CutSkipAction.
			endif
		else
			LDA !Button2RAM			;Load configured controller data RAM for skip action.
			AND #!CutButton2		;Check if respective bit is set.
			BNE .CutSkipAction		;If button is pressed, branch to .CutSkipAction.
		endif
	endif
	REP #$20			;16-bit A
	STZ $15				;Disable all controller data 1 inputs.
	STZ $17				;Disable all controller data 2 inputs.
	SEP #$20			;8-bit A
	RTL				;Return.
endif

+
if !CutTimeToWait == $00
	if !CutButtonSFX != $00
		LDA #!CutButtonSFX		;Load SFX value
		STA !CutButSFXBank|!addr	;Store to configured address to play it.
	endif
endif

if !CutMainAction == 0
	LDA #$06		;Load new player animation status
	STA $71			;Store it.
	STZ $89			;Make it as entering a right-facing pipe.
	STZ $88			;Zero pipe teleporting timer, to instantly teleport Mario.
endif
if !CutMainAction == 1
	JSL $05B160		;Call side exit subroutine from ROM.
endif
if !CutMainAction == 2
	!UseEndLevelAction = 1
	LDA #$01		;Load normal exit action for exitting level
	JSL .CutEndLevelAction	;yay shared subroutine because this effectively saves bytes
	LDA #$0B		;Load fade-out to OW gamemode
	STA $0100|!addr		;Store.
endif
if !CutMainAction == 3
	!UseEndLevelAction = 1
	LDA #$02		;Load secret exit action for exitting level
	JSL .CutEndLevelAction	;yay shared subroutine because this effectively saves bytes
	LDA #$0B		;Load fade-out to OW gamemode
	STA $0100|!addr		;Store.
endif
if !CutMainAction == 4
	!UseOWTeleport = 1
	JSL .CutOWTeleport	;yay shared subroutine because this effectively saves bytes
	JSL $05B160		;Call side exit subroutine from ROM.
endif
if !CutMainAction == 5
	!UseCheckNormalEvent = 1
	JSL .CutCheckNormal

	LDA $00			;Now load result of $1DEA divided
	AND $01			;Do the AND with AND'd $1DEA (now I know it's to check if bit is set or not)
	BNE +			;If event has already been run, positive branch.

	!UseBeatenProp = 1
	JSL .CutBeatenProp	;yay shared subroutine because this effectively saves bytes

	!UseEndLevelAction = 1
	LDA #$01		;Load normal exit action for exitting level
	JSL .CutEndLevelAction	;yay shared subroutine because this effectively saves bytes
	STA $0DD4|!addr		;Store previous A value there, it's a flag for a fix code. It's free RAM.

	+
	!UseOWTeleport = 1
	JSL .CutOWTeleport	;yay shared subroutine because this effectively saves bytes
endif
if !CutMainAction == 6
	!UseCheckSecretEvent = 1
	JSL .CutCheckSecret	;yay shared subroutine because this effectively saves bytes

	LDA $00			;Now load result of $1DEA divided
	AND $01			;Do the AND with AND'd $1DEA (now I know it's to check if bit is set or not)
	BNE +			;If event has already been run, positive branch.

	!UseBeatenProp = 1
	JSL .CutBeatenProp	;yay shared subroutine because this effectively saves bytes

	!UseEndLevelAction = 1
	LDA #$02		;Load secret exit action for exitting level
	JSL .CutEndLevelAction	;yay shared subroutine because this effectively saves bytes
	STA $0DD4|!addr		;Store previous A value there, it's a flag for a fix code. It's free RAM.

	+
	!UseOWTeleport = 1
	JSL .CutOWTeleport	;yay shared subroutine because this effectively saves bytes
endif
if !CutMainAction == 7
	LDA #$02		;Load Nintendo logo fade-out gamemode.
	STA $0100|!addr		;Store it.
endif
if !CutMainAction == 8
	!UseCredits = 1
	JSL .CutCredits		;yay shared subroutine because this effectively saves bytes
endif
RTL				;Return.

if !CutTimeToWait == $00
	if !CutButton2 != $00
		.CutSkipAction
		if !CutButton2SFX != $00
			LDA #!CutButton2SFX		;Load SFX value
			STA !CutBut2SFXBank|!addr	;Store to configured address to play it.
		endif
		if !CutSkipAction == 0
			REP #$20		;16-bit A
			LDA #!CutSkipTeleLevel|(((!CutSkipIsUnderwater<<3)|(1<<2)|(!CutSkipIsSecondary<<1))<<8)	;man this is f**king big
			STA $00			;Parts copied from GPS shared routines.
			STZ $88			;Too lazy to comment on everything.
			SEP #$30
			PHX
			LDX $95
			PHA
			LDA $5B
			LSR
			PLA
			BCC +
			LDX $97
		+
			LDA $00
			STA $19B8|!addr,x
			LDA $01
			STA $19D8|!addr,x
			LDA #$06
			STA $71
			PLX
		endif
		if !CutSkipAction == 1
			JSL $05B160		;Call side exit subroutine from ROM.
		endif
		if !CutSkipAction == 2
			!UseEndLevelAction = 1
			LDA #$01		;Load normal exit action for exitting level
			JSL .CutEndLevelAction	;yay shared subroutine because this effectively saves bytes
			LDA #$0B		;Load fade-out to OW gamemode
			STA $0100|!addr		;Store.
		endif
		if !CutSkipAction == 3
			!UseEndLevelAction = 1
			LDA #$02		;Load secret exit action for exitting level
			JSL .CutEndLevelAction	;yay shared subroutine because this effectively saves bytes
			LDA #$0B		;Load fade-out to OW gamemode
			STA $0100|!addr		;Store.
		endif
		if !CutSkipAction == 4
			!UseOWTeleport = 1
			JSL .CutOWTeleport	;yay shared subroutine because this effectively saves bytes
			JSL $05B160		;Call side exit subroutine from ROM.
		endif
		if !CutSkipAction == 5
			!UseCheckNormalEvent = 1
			JSL .CutCheckNormal

			LDA $00			;Now load result of $1DEA divided
			AND $01			;Do the AND with AND'd $1DEA (now I know it's to check if bit is set or not)
			BNE +			;If event has already been run, positive branch.

			!UseBeatenProp = 1
			JSL .CutBeatenProp	;yay shared subroutine because this effectively saves bytes

			!UseEndLevelAction = 1
			LDA #$01		;Load normal exit action for exitting level
			JSL .CutEndLevelAction	;yay shared subroutine because this effectively saves bytes
			STA $0DD4|!addr		;Store previous A value there, it's a flag for a fix code. It's free RAM.

			+
			!UseOWTeleport = 1
			JSL .CutOWTeleport	;yay shared subroutine because this effectively saves bytes
		endif
		if !CutSkipAction == 6
			!UseCheckSecretEvent = 1
			JSL .CutCheckSecret	;yay shared subroutine because this effectively saves bytes

			LDA $00			;Now load result of $1DEA divided
			AND $01			;Do the AND with AND'd $1DEA (now I know it's to check if bit is set or not)
			BNE +			;If event has already been run, positive branch.

			!UseBeatenProp = 1
			JSL .CutBeatenProp	;yay shared subroutine because this effectively saves bytes

			!UseEndLevelAction = 1
			LDA #$02		;Load secret exit action for exitting level
			JSL .CutEndLevelAction	;yay shared subroutine because this effectively saves bytes
			STA $0DD4|!addr		;Store previous A value there, it's a flag for a fix code. It's free RAM.

			+
			!UseOWTeleport = 1
			JSL .CutOWTeleport	;yay shared subroutine because this effectively saves bytes
		endif
		if !CutSkipAction == 7
			LDA #$02		;Load Nintendo logo fade-out gamemode.
			STA $0100|!addr		;Store it.
		endif
		if !CutSkipAction == 8
			!UseCredits = 1
			JSL .CutCredits		;yay shared subroutine because this effectively saves bytes
		endif
	endif
endif
RTL				;Return.

if !UseCheckNormalEvent
.CutCheckNormal
!UseBitTable = 1
LDA $1DEA|!addr		;Load normal exit event value that current level will trigger.
LSR #3			;apply division by 2 three times (divide by 8)
TAX			;Transfer A value to X.
LDA $1F02|!addr,x	;Load respective OW event flag address.
STA $00			;Store to scratch RAM.
LDA $1DEA|!addr		;I assume we load event number again
AND #$07		;Mask bits? I'm not very used to AND like this so lulz me
TAX			;Transfer A value to X.
LDA .BitTable,x		;Load bit table
STA $01			;Store to scratch RAM.
RTL			;Return.
endif

if !UseCheckSecretEvent
.CutCheckSecret
!UseBitTable = 1
LDA $1DEA|!addr		;Load normal exit event value that current level will trigger.
CLC			;clear carry bit
ADC #$01		;Add #$01, so it reads the secret exit event.
LSR #3			;apply division by 2 three times (divide by 8)
TAX			;Transfer A value to X.
LDA $1F02|!addr,x	;Load respective OW event flag address.
STA $00			;Store to scratch RAM.
LDA $1DEA|!addr		;I assume we load event number again
ADC #$01		;Again add #$01, so it reads the secret exit event. No need to use CLC again - carry is already clear.
AND #$07		;Mask bits? I'm not very used to AND like this so lulz me
TAX			;Transfer A value to X.
LDA .BitTable,x		;Load bit table
STA $01			;Store to scratch RAM.
RTL			;Return.
endif

if !UseEndLevelAction
.CutEndLevelAction
STA $0DD5|!addr		;Store A value to address.
STA $13CE|!addr		;Store A to midway point flag, too. Reason? Dunno, the code is copied.
INC $1DE9|!addr		;lolwut I'm so noobish
RTL			;Return.
endif

if !UseBeatenProp
.CutBeatenProp
LDX $13BF|!addr		;Load translevel on X.
LDA $1EA2|!addr,x	;Load respective level setting flag.
ORA #$80		;Check bit for beaten translevel/OW level.
STA $1EA2|!addr,x	;Store result back.
RTL			;Return.
endif

if !UseOWTeleport
.CutOWTeleport
LDA #$0B		;Load fade-out to OW gamemode
STA $0100|!addr		;Store.
LDX $0DB3|!addr		;Load character in play into X.
LDA #!CutOWSubmap	;Load new submap
STA $1F11|!addr,x	;Store into current submap for respective player.
LDX $0DD6|!addr		;Load OW character in play into X.
REP #$20		;16-bit A
LDA #!CutOWXCoord	;Load new X coordinate
STA $1F17|!addr,x	;Store it.
LSR #4			;Divide 4 times
STA $1F1F|!addr,x	;Store result into pointer to X position (to display correct level name).
LDA #!CutOWYCoord	;Load new Y coordinate
STA $1F19|!addr,x	;Store it.
LSR #4			;Divide 4 times
STA $1F21|!addr,x	;Store result into pointer to X position (to display correct level name).
SEP #$20		;8-bit A
RTL			;Return.
endif

if !UseCredits
.CutCredits
LDA #$08		;Load this value
STA $13C6|!addr		;Store to cutscene related address to play credits.
LDA #$18		;Load Pre-credits fade-out gamemode.
STA $0100|!addr		;Store it.
RTL			;Return.
endif

if !UseBitTable
.BitTable
db $80,$40,$20,$10,$08,$04,$02,$01		;Don't change this.
endif