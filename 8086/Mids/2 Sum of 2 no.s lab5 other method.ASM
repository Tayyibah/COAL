.MODEL SMALL
.STACK 100H
.DATA
        MSG DB 0AH,0DH,'THE SUM OF '
        C1 DB ?,' AND '
        C2 DB ?,' IS '
        SUM DB ?, ' $ '
.CODE
MAIN PROC
        MOV AX,@DATA
        MOV DS,AX

        MOV AH,2
        MOV DL,'?'
        INT 21H

        MOV AH,1
        INT 21H

        MOV C1,AL
        INT 21H

        MOV C2,AL
        ADD AL,C1
        SUB AL,30H
        MOV SUM,AL

        LEA DX,MSG
        MOV AH,9
        INT 21H

MOV AH,4CH
INT 21H
MAIN ENDP

END MAIN


