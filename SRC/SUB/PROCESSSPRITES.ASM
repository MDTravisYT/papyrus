DWORD_8796:
		DC.L	0
		DC.L	SCROLL_FGPOSX
		DC.L	SCROLL_FGPOSY
		DC.L	SCROLL_BG3POSX

PROCESSSPRITES:
                LEA     (SPRITETABLE).W,A2
                MOVEQ   #0,D5
                LEA     (SPRITES).W,A4
                MOVEQ   #7,D7

@PRIORITY:                             ; ...
                TST.W   (A4)
                BEQ.W   @NEXTPRIORITYLEVEL
                MOVEQ   #2,D6

@OBJECT:                               ; ...
                MOVEA.W (A4,D6.W),A0
                TST.B   (A0)
                BEQ.W   @SKIPOBJECT
                BCLR    #7,OBJ.RENDERFLAGS(A0)
                MOVE.B  OBJ.RENDERFLAGS(A0),D0
                MOVE.B  D0,D4
                ANDI.W  #%1100,D0
                BEQ.S   @DRAWFIXED
                MOVEA.L DWORD_8796(PC,D0.W),A1
                MOVEQ   #0,D0
                MOVE.B  OBJ.XDISP(A0),D0
                MOVE.W  OBJ.X(A0),D3
                SUB.W   (A1),D3
                MOVE.W  D3,D1
                ADD.W   D0,D1
                BMI.W   @SKIPOBJECT
                MOVE.W  D3,D1
                SUB.W   D0,D1
                CMPI.W  #$140,D1
                BGE.S   @SKIPOBJECT
                ADDI.W  #$80,D3
                BTST    #4,D4
                BEQ.S   @ASSUMEHEIGHT
                MOVEQ   #0,D0
                MOVE.B  OBJ.YRAD(A0),D0
                MOVE.W  OBJ.Y(A0),D2
                SUB.W   OBJ.MAP(A1),D2
                MOVE.W  D2,D1
                ADD.W   D0,D1
                BMI.S   @SKIPOBJECT
                MOVE.W  D2,D1
                SUB.W   D0,D1
                CMPI.W  #$E0,D1
                BGE.S   @SKIPOBJECT
                ADDI.W  #$80,D2
                BRA.S   @DRAWOBJECT
; ---------------------------------------------------------------------------

@DRAWFIXED:                            ; ...
                MOVE.W  OBJ.YSCR(A0),D2
                MOVE.W  OBJ.X(A0),D3
                BRA.S   @DRAWOBJECT
; ---------------------------------------------------------------------------

@ASSUMEHEIGHT:                         ; ...
                MOVE.W  OBJ.Y(A0),D2
                SUB.W   OBJ.MAP(A1),D2
                ADDI.W  #128,D2
                CMPI.W  #96,D2
                BCS.S   @SKIPOBJECT
                CMPI.W  #384,D2
                BCC.S   @SKIPOBJECT

@DRAWOBJECT:                           ; ...
                MOVEA.L OBJ.MAP(A0),A1
                MOVEQ   #0,D1
                BTST    #5,D4
                BNE.S   @STATICMAP
                MOVE.B  OBJ.FRAME(A0),D1
                ADD.B   D1,D1
                ADDA.W  (A1,D1.W),A1
                MOVE.B  (A1)+,D1
                SUBQ.B  #1,D1
                BMI.S   @SETVISIBLE

@STATICMAP:                            ; ...
                BSR.W   BUILDSPRITETOBUFFER

@SETVISIBLE:                           ; ...
                BSET    #7,OBJ.RENDERFLAGS(A0)

@SKIPOBJECT:                           ; ...
                ADDQ.W  #2,D6
                SUBQ.W  #2,(A4)
                BNE.W   @OBJECT

@NEXTPRIORITYLEVEL:                    ; ...
                LEA     $80(A4),A4
                DBF     D7,@PRIORITY
                MOVE.B  D5,(SPRITECOUNT).W
                CMPI.B  #80,D5
                BEQ.S   @LIMITREACHED
                MOVE.L  #0,(A2)
                RTS
; ---------------------------------------------------------------------------

@LIMITREACHED:                         ; ...
                MOVE.B  #0,-5(A2)
                RTS
; END OF FUNCTION PROCESSSPRITES

BUILDSPRITETOBUFFER:                    ; ...
                MOVEA.W OBJ.TILE(A0),A3
                BTST    #0,D4
                BNE.S   _BUILDSPRITEXFLIP
                BTST    #1,D4
                BNE.W   _BUILDSPRITEYFLIP
; END OF FUNCTION BUILDSPRITETOBUFFER


; =============== S U B R O U T I N E =======================================


_BUILDSPRITE:                           ; ...
                CMPI.B  #80,D5
                BEQ.S   @LIMITREACHED
                MOVE.B  (A1)+,D0
                EXT.W   D0
                ADD.W   D2,D0
                MOVE.W  D0,(A2)+
                MOVE.B  (A1)+,(A2)+
                ADDQ.B  #1,D5
                MOVE.B  D5,(A2)+
                MOVE.B  (A1)+,D0
                LSL.W   #8,D0
                MOVE.B  (A1)+,D0
                ADD.W   A3,D0
                MOVE.W  D0,(A2)+
                MOVE.B  (A1)+,D0
                EXT.W   D0
                ADD.W   D3,D0
                ANDI.W  #$1FF,D0
                BNE.S   @WRITEX
                ADDQ.W  #1,D0

