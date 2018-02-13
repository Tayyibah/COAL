.MODEL SMALL
.STACK 100H
.DATA
	MSG1 DB 0AH,0DH,'PLEASE ENTER TWO DECIMAL DIGITS: $'
        MSG2 DB 0AH,0DH,'THE SUM OF '
        C1 DB ?,' AND '
        C2 DB ?,' IS '
        SUM DB ?, ' $ '
	MSG3 DB 'THE SUM IS GREATER THAN TEN $'
.CODE
MAIN PROC
        MOV AX,@DATA
        MOV DS,AX

	LEA DX,MSG1
        MOV AH,9
        INT 21H

        MOV AH,1
        INT 21H

        MOV C1,AL
        INT 21H

        MOV C2,AL
        ADD AL,C1
        SUB AL,30H
        MOV SUM,AL
      
        CMP SUM,58          
        JAE ELSE1_ 
  
	LEA DX,MSG2
        MOV AH,9
        INT 21H

	JMP END_IF1
ELSE1_:
	LEA DX,MSG3
        MOV AH,9
        INT 21H
END_IF1:

MOV AH,4CH
INT 21H
MAIN ENDP

END MAIN


