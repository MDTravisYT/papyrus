_OBJECTANIMATE:                         ; ...
                MOVEQ   #0,D0
                MOVE.B  OBJ.ANIM(A0),D0
                CMP.B   OBJ.ANIMPREVIOUS(A0),D0
                BEQ.S   @DOANIM
                MOVE.B  D0,OBJ.ANIMPREVIOUS(A0)
                MOVE.B  #0,OBJ.ANIMFRAME(A0)
                MOVE.B  #0,OBJ.FRAMETIMER(A0)

	@DOANIM:                               ; ...
                ADD.W   D0,D0
                ADDA.W  (A1,D0.W),A1
                SUBQ.B  #1,OBJ.FRAMETIMER(A0)
                BPL.S   @EXIT
                MOVE.B  (A1),OBJ.FRAMETIMER(A0)
                MOVEQ   #0,D1
                MOVE.B  OBJ.ANIMFRAME(A0),D1
                MOVE.B  1(A1,D1.W),D0
                BMI.S   @HANDLEFLAGS

	@FINISH:                               ; ...
                MOVE.B  D0,D1
                ANDI.B  #$1F,D0
                MOVE.B  D0,OBJ.FRAME(A0)
                MOVE.B  OBJ.STATUS(A0),D0
                ANDI.B  #3,D0
                ANDI.B  #$FC,OBJ.RENDERFLAGS(A0)
                LSR.B   #5,D1
                EOR.B   D0,D1
                OR.B    D1,OBJ.RENDERFLAGS(A0)
                ADDQ.B  #1,OBJ.ANIMFRAME(A0)

	@EXIT:                                 ; ...
                RTS
; ---------------------------------------------------------------------------

	@HANDLEFLAGS:                          ; ...
                ADDQ.B  #1,D0
                BNE.S   @NOTLOOP
                MOVE.B  #0,OBJ.ANIMFRAME(A0)
                MOVE.B  1(A1),D0
                BRA.S   @FINISH
; ---------------------------------------------------------------------------

	@NOTLOOP:                              ; ...
                ADDQ.B  #1,D0
                BNE.S   @NOTBACK
                MOVE.B  2(A1,D1.W),D0
                SUB.B   D0,OBJ.ANIMFRAME(A0)
                SUB.B   D0,D1
                MOVE.B  1(A1,D1.W),D0
                BRA.S   @FINISH
; ---------------------------------------------------------------------------

	@NOTBACK:                              ; ...
                ADDQ.B  #1,D0
                BNE.S   @NOTCHGANI
                MOVE.B  2(A1,D1.W),OBJ.ANIM(A0)

	@NOTCHGANI:                            ; ...
                ADDQ.B  #1,D0
                BNE.S   @NOTROUTINE
                ADDQ.B  #2,OBJ.ACTION(A0)

	@NOTROUTINE:                           ; ...
                ADDQ.B  #1,D0
                BNE.S   @NOTRESET
                MOVE.B  #0,OBJ.ANIMFRAME(A0)
                CLR.B   OBJ.SUBACTION(A0)

	@NOTRESET:                             ; ...
                RTS
; END OF FUNCTION _OBJECTANIMATE