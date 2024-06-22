INTEG_UPHOLD	=	OBJ.FIELD_3F

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
		MOVE.B	#4,			OBJ.YRAD(A0)
		MOVE.B	#4,			OBJ.XRAD(A0)
		MOVE.L	#MAP_SOUL,	OBJ.MAP(A0)
		MOVE.W	#$2000,		OBJ.TILE(A0)
		MOVE.B	#4,			OBJ.RENDERFLAGS(A0)
		MOVE.B	#2,			OBJ.PRIORITY(A0)
		
	@fall:
		JSR		OBJECTFALL
		bset	#0,	SOUL.MOVE(A0)
		MOVE.B	JOYPAD,	D0
		btst	#0,	INTEG_UPHOLD(A0)
		bne.s	@chkfloor
		cmpi.b	#0,	OBJ.YSPEED(A0)
		bge.s	@set
		btst	#bitUp,D0
		bne.s	@chkfloor
		move.w	#0,	OBJ.YSPEED(A0)	;	clear upwards movement if up is no longer held
	@set:
		bset	#0,	INTEG_UPHOLD(A0)
	@chkfloor:
		cmpi.w	#$A8,	OBJ.Y(A0)	;	bottom of playfield
		blo.s	@contfall
		ADDQ.B	#2,			OBJ.ACTION(A0)
		move.w	#$A8,	OBJ.Y(A0)
		bclr	#0,	INTEG_UPHOLD(A0)
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
		beq.s	@endtst
		addi.w	#1,D1
	@endtst:
		btst	#bitStart,D0
		beq.s	@apply
		MOVE.W	#152,	OBJ.X(A0)
		MOVE.W	#204,	OBJ.Y(A0)
		MOVE.B	#0,	OBJ.ACTION(A0)
		MOVE.B	#0,	OBJ.FRAME(A0)
		MOVE.B	#3,	OBJ.ID(A0)
		MOVE.B	#$A2,	TEXTSND
		ADDI.B	#2,	MOVENUM
		COPYTILEMAP		BATTLEMAP,	$8084,	35,	25
		rts
	@apply:
		add.w	D1,OBJ.X(A0)
		
		cmpi.b	#2,	OBJ.ACTION(A0)
		beq.s	@chkWall
		bclr	#0,	SOUL.MOVE(A0)
		tst.l	D1
		beq.s	@chkWall
		bset	#0,	SOUL.MOVE(A0)
		
	@chkWall:
		cmpi.w	#$D1,OBJ.X(A0)
		ble.s	@contchk
		move.w	#$D1,OBJ.X(A0)
	@contchk:
		cmpi.w	#$6F,OBJ.X(A0)
		bge.s	@allgood
		move.w	#$6F,OBJ.X(A0)
	@allgood:
		JSR		_OBJECTCOLLIDE
		JMP		_OBJECTDISPLAY