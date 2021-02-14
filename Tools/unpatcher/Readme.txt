Unpatcher by TheBiob

This tool allows you to remove (most) patches from your ROM.

Disclaimer:
  The tool will not be able to remove patches that change how other patches work like the sa-1 patch.
  The tool will not be able to remove patches with freespace leaks (If it does remove the functionality correctly, it most likely left a lot of now unused code or data in your ROM)
  The tool might not be able to correctly remove read3 code. If the patch changed some stuff in freespace using read3 the tool will interpret it as freecode that needs to be autocleaned so it might remove unintended data. If you know some asm you can output the "unpatch" with -o and try to fix this yourself or get help on the forums.
  It is your responsibility to make sure you have a backup of your ROM before making changes using this tool. The tool will not do this for you.

Usage:
    Get a clean ROM for the tool to read from and name it "smwOrig.smc", place this file in the same folder the tools is in.

    After that double click "Unpatch.cmd", this will ask for the ROM and for the patch file, then run the actual tool with them.
	  Note: If that file doesn't properly remove the patch try running "UnpatchF.cmd" the same way, this will use a different method of trying to remove the patch which might work better for some patch but is more likely to break on others.
	  WARNING: If the patches uses freespace inside "apply once" code changes the tool might not be able to figure out the freespace location and not be able to clean it. This does not affect functionality of the game, it does however reduce the size of freespace you have in your ROM so be aware of that.

    Alternativly, double click the exe directly and input your ROM. This will use "patch.asm" as the patch it will try to remove.

Command Line Usage:
    Unpatch.exe [options] <rom>
    
	<rom>: Required. The path to your rom.
	[options]: Optional. Options on how the tool tries to clean the patch as well as what it outputs.

Valid Options:
    -patch <patch>    This will set the patch the tool tries to remove from your ROM.
    -orig <original>  This will set the path for the unmodified ROM the tool reads from.
    -unpatch <path>    This will set the path to the "unpatch" file. Note: Unless you use this with -o or -k the file will get deleted after the tool applied it to your ROM.
    -k                Running the tool with this flag will cause it to keep the "unpatch" patch it created.
    -o                Running the tool with this flag will cause it to output the "unpatch" patch it creates. (Unlike -k which also automatically applies said patch after creating it)
    -f                Running the tool with this flag will make it figure out the non-freespace changes by applying it to the clean ROM rather than the actual ROM. This might be useful if your patch checks if the hijacks are already installed and doesn't apply them again as the tool can't figure that out.

Q&A:
Q) I get bug, how to fix?
A) Start by asking proper questions.

Q) Does this work with sa-1?
A) To make it work with sa-1 you need to apply the sa-1 patch on the original file ("smwOrig.smc" by default) and save it before trying to remove a patch.

Q) The tool did not remove patch X properly, what do I do?
A) Your best bet would be to ask on the forums. The tool is not perfect and can not always fully remove a patch from ROM.

Q) Where do I submit bug reports or patches I think should be supported but aren't?
A) Either PM me (TheBiob) directly on SMWC or via Discord and send a description of what you tried and how to replicate the bug or ask on the forums maybe someone knows how to fix said bug. Should I not be active on smwc anymore, only ask on the forums.