.MODEL SMALL
.STACK 100H
.DATA
	MSG DB 0AH,0DH,"ENTER THREE INITIALS: $"
	C1 DB ?,0AH,0DH
	C2 DB ?,0AH,0DH
	C3 DB ?,'$'
.CODE
	MAIN PROC
	MOV AX,@DATA ;initialze DS
	MOV DS,AX
	MOV AH,9 ; display MSG
	LEA DX,MSG
	INT 21H
	MOV AH,1 ; read & store 1st char.
	INT 21H
	MOV C1,AL
	INT 21H ; read & store 2nd char.
	MOV C2,AL
	INT 21H ; read & store 3rd char.
	MOV C3,AL
	MOV AH,2 ; display enter
	MOV DL,0AH
	INT 21H
	MOV DL,0DH
	INT 21H
	MOV AH,9 ; display message from c1 until $
	LEA DX,C1
	INT 21H
MOV AH,4CH ; return to DOS
INT 21H
MAIN ENDP
END MAIN
