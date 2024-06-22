		DC.L	$00FFFE00
		DC.L	START
		DC.L 	BusError		; Bus error
		DC.L 	AddressError	; Address error (4)
		DC.L 	IllegalInstr	; Illegal instruction
		DC.L 	ZeroDivide		; Division by zero
		DC.L 	ChkInstr		; CHK exception
		DC.L 	TrapvInstr		; TRAPV exception (8)
		DC.L 	PrivilegeViol	; Privilege violation
		DC.L 	Trace			; TRACE exception
		DC.L 	Line1010Emu		; Line-A emulator
		DC.L 	Line1111Emu		; Line-F emulator (12)
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	INT
		DC.L	INT
		DC.L	INT
		DC.L	HBLANK
		DC.L	INT
		DC.L	VBLANK
		DC.L	INT
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.B	'SEGA MEGA DRIVE '		;	SYSTEM
		DC.B	'MDTRAVIS 2024   '		;	DATE
		DC.B	'UNDERTALE BATTLE'		;	DOMESTIC TITLE
		DC.B	' TEST           '
		DC.B	'                '
		DC.B	'UNDERTALE BATTLE'		;	INTERNATIONAL TITLE
		DC.B	' TEST           '
		DC.B	'                '
		DC.B	'GM XXXXXXXX-XX',0,0	;	SERIAL
		DC.B	'J               '		;	I/O SUPPORT JOYPAD
		DC.L	$00000000				;	ROM START
		DC.L	$0007FFFF				;	ROM END
		DC.L	$00FF0000				;	RAM START
		DC.L	$00FFFFFF				;	RAM END
time:	INCBIN	"time.txt"
		DC.B	$FF
	ALIGN	$1F0
		DC.B	'JU              '		;	REGION