@WRITEX:                               ; ...
                MOVE.W  D0,(A2)+
                DBF     D1,_BUILDSPRITE

@LIMITREACHED:                         ; ...
                RTS
; END OF FUNCTION _BUILDSPRITE

_BUILDSPRITEXFLIP:                      ; ...
                BTST    #1,D4
                BNE.W   _BUILDSPRITEXYFLIPPED

@LOOP:                                 ; ...
                CMPI.B  #$50,D5 ; 'P'
                BEQ.S   @LIMITREACHED
                MOVE.B  (A1)+,D0
                EXT.W   D0
                ADD.W   D2,D0
                MOVE.W  D0,(A2)+
                MOVE.B  (A1)+,D4
                MOVE.B  D4,(A2)+
                ADDQ.B  #1,D5
                MOVE.B  D5,(A2)+
                MOVE.B  (A1)+,D0
                LSL.W   #8,D0
                MOVE.B  (A1)+,D0
                ADD.W   A3,D0
                EORI.W  #$800,D0
                MOVE.W  D0,(A2)+
                MOVE.B  (A1)+,D0
                EXT.W   D0
                NEG.W   D0
                ADD.B   D4,D4
                ANDI.W  #$18,D4
                ADDQ.W  #8,D4
                SUB.W   D4,D0
                ADD.W   D3,D0
                ANDI.W  #$1FF,D0
                BNE.S   @WRITEX
                ADDQ.W  #1,D0

@WRITEX:                               ; ...
                MOVE.W  D0,(A2)+
                DBF     D1,@LOOP

@LIMITREACHED:                         ; ...
                RTS
; END OF FUNCTION _BUILDSPRITEXFLIP


; =============== S U B R O U T I N E =======================================


_BUILDSPRITEYFLIP:                      ; ...
                CMPI.B  #$50,D5 ; 'P'
                BEQ.S   @LIMITREACHED
                MOVE.B  (A1)+,D0
                MOVE.B  (A1),D4
                EXT.W   D0
                NEG.W   D0
                LSL.B   #3,D4
                ANDI.W  #$18,D4
                ADDQ.W  #8,D4
                SUB.W   D4,D0
                ADD.W   D2,D0
                MOVE.W  D0,(A2)+
                MOVE.B  (A1)+,(A2)+
                ADDQ.B  #1,D5
                MOVE.B  D5,(A2)+
                MOVE.B  (A1)+,D0
                LSL.W   #8,D0
                MOVE.B  (A1)+,D0
                ADD.W   A3,D0
                EORI.W  #$1000,D0
                MOVE.W  D0,(A2)+
                MOVE.B  (A1)+,D0
                EXT.W   D0
                ADD.W   D3,D0
                ANDI.W  #$1FF,D0
                BNE.S   @WRITEX
                ADDQ.W  #1,D0

@WRITEX:                               ; ...
                MOVE.W  D0,(A2)+
                DBF     D1,_BUILDSPRITEYFLIP

@LIMITREACHED:                         ; ...
                RTS
; END OF FUNCTION _BUILDSPRITEYFLIP


; =============== S U B R O U T I N E =======================================


_BUILDSPRITEXYFLIPPED:                  ; ...
                CMPI.B  #$50,D5 ; 'P'
                BEQ.S   @LIMITREACHED
                MOVE.B  (A1)+,D0
                MOVE.B  (A1),D4
                EXT.W   D0
                NEG.W   D0
                LSL.B   #3,D4
                ANDI.W  #$18,D4
                ADDQ.W  #8,D4
                SUB.W   D4,D0
                ADD.W   D2,D0
                MOVE.W  D0,(A2)+
                MOVE.B  (A1)+,D4
                MOVE.B  D4,(A2)+
                ADDQ.B  #1,D5
                MOVE.B  D5,(A2)+
                MOVE.B  (A1)+,D0
                LSL.W   #8,D0
                MOVE.B  (A1)+,D0
                ADD.W   A3,D0
                EORI.W  #$1800,D0
                MOVE.W  D0,(A2)+
                MOVE.B  (A1)+,D0
                EXT.W   D0
                NEG.W   D0
                ADD.B   D4,D4
                ANDI.W  #$18,D4
                ADDQ.W  #8,D4
                SUB.W   D4,D0
                ADD.W   D3,D0
                ANDI.W  #$1FF,D0
                BNE.S   @WRITEX
                ADDQ.W  #1,D0

@WRITEX:                               ; ...
                MOVE.W  D0,(A2)+
                DBF     D1,_BUILDSPRITEXYFLIPPED

@LIMITREACHED:                         ; ...
                RTS
; END OF FUNCTION _BUILDSPRITEXYFLIPPED

_OBJECTDISPLAY:                         ; ...
                LEA     (SPRITES).W,A1
                MOVE.B  OBJ.PRIORITY(A0),D0
                ANDI.W  #7,D0
                LSL.W   #7,D0
                ADDA.W  D0,A1
                CMPI.W  #$7E,(A1) ; '~'
                BCC.S   @EXIT
                ADDQ.W  #2,(A1)
                ADDA.W  (A1),A1
                MOVE.W  A0,(A1)

@EXIT:                                 ; ...
                RTS