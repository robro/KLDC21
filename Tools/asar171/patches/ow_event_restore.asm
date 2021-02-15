if read1($00FFD5) == $23
        sa1rom
        !addr   = $6000
        !bank   = $000000
else
        lorom
        !addr   = $0000
        !bank   = $800000
endif

org $04DC6A
        JSL $04DD40|!bank
        NOP
org $04DD56
        RTL
org $00A0BF
        autoclean JML ow_event_restore

freedata
ow_event_restore:
        LDA $0DBE|!addr
        BPL +
        INC $1B87|!addr
+       STA $0DB4|!addr,x

        PHX
        PHY
        PEA.w ($04|(!bank>>16))|($00|!bank>>16<<8)
        PLB
        JSL $04DD40|!bank
        PLB
        PLY
        PLX

        JML $00A0CA|!bank

