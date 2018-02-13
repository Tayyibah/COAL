.MODEL SMALL
.STACK 100H
.DATA
        MSG1 DB 'THE SUM OF '
        DIG1 DB ?
        MSG2 DB ' AND '
        DIG2 DB ?
        MSG3 DB ' IS '
        SUM DB ? ,'$'
.CODE
MAIN PROC
        MOV AX,@DATA
        MOV DS,AX

        MOV AH,2
        MOV DL,'?'
        INT 21H

 	MOV AH,1
        INT 21H

	MOV BL,AL
	MOV DIG1,BL

 	MOV AH,1
        INT 21H

	MOV DIG2 ,AL
	
	MOV DL,AL
	ADD DL,DIG2

	SUB DL,30H
	
	MOV SUM,DL

        MOV AH,9
        LEA DX, MSG1
        INT 21H

MOV AH,4CH
INT 21H
MAIN ENDP
        END MAIN

