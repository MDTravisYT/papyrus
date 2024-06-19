;=======================================================;
;			*$$SE1.S  (S.E. Data)						;
;						ORG. MDSE111.S					;
;				'Sound-Source'							;
;				 for Mega Drive (68K)					;
;						Ver  1.1 / 1990.9.1				;
;									  By  H.Kubota		;
;=======================================================;


;		list off
;		include mdEQ11.LIB
;		include mdMCR11.LIB
;		include mdTB11.LIB
;		list on

;		PUBLIC	SA0,SA1,SA2,SA3,SA4,SA5,SA6,SA7
;		PUBLIC	SA8,SA9,SAA,SAB,SAC,SAD,SAE,SAF

		even

;=======================================;
;				   SA0					;
;=======================================;
SA0:

		TDW		TIMBA0,SA0				; Voice Top Address
		DC.B	2,2						; Base,Use Channel Total

		DC.B	80H,080H				; Flag,Channel
		TDW		TABA00,SA0				; FM 1ch Table Pointer
		DC.B	-12,000H				; Bias,Volm
		
		DC.B	80H,0A0H				; Flag,Channel
		TDW		TABA01,SA0				; FM 1ch Table Pointer
		DC.B	-12,000H				; Bias,Volm

;------------< Table Data >-------------;
TABA00	EQU		*
		DC.B	EV,3
		DC.B	GS4,1,CS5,FS5
		DC.B	PVADD,4
		DC.B	CS5,FS5
		DC.B	PVADD,4
		DC.B	CS5,FS5
		DC.B	SFEND

TABA01	EQU		*
		DC.B	EV,3
		DC.B	NL,2
		DC.B	PVADD,4
		DC.B	GS4,1,NL
		DC.B	PVADD,4
		DC.B	GS4,NL
		DC.B	SFEND

;------------< Voice Data >-------------;
TIMBA0	EQU		*

		even

;=======================================;
;				   SA1					;
;=======================================;
SA1:
		TDW		TIMBA1,SA1				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,080H				; Flag,Channel
		TDW		TABA10,SA1				; FM 1ch Table Pointer
		DC.B	-12,000H				; Bias,Volm

;------------< Table Data >-------------;
TABA10	EQU		*
		DC.B	EV,3
		DC.B	BN4,1
		DC.B	SFEND

;------------< Voice Data >-------------;
TIMBA1	EQU		*

		even

;=======================================;
;				   SA2					;
;=======================================;
SA2:
		TDW		TIMBA2,SA2				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,5					; Flag,Channel
		TDW		TABA20,SA2				; FM 1ch Table Pointer
		DC.B	00H,000H				; Bias,Volm

;------------< Table Data >-------------;
TABA20	EQU		*
		DC.B	FEV,0
		DC.B	BN4,1,NL,8
		DC.B	SFEND

;------------< Voice Data >-------------;
TIMBA2	EQU		*
	smpsVcAlgorithm     $02
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $02, $00, $00, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $00, $00, $10
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $1F, $00, $00, $00
	smpsVcDecayRate2    $04, $00, $00, $03
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $09, $00, $00, $02
	smpsVcTotalLevel    $00, $7F, $7F, $5D

		even

;=======================================;
;				   SA3					;
;=======================================;
SA3:
		TDW		TIMBA3,SA3				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,5					; Flag,Channel
		TDW		TABA30,SA3				; FM 1ch Table Pointer
		DC.B	00H,000H				; Bias,Volm

;------------< Table Data >-------------;
TABA30	EQU		*
		DC.B	FEV,0
		DC.B	BN4,1
		DC.B	SFEND

;------------< Voice Data >-------------;
TIMBA3	EQU		*
;	Voice $00
;	$02
;	$02, $51, $20, $01, 	$1E, $1E, $1E, $1E, 	$10, $0A, $14, $13
;	$01, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$24, $0E, $1F, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $02, $05, $00
	smpsVcCoarseFreq    $01, $00, $01, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1E, $1E, $1E, $1E
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $13, $14, $0A, $10
	smpsVcDecayRate2    $00, $00, $00, $01
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $80, $1F, $0E, $24

		even

;=======================================;
;				   SA4					;
;=======================================;
SA4:
		TDW		TIMBA4,SA4				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,5					; Flag,Channel
		TDW		TABA40,SA4				; FM 1ch Table Pointer
		DC.B	0F4H,000H				; Bias,Volm

;------------< Table Data >-------------;
TABA40	EQU		*
		DC.B	FEV,0
TA40	EQU		*
		DC.B	0A0H,60h
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBA4	EQU		*
		CNF		3,7
		MD		2,5,1,3,1,5,1,5
		RSAR	0,0CH,0,0CH,0,12H,0,12H
		D1R		0EH,0,0EH,0CH
		D2R		0,0,0,0EH
		RRL		15,4,15,0,15,5,15,3
		TL		15H,13H,1CH,0

		even

