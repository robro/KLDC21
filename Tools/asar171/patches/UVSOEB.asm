if read1($00FFD5) == $23
    sa1rom
    !sa1 = 1
    !dp = $3000
    !addr = $6000
    !bank = $000000
else
    lorom
    !sa1 = 0
    !dp = $0000
    !addr = $0000
    !bank = $800000
endif

org $01AA33
autoclean JML scroll_camera_on_boost

freedata
scroll_camera_on_boost:
    LDA $74
    BNE skip_boost
    LDA.B #$01
    STA.W $1404|!addr
    JML $01AA37|!bank

skip_boost:
    JML $01AA41|!bank