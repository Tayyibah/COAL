.MODEL SMALL
.STACK 100H
.DATA
        A DB 6
.CODE
MAIN PROC
	MOV AX,@DATA
	MOV DS,AX

        MOV AL,A
        ADD AL,A
        ADD AL,A
        ADD AL,A
        ADD AL,A
        ADD AL,A

        MOV AH,2
        MOV DL ,AL
        INT 21H

MOV AH,4CH
INT 21H
MAIN ENDP

END MAIN
