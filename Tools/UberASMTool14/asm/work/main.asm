incsrc "asm/work/library.asm"
incsrc "../../other/macro_library.asm"
!level_nmi	= 1
!overworld_nmi	= 0
!gamemode_nmi	= 0
!global_nmi	= 0

!sprite_RAM	= $7FAC80

autoclean $A5D2F3
autoclean $9086A9
autoclean $908691
autoclean $A5DC4C

!previous_mode = !sprite_RAM+(!sprite_slots*3)

incsrc level.asm
incsrc overworld.asm
incsrc gamemode.asm
incsrc global.asm
incsrc sprites.asm
incsrc statusbar.asm


print freespaceuse
