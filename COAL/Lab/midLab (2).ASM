.MODEL SMALL
.STACK 100H
.DATA
	MSG1 DB 'ENTER SIZE:$'
	MSG2 DB 'INVALID INPUT TRY AGAIN, ENTER AGAIN:$'
        NUM DB ?
	spc db ?
.CODE
MAIN PROC
	MOV AX,@DATA
	MOV DS,AX
	MOV AH,9
	LEA DX,MSG1
	INT 21H

	MOV AH,1
	INT 21H
        MOV BL,AL
        SUB BL,48
	MOV AH,2
	MOV DL,10
	INT 21H
        CMP BL,6
        JAE  IFF0
        MOV AL,BL
        MOV CH,AL

	MOV AH,2
	MOV DL,10
	INT 21H
IFF0:
	MOV AH,9
	LEA DX,MSG2
	INT 21H
	
	
WHILE1:
        CMP CH,0
        JBE ENDWHILE1
        DEC CH
        MOV NUM, BL
        SUB NUM,CH
        MOV BH,NUM
	MOV DL,10
	INT 21H
	MOV AL,BL
	SUB AL,NUM
	mov CL,AL
WHILE3:
	CMP CL,0
	JE WHILE2
	DEC CL
	mov AH,2
	mov dl,' '
	INT 21H
	JMP WHILE3

WHILE2:
        CMP BH,0
        JBE WHILE1
	MOV AH,2
	MOV DL,'*'
	INT 21H
        DEC BH
        JMP WHILE2
ENDWHILE1:

MOV AH,4CH
INT 21H
MAIN ENDP
 END MAIN
