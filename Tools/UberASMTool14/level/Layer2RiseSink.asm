;========================================;
; Custom Layer 2 Sink/Rise Commands      ;
; By Erik557                             ;
;========================================;
; This will allow you to create your     ;
; own simple layer 2 sink/rise commands. ;
; (probably) NOT COMPATIBLE WITH Layer 3.;
;========================================;
; NOTE: BG Scroll settings SHOULD BE     ;
; H: Constant, V: None.                  ;
;========================================;

!FreeRAM = $18B4|!addr      ; 1 byte.
!StopAt = $01               ; where to stop the scroll + 1. F1 is the bottom. 01, the top.
!Type = 1                   ; 0 = sink; 1 = rise.
!Speed = $07                ; valid values: 01, 03, 07, 0F, 1F, 3F, 7F. the larger, the slower.

; don't touch.

!CurrentLayerY = $20
!NFrameLayerY = $1468|!addr


if !Type = 1
       !Move = INC
       !Stop = BCC
else
       !Move = DEC
       !Stop = BCS
endif

main:
       LDA !FreeRAM         ;\ if ram already set, skip touching check
       BNE .Start           ;/
       LDA $13EF|!addr      ;\ if not touching, return
       CMP #02              ; |
       BCC .Return          ;/
       INC !FreeRAM         ; bypass future checks
.Start
       LDA !CurrentLayerY   ;\ if already at the limit, return
       CMP #!StopAt         ; |
       !Stop .Return        ;/
       LDA $9D              ;\ is sprites locked, return
       BNE .Return          ;/
       LDA $14              ;\ return every certain frames
       AND #!Speed          ; |
       BNE .Return          ;/
       REP #$20             ;\ move the layer
       !Move !NFrameLayerY  ; |
       SEP #$20             ;/
.Return
	RTL