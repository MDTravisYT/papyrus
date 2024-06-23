MENU_HANDLE:
		MOVEQ	#0,	D0
		MOVE.B	OBJ.ACTION(A0),	D0
		MOVE.W	@INDEX(PC,D0.W),	D1
		JMP		@INDEX(PC,D1.W)
		
	@INDEX:
		DC.W	@init-@INDEX	;	0
		DC.W	@do-@INDEX		;	2
		DC.W	@sel-@INDEX		;	4
		
	@init:
		ADDQ.B	#2,			OBJ.ACTION(A0)
		MOVE.B	#$12,		OBJ.YRAD(A0)
		MOVE.B	#9,			OBJ.XRAD(A0)
		MOVE.L	#MAP_SOUL,	OBJ.MAP(A0)
		MOVE.W	#0,			OBJ.TILE(A0)
		MOVE.B	#4,			OBJ.RENDERFLAGS(A0)
		MOVE.B	#2,			OBJ.PRIORITY(A0)
		MOVE.B	#2,			OBJ.FRAME(A0)
		
	;	TEXTSETUP	$48080002,TXT_ENCOUNTER,$A2,$100
	;	2	=	FIGHT
	;	3	=	ACT
	;	4	=	ITEM
	;	5	=	MERCY
	
		lea		(OBJSLOT01),	A1
		MOVEQ	#0,	D0
		MOVEQ	#0,	D1
		move.w	#$400,	d0
	@loop:
		move.l	d1,(a1)+
		dbf		d0,	@loop
		

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
		beq.s	@presstst
		addi.b	#1,D1
		move.b	#$A1,D0
		jsr		PlaySound
	@presstst:
		MOVE.B	JOYPADPRESS,	D0
		andi.b	#btnA+btnB+btnC,D0
		beq.s	@apply
		ADDQ.B	#2,			OBJ.ACTION(A0)
		move.w	#$A0,	D0
		jmp		PlaySound
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
		
		
	@sel:
		move.b	OBJ.FRAME(A0),D0
		sub.b	#2,D0
		rol.b	#1,D0
		MOVE.W	@MENUDEX(PC,D0.W),	D1
		JMP		@MENUDEX(PC,D1.W)
		
	@MENUDEX:
		DC.W	@FIGHT-@MENUDEX
		DC.W	@ACT-@MENUDEX
		DC.W	@ITEM-@MENUDEX
		DC.W	@MERCY-@MENUDEX
		
	@FIGHT:
			TEXTSETUP	$48080002,TST2,$A1,$100
			SUBI.B	#2,	OBJ.ACTION(A0)
			RTS
	@ACT:
		MOVEQ	#0,	D0
		MOVE.B	OBJ.SUBACTION(A0),	D0
		MOVE.W	@ACT_INDEX(PC,D0.W),	D1
		JMP		@ACT_INDEX(PC,D1.W)
		
		@ACT_INDEX:
			DC.W	@R1-@ACT_INDEX
			DC.W	@R2-@ACT_INDEX
		
		@R1:
			COPYTILEMAP		BATTLEMAP,	$8084,	35,	25
			TEXTSETUP	$48080002,TXT_CHECK1,$A2,$100
			ADDI.B	#2,	OBJ.SUBACTION(A0)
		@R2:
			MOVEQ	#0,	D0
			MOVEQ	#0,	D1
			MOVE.B	JOYPADPRESS,	D0
			andi.b	#btnA+btnB+btnC,D0
			beq.w	@act_end
			MOVE.B	#3,	OBJ.ID(A0)
			MOVE.B	#0,	OBJ.ACTION(A0)
			MOVE.B	#0,	OBJ.SUBACTION(A0)
			COPYTILEMAP		BATTLEMAP,	$8084,	35,	25
		@act_end:
			RTS
			
	@ITEM:
			TEXTSETUP	$48080002,TST2,$A1,$100
			SUBI.B	#2,	OBJ.ACTION(A0)
			RTS
	@MERCY:
		MOVE.B	#5,	OBJ.ID(A0)
		MOVE.B	#0,	OBJ.ACTION(A0)
		MOVE.B	#0,	OBJ.SUBACTION(A0)
		MOVE.W	#48,	OBJ.X(A0)
		MOVE.W	#144,	OBJ.Y(A0)
		RTS