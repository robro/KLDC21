Layer 2 Smash Sideways
By Erik557

NOTE:
- Assumes the level is vertical
- Assumes the words 'fall' or 'smash' mean 'layer 2 shifts to the left'

Usage:
1.- Set the positions where something happens. For example:

minScreenPos:                             ; screens with activity and no activity.
       dw $0601,$0450,$04E0,$0400,$0330

maxScreenPos:
       dw $05B0,$0380,$0420,$03A0,$0000

This means that there's smasher activity between screen 06, y pos of the camera 1 and screen 5, y pos of the camera B0. It may be confusing and IS pretty trial and error, but there isn't a better way to make it (unless pointers, but those aren't versatile enough). Also it's not limited to only 5 actions, you can add or remove.

2.- Configure the other tables. Those aren't really hard to understand, it's only timers. I documented them well.
3.- Insert with UberASM Tool.



"but i use the patch ;_;"
ok fine. copy everything between ; Defines and tables and init: at the top of level_init AND level_main. Copu everything between init: and main: in level_init. Copy everything after main: in level_main. Replace every RTL with RTS, and patch.

4.- Try it. Keep playing with the above tables until you get the desired result. The result is cool.