;=======================================;
;				   SA5					;
;=======================================;
SA5:
		TDW		TIMBA5,SA5				; Voice Top Address
		DC.B	1,2						; Base,Use Channel Total

		DC.B	80H,0A0H				; Flag,Channel
		TDW		TABA50,SA5				; FM 1ch Table Pointer
		DC.B	0F4H,000H				; Bias,Volm

		DC.B	80H,0C0H				; Flag,Channel
		TDW		TABA51,SA5				; FM 1ch Table Pointer
		DC.B	0F4H,000H				; Bias,Volm

;------------< Table Data >-------------;
TABA50	EQU		*
		DC.B	EV,1
		DC.B	FVR,1,1,50H,17H
		DC.B	09BH,0Ah
TA50	EQU		*
		DC.B	0A3H,4,PVADD,2
		DC.B	CMREPT,0,6
		JDW		TA50
		DC.B	CMEND
TABA51	EQU		*
		DC.B	EV,1
		DC.B	FVR,2,1,20H,10H,CMNOIS,NOIS7
		DC.B	0C4H,0AH
TA51	EQU		*
		DC.B	0C2H,02H,PVADD,1
		DC.B	CMREPT,0,12
		JDW		TA51
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBA5	EQU		*
		CNF		0,7
		MD		15,0,15,0,15,0,15,0
		RSAR	0,31,0,31,0,31,0,14
		D1R		0,0,0,10
		D2R		0,0,0,25
		RRL		15,0,15,0,15,0,15,1
		TL		7,7,7,0

		even

;=======================================;
;				   SA6					;
;=======================================;
SA6:
		TDW		TIMBA6,SA6				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,5					; Flag,Channel
		TDW		TABA60,SA6				; FM 1ch Table Pointer
		DC.B	00H,004H				; Bias,Volm

;------------< Table Data >-------------;
TABA60	EQU		*
		DC.B	FEV,0
TBA6	EQU		*
		DC.B	0A0h,14
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBA6	EQU		*
		CNF		0,5
		MD		3,0,0,7,1,3,0,0
		RSAR	0,31,0,31,1,31,1,31
		D1R		3,3,3,2
		D2R		1,2,2,3
		RRL		15,10,15,2,15,2,15,5
		TL		30,25,22,0

		even

;=======================================;
;				   SA7					;
;=======================================;
SA7:
		TDW		TIMBA7,SA7				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,0C0H				; Flag,Channel
		TDW		TABA70,SA7				; FM 1ch Table Pointer
		DC.B	00H,000H				; Bias,Volm

;------------< Table Data >-------------;
TABA70	EQU		*
		DC.B	CMNOIS,NOIS7
		DC.B	FVR,1,1,7,2
		DC.B	EXCOM,S_PSE,ON
TA70	EQU		*
		DC.B	0A0H,4,CMBIAS,1,CMREPT,0,20H
		JDW		TA70
		DC.B	20
		DC.B	EXCOM,S_PSE,OFF
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBA7	EQU		*

		even

;=======================================;
;				   SA8					;
;=======================================;
SA8:
		TDW		TIMBA8,SA8				; Voice Top Address
		DC.B	1,2						; Base,Use Channel Total

		DC.B	80H,4					; Flag,Channel
		TDW		TABA81,SA8				; FM 1ch Table Pointer
		DC.B	0F2H,008H				; Bias,Volm

		DC.B	80H,5					; Flag,Channel
		TDW		TABA80,SA8				; FM 1ch Table Pointer
		DC.B	0F2H,008H				; Bias,Volm

;------------< Table Data >-------------;
TABA80	EQU		*
		DC.B	FEV,0
		DC.B	CMJUMP
		JDW		TA80
TABA81	EQU		*
		DC.B	FEV,0
TA80	EQU		*
		DC.B	0B0H,2,CMTAB,0AEh,1,CMTAB,CMBIAS,-1
		DC.B	CMREPT,0,20H
		JDW		TA80
		DC.B	CMBIAS,20H
TA81	EQU		*
		DC.B	090H,2,NL,1
		DC.B	CMREPT,0,5
		JDW		TA81
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBA8	EQU		*
;-----------< Voice Data 0 >------------;
		CNF		3,7
		MD		12,3,9,3,0,3,1,3
		RSAR	3,31,0,31,0,31,3,31
		D1R		4,5,4,1
		D2R		4,4,4,2
		RRL		15,15,15,0,15,1,15,10
		TL		41,32,15,0
;-----------< Voice Data 1 >------------;
		CNF		5,7
		MD		1,0,2,0,0,0,1,0
		RSAR	0,31,0,14,0,14,0,14
		D1R		7,31,31,31
		D2R		0,0,0,0
		RRL		15,1,15,0,15,0,15,0
		TL		23,13,12,12

		even

;=======================================;
;				   SA9					;
;=======================================;
SA9:
		TDW		TIMBA9,SA9				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,5					; Flag,Channel
		TDW		TABA90,SA9				; FM 1ch Table Pointer
		DC.B	00H,006H				; Bias,Volm

