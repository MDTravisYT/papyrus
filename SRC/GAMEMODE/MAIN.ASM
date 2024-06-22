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
		
		move.l	#VRAMWRITE,	(VDPCTRL)
		LEA		ART_PAPHEAD,		A0
		LEA		VDPDATA,	A1
		WRITEVRAM	$4000
		MOVE.W	#(ART_PAPHEAD_END-ART_PAPHEAD)/2-1,		D0
	@LOADGFX3:
		MOVE.W	(A0)+,	(A1)
		DBF		D0,	@LOADGFX3
		
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
		
		move.b	#$81,	D0
		jsr		PlaySound
		
		JSR		PALFADEIN
		
		MOVE.L	#$48080002,	TEXTLOG			;	where on screen the text should print
		MOVE.L	#$48080002,	NEWLINE_MEMO	;	memorize where a new line starts
		MOVE.W	#$0,	TEXTPROG			;	memorize how far into a script it's read
		MOVE.L	#TXT_ENCOUNTER,	TEXTLOC				;	where in ROM the script is read
		MOVE.W	#0,		TIMER				;	reset timer (makes the dialogue begin later if set other than 0)
		MOVE.B	#$A2,	TEXTSND				;	sound byte
		MOVE.B	#20,	HP
		
	@loop:
		MOVE.B	#1,	(VBLANKCMD).W
		jsr		VSYNC
		JSR		RUNOBJECTS
		JSR		PROCESSSPRITES
		
		cmpi.b	#0,HP
		bne.s	@noDie
		jmp		START
		
	@noDie:
		
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
		MOVE.L	#BLANKTXT,	TEXTLOC
		MOVE.L	#$48080002,	TEXTLOG
		MOVE.L	#$48080002,	NEWLINE_MEMO
		MOVE.W	#$0,	TEXTPROG
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

;	--< INTERNAL >--
;	Stuff that shouldn't be seen in the final gameplay.

SKIP_BLIP:
	DC.B	' ',$FF
SLOW_BLIP:
	DC.B	'.,!?',$FF
	
BLANKTXT:
	DC.B	$FF
	
TST:	;	Alignment reference. Each line can have a maximum of 32 characters, and each box can only have a maximum of 3 lines.
	DC.B	'01234567890123456789012345678901',1
	DC.B	'12345678901234567890123456789012',1
	DC.B	'23456789012345678901234567890123'
	DC.B	$FF
	even
	
;	--< ENCOUNTER >--
;	Only shows at the start.
	
TXT_ENCOUNTER:
	DC.B	'Papyrus blocks the way!'
	DC.B	$FF
	even
	
;	--< NEUTRAL TEXT >--
;	Randomly shows one of these if certain events aren't active.
	
TXT_NEUTRAL1:
	DC.B	'Papyrus is preparing a bone ',1
	DC.B	'attack.'
	DC.B	$FF
	even
	
TXT_NEUTRAL2:
	DC.B	'Papyrus prepares a non-bone ',1
	DC.B	'attack then spends a minute ',1
	DC.B	'fixing his mistake.'
	DC.B	$FF
	even
	
TXT_NEUTRAL3:
	DC.B	'Papyrus is cackling.'
	DC.B	$FF
	even
	
TXT_NEUTRAL4:
	DC.B	'Papyrus whispers "Nyeh heh heh!"'
	DC.B	$FF
	even
	
TXT_NEUTRAL5:
	DC.B	'Papyrus is rattling his bones.'
	DC.B	$FF
	even
	
TXT_NEUTRAL6:
	DC.B	'Papyrus is trying to play it ',1
	DC.B	'cool.'
	DC.B	$FF
	even
	
TXT_NEUTRAL7:
	DC.B	'Smells like bones.'
	DC.B	$FF
	even
	
TXT_NEUTRAL8:
	DC.B	'Papyrus is considering his ',1
	DC.B	'options.'
	DC.B	$FF
	even
	
TXT_NEUTRAL9:
	DC.B	'Papyrus remembered a bad joke '
	DC.B	'Sans told and is frowning.'
	DC.B	$FF
	even
	
;	--< ACT - CHECK >--
	
TXT_CHECK1:
	DC.B	'PAPYRUS 8 ATK 2 DEF',1
	DC.B	'He likes to say:',1
	DC.B	'"Nyeh heh heh!"'
	DC.B	$FF
	even

TXT_CHECK2:
	DC.B	'NYEH HEH HEH!'
	DC.B	$FF
	even
	
;	--< ACT - FLIRT >--

