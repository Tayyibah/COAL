.MODEL small
.STACK 100H
.Data
XMOVEMENTS		DW	49
YMOVEMENTS		DW	38
INCREMENTX		DW	-1
INCREMENTY		DW	1

TT		EQU	8192-320
TG		EQU	8192-320

.386
.CODE
MAIN PROC
START:
	MOV	AX,0B800h	;Set ES to start of CGA video buffer
	MOV	ES,AX

	MOV	AX,0006h	;Set video mode 640 x 200 x 1 (monochrome)
	INT 10h
MOVEMENT:
	MOV	BX,INCREMENTX		
	ADD	XMOVEMENTS,BX 	;and add to XMOVEMENTS

	MOV	BX,INCREMENTY 	
	ADD	YMOVEMENTS,BX 	;and add to YMOVEMENTS

	MOV	BX,XMOVEMENTS
	TEST	BX,BX		;See if XMOVEMENTS=0
	JNZ	MOVEMENT2
	NEG	INCREMENTX		;and reverse DELTA X if so
MOVEMENT2:
	MOV	BX,YMOVEMENTS 	;See if YMOVEMENTS = 0
	TEST	BX,BX
	JNZ	MOVEMENT3
	NEG	INCREMENTY		;and reverse DELTA Y if so
	MOV	AH,1		;Lets check for a keypress now
	INT	16h
	JNZ	SEND1 	;and exit if one was pressed
				;we could check more often, but its faster this way
MOVEMENT3:
	CMP	XMOVEMENTS,79 	;See if XMOVEMENTS is at last 8x8 Glyph
	JNE	MOVEMENT4
	NEG	INCREMENTX		;and reverse DELTA X if so
MOVEMENT4:
	CMP	YMOVEMENTS,91 	;And see of YMOVEMENTS is near bottom
	JNE	MOVEMENT5
	NEG	INCREMENTY		
MOVEMENT5:
	CALL	DRAW_BALL	;Draw the ball
	JMP	MOVEMENT		;Lets do it all again
SEND1:
	MOV	AX,0003h		;Set back to text mode
	INT     10h
	MOV     AX,4CH         ; Send exit code to dos
	INT     21H             ; Send command to DOS

MAIN ENDP

DRAW_BALL PROC

	XOR	DI,DI		;Set offset to 0
	MOV	CL,4
	MOV	AX,YMOVEMENTS
	SHL	AX,CL	     ; Calculate Y position * 80 + XMOVEMENTS
	MOV	DX,AX	     ;using bit shifts to get a screen offset
	MOV	CL,2

	SHL	AX,CL
	ADD	DX,AX
	ADD	DX,XMOVEMENTS
	ADD	DI,DX	     ;Store offset in DI

	MOV	AX,0111111011111111b	   ;Draw line for part of ball
	CALL	PUT_BALL     ;Put ball on screen

	MOV	DX,03DAh     ;Wait for screen refresh
WAIT1:	IN	AL,DX
	TEST	AL,08h
	JNZ	WAIT1
WAIT2:
	IN	AL,DX
	TEST	AL,08h
	JZ	WAIT2
	XOR	AX,AX		;Clear AX
	CALL	PUT_BALL	;And remove ball
	RET
	DRAW_BALL	ENDP

PUT_BALL	PROC 
	PUSH	DI
	MOV	ES:[DI],AH	;Draw 4 times
	ADD	DI,80

	MOV	CX,3
LOOP1:
	MOV	ES:[DI],AL	;Draw 4 times
	ADD	DI,80
	DEC	CX
	TEST	CX,CX
	JNZ	LOOP1

	ADD	DI,TT		;Go to next 8K bank

	MOV	CX,3
LOOP2:
	MOV	ES:[DI],AL	;Fill in the blanks for a solid square
	ADD	DI,80
	DEC	CX
	TEST	CX,CX
	JNZ	LOOP2

	MOV	ES:[DI],AH	;Fill in the blanks for a solid square
	POP	DI
	RET

	PUT_BALL ENDP

END MAIN 