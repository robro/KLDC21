org $12E018


db $53, $54, $41, $52				; Needed to stop Asar from treating this like an xkas patch.
dw SGEnd-SampleGroupPtrs-$01
dw SGEnd-SampleGroupPtrs-$01^$FFFF
SampleGroupPtrs:


dw $0000, SGPointer01, SGPointer02, SGPointer03, SGPointer04, SGPointer05, SGPointer06, SGPointer07, SGPointer08, SGPointer09, SGPointer0A, SGPointer0B, SGPointer0C, SGPointer0D, SGPointer0E, SGPointer0F
dw SGPointer10, SGPointer11, SGPointer12, SGPointer13, SGPointer14, SGPointer15, SGPointer16, SGPointer17, SGPointer18, SGPointer19, SGPointer1A, SGPointer1B, SGPointer1C, SGPointer1D, SGPointer1E, SGPointer1F
dw SGPointer20, SGPointer21, SGPointer22, SGPointer23, SGPointer24, SGPointer25, SGPointer26, SGPointer27, SGPointer28, SGPointer29, SGPointer2A, SGPointer2B, SGPointer2C, SGPointer2D, SGPointer2E, SGPointer2F
dw SGPointer30, SGPointer31, SGPointer32, SGPointer33, SGPointer34, SGPointer35, SGPointer36, SGPointer37, SGPointer38, SGPointer39, SGPointer3A, SGPointer3B, SGPointer3C, SGPointer3D, SGPointer3E, SGPointer3F
dw SGPointer40, SGPointer41, SGPointer42, SGPointer43


SGPointer01:

SGPointer02:

SGPointer03:

SGPointer04:

SGPointer05:

SGPointer06:

SGPointer07:

SGPointer08:

SGPointer09:

