PALFADEIN:
		               MOVE.W  #63,(PALFADEARGS).W

PALFADEIN_USERARGS:		     ; ...
		MOVEQ   #0,D0
		LEA     (PALETTE).W,A0
		MOVE.B  (PALFADEARGS).W,D0
		ADDA.W  D0,A0
		MOVEQ   #0,D1
		MOVE.B  (PALFADESIZE).W,D0

@FILLBLACK:		            ; ...
		MOVE.W  D1,(A0)+
		DBF     D0,@FILLBLACK
		MOVE.W  #$14,D4

@LOOP:				 ; ...
		MOVE.B  #$12,(VBLANKCMD).W
		BSR.W   VSYNC
		BSR.S   @DOFADECALC
	;	BSR.W   PROCESSARTLOADING
		DBF     D4,@LOOP
		RTS
; ---------------------------------------------------------------------------

@DOFADECALC:		           ; ...
		MOVEQ   #0,D0
		LEA     (PALETTE).W,A0
		LEA     (PALFADEBUFFER).W,A1
		MOVE.B  (PALFADEARGS).W,D0
		ADDA.W  D0,A0
		ADDA.W  D0,A1
		MOVE.B  (PALFADESIZE).W,D0

@DOREQUESTEDSIZE:		      ; ...
		BSR.S   @CALCCOLOR
		DBF     D0,@DOREQUESTEDSIZE
		RTS
; ---------------------------------------------------------------------------

@CALCCOLOR:		            ; ...
		MOVE.W  (A1)+,D2
		MOVE.W  (A0),D3
		CMP.W   D2,D3
		BEQ.S   @NEXTCOLOR
		MOVE.W  D3,D1
		ADDI.W  #$200,D1
		CMP.W   D2,D1
		BHI.S   @ADDGREEN
		MOVE.W  D1,(A0)+
		RTS
; ---------------------------------------------------------------------------

@ADDGREEN:		             ; ...
		MOVE.W  D3,D1
		ADDI.W  #$20,D1 ; ' '
		CMP.W   D2,D1
		BHI.S   @ADDRED
		MOVE.W  D1,(A0)+
		RTS
; ---------------------------------------------------------------------------

@ADDRED:		               ; ...
		ADDQ.W  #2,(A0)+
		RTS
; ---------------------------------------------------------------------------

@NEXTCOLOR:		            ; ...
		ADDQ.W  #2,A0
		RTS
; END OF FUNCTION PALFADEIN