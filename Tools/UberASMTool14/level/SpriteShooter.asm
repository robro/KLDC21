;==========================================================
; Better sprite shooter
; By Erik557
;
; Description: This sprite allows Mario to shoot sprite
; projectiles (or any sprite). Better than wiiq's garbage
; that isn't coded properly, in UberASM for convenience.
; Adds features to despawn whatever sprite was shooted.
; Note: Uses 1FD6 as FreeRAM.
;==========================================================

;====================
; Defines and stuff
;====================

       !custom       = 1           ;   1 for custom, anything else for normal
       !extraBit     = 0           ;   0 clear, 1 set, anything else for a crash
       !limitSpawns  = 1           ;   1 to limit how many sprites can be spawned, 0 to not do so
       !spawnedLimit = $03         ;   amount of the same sprites that can be on-screen at once (if the above is 1)
       !sprite       = $0E         ;   sprite to generate
       !status       = $09         ;   status of the spawned sprite. leave it at $08 if you don't know what
       !buttonA      = $10         ;   bit of the button(s) that will allow the projectile to be shooted.
       !buttonB      = $20         ;   bit of the button(s) that will cause the projectile to be despawned. see below link for both
       !buttonRAM    = $18         ;   should be $16 or $18. see https://www.smwcentral.net/?p=nmap&m=smwram#7E0016 for info
       !sprYSpeed    = $00         ;   y speed of the sprite
       !sprYpos      = $0E         ;   relative to Mario's position
       !spawnSFX     = $06         ;\  sound and port, see https://smwc.me/96604 for info. set to 0 for none
       !spawnPort    = $1DFC       ;/
       !despawnSFX   = $10         ;\  this will play when a sprite is despawned. set to 0 for none
       !despawnPort  = $1DF9       ;/
       !wrongSFX     = $2A         ;\  this will play when there's no slots available or there's no sprite to despawn. set to 0 for none
       !wrongPort    = $1DFC       ;/

	   !ExtraByte_1  = $00         ;
	   !ExtraByte_2  = $00         ;
	   !ExtraByte_3  = $00         ;
	   !ExtraByte_4  = $00         ;

sprXPos:
       db $F0,$10                  ;   relative to Mario's position
sprXOff:
       db $FF,$00                  ;   don't touch :angry:
sprXSpeed:
       db $F8,$08                  ;   x speeds. will have no effect if they aren't used or are modified in the sprite so dw

;========================
; Main code begins here
;========================

main:
       LDA $9D
       ORA $13D4|!addr
       BNE .return
       LDX #$0B
       LDA.b !buttonRAM
       BIT #!buttonA
       BNE .spawn
       AND #!buttonB
       BEQ .return

-      LDA !14C8,x
       BEQ .nextDespawn
       LDA !1FD6,x
       BEQ .nextDespawn
       STZ !14C8,x
       if !despawnSFX != 0
              LDA.b #!despawnSFX
              STA.w !despawnPort|!addr
       endif
       RTL
.nextDespawn
       DEX
       BPL -
       if !wrongSFX != 0           ;   faster than BRA
              LDA.b #!wrongSFX
              STA.w !wrongPort|!addr
       endif
       RTL

.spawn
-      LDA !14C8,x
       BEQ .freeSlot
       DEX
       BPL -
.wrongRet
       if !wrongSFX != 0
              LDA.b #!wrongSFX
              STA.w !wrongPort|!addr
       endif
.return
       RTL

.freeSlot
       STX $01
       if !limitSpawns == 1
              STZ $00
              LDX #!sprite_slots-1
       -      
              if !custom == 1
                     LDA !7FAB9E,x
              else
                     LDA !9E,x
              endif
              CMP.b #!sprite
              BNE .decLoop
              LDA !14C8,x
              BEQ .decLoop
              INC $00
              LDA $00
              CMP.b #!spawnedLimit
              BCS .wrongRet
       .decLoop
              DEX
              BPL -
       endif

       if !spawnSFX != 0
              LDA.b #!spawnSFX
              STA.w !spawnPort
       endif
       LDX $01
       LDY $76
       LDA $94
       CLC
       ADC sprXPos,y
       STA !E4,x
       LDA $95
       ADC sprXOff,y
       STA !14E0,x
       if !sprYpos != 0
              LDA $96
              CLC
              ADC.b #!sprYpos
              STA !D8,x
              LDA $97
              ADC #$00
              STA !14D4,x
       endif
       LDA.b #!sprite
       if !custom == 1
              STA !7FAB9E,x
       else
              STA !9E,x
       endif
       LDA.b #!status
       STA !14C8,x
       JSL $07F7D2|!bank
       if !custom == 1
              JSL.l read3($0187A8)
              LDA.b #$08+(!extraBit*4)
              STA !7FAB10,x
       endif
       LDA sprXSpeed,y
       STA !B6,x
       if !sprYSpeed != 0
              LDA.b #!sprYSpeed
              STA !AA,x
       endif
       LDA $76
       EOR #$01
       STA !157C,x
       LDA #$0C
       STA !154C,x
       INC !1FD6,x

	   ; The following stuff were added as per request by the creator.
	   LDA #!ExtraByte_1
	   STA !extra_byte_1,x
	   LDA #!ExtraByte_2
	   STA !extra_byte_2,x
	   LDA #!ExtraByte_3
	   STA !extra_byte_3,x
	   LDA #!ExtraByte_4
	   STA !extra_byte_4,x

       RTL

