CLEARSCREEN:                            ; ...
                LEA     (VDPCTRL).L,A5
                MOVE.W  #$8F01,(A5)     ; SET_VDP_AUTO_INC_VALUE_$0001
                MOVE.L  #$940F93FF,(A5) ; SET_LOWER_BYTE_OF_DMA_LEN_TO_$FF
                                        ; SET_HIGHER_BYTE_OF_DMA_LEN_TO_$0F
                MOVE.W  #$9780,(A5)     ; SET_HIGH_BYTE_OF_DMA_SRC_TO_$00
                                        ; ADD_$800000_TO_DMA_SRC_ADDR
                                        ; SET_VRAM_FILL_DMA_MODE
                MOVE.L  #$40000082,(A5) ; DO_WRITE_TO_VRAM_AT_$C000_ADDR
                                        ; DO_OPERATION_USING_DMA
                MOVE.W  #0,(VDPDATA).L

@WAITFGCLEAR:                          ; ...
                MOVE.W  (A5),D1
                BTST    #1,D1
                BNE.S   @WAITFGCLEAR
                MOVE.W  #$8F02,(A5)
                LEA     (VDPCTRL).L,A5
                MOVE.W  #$8F01,(A5)     ; SET_VDP_AUTO_INC_VALUE_$0001
                MOVE.L  #$940F93FF,(A5) ; SET_LOWER_BYTE_OF_DMA_LEN_TO_$FF
                                        ; SET_HIGHER_BYTE_OF_DMA_LEN_TO_$0F
                MOVE.W  #$9780,(A5)     ; SET_HIGH_BYTE_OF_DMA_SRC_TO_$00
                                        ; ADD_$800000_TO_DMA_SRC_ADDR
                                        ; SET_VRAM_FILL_DMA_MODE
                MOVE.L  #$60000082,(A5) ; DO_WRITE_TO_VRAM_AT_$E000_ADDR
                                        ; DO_OPERATION_USING_DMA
                MOVE.W  #0,(VDPDATA).L

@WAITBGCLEAR:                          ; ...
                MOVE.W  (A5),D1
                BTST    #1,D1
                BNE.S   @WAITBGCLEAR
                MOVE.W  #$8F02,(A5)
                MOVE.L  #0,(VDP_SCREENPOSY).W
                MOVE.L  #0,(VDP_SCREENPOSX).W
                LEA     (SPRITETABLE).W,A1
                MOVEQ   #0,D0
                MOVE.W  #$A0,D1

@CLEARSPRITES:                         ; ...
                MOVE.L  D0,(A1)+
                DBF     D1,@CLEARSPRITES
                LEA     (HSCROLLTABLE).W,A1
                MOVEQ   #0,D0
                MOVE.W  #$100,D1

@CLEARHSCROLL:                         ; ...
                MOVE.L  D0,(A1)+
                DBF     D1,@CLEARHSCROLL
                RTS
; END OF FUNCTION CLEARSCREEN