incsrc "asm/work/library.asm"
incsrc "../../other/macro_library.asm"
!level_nmi	= 0
!overworld_nmi	= 0
!gamemode_nmi	= 0
!global_nmi	= 0

!sprite_RAM	= $7FAC80

autoclean $A5D2F3
autoclean $9084CC
autoclean $9084D9
autoclean $9084E4
autoclean $9084B4
autoclean $A4FBEE

!previous_mode = !sprite_RAM+(!sprite_slots*3)

incsrc level.asm
incsrc overworld.asm
incsrc gamemode.asm
incsrc global.asm
incsrc sprites.asm
incsrc statusbar.asm


print freespaceuse
