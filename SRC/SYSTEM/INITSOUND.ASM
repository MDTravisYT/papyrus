INITSOUND:
		nop	
		stopZ80
		resetZ80
		lea	(Kos_Z80).l,a0	; load sound driver
		lea	(z80_ram).l,a1	; target Z80 RAM
		bsr.w	KosDec		; decompress
		resetZ80a
		nop	
		nop	
		nop	
		nop	
		resetZ80
		startZ80
		rts	
; End of function SoundDriverLoad