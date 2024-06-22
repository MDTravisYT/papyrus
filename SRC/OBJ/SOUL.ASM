SOUL.MOVE		=	OBJ.FIELD_3E
SOUL.INV		=	OBJ.FIELD_3D

SOUL:
		BTST	#0,BLUEMODE
		BEQ.S	@RED
		MOVE.B	#2,	OBJ.ID(A0)
		RTS
	@RED:
		MOVEQ	#0,	D0
		MOVE.B	OBJ.ACTION(A0),	D0
		MOVE.W	@INDEX(PC,D0.W),	D1
		JMP		@INDEX(PC,D1.W)
		
	@INDEX:
		DC.W	@init-@INDEX
		DC.W	@do-@INDEX
	;	DC.W	@delete-@INDEX
	;	DC.W	@delete-@INDEX
		
	@init:
		ADDQ.B	#2,			OBJ.ACTION(A0)
		MOVE.B	#4,			OBJ.YRAD(A0)
		MOVE.B	#4,			OBJ.XRAD(A0)
		MOVE.L	#MAP_SOUL,	OBJ.MAP(A0)
		MOVE.W	#$0,		OBJ.TILE(A0)
		MOVE.B	#4,			OBJ.RENDERFLAGS(A0)
		MOVE.B	#2,			OBJ.PRIORITY(A0)

	@do:
		tst.b	TIMER
		beq.w	@timeOver
		tst.b	SOUL.INV(A0)
		beq.s	@skipInv
		sub.b	#1,	SOUL.INV(A0)
	@skipInv:
		MOVEQ	#0,	D0
		MOVEQ	#0,	D1
		MOVE.B	JOYPAD,	D0
	@uptst:
		btst	#bitUp,D0
		beq.s	@downtst
		subi.w	#1,D1
	@downtst:
		btst	#bitDn,D0
		beq.s	@lefttst
		addi.w	#1,D1
	@lefttst:
		rol.l	#8,d1
		rol.l	#8,d1
		btst	#bitL,D0
		beq.s	@righttst
		subi.w	#1,D1
	@righttst:
		btst	#bitR,D0
		beq.s	@apply
		addi.w	#1,D1
	@apply:
		add.w	D1,OBJ.X(A0)
		rol.l	#8,d1
		rol.l	#8,d1
		add.w	D1,OBJ.Y(A0)
		bclr	#0,	SOUL.MOVE(A0)
		
		tst.l	D1
		beq.s	@chkU
		bset	#0,	SOUL.MOVE(A0)
		
	@chkU:
		cmpi.w	#$78,OBJ.Y(A0)
		bge.s	@chkD
		move.w	#$78,OBJ.Y(A0)
	@chkD:
		cmpi.w	#$A8,OBJ.Y(A0)
		ble.s	@chkR
		move.w	#$A8,OBJ.Y(A0)
	@chkR:
		cmpi.w	#$D1,OBJ.X(A0)
		ble.s	@chkL
		move.w	#$D1,OBJ.X(A0)
	@chkL:
		cmpi.w	#$6F,OBJ.X(A0)
		bge.s	@allgood
		move.w	#$6F,OBJ.X(A0)
	@allgood:
		JSR		_OBJECTCOLLIDE
		btst	#1, SOUL.INV(A0)
		bne.s	@noDisplay
		JMP		_OBJECTDISPLAY
	@noDisplay:
		rts
		
	@timeOver:
		MOVE.W	#152,	OBJ.X(A0)
		MOVE.W	#204,	OBJ.Y(A0)
		MOVE.B	#0,	OBJ.ACTION(A0)
		MOVE.B	#0,	OBJ.FRAME(A0)
		MOVE.B	#3,	OBJ.ID(A0)
		MOVE.B	#$A2,	TEXTSND
		ADDI.B	#2,	MOVENUM
		COPYTILEMAP		BATTLEMAP,	$8084,	35,	25
		rts
		
MAP_SOUL:
		INCBIN	"SRC/OBJ/SOUL.MAP"
		even