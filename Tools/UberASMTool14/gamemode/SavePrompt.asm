;Insert this as Game Mode 0E

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Bring up Save Prompt By pressing select + Autosave patch.   
; Original patches by Erik and Alcaro, UberASM version by West                                 
;
; Allows you to save the game on the overworld automatically or 
; by pressing the select button with or without bringing up a save prompt. (see defines below)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

!SaveFlag = $14C1|!addr		;Flag used to make sure the code runs only once per level-tile. (prevents lag)

!Autosave = !no		;If enabled the game will automatically save everytime the player moves AND enters the overworld, if you insert the other gamemode patch.
!SkipPrompt = !no		;If enabled the game will automatically save once the select button is pressed. 

!SkipPromptSound = $05		;\ Sound effect that plays if the skip prompt option is enabled. $00 is reccomended if you have enabled Auto-saving.
!SkipPromptBank = $1DF9|!addr		;/ use this link to find which sound effects to use. https://www.smwcentral.net/?p=viewthread&t=6665
 
!no = 0			;\ Don't change these.
!yes = 1		;/

if !Autosave == 1			;\
!SkipPrompt = 1				;| Skips the prompt automatically if autosave is enabled. 
endif					;/

main:
	if !Autosave
	LDA $13D9|!addr
	CMP #$04
	BEQ .Reset
	LDA !SaveFlag
	CMP #$01
	BEQ .Return
	LDA $13D9|!addr
	CMP #$03
	BEQ .Save
	RTL							 
	endif
	LDA $16			; \ 
	AND #$20		; | Check if the select button is pressed.
	BEQ .Return		; /
	LDA $13D9|!addr       ;\
    CMP #$03        ; | don't do anything if not on a level tile
    BNE .Return     ;/
	if !SkipPrompt
	BRA .Save
	endif
	LDA $1B87|!addr		;\
	CMP #$05		; | don't show prompt if it's already being shown.
	BCS .Return		;/
	JSR Save
	INC $13CA|!addr        ;   save prompt is being brought up
	JSR CODE_049037   ;   make save prompt appear
	.Return
	RTL
	
	.Reset
	STZ !SaveFlag
	RTL
	
	.Save
	LDA #!SkipPromptSound		
	STA !SkipPromptBank
	JSR Save	;shoutouts to Erik for making this sub-routine.	 
	JSR CODE_049037
	JSL $009BC9|!bank  ;Jump to save-game routine. (since the prompt is disabled.)
	LDA #$01
	STA !SaveFlag
	RTL
	
Save:                           ;   based around $048F94
        LDX #$2C                ;\
-       LDA $1F02|!addr,x       ; |
        STA $1FA9|!addr,x       ; | update some misc stuff in the save buffer not updated in $049037
        DEX                     ; |
        BPL -                   ;/
        REP #$30                ;   16-bit axy
        LDX $0DD6|!addr         ;\
        TXA                     ; | load mario/luigi data on x and luigi/mario data on y
        EOR #$0004              ; |
        TAY                     ;/
        LDA $1FBE|!addr,x       ;\
        STA $1FBE|!addr,y       ; |
        LDA $1FC0|!addr,x       ; |
        STA $1FC0|!addr,y       ; | sync x/y positions and its pointers between players
        LDA $1FC6|!addr,x       ; |
        STA $1FC6|!addr,y       ; |
        LDA $1FC8|!addr,x       ; |
        STA $1FC8|!addr,y       ;/
        TXA                     ;\
        LSR                     ; |
        TAX                     ; | more of the same
        EOR #$0002              ; |
        TAY                     ;/
        LDA $1FBA|!addr,x       ;\  sync player animations
        STA $1FBA|!addr,y       ;/
        TXA                     ;\
        SEP #$30                ; | 8-bit axy
        LSR                     ; |
        TAX                     ; | more of the same
        EOR #$01                ; |
        TAY                     ;/
        LDA $1FB8|!addr,x       ;\  sync submap between players
        STA $1FB8|!addr,y       ;/
        RTS
				
CODE_049037:   		;Sub-routine used to transfer some overworld settings over to SRAM see $049037 in the disassembly for more details.	
PHX                       
PHY                       
PHP       
if !SkipPrompt == 0
LDA $13CA|!addr               
BEQ -    
endif
LDX #$5F                
--      
LDA $1EA2|!addr,x             
STA $1F49|!addr,x              
DEX                       
BPL --   
if !SkipPrompt == 0
STZ $13CA|!addr               
LDA #$05                
STA $1B87|!addr  
endif
-     
PLP                       
PLY                       
PLX                         
RTS 