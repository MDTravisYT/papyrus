;=======================================================;
;			*$$SNG81.S	(Song Data)						;
;						ORG. MDSNG111.S					;
;				'Sound-Source'							;
;				 for Mega Drive (68K)					;
;						Ver  1.1 / 20XX					;
;								By  T.Fox,	MDTravis	;
;=======================================================;

;		public	S81

;		list off
;		include	mdEQ11.LIB
;		include	mdMCR11.LIB
;		include	mdTB11.LIB
;		list on

		even

;===============================================;
;												;
;					 ASSIGN						;
;												;
;===============================================;
;=====< S81 CHANNEL TOTAL >=====;
FM81	EQU		6				; FM Channel Total
PSG81	EQU		3				; PSG Channel Total
;=========< S81 TEMPO >=========;
TP81	EQU		2				; Tempo
DL81	EQU		3				; Delay
;==========< S81 BIAS >=========;
FB810	EQU		0				; FM 0ch
FB811	EQU		0				; FM 1ch
FB812	EQU		0				; FM 2ch
FB814	EQU		0				; FM 4ch
FB815	EQU		0				; FM 5ch
FB816	EQU		0				; FM 6ch (if don't use PCM drum)
PB818	EQU		-12				; PSG 80ch
PB81A	EQU		-12				; PSG A0ch
PB81C	EQU		0				; PSG C0ch
;==========< S81 VOLM >=========;
FA810	EQU		$04				; FM 0ch
FA811	EQU		$0C				; FM 1ch
FA812	EQU		$04				; FM 2ch
FA814	EQU		$04				; FM 4ch
FA815	EQU		$04				; FM 5ch
FA816	EQU		$04				; FM 6ch (if don't use PCM drum)
PA818	EQU		$03				; PSG 80ch
PA81A	EQU		$03				; PSG A0ch
PA81C	EQU		$03				; PSG C0ch
;==========< S81 ENVE >=========;
PE818	EQU		0				; PSG 80ch
PE81A	EQU		0				; PSG A0ch
PE81C	EQU		4				; PSG C0ch
;==========< S81 VOICE >========;
BASS81	EQU		0
LEAD181	EQU		1
LEAD281	EQU		2

;===============================================;
;												;
;					 HEADER						;
;												;
;===============================================;
S81:
		TDW		TIMB81,S81				; Voice Top Address
		DC.B	FM81,PSG81,TP81,DL81	; FM Total,PSG Total,Tempo,Delay

		TDW		TAB81D,S81				; PCM Drum Table Pointer
		DC.B	0,0						; Bias,Volm (Dummy)

		TDW		TAB810,S81				; FM 0ch Table Pointer
		DC.B	FB810,FA810				; Bias,Volm

		TDW		TAB811,S81				; FM 1ch Table Pointer
		DC.B	FB811,FA811				; Bias,Volm

		TDW		TAB812,S81				; FM 2ch Table Pointer
		DC.B	FB812,FA812				; Bias,Volm

		TDW		TAB814,S81				; FM 4ch Table Pointer
		DC.B	FB814,FA814				; Bias,Volm

		TDW		TAB815,S81				; FM 5ch Table Pointer
		DC.B	FB815,FA815				; Bias,Volm

		TDW		TAB818,S81				; PSG 80ch Table Pointer
		DC.B	PB818,PA818,0,PE818		; Bias,Volm,Dummy,Enve

		TDW		TAB81A,S81				; PSG A0ch Table Pointer
		DC.B	PB81A,PA81A,0,PE81A		; Bias,Volm,Dummy,Enve

		TDW		TAB81C,S81				; PSG C0ch Table Pointer
		DC.B	PB81C,PA81C,0,PE81C		; Bias,Volm,Dummy,Enve

;===============================================;
;												;
;				   SONG TABLE					;
;												;
;===============================================;
;===============================================;
;					 FM 0ch						;
;===============================================;
TAB810	EQU		*
		DC.B	FEV,0
		DC.B	CN3,4,NL
		DC.B	CMREPT,	0,8*6
		JDW		TAB810
		DC.B	CMCALL
		JDW		SUB810_0
		DC.B	CMCALL
		JDW		SUB810_1
		DC.B	CMCALL
		JDW		SUB810_0
		DC.B	CMCALL
		JDW		SUB810_2
		DC.B	CMEND
		
SUB810_0	EQU	*
		DC.B	FN3,NL,CN3,NL,FN3,NL,CN3,NL
		DC.B	GN3,NL,DN3,NL,GN3,NL,DN3,NL
		DC.B	CMRET
		
SUB810_1	EQU	*
		DC.B	GS3,NL,DS3,NL,GS3,NL,FN3,NL
		DC.B	DS3,NL,AS2,NL,CS3,NL,GN3,NL
		DC.B	CMRET
		
SUB810_2	EQU	*
		DC.B	GS3,NL,GS3,NL,GS3,NL,27
		DC.B	FN3,2,GN3,NL,FN3,NL,DS3,NL,DN3,NL
		DC.B	CMJUMP
		JDW		TAB810
;===============================================;
;					 FM 1ch						;
;===============================================;
TAB811	EQU		*
		DC.B	FEV,1
		DC.B	NL,64,NL
		DC.B	NL,4,CN4,2,NL,GN4,NL,CN5,NL
		DC.B	LFO,0,3,10,10,DN5,8,VROFF
		DC.B	CN5,BN4,4,CN5,VRON,CS5,8,VROFF
		DC.B	CN5,2,NL,GN4,NL,DS4,NL,CN4,NL
		DC.B	DN4,4,DS4,2,NL,FS4,8
		DC.B	GN4,2,NL,DS4,NL,CN4,NL,AN3,NL
		DC.B	BN3,4,CN4,2,NL,DN4,8,CN4,2,NL,18
		
		DC.B	CN4,2,NL,GN4,NL,CN5,NL,VRON,DN5,8
		DC.B	VROFF,GS5,1,AN5,AS5,6
		DC.B	AN5,2,NL,GN5,NL,AN5,8
		DC.B	AS5,2,NL,GN5,NL,DS5,NL,CN5,NL
		DC.B	BN4,NL,CN5,NL,DN5,8
		DC.B	DS5,2,NL,CN5,NL,GN4,NL,DS4,NL
		DC.B	BN4,4,AN4,2,NL,BN4,1,CN5,BN4,CN5,BN4,4
		DC.B	CN5,2,NL,18
		
		DC.B	FEV,2
		DC.B	FN4,2,NL,GS4,NL,CN5,NL
		DC.B	FN5,8,CN5
		DC.B	BN4,2,NL,CN5,NL,DN5,1,DS5,DN5,6
		DC.B	BN4,2,NL,GN4,NL,BN4,NL,DN5,NL
		DC.B	DS5,6,DS5,1,FN5,DS5,DN5,NL,2
		DC.B	CN5,NL,CN6,8,AS5,2,NL,GS5,NL
		DC.B	GN5,6,GN5,1,GS5,GN5,FN5,NL,2
		DC.B	GS5,NL,GN5,16,NL,4
		
		DC.B	FN4,2,NL,GS4,NL,CN5,NL
		DC.B	FN5,8,CN5
		DC.B	BN4,2,NL,CN5,NL,DN5,1,DS5,DN5,6
		DC.B	BN4,2,NL,GN4,NL,BN4,NL,DN5,NL
		DC.B	DS5,6,DS5,1,FN5,DS5,DN5,NL,2
		DC.B	CN5,NL,CN6,8,NL,4,DN6,1,DS6,NL,2
		DC.B	DN6,NL,CN6,NL,BN5,NL,GS5,NL,GN5,16
		DC.B	CMJUMP
		JDW		TAB811
;===============================================;
;					 FM 2ch						;
;===============================================;
TAB812	EQU		*
		DC.B	CMEND
;===============================================;
;					 FM 4ch						;
;===============================================;
TAB814	EQU		*
		DC.B	CMEND
;===============================================;
;					 FM 5ch						;
;===============================================;
TAB815	EQU		*
		DC.B	CMEND
;===============================================;
;					 PSG 80ch					;
;===============================================;
TAB818	EQU		*
		DC.B	CMCALL
		JDW		SUB818_0
		DC.B	CMREPT,	0,6
		JDW		TAB818
		DC.B	CMCALL
		JDW		SUB818_1
		DC.B	CMCALL
		JDW		SUB818_2
		DC.B	CMCALL
		JDW		SUB818_1
		DC.B	CMCALL
		JDW		SUB818_3
		DC.B	CMJUMP
		JDW		TAB818

SUB818_0	EQU	*
		DC.B	NL,4,DS2,2,NL,6,FS2,2,NL,6,DS2,2,NL,6,DN2,2,NL,2
		DC.B	NL,4,DS2,2,NL,6,FS2,2,NL,6,DS2,2,NL,6,DN2,2,NL,2
		DC.B	CMRET

SUB818_1	EQU	*
		DC.B	NL,4,CN2,2,NL,6,CN2,2,NL,6,CN2,2,NL,6,CN2,2,NL,2
		DC.B	NL,4,DN2,2,NL,6,DN2,2,NL,6,DN2,2,NL,6,DN2,2,NL,2
		DC.B	CMRET

SUB818_2	EQU	*
		DC.B	NL,4,DS2,2,NL,6,DS2,2,NL,6,DS2,2,NL,6,CN3,2,NL,2
		DC.B	NL,4,AS2,2,NL,6,AS2,2,NL,6,GN2,2,NL,6,GN2,2,NL,2
		DC.B	CMRET

SUB818_3	EQU	*
		DC.B	NL,4,DS2,2,NL,6,DS2,2,NL,32,FN2,2
		DC.B	GN2,NL,FN2,NL,DS2,NL,DN2,NL
		DC.B	CMRET
;===============================================;
;					 PSG A0ch					;
;===============================================;
TAB81A	EQU		*
		DC.B	CMCALL
		JDW		SUB81A_0
		DC.B	CMREPT,	0,6
		JDW		TAB81A
		DC.B	CMCALL
		JDW		SUB81A_1
		DC.B	CMCALL
		JDW		SUB81A_2
		DC.B	CMCALL
		JDW		SUB81A_1
		DC.B	CMCALL
		JDW		SUB81A_3
		DC.B	CMJUMP
		JDW		TAB81A

SUB81A_0	EQU	*
		DC.B	CN1,2,NL,GN2,NL,CN1,NL,AN2,NL
		DC.B	CN1,NL,GN2,NL,CN1,NL,FS2,NL
		DC.B	CN1,NL,GN2,NL,CN1,NL,AN2,NL
		DC.B	CN1,NL,GN2,NL,CN1,NL,FS2,NL
		DC.B	CMRET
		
SUB81A_1	EQU	*
		DC.B	FN1,NL,FN3,NL,CN1,NL,FN3,NL
		DC.B	FN1,NL,FN3,NL,CN1,NL,FN3,NL
		DC.B	GN1,NL,GN3,NL,DN1,NL,GN3,NL
		DC.B	GN1,NL,GN3,NL,DN1,NL,GN3,NL
		DC.B	CMRET
		
SUB81A_2	EQU	*
		DC.B	GS1,NL,GS3,NL,DS1,NL,GS3,NL
		DC.B	GS1,NL,GS3,NL,FN1,NL,FN3,NL
		DC.B	DS1,NL,DS3,NL,AS0,NL,DS3,NL
		DC.B	CS1,NL,CS3,NL,GS1,NL,DN3,NL
		DC.B	CMRET
		
SUB81A_3	EQU	*
		DC.B	GS1,NL,GS3,NL,GS1,NL,GS3,NL
		DC.B	GS1,NL,14
		DC.B	FN1,8,DN1,6,FN1,2
		DC.B	GN1,NL,FN1,NL,DS1,NL,DN1,NL
		DC.B	CMRET
;===============================================;
;					 PSG C0ch					;
;===============================================;
TAB81C	EQU		*
		DC.B	CMNOIS,NOIS7
		DC.B	CMGATE,6
		DC.B	0C6H-12*2,4	;	5
		DC.B	0C6H		;	8
		DC.B	0C6H-12*2	;	5
		DC.B	0C6H-6		;	7
		DC.B	0C6H-12*2	;	5
		DC.B	0C6H		;	8
		DC.B	0C6H-6		;	7
		DC.B	0C6H-12		;	6
		DC.B	0C6H-12*2	;	5
		DC.B	0C6H		;	8
		DC.B	0C6H-12*2	;	5
		DC.B	0C6H-6		;	7
		DC.B	0C6H-12*2	;	5
		DC.B	0C6H		;	8
		DC.B	0C6H,2		;	8
		DC.B	0C6H-6		;	7
		DC.B	0C6H-12,4	;	6
		DC.B	CMREPT,	0,9
		JDW		TAB81C
		DC.B	0C6H-12*2	;	5
		DC.B	0C6H		;	8
		DC.B	0C6H-12*2	;	5
		DC.B	0C6H-6		;	7
		DC.B	0C6H-12*2,16;	5
		DC.B	0C6H-12*2,4	;	5
		DC.B	0C6H		;	8
		DC.B	0C6H-12*2	;	5
		DC.B	0C6H-6		;	7
		DC.B	0C6H-12		;	6
		DC.B	0C6H-12*2	;	5
		DC.B	0C6H-12*3	;	4
		DC.B	0C6H-6		;	7
		
		DC.B	CMJUMP
		JDW		TAB81C
;===============================================;
;					 PCM DRUM					;
;===============================================;
TAB81D	EQU		*
		DC.B	CMEND
;===============================================;
;												;
;					  VOICE						;
;												;
;===============================================;
TIMB81	EQU		*
;			<BASS>
	smpsVcAlgorithm     $04
	smpsVcFeedback      $03
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $0E, $0E, $00, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $38, $23, $00, $2A
;			<LEAD1>
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $02, $06, $03, $04
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $03, $09, $00, $1B
;			<LEAD2>
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $02, $04, $03, $05
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $02, $0B, $00, $1A

; vim: set ft=asm68k sw=4 ts=4 noet:
