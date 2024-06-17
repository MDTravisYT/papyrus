DrawTileMap:		;	SUBROUTINE
                lea     VDPDATA,a6
                move.l  #$800000,d4

.LoopRow:                           
                move.l  d0,4(a6)    ; VDPCTRL
                move.w  d1,d3

.LoopColumn: 
                move.w  (a1)+,(a6)
                dbf     d3,.LoopColumn
                add.l   d4,d0
                dbf     d2,.LoopRow
                rts