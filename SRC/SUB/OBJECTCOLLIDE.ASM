_OBJECTCOLLIDE:
		MOVEQ	#0,	D4
		MOVE.B	OBJ.XRAD(A0),D4
		SUBQ.B	#3,	D4
		MOVE.W	OBJ.X(A0),D2
		SUB.W	D4,D2
		ADD.W	D4,D4
		
		MOVEQ	#0,	D5
		MOVE.B	OBJ.YRAD(A0),D5
		SUBQ.B	#3,	D5
		MOVE.W	OBJ.Y(A0),D3
		SUB.W	D5,D3
		ADD.W	D5,D5
		
		LEA		(OBJSLOT01).W,A1
		MOVE.W	#96-1,D6
		
	@LOOP:
		TST.B	OBJ.RENDERFLAGS(A1)
		BPL.S	@NEXTOBJ
		MOVE.B	OBJ.COLLISION(A1),D0
		BNE.S	@HASCOLLISION
		
	@NEXTOBJ:
		LEA		OBJ.SIZE(A1),A1
		DBF		D6,@LOOP
		MOVEQ	#0,D0
		RTS
		
	@COLSIZES:
		;		width	height
		dc.b 	$14,	$14		;	$01
		dc.b 	 $C,	$14     ;	$02
		dc.b 	$14,	 $C     ;	$03
		dc.b 	  4,	$10     ;	$04
		dc.b 	 $C,	$12     ;	$05
		dc.b 	$10,	$10     ;	$06
		dc.b 	  6,	  6     ;	$07
		dc.b 	$18,	 $C     ;	$08
		dc.b 	 $C,	$10     ;	$09
		dc.b 	$10,	 $C     ;	$0A
		dc.b 	  8,	  8     ;	$0B
		dc.b 	$14,	$10     ;	$0C
		dc.b 	$14,	  8     ;	$0D
		dc.b 	 $E,	 $E     ;	$0E
		dc.b 	$18,	$18     ;	$0F
		dc.b 	$28,	$10     ;	$10
		dc.b 	$10,	$18     ;	$11
		dc.b 	 $C,	$20     ;	$12
		dc.b 	$20,	$70     ;	$13
		dc.b 	$40,	$20     ;	$14
		dc.b 	$80,	$20     ;	$15
		dc.b 	$20,	$20     ;	$16
		dc.b 	  8,	  8     ;	$17
		dc.b 	  4,	  4     ;	$18
		dc.b 	$20,	  8     ;	$19
		
	@HASCOLLISION:
		ANDI.W	#$3F,D0
		ADD.W	D0,D0
		LEA		OBJ.XRAD(A1),A2
		MOVEQ	#0,	D1
		MOVE.B	(A2)+,D1
		MOVE.W	OBJ.X(A1),D0
		SUB.W	D1,D0
		SUB.W	D2,D0
		BCC.S	@OUT_X
		ADD.W	D1,D1
		ADD.W	D1,D0
		BCS.S	@IN_X
		BRA.S	@NEXTOBJ
		
	@OUT_X:
		CMP.W	D4,	D0
		BHI.S	@NEXTOBJ
	@IN_X:
		MOVEQ	#0,	D1
		MOVE.B	(A2)+,D1
		MOVE.W	OBJ.Y(A1),D0
		SUB.W	D1,D0
		SUB.W	D3,D0
		BCC.S	@OUT_Y
		ADD.W	D1,D1
		ADD.W	D0,D1
		BCS.S	@HURT	;	inside both X and Y
		BRA.W	@NEXTOBJ
		
	@OUT_Y:
		CMP.W	D5,D0
		BHI.W	@NEXTOBJ
		
	@HURT:
		move.b	TEXTSND,	D0
		jmp		PlaySound