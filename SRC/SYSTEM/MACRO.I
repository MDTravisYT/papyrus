ALIGN	MACRO
		DCB.B (\1-(*%\1))%\1,0
		ENDM
		
COPYTILEMAP		MACRO	source,loc,width,height
		lea		(source).l,a1
		move.l	#$40000000+((loc&$3FFF)<<16)+((loc&$C000)>>14),d0
		moveq	#width,d1
		moveq	#height,d2
		jsr		DrawTileMap
		endm
		
WRITEVRAM	MACRO	LOC
		MOVE.L	#VRAMWRITE+((LOC&$3FFF)<<16)+((LOC&$C000)>>14),	(VDPCTRL)
		ENDM
		
startZ80:       macro
		move.w	#0,(Z80BUS).l
		endm
		
stopZ80:        macro
		move.w	#$100,(Z80BUS).l
		endm
		
waitZ80:	macro
.wait:		btst	#0,(Z80BUS).l
		bne.s	.wait
		endm
		
resetZ80:	macro
		move.w	#$100,(Z80_RESET).l
		endm

resetZ80a:	macro
		move.w	#0,(Z80_RESET).l
		endm
		
TEXTSETUP:	MACRO	LOG,LOC,SND,VRAM
		COPYTILEMAP		BATTLEMAP,	$8084,	35,	25
		MOVE.L	#LOG,	TEXTLOG				;	where on screen the text should print
		MOVE.L	#LOG,	NEWLINE_MEMO		;	memorize where a new line starts
		MOVE.W	#0,		TEXTPROG			;	memorize how far into a script it's read
		MOVE.L	#LOC,	TEXTLOC				;	where in ROM the script is read
		MOVE.W	#0,		TIMER				;	reset timer (makes the dialogue begin later if set other than 0)
		MOVE.B	#SND,	TEXTSND				;	sound byte
		MOVE.W	#VRAM,	TXTVRAM				;	VRAM offset
		ENDM
		
STOPTXT:	MACRO
		MOVE.L	#BLANKTXT,	TEXTLOC
		MOVE.W	#0,			TEXTPROG
		ENDM