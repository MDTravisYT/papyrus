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