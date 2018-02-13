.MODEL SMALL
.STACK 100H
.DATA
       M1 DB  'abcd0'
       M2 DB  'abcd0'
       LEN DW 5
       B DB 80 DUP('A'), 80 DUP('B'), 80 DUP('C'), 80 DUP('D'), 80 DUP('E'), 80 DUP('F')
         DB 80 DUP('G'), 80 DUP('H'), 80 DUP('I'), 80 DUP('J'), 80 DUP('K'), 80 DUP('L')
         DB 80 DUP('M')
         DB 80 DUP('N'), 80 DUP('O'), 80 DUP('P'), 80 DUP('Q'), 80 DUP('R'), 80 DUP('S')
         DB 80 DUP('T'), 80 DUP('U'), 80 DUP('V'), 80 DUP('W'), 80 DUP('X'), 80 DUP('Y')

.CODE
MAIN PROC
	MOV AX,@DATA
	MOV DS,AX


        MOV AX,0B800H
        MOV ES,AX
        XOR DI,DI
        LEA SI,B
        MOV CX,2000
    WHILE1:
        LODSB
        CMP CX,0
        JE ENDWHILE1
        MOV AH,54H
        STOSW
        DEC CX
        JMP WHILE1
    ENDWHILE1:

     PUSH LEN
     CALL SCROLL_DOWN


     ;   PUSH LEN
      ;  CALL SCROLL_UP


MOV AH,4CH
INT 21H
MAIN ENDP
STR_LEN PROC
        PUSH BP
        MOV BP,SP
        PUSH DI
        PUSH CX
        
        MOV DI,[BP+4]

        MOV AL,'0'
	MOV CX,0FFFFH
REPNZ SCASB
        MOV AX,0FFFFH
        SUB AX,CX
        DEC AX

        
        POP CX
        POP DI
        POP BP
 RET 2
STR_LEN ENDP
STR_CMP PROC
        PUSH BP
        MOV BP,SP
        PUSH DI
        PUSH SI
        PUSH CX
        
        MOV DI,[BP+4]
        MOV SI,[BP+6]
        MOV CX,LEN
        REPE CMPSB

        CMP CX,0
        JE UPDATE
        MOV AX,0
        JMP END1
  UPDATE:
        MOV AX,1
END1:        
        POP CX
        POP SI
        POP DI
        POP BP
 RET 4
STR_CMP ENDP
SCROLL_DOWN PROC
        PUSH BP
        MOV BP,SP
        PUSH DI
        PUSH SI
        PUSH CX
        PUSH AX
        PUSH DX
        PUSH ES
        PUSH DS

        MOV AX,0B800H
        MOV DS,AX


        MOV AX,[BP+4]
        MOV CX,160  
        MUL CX    ;AX=LEN*160
     
        
      MOV DI,3998
      MOV SI,DI ;SI=3998
      SUB SI,AX ;SI=3998-AX
      MOV CX,1920


       STD
       REP MOVSW

      SHR AX,1
      MOV CX,AX
      MOV AX,0720H
       REP STOSW
       
        POP DS
        POP ES
        POP DX
        POP AX
        POP CX
        POP SI
        POP DI
        POP BP

RET 2
SCROLL_DOWN ENDP
SCROLL_UP PROC
        PUSH BP
        MOV BP,SP
        PUSH DI
        PUSH SI
        PUSH CX
        PUSH AX
        PUSH DX
        PUSH ES
        PUSH DS

        MOV AX,0B800H
        MOV DS,AX


        MOV AX,[BP+4]
        MOV CX,160
        MUL CX     ; 160* LEN
     
      
        
      MOV DI,0
      MOV SI,AX
      SUB SI,160
      MOV CX,1920

       CLD
       REP MOVSW

      SHR AX,1
      MOV CX,AX
      MOV AX,0720H

       REP STOSW
       
        POP DS
        POP ES
        POP DX
        POP AX
        POP CX
        POP SI
        POP DI
        POP BP

RET 2
SCROLL_UP ENDP
END MAIN
