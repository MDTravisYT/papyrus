INTEGRITY:
		MOVEQ	#0,	D0
		MOVE.B	OBJ.ACTION(A0),	D0
		MOVE.W	@INDEX(PC,D0.W),	D1
		JMP		@INDEX(PC,D1.W)
		
	@INDEX:
		DC.W	@init-@INDEX	;	0
		DC.W	@fall-@INDEX	;	2
		DC.W	@ground-@INDEX	;	4
	;	DC.W	@delete-@INDEX
		
	@init:
		ADDQ.B	#2,			OBJ.ACTION(A0)
		MOVE.B	#$12,		OBJ.YRAD(A0)
		MOVE.B	#9,			OBJ.XRAD(A0)
		MOVE.L	#MAP_SOUL,	OBJ.MAP(A0)
		MOVE.W	#$2001,		OBJ.TILE(A0)
		MOVE.B	#4,			OBJ.RENDERFLAGS(A0)
		MOVE.B	#2,			OBJ.PRIORITY(A0)
		
	@fall:
		JSR		OBJECTFALL
		cmpi.w	#$A8,	OBJ.Y(A0)	;	bottom of playfield
		blo.s	@contfall
		ADDQ.B	#2,			OBJ.ACTION(A0)
		move.w	#$A8,	OBJ.Y(A0)
	@contfall:
		
	@ground:
		MOVEQ	#0,	D0
		MOVEQ	#0,	D1
		MOVE.B	JOYPAD,	D0
	@uptst:
		cmpi.b	#2,	OBJ.ACTION(A0)
		beq.s	@lefttst
		btst	#bitUp,D0
		beq.s	@lefttst
		SUBQ.B	#2,	OBJ.ACTION(A0)
		move.w	#-600,	OBJ.YSPEED(A0)
	@lefttst:
		btst	#bitL,D0
		beq.s	@righttst
		subi.w	#1,D1
	@righttst:
		btst	#bitR,D0
		beq.s	@apply
		addi.w	#1,D1
	@apply:
		add.w	D1,OBJ.X(A0)
		JSR		_OBJECTDISPLAY
		RTS