TXT_FLIRT1_1:	;	flirt 1
	DC.B	'WHAT!? FLIRTING!?'
	DC.B	$FF
	even
	
TXT_FLIRT1_2:
	DC.B	'SO YOU FINALLY REVEAL YOUR ',1
	DC.B	3,'ULTIMATE FEELINGS',2,'!'
	DC.B	$FF
	even
	
TXT_FLIRT1_3:
	DC.B	"W-WELL! I'M A SKELETON WITH VERY ",1
	DC.B	"HIGH STANDARDS!!!"
	DC.B	$FF
	even
	
TXT_FLIRT1_4:
	DC.B	'I can make spaghetti',1,1
	DC.B	'I have zero redeeming qualities'
	DC.B	$FF
	even
	
TXT_FLIRT1_4_11:	;	I can make spaghetti
	DC.B	"OH NO!!! YOU'RE ",1
	DC.B	"METTING ALL MY STANDARDS!!!"
	DC.B	$FF
	even
	
TXT_FLIRT1_4_12:
	DC.B	"I GUESS THIS MEANS I HAVE TO GO ",1
	DC.B	"ON A DATE WITH YOU...?"
	DC.B	$FF
	even
	
TXT_FLIRT1_4_13:
	DC.B	"I GUESS THIS MEANS I HAVE TO GO ",1
	DC.B	"ON A DATE WITH YOU...?"
	DC.B	$FF
	even
	
TXT_FLIRT1_4_21:	;	I have zero redeeming qualities
	DC.B	"OH NO!!! THAT HUMILITY...",1
	DC.B	"IT REMINDS ME OF,"
	DC.B	$FF
	even
	
TXT_FLIRT1_4_22:
	DC.B	"MYSELF!!!"
	DC.B	$FF
	even
	
TXT_FLIRT1_4_23:
	DC.B	"YOU'RE MEETING ALL MY ",1
	DC.B	"STANDARDS!!!"
	DC.B	$FF
	even
	
TXT_FLIRT1_5:	;	both options end with this string, shows alone after 2 flirts
	DC.B	"LET'S DATE L-LATER!!",1
	DC.B	"AFTER I CAPTURE YOU!"
	DC.B	$FF
	even
	
TXT_FLIRT2:	;	shows after 1 flirt, goes to 1_5 after
	DC.B	"OH NO!!!"
	DC.B	$FF
	even

;	--< ACT - INSULT >--

TXT_INSULT1_1:	;	insult 1
	DC.B	'HOW SELFLESS...'
	DC.B	$FF
	even
TXT_INSULT1_2:
	DC.B	'YOU WANT ME TO FEEL BETTER ABOUT ',1
	DC.B	'FIGHTING YOU...'
	DC.B	$FF
	even
TXT_INSULT1_3:
	DC.B	"I DON'T DESERVE SUCH HOSPITALITY ",1
	DC.B	'FROM YOU ...'
	DC.B	$FF
	even
	
TXT_INSULT2_1:	;	insult 2
	DC.B	"THERE'S NO NEED TO LIE TO",1
	DC.B	"YOURSELF!!!"
	DC.B	$FF
	even
TXT_INSULT2_2:
	DC.B	"YOUR BARBS HIDE A HIDDEN ",1
	DC.B	"AFFECTION! YOU EMOTIONAL ",1
	DC.B	"CACTUS!"
	DC.B	$FF
	even
	
TXT_INSULT3_1:	;	insult 3
	DC.B	"DON'T...!"
	DC.B	$FF
	even
	
TXT_INSULT4:	;	insult 4+, also 3_2
	DC.B	"DON'T WASTE YOUR WORDS ON ME!"
	DC.B	$FF
	even
	
;	--< DEATH >--

TXT_DIE1:
	DC.B	"YOU'RE TOO WEAK!! I WAS EASILY ",1
	DC.B	"ABLE TO CAPTURE YOU!!!"
	DC.B	$FF
	even
TXT_DIE2:
	DC.B	"I WILL NOW SEND YOU TO THE ",1
	DC.B	"CAPTURE ZONE!!"
	DC.B	$FF
	even
TXT_DIE3:
	DC.B	"OR, AS SANS CALLS IT..."
	DC.B	$FF
	even
TXT_DIE4:	;	game resets after this
	DC.B	"THE ENTRYPOINT???"
	DC.B	$FF
	even

TST3:

TXTERR:
	DC.B	'The programmer had a nap.',1
	DC.B	'Hold out, programmer!',1
	DC.B	'(moveset end reached)',$FF
	even