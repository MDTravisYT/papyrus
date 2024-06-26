_OBJECTCOLLIDE:
		TST.B	SOUL.INV(A0)
		BNE.W	@DONT
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
		MOVE.B	OBJ.COLLISION(A1),D0
		BTST	#7,	D0
		BEQ.S	@CONT
		TST.B	SOUL.MOVE(A0)
		BEQ.S	@DONT
	@CONT:
		AND.B	#%01111111,	D0
		MOVE.B	HP,		D1
		and		#0,		CCR
		SBCD	D0,		D1
		move.b	D1,		HP
		move.b	#30,SOUL.INV(A0)
		move.b	#$A6,	D0
		jmp		PlaySound
		
	@DONT:
		RTS