.MODEL SMALL
.STACK 100H
.DATA
        MSG1 DB 'HELLO$'
        MSG2 DB 0DH,0AH,'IN UPPERCASE IT IS '
 	CHAR DB ?,'$'

.CODE
MAIN PROC 

        MOV AX, @DATA
        MOV DS, AX

        MOV AH, 9
        LEA DX,MSG1
        INT 21H

	MOV AH, 2
	MOV DL,'?'
        INT 21H

        MOV AH, 1
        INT 21H

	MOV BL,AL

	SUB AL,20H

        MOV CHAR,AL

	MOV AH,9
        LEA DX,MSG2
        INT 21H

MOV AH,4CH
INT 21H
MAIN ENDP

END MAIN

