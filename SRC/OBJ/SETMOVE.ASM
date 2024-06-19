HIMOVE	=	2*2	;	anything above this errors

SETMOVE:
		MOVEQ	#0,	D0
		CMPI.B	#HIMOVE,	MOVENUM
		BEQ.W	MoveErr
		MOVE.B	MOVENUM,OBJ.ACTION(A0)
		MOVE.B	OBJ.ACTION(A0),	D0
		MOVE.W	@INDEX(PC,D0.W),	D1
		JMP		@INDEX(PC,D1.W)
		
	@INDEX:
		DC.W	Move1-@INDEX
		DC.W	Move2-@INDEX
		@INDEX_END:
		
	Move1:
	
		MOVEQ	#0,	D0
		MOVE.B	OBJ.SUBACTION(A0),	D0
		MOVE.W	@MV1_INDEX(PC,D0.W),	D1
		JMP		@MV1_INDEX(PC,D1.W)
		
		@MV1_INDEX:
			DC.W	@R1-@MV1_INDEX
			DC.W	@R2-@MV1_INDEX
		@R1:
			COPYTILEMAP		BATTLEMAP,	$8084,	35,	25
			MOVE.L	#$48140002,	TEXTLOG			;	where on screen the text should print
			MOVE.L	#$48140002,	NEWLINE_MEMO	;	memorize where a new line starts
			MOVE.W	#$0,	TEXTPROG			;	memorize how far into a script it's read
			MOVE.L	#TST2,	TEXTLOC				;	where in ROM the script is read
			MOVE.W	#0,		TIMER				;	reset timer (makes the dialogue begin later if set other than 0)
			MOVE.B	#$A3,	TEXTSND				;	sound byte
			ADDI.B	#2,	OBJ.SUBACTION(A0)
		@R2:
			MOVEQ	#0,	D0
			MOVEQ	#0,	D1
			MOVE.B	JOYPADPRESS,	D0
			andi.b	#btnA+btnB+btnC,D0
			beq.w	@end
			
			MOVE.B	#$A0,	D0
			JSR		PlaySound
			
			MOVE.B	#1,	OBJ.ID(A0)
			MOVE.W	#160,	OBJ.X(A0)
			MOVE.W	#140,	OBJ.Y(A0)
			MOVE.B	#0,	OBJ.ACTION(A0)
			MOVE.B	#0,	OBJ.FRAME(A0)
			MOVE.W	#0,	OBJ.YSPEED(A0)
			
			MOVE.B	#$04,	(OBJSLOT01)+OBJ.ID
			MOVE.W	#250,	(OBJSLOT01)+OBJ.X
			MOVE.W	#164,	(OBJSLOT01)+OBJ.Y
			
			MOVE.B	#$04,	(OBJSLOT02)+OBJ.ID
			MOVE.W	#300,	(OBJSLOT02)+OBJ.X
			MOVE.W	#162,	(OBJSLOT02)+OBJ.Y
			MOVE.W	#2,		(OBJSLOT02)+OBJ.ARGUMENT
			
			MOVE.B	#$04,	(OBJSLOT03)+OBJ.ID
			MOVE.W	#350,	(OBJSLOT03)+OBJ.X
			MOVE.W	#160,	(OBJSLOT03)+OBJ.Y
			MOVE.W	#4,		(OBJSLOT03)+OBJ.ARGUMENT
			
			MOVE.L	#BLANKTXT,	TEXTLOC
			MOVE.L	#$48080002,	TEXTLOG
			MOVE.L	#$48080002,	NEWLINE_MEMO
			MOVE.W	#$0,	TEXTPROG
			
			COPYTILEMAP		BOARDMAP,	$8704,	35,	7
		@end:
			rts

	Move2:
		MOVEQ	#0,	D0
		MOVE.B	OBJ.SUBACTION(A0),	D0
		MOVE.W	@MV2_INDEX(PC,D0.W),	D1
		JMP		@MV2_INDEX(PC,D1.W)
		
		@MV2_INDEX:
			DC.W	@R1-@MV2_INDEX
			DC.W	@R2-@MV2_INDEX
		@R1:
			COPYTILEMAP		BATTLEMAP,	$8084,	35,	25
			MOVE.L	#$48140002,	TEXTLOG			;	where on screen the text should print
			MOVE.L	#$48140002,	NEWLINE_MEMO	;	memorize where a new line starts
			MOVE.W	#$0,	TEXTPROG			;	memorize how far into a script it's read
			MOVE.L	#TST3,	TEXTLOC				;	where in ROM the script is read
			MOVE.W	#0,		TIMER				;	reset timer (makes the dialogue begin later if set other than 0)
			MOVE.B	#$A3,	TEXTSND				;	sound byte
			ADDI.B	#2,	OBJ.SUBACTION(A0)
		@R2:
			MOVEQ	#0,	D0
			MOVEQ	#0,	D1
			MOVE.B	JOYPADPRESS,	D0
			andi.b	#btnA+btnB+btnC,D0
			beq.w	@end
			
			MOVE.B	#$A0,	D0
			JSR		PlaySound
			
			MOVE.B	#2,	OBJ.ID(A0)
			MOVE.W	#160,	OBJ.X(A0)
			MOVE.W	#140,	OBJ.Y(A0)
			MOVE.B	#0,	OBJ.ACTION(A0)
			MOVE.B	#0,	OBJ.FRAME(A0)
			MOVE.W	#0,	OBJ.YSPEED(A0)
			
			MOVE.B	#$04,	(OBJSLOT01)+OBJ.ID
			MOVE.W	#250,	(OBJSLOT01)+OBJ.X
			MOVE.W	#164,	(OBJSLOT01)+OBJ.Y
			
			MOVE.B	#$04,	(OBJSLOT02)+OBJ.ID
			MOVE.W	#300,	(OBJSLOT02)+OBJ.X
			MOVE.W	#162,	(OBJSLOT02)+OBJ.Y
			MOVE.W	#2,		(OBJSLOT02)+OBJ.ARGUMENT
			
			MOVE.B	#$04,	(OBJSLOT03)+OBJ.ID
			MOVE.W	#350,	(OBJSLOT03)+OBJ.X
			MOVE.W	#160,	(OBJSLOT03)+OBJ.Y
			MOVE.W	#4,		(OBJSLOT03)+OBJ.ARGUMENT
			
			MOVE.L	#BLANKTXT,	TEXTLOC
			MOVE.L	#$48080002,	TEXTLOG
			MOVE.L	#$48080002,	NEWLINE_MEMO
			MOVE.W	#$0,	TEXTPROG
			
			COPYTILEMAP		BOARDMAP,	$8704,	35,	7
		@end:
			rts
		
	MoveErr:
		MOVEQ	#0,	D0
		MOVE.B	OBJ.SUBACTION(A0),	D0
		MOVE.W	@MVERR_INDEX(PC,D0.W),	D1
		JMP		@MVERR_INDEX(PC,D1.W)
		
		@MVERR_INDEX:
			DC.W	@R1-@MVERR_INDEX
			DC.W	@R2-@MVERR_INDEX
		@R1:
			MOVE.L	#$48080002,	TEXTLOG			;	where on screen the text should print
			MOVE.L	#$48080002,	NEWLINE_MEMO	;	memorize where a new line starts
			MOVE.W	#$0,	TEXTPROG			;	memorize how far into a script it's read
			MOVE.L	#TXTERR,	TEXTLOC				;	where in ROM the script is read
			MOVE.W	#0,		TIMER				;	reset timer (makes the dialogue begin later if set other than 0)
			MOVE.B	#$A1,	TEXTSND				;	sound byte
			ADDI.B	#2,	OBJ.SUBACTION(A0)
		@R2:
			RTS