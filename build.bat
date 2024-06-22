echo %date% %time% > time.txt

IF NOT EXIST OUT MKDIR OUT
asm68k /k /p /o ae-,c+ SRC/_MAIN.ASM, OUT/UT.BIN >OUT/UT.LOG, OUT/UT.SYM, OUT/UT.LST
convsym OUT/UT.SYM OUT/UT.BIN -a

del time.txt