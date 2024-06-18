SOUL:
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
		MOVE.B	#$12,		OBJ.YRAD(A0)
		MOVE.B	#9,			OBJ.XRAD(A0)
		MOVE.L	#MAP_SOUL,	OBJ.MAP(A0)
		MOVE.W	#$0,		OBJ.TILE(A0)
		MOVE.B	#4,			OBJ.RENDERFLAGS(A0)
		MOVE.B	#2,			OBJ.PRIORITY(A0)

	@do:
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
		beq.s	@bluetst
		addi.w	#1,D1
	@bluetst:
		andi.b	#btnA+btnB+btnC,D0
		beq.s	@apply
		move.b	#0,	OBJ.ACTION(A0)
		move.b	#2,	OBJ.ID(A0)
		move.w	#$A0,	D0
		jmp		PlaySound
	@apply:
		add.w	D1,OBJ.X(A0)
		rol.l	#8,d1
		rol.l	#8,d1
		add.w	D1,OBJ.Y(A0)
		JMP		_OBJECTDISPLAY
		
MAP_SOUL:
		INCBIN	"SRC/OBJ/SOUL.MAP"
		even