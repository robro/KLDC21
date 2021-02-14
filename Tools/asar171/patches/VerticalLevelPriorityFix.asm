        lorom
if read1($00FFD5) == $23
        sa1rom
endif

org $0584BE		;\ Enable Priority for Level Mode 07 & 08
db $20,$20		;/

org $0584C1		;\ Enable Priority for Level Mode 0A
db $20			;/

org $0584C3		;\ Enable Priority for Level Mode 0C, 0D & 0E
db $20,$20,$20		;/

org $0584C8		;\ Enable Priority for Level Mode 11
db $20			;/

org $0584D5		;\ Enable Priority for Level Mode 1E & 1F
db $20,$20		;/