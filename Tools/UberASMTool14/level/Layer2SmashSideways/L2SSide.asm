;=================================================
; Layer 2 Smash Sideways
; By Erik557
;=================================================
; This is an horizontal version of the Layer 2
; smasher you see in, for example, Wendy's castle.
; It's very customizable.
;=================================================


; Defines and tables

!FreeRAM      =      $18CB                ; 2 bytes. must be between $0100 and $1fff

!SmashPos     =      $E0                  ; where will the smasher stop before rising again.

timeBefFalling:                           ; time until the smasher falls.
       db $40,$10,$10,$20,$30             ; smaller the value, smaller the delay

timeBefOffset:                            ; time before the smasher lowers by one tile.
       db $80,$20,$20,$40,$60             ; smaller the value, smaller the delay

smashSpeed:                               ; speed of the smasher when it falls.
       db $02,$01,$02,$02,$05             ; the smaller the value, the slower it smashes

timeBefRising:                            ; time before the smasher goes back.
       db $50,$2C,$28,$24,$20             ; smaller the value, smaller the delay

riseSpeed:                                ; speed of the smasher when it rises.
       db $01,$01,$01,$02,$04             ; the smaller the value, the slower it smashes

screenStart:
minScreenPos:                             ; screens with activity and no activity.
       dw $06F8,$0450,$04E0,$0400,$0330

maxScreenPos:
       dw $0550,$0380,$0420,$03A0,$0000
screenEnd:

!FreeRAM      :=     !FreeRAM|!addr

init:
       LDA $71              ;\
       CMP #$0A             ; | don't run on castle intros
       BEQ .return          ;/
       STZ $1466|!addr      ;   initial layer 2 pos
       STZ $1411|!addr      ;   no horizontal scroll
       LDY #$00             ;\
       LDA timeBefFalling,y ; | init timer
       STA !FreeRAM         ;/
       STZ !FreeRAM+1
.return
       RTL

main:
       LDA $71                            ;\
       CMP #$0A                           ; | don't run on castle intros
       BEQ .return                        ;/
       LDA $9D                            ;\
       ORA $13D4|!addr                    ; | don't run on game locked or pause
       BNE .return                        ;/
       REP #$20                           ;   16-bit A
       LDY.b #screenEnd-screenStart/2-2   ;   number of screens to check
.posLoop
       LDA $1468|!addr                    ;\
       CMP minScreenPos,y                 ; |
       BCS .checkNextScreen               ; | check if mario is in the specified positions
       CMP maxScreenPos,y                 ; |
       BCC .checkNextScreen               ;/
       SEP #$20                           ;   8-bit A
       LDA.w !FreeRAM                     ;\  check if time for move is now
       BEQ smash                          ;/
       DEC.w !FreeRAM                     ;   if not, decrement timer and return
       RTL

.checkNextScreen
       DEY                                ;\
       DEY                                ; | check next set of screens
       BPL .posLoop                       ;/
       SEP #$20                           ;   8-bit A
       STZ $1466|!addr                    ;   reset layer 2 pos
.return
       RTL

smash:
       TYA                  ;\
       LSR                  ; | correctly index the next tables
       TAY                  ;/
       LDA !FreeRAM+1       ;\  check if fall or rise
       BEQ .offset          ;/
       CMP #$01
       BEQ .fall
.rise
       LDA $1466|!addr      ;\
       SEC                  ; | increase layer 2 pos
       SBC riseSpeed,y      ;/
       BNE +                ;   return if not time to offset
       STZ !FreeRAM+1       ;   decrease state
       LDA timeBefOffset,y  ;\  set time before the smasher offsets
       STA !FreeRAM         ;/
       LDA #$00             ;\  set layer 2 position
+      STA $1466|!addr      ;/
..return
       RTL
.fall
       LDA $1466|!addr      ;\
       CLC                  ; | decrease layer 2 pos
       ADC smashSpeed,y     ;/
       CMP #!SmashPos       ;\  return if not time to return (...)
       BNE +                ;/
       INC !FreeRAM+1       ;   increase state
       LDA #$20             ;\  shake layer 1
       STA $1887|!addr      ;/
       LDA #$09             ;\  play SFX
       STA $1DFC|!addr      ;/
       LDA timeBefRising,y  ;\  set time before the smasher rises
       STA !FreeRAM         ;/
       LDA #!SmashPos       ;\  set layer 2 position
+      STA $1466|!addr      ;/
..return
       RTL

.offset
       LDA $1466|!addr      ;\
       INC                  ; | decrease layer 2 pos
       STA $1466|!addr      ;/
       CMP #$10             ;\  return if not time to fall
       BNE ..return         ;/
       INC !FreeRAM+1       ;   increase state
       LDA timeBefFalling,y ;\  set time before the smasher falls
       STA !FreeRAM         ;/
..return
       RTL

