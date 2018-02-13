.MODEL SMALL
.STACK 100H
.DATA
        A DB "AMINA$"
.CODE
MAIN PROC
        MOV AX,@DATA
        MOV DS,AX

        MOV CX,3   ;ROW
        MOV BX,2   ;COL

        LEA SI,A
        PUSH SI
        PUSH CX
        PUSH BX
        CALL PRINTSTRING
       ; MOV AH,1
        ;INT 21H
MOV AH,4CH
INT 21H
MAIN ENDP
PRINTSTRING PROC
        PUSH BP
        MOV BP,SP
        MOV BX,[BP+4]
        MOV CX,[BP+6]
        MOV DI,[BP+8]
        XOR SI,SI
      
        MOV AX,80
        MUL CX
        ADD BX,AX
        SHL BX,1
        MOV SI,BX
WHILE_1:
        CMP BYTE PTR [DI],'$'
        JE END_WHILE
        MOV AX,0B800H
        MOV ES,AX

        MOV DH,25H
        MOV DL,[DI]
        MOV ES:[SI],DX
        ADD SI,2
        INC DI
        MOV DL,[DI]
        JMP WHILE_1
END_WHILE:
MOV AH,1
INT 21H
        POP BP
RET 6
PRINTSTRING ENDP
END MAIN