SGPointer0A:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $0014, $0010, $0014, $0012, $0013
SGPointer0B:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $0014, $0010, $0014, $0012, $0013
SGPointer0C:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $0014, $0010, $0014, $0012, $0013
SGPointer0D:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $000D, $000E, $000F, $0010, $0011, $0012, $0013
SGPointer0E:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $0014, $0010, $0014, $0012, $0013
SGPointer0F:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $0014, $0010, $0014, $0012, $0013
SGPointer10:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $0014, $0010, $0014, $0012, $0013
SGPointer11:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $0014, $0010, $0014, $0012, $0013
SGPointer12:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $000D, $000E, $0014, $0010, $0014, $0012, $0013
SGPointer13:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $0014, $0010, $0014, $0012, $0013
SGPointer14:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $0014, $0010, $0014, $0012, $0013
SGPointer15:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $0014, $0010, $0014, $0012, $0013
SGPointer16:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $000F, $0010, $0014, $0012, $0013
SGPointer17:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $0014, $0010, $0014, $0012, $0013
SGPointer18:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $0014, $0010, $0014, $0012, $0013
SGPointer19:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $000D, $000E, $000F, $0010, $0014, $0012, $0013
SGPointer1A:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $0014, $0010, $0014, $0012, $0013
SGPointer1B:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $0014, $0010, $0014, $0012, $0013
SGPointer1C:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $000D, $000E, $000F, $0010, $0014, $0012, $0013
SGPointer1D:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $000D, $000E, $0014, $0010, $0014, $0012, $0013
SGPointer1E:
db $14
dw $0015, $0016, $0017, $0018, $0019, $001A, $001B, $001C, $001D, $001E, $001F, $0020, $0021, $0014, $0023, $0014, $0025, $0014, $0027, $0028
SGPointer1F:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $000D, $000E, $000F, $0010, $0011, $0012, $0013
SGPointer20:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $000D, $000E, $000F, $0010, $0011, $0012, $0013
SGPointer21:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $000F, $0010, $0011, $0012, $0013
SGPointer22:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $000F, $0010, $0014, $0012, $0013
SGPointer23:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $0014, $0010, $0011, $0012, $0013
SGPointer24:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $0014, $0010, $0011, $0012, $0013
SGPointer25:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $0014, $0010, $0014, $0012, $0013
SGPointer26:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $000F, $0010, $0014, $0012, $0013
SGPointer27:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $0014, $0010, $0014, $0012, $0013
SGPointer28:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $000F, $0010, $0014, $0012, $0013
SGPointer29:
db $1F
dw $0015, $0016, $0017, $0018, $0019, $001A, $001B, $001C, $001D, $001E, $001F, $0020, $0021, $0014, $0023, $0014, $0025, $0014, $0027, $0028, $0029, $002A, $002B, $002C, $002D, $002E, $002F, $0030, $0031, $0032, $0033
SGPointer2A:
db $1E
dw $0015, $0016, $0017, $0018, $0019, $001A, $001B, $001C, $001D, $001E, $001F, $0020, $0021, $0014, $0023, $0014, $0025, $0014, $0027, $0028, $002C, $002D, $002A, $002B, $0030, $0032, $0031, $002F, $0029, $0033
SGPointer2B:
db $15
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $0014, $0010, $0014, $0012, $0013, $0034
SGPointer2C:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $000F, $0010, $0014, $0012, $0013
SGPointer2D:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $000D, $000E, $000F, $0010, $0014, $0012, $0013
SGPointer2E:
db $1E
dw $0015, $0016, $0017, $0018, $0019, $001A, $001B, $001C, $001D, $001E, $001F, $0020, $0021, $0014, $0023, $0014, $0025, $0014, $0027, $0035, $0036, $0037, $0038, $0039, $003A, $003B, $003C, $003D, $003E, $003F
SGPointer2F:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $000F, $0010, $0014, $0012, $0013
SGPointer30:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $000F, $0010, $0014, $0012, $0013
SGPointer31:
db $1C
dw $0015, $0016, $0017, $0018, $0019, $001A, $001B, $001C, $001D, $0014, $001F, $0020, $0021, $0014, $0023, $0014, $0025, $0014, $0027, $0014, $0040, $0041, $0042, $0043, $0044, $0045, $0046, $0047
SGPointer32:
db $27
dw $0015, $0016, $0017, $0018, $0019, $001A, $001B, $001C, $001D, $0014, $001F, $0020, $0021, $0014, $0023, $0014, $0025, $0014, $0027, $0014, $0048, $0049, $004A, $004B, $004C, $004D, $004E, $004F, $0050, $0051, $0052, $0053, $0054, $0055, $0056, $0057, $0058, $0059, $005A
SGPointer33:
db $20
dw $0015, $0016, $0017, $0018, $0019, $001A, $001B, $001C, $001D, $001E, $001F, $0020, $0021, $0014, $0023, $0014, $0025, $0014, $0027, $0028, $005B, $005C, $005D, $005E, $005F, $0060, $0061, $0062, $0063, $0064, $0065, $0066
SGPointer34:
db $1F
dw $0015, $0016, $0017, $0018, $0019, $001A, $001B, $001C, $001D, $001E, $001F, $0020, $0021, $0014, $0023, $0014, $0025, $0014, $0027, $0028, $0067, $0068, $0069, $005E, $006A, $0014, $006B, $006C, $006D, $006E, $006F
SGPointer35:
db $21
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $0014, $0010, $0014, $0012, $0013, $0070, $0071, $0072, $0073, $0074, $0075, $0076, $0077, $0078, $0079, $007A, $007B, $007C
SGPointer36:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $0014, $0010, $0014, $0012, $0013
SGPointer37:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $000F, $0010, $0014, $0012, $0013
SGPointer38:
db $1A
dw $0015, $0016, $0017, $0018, $0019, $001A, $001B, $001C, $001D, $001E, $001F, $0020, $0021, $0014, $0014, $0014, $003B, $003C, $007D, $003D, $003E, $003F, $007E, $007F, $0080, $0081
SGPointer39:
db $1E
dw $0015, $0016, $0017, $0018, $0019, $001A, $001B, $001C, $001D, $001E, $001F, $0020, $0021, $0014, $0023, $0014, $0025, $0014, $0027, $0028, $0082, $0083, $0084, $0085, $0086, $0087, $0088, $0089, $008A, $008B
SGPointer3A:
db $1C
dw $0015, $0016, $0017, $0018, $0019, $001A, $001B, $001C, $001D, $001E, $001F, $0020, $0021, $0014, $0023, $0014, $0025, $0014, $0027, $0028, $008C, $008D, $008E, $008F, $0090, $0091, $0092, $0093
SGPointer3B:
db $46
dw $0015, $0016, $0017, $0018, $0019, $001A, $001B, $001C, $001D, $001E, $001F, $0020, $0021, $0014, $0023, $0014, $0025, $0014, $0027, $0028, $0094, $0095, $0096, $0097, $0098, $0099, $009A, $009B, $009C, $009D, $009E, $009F, $00A0, $00A1, $00A2, $00A3, $00A4, $00A5, $00A6, $00A7, $00A8, $00A9, $00AA, $00AB, $00AC, $00AD, $00AE, $00AF, $00B0, $00B1, $00B2, $00B3, $00B4, $00B5, $00B6, $00B7, $00B8, $00B9, $00BA, $00BB, $00BC, $00BD, $00BE, $00BF, $00C0, $00C1, $00C2, $00C3, $00C4, $00C5
SGPointer3C:
db $1E
dw $0015, $0016, $0017, $0018, $0019, $001A, $001B, $001C, $001D, $001E, $001F, $0020, $0021, $0014, $0023, $0014, $0025, $0014, $0027, $0028, $00C6, $0068, $00C7, $005E, $005D, $00C8, $00C9, $006D, $00CA, $0064
SGPointer3D:
db $24
dw $0015, $0016, $0017, $0018, $0019, $001A, $001B, $001C, $001D, $001E, $001F, $0020, $0021, $0014, $0023, $0014, $0025, $0014, $0027, $0028, $00CB, $005B, $00CC, $00CD, $00CE, $00CF, $00D0, $00D1, $00D2, $00D3, $00D4, $00D5, $00D6, $00D7, $00D8, $00D9
SGPointer3E:
db $1E
dw $0015, $0016, $0017, $0018, $0019, $001A, $001B, $001C, $001D, $001E, $001F, $0020, $0021, $0014, $0023, $0014, $0025, $0014, $0027, $0028, $00DA, $00DB, $00DC, $00DD, $00DE, $00DF, $00E0, $00E1, $00E2, $00E3
SGPointer3F:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $000F, $0010, $0011, $0012, $0013
SGPointer40:
db $14
dw $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $0009, $000A, $000B, $000C, $0014, $000E, $000F, $0010, $0014, $0012, $0013
SGPointer41:
db $21
dw $0015, $0016, $0017, $0018, $0019, $001A, $001B, $001C, $001D, $001E, $001F, $0020, $0021, $0014, $0023, $0014, $0025, $0014, $0027, $0028, $002A, $0030, $00E4, $002F, $002B, $002C, $00E5, $002D, $0033, $00D8, $00E6, $00E7, $00E8
SGPointer42:
db $1A
dw $0015, $0016, $0017, $0018, $0019, $001A, $001B, $001C, $001D, $001E, $001F, $0020, $0021, $0014, $0023, $0014, $0025, $0014, $0027, $0028, $00E9, $00EA, $00EB, $00EC, $00ED, $00EE
SGPointer43:
db $1B
dw $0015, $0016, $0017, $0018, $0019, $001A, $001B, $001C, $001D, $001E, $001F, $0020, $0021, $0014, $0023, $0014, $0025, $0014, $0027, $0028, $00EF, $00F0, $00F1, $00F2, $00F3, $00F4, $00F5
SGEnd: