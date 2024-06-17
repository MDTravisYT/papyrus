VBLANK:
		MOVEM.L	D0-D7/A0-A6,	-(SP)
		TST.B	VBLANKCMD
		BEQ.S	.END
		MOVE.W	(VDPCTRL).L,	D0
		MOVE.L	#$40000010,	(VDPCTRL).L
		MOVE.L	VDP_SCREENPOSY,	(VDPDATA).L
		BTST	#6,	HARDWAREVERSION
		BEQ.S	.NTSC
		MOVE.W	#$700,	D0
		
	.PAL:
		DBF	D0,	.PAL
		
	.NTSC:
		MOVE.B	VBLANKCMD,	D0
		MOVE.B	#0,	VBLANKCMD
		MOVE.W	#1,	HBLANKFLAG
		ANDI.W	#%111110,	D0
		MOVE.W	.INDEX(PC,D0.W),	D0
		JSR		.INDEX(PC,D0.W)
		
	.END:
		ADDQ.L	#1,	VBLANKCOUNTER
	;	JSR		
		MOVEM.L	(SP)+,	D0-D7/A0-A6
		RTE
		
	VBL_INVALID:
		RTS
		
	.INDEX:
		DC.W	VBL_DEFAULT-.INDEX	;	0
		DC.W	VBL_INVALID-.INDEX  	;	2
		DC.W	VBL_INVALID-.INDEX  	;	4
		DC.W	VBL_INVALID-.INDEX  ;	6
		DC.W	VBL_INVALID-.INDEX  ;	8
		DC.W	VBL_INVALID-.INDEX  ;	A
		DC.W	VBL_INVALID-.INDEX  ;	C
		DC.W	VBL_INVALID-.INDEX  ;	E
		DC.W	VBL_INVALID-.INDEX  ;	10
		DC.W	VBL_INVALID-.INDEX  ;	12
		DC.W	VBL_INVALID-.INDEX  ;	14
		DC.W	VBL_INVALID-.INDEX  ;	16
		DC.W	VBL_INVALID-.INDEX  ;	18
		DC.W	VBL_INVALID-.INDEX  ;	1A
		DC.W	VBL_INVALID-.INDEX  ;	1C
		DC.W	VBL_INVALID-.INDEX  ;	1E
		
VBL_DEFAULT:
		JSR		READJOYPADS
		BSR.W	REFRESH_VDP_BUFFERS
		TST.W	(TIMER).W
		BEQ.W	@STOP
		SUBQ.W	#1,	(TIMER).W
	@STOP:	
		RTS
		
REFRESH_VDP_BUFFERS:
;		MOVE.W	#$100,	(Z80BUS).L
;		
;	@LOOP:
;		BTST	#0,	(Z80BUS).L
;		BNE.S	@LOOP
		
		LEA	(VDPCTRL).L,	A5
        move.l  #$94009340,(a5)
        move.l  #$96FD9580,(a5)
        move.w  #$977F,(a5)
        move.w  #$C000,(a5)
        move.w  #$80,(VDPBUFFER2).w
        move.w  (VDPBUFFER2).w,(a5)
        lea     (VDPCTRL).l,a5
        move.l  #$94019340,(a5)
        move.l  #$96FC9500,(a5)
        move.w  #$977F,(a5)
        move.w  #$7800,(a5)
        move.w  #$83,(VDPBUFFER2).w
        move.w  (VDPBUFFER2).w,(a5)
        lea     (VDPCTRL).l,a5

loc_EDC:
        move.l  #$940193C0,(a5)
        move.l  #$96E69500,(a5)
        move.w  #$977F,(a5)
        move.w  #$7C00,(a5)
        move.w  #$83,(VDPBUFFER2).w
        move.w  (VDPBUFFER2).w,(a5)
        move.w  #0,(Z80BUS).l
        rts