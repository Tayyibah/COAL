.MODEL SMALL
.STACK 100H
.DATA
	MSG1 DB 0AH,0DH, 'Display all Alphabets :',' $'
	SPACE1 DB ' ','$' 
.CODE
MAIN PROC                               
	MOV AX,@DATA
	MOV DS,AX

	MOV AH,9
	LEA DX,MSG1
	INT 21H
	MOV CX,256
	MOV DX,0
	MOV AH,2
FOR1:
SUB DX,48
	INC DX
	INT 21H
	LOOP FOR1

MOV AH , 4CH
INT 21H
MAIN ENDP
	END MAIN
