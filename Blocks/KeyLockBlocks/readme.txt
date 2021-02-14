Since the origional BlockTool 16x32 (1x2 block) key block
was removed, I revised it, with new features:

	-Now includes a 3 line blocks vertically and horizontally
	-A 32x32 px (2x2 16x16) key block.

	-A "stackable" key like in "The Legend of Zelda:
	 the Adventure of Link", as well as gates that
	 interact with how many keys you have. This is
	 very useful for giant puzzle levels with 15+
	 doors and keys as to prevent "item babysitting".

	-included a "barrier" and "collectable key"
	 (ExGFX80.bin) graphic as well as a key "icon" on
	 the status bar (GFX28.bin).

Usage:
	Simple! Insert the block using GPS. To place them, use
	tile_placements.PNG to place the blocks correctly. If you are
	using the ALTTP styled key collection, make sure you open
	KeyBlkDef.txt and read info there, and use collectable_key.asm.

	All lock blocks behave $130
	collectable_key.asm behave $25 (so he doesn't stop briefly when
	he runs into it).

	Note: for horizontal gates, you need to press up or down on the
	D-Pad while holding a key to unlock it; since its odd that what
	if the player doesn't want to fall through the gate?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Items list (6 items, sorted by type):

	blocks

	key_counter.asm		;>An uberasm code that display the number
				; of collectable keys the player has.

	ExGFX80.bin		;>ExGFX file for the blocks.
	GFX28.bin		;>ExGFX file for the status bar/HUD.

	tile_placements.PNG	;>displays on how to place the blocks.

	readme.txt		;>You are reading it.


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
version history:
	-added a new define that lets you have custom sprites to open
	 the gate.
ver1.6
	-Fix a flaw that causes the block not to delete the key sprite if
	 the player kicks and unlocks the gate at the same frame. Thanks
	 to MarioE. I use
	 this code:

	 LDA #$40		;\fix a bug with the "reuse key" glitch
	 TSB $15		;/

	 ^which disable letting go of the sprite as it
	 disappears.
	-BIG GOOD NEWS!!! Now compatable in vertical
	 levels!!
ver1.6.1
	-found a glitch and put a warning not to place these gates in the
	 vertical level's first two screen boundry, would delete tiles in
	 random subscreen boundry.

year format: M/D/Y
5/12/2015 - 1.6.2

	-TRUELY fix the vertical level problem:
		LDA $5B				;\Check if vertical level = true
		AND #$01			;|
		BEQ +				;/
		LDA $9B				;\Fix the $99 and $9B from glitching up if placed
		STA $00				;|other than top-left subscreen boundaries of vertical
		LDA $99				;|levels!!!!! (barrowed from the map16 change routine of GPS).
		STA $9B				;|(this switch values $99 <-> $9B, since the subscreen boundaries
		LDA $00				;|are now sideways)
		STA $99				;|
	+					;/
	 ^This code was used because in vertical levels, $98 and $99 (the
	 high bytes (or "subscreen boundaries")) was swapped due to the
	 format of the vertical level's subscreen boundaries, when
	 destroying 2+ blocks from one block, the first "block break"
	 routine inverts in the condition of a vertical level, but the
	 second one "re-inverts" (it re-uses the block break routine)
	 and makes it think its in a horizontal level, causing it to
	 use the wrong subscreen boundary. Now you don't have to worry
	 about having to have random tiles messing up on the first two
	 screens.
	 ^Also note that if you install the "Smoke Sprite High Bytes"
	 by MarioE, you may gunna need to move the smoke routine, because
	 they also uses $99 and $9B
	-Merge both AOL and SMB2 block versions into one using the labels
	 and if statements (no double if you can reuse), thanks to
	 GPS's asar usage.
	-Updated the block names to they are more easy to understand.
	-Added a puff of smoke effect.
	-Remove GFX tile duplicates.
	-Use better "Key contact" routine; it now uses the "player touch
	 side" offset rather than sprite contact routine (if you are using
	 SA-1 and already have converted the ram addresses, you'll have to
	 change the number of slots manuelly (there is a define for you)).
	-Now checks if the sprite is custom or not properly without
	 glitches assuming that they are the same.
	-Improved the key counter routine.
5/15/2015
	-Improved the if statement using "else" for the checking if the sprite
	 is custom or not.
10/25/2015
	-Fix an issue with the custom sprites, the if statement only checks
	 "if !custom_type == 0" without checking "if !custom_type == 1". it
	 was removed because of that.
	-Fix the freeram and define mismatch.
11/30/2015
	-For some reason, it checks specific slots. So if you have multiple
	 keys, it sometimes fail to open the door...
4/1/2016
	-Added sideways and 32x32 gate.
4/2/2016
	-Fix a puff of smoke issue with the 32x32 gate