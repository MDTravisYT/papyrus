PALFADEOUT:		             ; ...
		MOVE.W  #$3F,(PALFADEARGS).W ; '?'
		MOVE.W  #20,D4

@LOOP:				 ; ...
		MOVE.B  #$12,(VBLANKCMD).W
		BSR.W   VSYNC
		BSR.S   _LEVELDOFADECALC
	;	BSR.W   PROCESSARTLOADING
		DBF     D4,@LOOP
		RTS
; ---------------------------------------------------------------------------

_LEVELDOFADECALC:		       ; ...
@DOFADECALC:
		MOVEQ   #0,D0
		LEA     (PALETTE).W,A0
		MOVE.B  (PALFADEARGS).W,D0
		ADDA.W  D0,A0
		MOVE.B  (PALFADESIZE).W,D0

LOC_1A02:		               ; ...
		BSR.S   LOC_1A0A
		DBF     D0,LOC_1A02
		RTS
; ---------------------------------------------------------------------------

LOC_1A0A:		               ; ...
		MOVE.W  (A0),D2
		BEQ.S   LOC_1A36
		MOVE.W  D2,D1
		ANDI.W  #$E,D1
		BEQ.S   LOC_1A1A
		SUBQ.W  #2,(A0)+
		RTS
; ---------------------------------------------------------------------------

LOC_1A1A:		               ; ...
		MOVE.W  D2,D1
		ANDI.W  #$E0,D1
		BEQ.S   LOC_1A28
		SUBI.W  #$20,(A0)+ ; ' '
		RTS
; ---------------------------------------------------------------------------

LOC_1A28:		               ; ...
		MOVE.W  D2,D1
		ANDI.W  #$E00,D1
		BEQ.S   LOC_1A36
		SUBI.W  #$200,(A0)+
		RTS
; ---------------------------------------------------------------------------

LOC_1A36:		               ; ...
		ADDQ.W  #2,A0
		RTS
; END OF FUNCTION PALFADEOUT