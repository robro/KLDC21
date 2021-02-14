;; Code which teleports the player to a specified level when all sprites are killed.

!Level      = $0103     ; The level to teleport to.

;;; exit flags; 0 = no, 1 = yes
!Secondary  = 0         ; Secondary exit flag.
!Water      = 0         ; If secondary = 1, water level flag.
						; If secondary = 0, midway exit flag (note: destination must use separate midway settings).
						
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

main:
    LDX.b #!sprite_slots-1
  - LDA !14C8,x
    BNE .ret
    DEX
    BPL -
    
    REP #$20
    LDA #!Level|(((!Water<<3)|(1<<2)|(!Secondary<<1))<<8)
    JSL TeleportToLevel
  .ret:
    RTL