RUNOBJECTS:                             ; ...
                LEA     (OBJSLOT00).W,A0
                MOVEQ   #$80-1,D7
                MOVEQ   #0,D0

@PROCESSOBJLOOP:                       ; ...
                MOVE.B  OBJ.ID(A0),D0
                BEQ.S   @EMPTYSLOT
                ADD.W   D0,D0
                ADD.W   D0,D0
                MOVEA.L OBJECTINDEX-4(PC,D0.W),A1 ; NO ZERO OFFSET - START AT 1
                JSR     (A1)
                MOVEQ   #0,D0

@EMPTYSLOT:                            ; ...
                LEA     OBJ.SIZE(A0),A0
                DBF     D7,@PROCESSOBJLOOP
                RTS
; ---------------------------------------------------------------------------

; END OF FUNCTION RUNOBJECTS

OBJECTINDEX:
		DC.L	SOUL	;	01
		DC.L	OBJNULL  ;	02
		DC.L	OBJNULL  ;	03
		DC.L	OBJNULL  ;	04
		DC.L	OBJNULL  ;	05
		DC.L	OBJNULL  ;	06
		DC.L	OBJNULL  ;	07
		DC.L	OBJNULL  ;	08
		DC.L	OBJNULL  ;	09
		DC.L	OBJNULL  ;	0A
		DC.L	OBJNULL  ;	0B
		DC.L	OBJNULL  ;	0C
		DC.L	OBJNULL  ;	0D
		DC.L	OBJNULL  ;	0E
		DC.L	OBJNULL  ;	0F
		DC.L	OBJNULL  ;	10
		
OBJNULL:
		RTS