arch spc700-raw

org $000000
incsrc "asm/main.asm"
base $1EC5

org $008000

	
	mov a, #$01			
	mov !PauseMusic, a	
	
	mov $f2, #$5c		
	mov $f3, #$ff		
	
	mov	a, #$7f		
	mov	y, #$0c		
	call DSPWrite	
	mov	a, #$7f		
	mov	y, #$1c		
	jmp	DSPWrite	
