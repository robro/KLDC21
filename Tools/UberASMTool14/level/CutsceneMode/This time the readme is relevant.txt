Cutscene Mode
by Blind Devil

----------

Oh, thanks for downloading. This ZIP file includes two ASM files: the cutscene
code file itself, and an optional one which should fix a certain issue regarding
enabling path directions and the 'level has been passed' flag for the OW level 
destination if using certain options, which will be explained later on. There's
also an OW coordinates diagram which will also be explained.

> "So, what 'Cutscene.asm' is exactly, and what it does?"
If you already saw or used the sprite variations (such as Alessio's Cutscene
Tool and my old Cutscene Generator Enhanced Pack), you might be aware of what
this does. But if you don't, I'll explain: it's a pack of codes for UberASMTool
that will prevent you from pausing/moving/jumping and so on, allowing the easy
creation of custom cutscenes. The advantages over the sprite versions are that
you won't be wasting sprite slots for that anymore, not to mention this is more
customizable, optimized, SA-1 compatible and comes with even more functionalities!

The ASM file has loads of configurable defines, such as:
	> Freeze or not sprites and animations;
	> Player's pose and facing direction;
	> Option to use a timer instead of button pressing (RAM $14AC);
	> Button to press to advance or skip* cutscene (the latter can be disabled);
	> What SFX to play when an specific button is pressed (can be disabled as well);
	> Action for each button (they're nine in total, check the ASM file);
	> Where to warp in the OW if using the OW warping action;
	> What sublevel/secondary exit to teleport if skip action is set to level teleport.

*it doesn't really skip, just does a different action depending on your
configuration.

Mostly everything is better detailed in the ASM files, so make sure to take a
look into them. Anyway, I will go into other details here.

> Issue related to 'OW warping + beating level' actions (5 and 6):
If a button is configured to OW teleport and run an OW event, once the event
finishes running, Mario will by default move as if you had beaten the level you set
as your destination. For example, if you are in level 105, beat the level and OW
teleport to level 106 area, Mario will move to the direction configured in 106 and
set the 'level has been passed' flag for it. This means that, while it triggers
exits and events correctly for 105, it'll mess up the flags of 106, too, as if you
were playing it previously.

This is where 'OWTilePropFix.asm' enters in. By simply inserting the code in
Gamemode E, it makes it so the beaten level/enabled direction flags of the
destination level are kept untouched after an event is run. You don't need to use
it, but keep in mind that you will have to deal with these probably unwanted side
effects if using any of the OW teleport + beat level actions (precisely 5 and 6).
Note that it needs a free RAM, so if something goes wrong, be sure to change it.

> How to get the coordinates for OW warping:
You can find this in game by watching RAM addresses $7E1F17 and $7E1F19 ($007F17
and $007F19 in a SA-1 ROM). They are 2 bytes long each, and refer to X and Y
coordinates of Mario, respectively. If you want the values from Luigi, addresses
are $7E1F1B and $7E1F1D ($007F1B and $007F1D in a SA-1 ROM). Also make sure the
last coordinate digit always end with an 8 (e.g. #$0078). Another alternative to
find the coordinates is taking a look at this diagram:
https://s19.postimg.org/fehrrn94j/OWCoord_Diagram.png

> "Well, tell me in details what 'Cutscene.asm' does as of now."
All right. If you insert the ASM file as is, the code will do the following:
	> Sprites won't move and animations will be frozen.
	> Player's pose is default, and he'll face right.
	> B button teleports to the screen exit set in LM and plays SFX.
	> Start button teleports to secondary exit #$00D2 and plays different SFX.

> "Anything else?"
Custom player pose and facing direction options don't work properly with Yoshi, so
it's probably a good idea to not use custom values in there in case you're riding one.
Also, while Select button is an option for you to define an action, be wary that, if you
have an item in the item box, it will be dropped as soon as the action is triggered. This
is no big issue if you're not mapping Select for anything, but if you really need it,
I'd recommend either disabling the item box or temporarily storing its RAM value
somewhere else, clearing the item box RAM during the cutscene, and restoring it later on.

----------

That should be all. Credit is not necessary.
Lastly, if you have any problems or suggestions, don't be afraid to contact me.