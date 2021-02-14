Best one-way blocks, By GreenHammerBro. No credit necessary.

Unlike the ropes already submitted in smw central, this is better:

	-one-way down blocks, when stacked, won't make mario zip downwards extremely fast,
	 instead, if mario is going upwards will make the bottom of the block solid.

	-Horizontal one-way blocks don't block the player if the player is directly inside
	 the block going in the opposite direction, only if the player is compleatly at the
	 edge (which also prevents the player from vibrating also). It actually pushes the
	 player if fewer pixels of his body is touching the side of the block (rather than
	 equal to the position that is touching the side of the block) in case if mario is
	 running full speed, which has a 1/2 chance that they will fail due to the fact that
	 when mario goes to that speed, he can skip from 1-3 pixels per frame and go 2-3 pixels
	 inside the block than he should be; "warping" past the blocks.

	-one-way applies to all block-interacting sprites, such as fireballs. Unlike ropes, the
	 fireball always passes through in any direction.

notes:
	-if you are using boost blocks, its possible to pass through the one-way blocks
	 in the opposite direction, so if you do that, there is a define that you should
	 change "0" into "1", I did this so if you are not using them, would save
	 extra space for you rom :-).
	-For some reason, "one_way_down_right [broken].asm" can be pass through in the opposite direction
	 by hitting its bottom-right corner at a certain angle for some reason, I recommend not
	 to use that block. I left the block there in case if someone can fix it as well as showing proof
	 that I did try to program it.

version history:
5/29/2017 - 1.1
	-fix the glitch that if you are using a code that increments or decrements mario's
	 x position (like the wind generator or conveyor blocks going) fast enough while mario is
	 moving in the direction the blocks allow him to in the opposite will allow mario to pass
	 through them in the wrong direction. (as he move "backwards" through them against the blocks
	 and wind). This is because mario's x speed doesn't get effected by the position within level.
9/14/2018 - 1.2
	-With the update with GPS with some missing side offsets (depending on the position of the sprite)
	 with carryable sprites being fixed, this fixes a glitch that would push sprites in the opposite
	 direction of the direction of the 1-way blocks.
	-Included 1-way diagonal blocks