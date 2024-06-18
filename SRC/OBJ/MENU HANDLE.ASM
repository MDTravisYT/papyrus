MENU_HANDLE:
		MOVEQ	#0,	D0
		MOVE.B	OBJ.ACTION(A0),	D0
		MOVE.W	@INDEX(PC,D0.W),	D1
		JMP		@INDEX(PC,D1.W)
		
	@INDEX:
		DC.W	@init-@INDEX	;	0
		DC.W	@do-@INDEX		;	2
		
	@init:
		ADDQ.B	#2,			OBJ.ACTION(A0)
		MOVE.B	#$12,		OBJ.YRAD(A0)
		MOVE.B	#9,			OBJ.XRAD(A0)
		MOVE.L	#MAP_SOUL,	OBJ.MAP(A0)
		MOVE.W	#0,			OBJ.TILE(A0)
		MOVE.B	#4,			OBJ.RENDERFLAGS(A0)
		MOVE.B	#2,			OBJ.PRIORITY(A0)
		MOVE.B	#2,			OBJ.FRAME(A0)
	;	2	=	FIGHT
	;	3	=	ACT
	;	4	=	ITEM
	;	5	=	MERCY

	@do:
		MOVEQ	#0,	D0
		MOVEQ	#0,	D1
		MOVE.B	JOYPADPRESS,	D0
	@lefttst:
		btst	#bitL,D0
		beq.s	@righttst
		subi.b	#1,D1
		move.b	#$A1,D0
		jsr		PlaySound
	@righttst:
		btst	#bitR,D0
		beq.s	@apply
		addi.b	#1,D1
		move.b	#$A1,D0
		jsr		PlaySound
	@apply:
		add.b	D1,OBJ.FRAME(A0)
		cmpi.b	#6,	OBJ.FRAME(A0)
		bne.s	@contchk
		move.b	#2,	OBJ.FRAME(A0)
	@contchk:
		cmpi.b	#1,	OBJ.FRAME(A0)
		bne.s	@allgood
		move.b	#5,	OBJ.FRAME(A0)
	@allgood:
		jmp		_OBJECTDISPLAY