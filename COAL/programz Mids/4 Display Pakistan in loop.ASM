.MODEL SMALL
.DATA
	STARS DB ,'***********',0AH,0DH,'$'
	MID DB ' *** '
	C1 DB ?
	C2 DB ?
	C3 DB ?,' ***',0AH,0DH,'$'
.CODE
	MAIN PROC
	MOV AX,@DATA ; initialize DS
	MOV DS,AX
	MOV AH,1 ;read & store 3 initials
	INT 21H
	MOV C1,AL
	INT 21H
	MOV C2,AL
	INT 21H
	MOV C3,AL
	MOV AH,2 ; CR to current line
	MOV DL,0DH
	INT 21H

	MOV AH,9 	;( display stars from the
			; beginning of line that will
			;cause to erase the 3 initial
			;and write over them)
	LEA DX,STARS
	INT 21H
	INT 21H
	INT 21H
	INT 21H
	INT 21H
	LEA DX,MID 	;( display the middle
			;line with initials)
	INT 21H
	LEA DX,STARS 	;continue displaying stars
	INT 21H
	INT 21H
	INT 21H
	INT 21H
	INT 21H
MOV AH,4CH ; return to DOS
INT 21H
MAIN ENDP
END MAIN