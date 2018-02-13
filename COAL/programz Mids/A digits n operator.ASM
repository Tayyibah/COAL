.MODEL SMALL
.STACK 100H
.DATA
	MSG1 DB 0AH,0DH,'Type two digits and an operator: $'
.CODE
MAIN PROC
        MOV AX,@DATA
        MOV DS,AX

	LEA DX,MSG1
        MOV AH,9
        INT 21H

        MOV AH,1
        INT 21H
        SUB AL,48

	MOV BL,AL

        INT 21H
	MOV CL,AL
        SUB CL,48

        INT 21H

	CMP AL,43
        JE ELSE1_ 
        SUB BL,CL
        ADD BL,48
	MOV AH,2
        MOV DL,BL
	INT 21H

        JMP END_IF1                                               
ELSE1_:


        ADD BL,CL
        ADD BL,48
	MOV AH,2
        MOV DL,BL
	INT 21H

END_IF1:

MOV AH,4CH
INT 21H
MAIN ENDP

END MAIN