;------------< Table Data >-------------;
TABA90	EQU		*
		DC.B	FEV,0
		DC.B	NL,1
		DC.B	FVR,0,1,0D0H,0FFH
		DC.B	0C5H,0FH
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBA9	EQU		*
		CNF		0,7
		MD		15,0,15,0,15,0,15,0
		RSAR	0,31,0,31,0,31,0,14
		D1R		0,0,0,11H
		D2R		0,0,0,13H
		RRL		15,0,15,0,15,0,15,1
		TL		7,7,7,0

		even

;=======================================;
;				   SAA					;
;=======================================;
SAA:
		TDW		TIMBAA,SAA				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,0C0H				; Flag,Channel
		TDW		TABAA0,SAA				; FM 1ch Table Pointer
		DC.B	00H,001H				; Bias,Volm

;------------< Table Data >-------------;
TABAA0	EQU		*
		DC.B	FVR,1,1,0F0H,8,CMNOIS,NOIS7
		DC.B	0B0H,4,0CAH,4
TAA0	EQU		*
		DC.B	0C0H,1,PVADD,1,CMREPT,0,8
		JDW		TAA0
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBAA	EQU		*

		even

;=======================================;
;				   SAB					;
;=======================================;
SAB:
		TDW		TIMBAB,SAB				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,0C0H				; Flag,Channel
		TDW		TABAB0,SAB				; FM 1ch Table Pointer
		DC.B	00H,000H				; Bias,Volm

;------------< Table Data >-------------;
TABAB0	EQU		*
		DC.B	EV,1
		DC.B	FVR,3,1,20H,8,CMNOIS,NOIS7
		DC.B	0A2H,3,0A6H,4
TAB0	EQU		*
		DC.B	0B2h,9,CMBIAS,2,PVADD,3,CMREPT,0,2
		JDW		TAB0
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBAB	EQU		*

		even

;=======================================;
;				   SAC					;
;=======================================;
SAC:
		TDW		TIMBAC,SAC				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,05H					; Flag,Channel
		TDW		TABAC0,SAC				; FM 1ch Table Pointer
		DC.B	000H,002H				; Bias,Volm

;------------< Table Data >-------------;
TABAC0	EQU		*
		DC.B	FEV,0
		DC.B	08dH,02cH
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBAC	EQU		*
		CNF		4,7
		MD		2,0,0,0,1,0,1,0
		RSAR	0,31,0,31,0,31,0,31
		D1R		0,14,25,16
		D2R		0,12,0,15
		RRL		15,0,15,14,15,15,15,15
		TL		5,0,0,0

		even

;=======================================;
;				   SAD					;
;=======================================;
SAD:
		TDW		TIMBAD,SAD				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,0C0H				; Flag,Channel
		TDW		TABAD0,SAD				; FM 1ch Table Pointer
		DC.B	00H,000H				; Bias,Volm

;------------< Table Data >-------------;
TABAD0	EQU		*
		DC.B	EV,2
		DC.B	FVR,1,1,0F0H,8,CMNOIS,NOIS7
TAD0	EQU		*
		DC.B	0B0H,4,NL,2
		DC.B	CMREPT,0,3
		JDW		TAD0
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBAD	EQU		*

		even

;=======================================;
;				   SAE					;
;=======================================;
SAE:
		TDW		TIMBAE,SAE				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,0C0H				; Flag,Channel
		TDW		TABAE0,SAE				; FM 1ch Table Pointer
		DC.B	00H,004H				; Bias,Volm

;------------< Table Data >-------------;
TABAE0	EQU		*
TBAE	EQU		*
		DC.B	GN4,L2,FN4
		DC.B	CMJUMP
		JDW		TBAE

;------------< Voice Data >-------------;
TIMBAE	EQU		*
		CNF		0,5
		MD		3,0,0,7,1,3,0,0
		RSAR	0,31,0,31,1,31,1,31
		D1R		3,3,3,2
		D2R		1,2,2,3
		RRL		15,10,15,2,15,2,15,5
		TL		30,25,22,0

		even

;=======================================;
;				   SAF					;
;=======================================;
SAF:
		TDW		TIMBAF,SAF				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	080H,0C0H				; Flag,Channel
		TDW		TABAF0,SAF				; FM 1ch Table Pointer
		DC.B	00H,000H				; Bias,Volm

;------------< Table Data >-------------;
TABAF0	EQU		*
		DC.B	CMNOIS,NOIS3
TAF0	EQU		*
		DC.B	GN4,L2,FN4
		DC.B	CMJUMP
		JDW		TAF0

;------------< Voice Data >-------------;
TIMBAF	EQU		*
		CNF		5,7
		MD		0,0,1,1,1,1,1,1
		RSAR	3,31,0,0DH,0,0DH,0,0DH
		D1R		1,10H,10H,10H
		D2R		1,12H,12H,12H
		RRL		15,0,15,1,15,1,15,1
		TL		31,0,0,0

; vim: set ft=asm68k sw=4 ts=4 noet:
