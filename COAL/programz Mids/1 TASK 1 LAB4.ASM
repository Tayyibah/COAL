.MODEL SMALL
.STACK 100H
.DATA
A DW 0ABCDH
B DW 1234H
.CODE
MAIN PROC
      MOV AX, @DATA
      MOV DS, AX
      MOV AX, -1
	MOV AH, 2
        MOV DX,AX
        INT 21H
      MOV BX, 255
	MOV AH, 2
        MOV DX,AX
        INT 21H
      ADD AX, BX
	MOV AH, 2
        MOV DX,AX
        INT 21H
      SUB BX, A
	MOV AH, 2
        MOV DX,AX
        INT 21H
      XCHG BX, A
	MOV AH, 2
        MOV DX,AX
        INT 21H
      XCHG AX, B
	MOV AH, 2
        MOV DX,AX
        INT 21H
      DEC AX
	MOV AH, 2
        MOV DX,AX
        INT 21H
      INC BX
MOV AH, 4CH
INT 21H
MAIN ENDP
END MAIN
