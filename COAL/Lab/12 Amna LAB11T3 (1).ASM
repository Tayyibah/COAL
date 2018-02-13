.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC
      MOV AX,0B800H
      MOV ES,AX
      MOV CX,40
      XOR SI,SI
      MOV DI,158
      MOV DH,20H
WHILE1:
      CMP SI,79
      JE END_WHILE1
      CMP DI,80
       JE END_WHILE1
       
      MOV DH,20H
      MOV DL,'*'
     
      MOV ES:[SI],DX
      MOV ES:[DI],DX


      MOV BX,50000
L2:
     DEC BX
     JNZ L2
   
      MOV DL,' '
      MOV ES:[SI],DX
     MOV ES:[DI],DX
      ADD SI,2
   
       SUB DI,2
      JMP WHILE1


       MOV AH,1
      INT 21H
END_WHILE1:
MOV AH,4CH
INT 21H
MAIN ENDP
END MAIN

