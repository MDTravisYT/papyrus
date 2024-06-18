MAIN:
		JSR		CLEARSCREEN
		
		move.l	#VRAMWRITE,	(VDPCTRL)
		LEA		BATTLEART,		A0
		LEA		VDPDATA,	A1
		MOVE.W	#(BATTLEART_END-BATTLEART)/2-1,		D0
	@LOADGFX:
		MOVE.W	(A0)+,	(A1)
		DBF		D0,	@LOADGFX
		
		move.l	#VRAMWRITE,	(VDPCTRL)
		LEA		TXTART,		A0
		LEA		VDPDATA,	A1
		WRITEVRAM	$2000
		MOVE.W	#(TXTART_END-TXTART)/2-1,		D0
	@LOADGFX2:
		MOVE.W	(A0)+,	(A1)
		DBF		D0,	@LOADGFX2
		
		LEA		BATTLEPAL,	A0
		LEA		PALFADEBUFFER,	A1
		MOVE.B	#16,	D0
	@PALLOOP:
		MOVE.L	(A0)+,	(A1)+
		DBF		D0,	@PALLOOP
		
	COPYTILEMAP		BATTLEMAP,	$8084,	35,	25
	
		MOVE.B	#$03,	(OBJSLOT00)
		LEA		(OBJSLOT00),	A0
		MOVE.W	#152,	OBJ.X(A0)
		MOVE.W	#204,	OBJ.Y(A0)
		
		JSR		PALFADEIN
		
		MOVE.L	#$48080002,	TEXTLOG			;	where on screen the text should print
		MOVE.L	#$48080002,	NEWLINE_MEMO	;	memorize where a new line starts
		MOVE.W	#$0,	TEXTPROG			;	memorize how far into a script it's read
		MOVE.L	#TST,	TEXTLOC				;	where in ROM the script is read
		MOVE.W	#0,		TIMER				;	reset timer (makes the dialogue begin later if set other than 0)
		MOVE.B	#$A2,	TEXTSND				;	sound byte
		
	@loop:
		MOVE.B	#1,	(VBLANKCMD).W
		jsr		VSYNC
		JSR		RUNOBJECTS
		JSR		PROCESSSPRITES
		
		tst.b	TIMER+1
		bne.W	@skipDialogue
		MOVE.L	TEXTLOC,	A0
		ADD.W	TEXTPROG,	A0
		CMPI.B	#1,	(A0)
		BNE.S	@no_newline
		ADD.L	#$1000000,	NEWLINE_MEMO
		MOVE.L	NEWLINE_MEMO,	TEXTLOG
		ADDI.W	#1,	TEXTPROG
		bra.w	@loop
	@no_newline:
		CMPI.B	#$FF,	(A0)
		BNE.S	@noEnd
		bra.w	@loop
	@noEnd:
		MOVE.L	TEXTLOG,	(VDPCTRL)
		MOVE.W	#$100,	D0
		ADD.B	(A0)+,	D0
		MOVE.W	D0,	($C00000)
		add.l	#$20000,TEXTLOG
		move.b	#2,	TIMER+1
		add.w	#1,	TEXTPROG
		cmpi.b	#' ',	D0
		beq.s	@skipDialogue
		cmpi.b	#'.',	D0	;	TODO: optimize this into a table
		beq.s	@extnd
		cmpi.b	#',',	D0
		beq.s	@extnd
		cmpi.b	#'!',	D0
		beq.s	@extnd
		cmpi.b	#'?',	D0
		bne.s	@sound
	@extnd:
		move.b	#8,	TIMER+1
	@sound:
		move.b	TEXTSND,	D0
		jsr		PlaySound
	@skipDialogue:
		bra.w	@loop
		rts
		
BATTLEPAL:	INCBIN		"PAL/BATTLE.PAL"
BATTLEMAP:	INCBIN		"MAP/BATTLE.MAP"
BOARDMAP:	INCBIN		"MAP/BOARD.MAP"
BATTLEART:	INCBIN		"ART/BATTLE.UNC"
	BATTLEART_END:
TXTART:	INCBIN		"ART/FONT.UNC"
	TXTART_END:

SKIP_BLIP:
	DC.B	' ',$FF
SLOW_BLIP:
	DC.B	'.,!?',$FF
	
BLANKTXT:
	DC.B	$FF
	
TST:
	DC.B	'You see a trousle of bones',1
	dc.b	'blocking your way. Very boney.'
	DC.B	$FF
	even

TST2:
	DC.B	'NYEH HEH HEH!'
	DC.B	$FF
	even

TST3:
	DC.B	"YOU'RE BLUE NOW.",1,"THAT'S MY ATTACK!",1,"NYEH HEH HEH HEH HEH HEH HEH HEH HEH!!!"
	DC.B	$FF
	even
	

TXTERR:
	DC.B	'Unexpected move set'
	even