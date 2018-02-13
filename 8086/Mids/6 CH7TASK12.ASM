.MODEL SMALL
.STACK 100H
.DATA
        MSG1 DB 10,13,'ENTER A STRING OF CAPITAL LETERS:$'
        MSG2 DB 10,13,'THE LONGEST CONSECTIVELY INCREASING STRING IS:',10,13,'$'
.CODE

MAIN PROC
        MOV AX, @DATA
        MOV DS, AX
        MOV AH,9
        LEA DX, MSG1
        MOV AH, 1
        MOV CH, 0      ; FOR STORING LENGHT OF STRING LETTER
        MOV CL, 0      ; FOR STORING STARTING INDEX OF STRING
        INT 21H
        WHILE1:  
                MOV DL, AL     ; FOR NEW STRING STARTING LETTER
                MOV DH, 0      ; FOR NEW STRING LENGTH
                CMP AL, 13
                JE SHOW1
                CHECK1:                 
                        INC DH

                        MOV BH, AL      ; MOVING PREVIOUS LETTER
                        INC BH          ; CHANGING ING NEXT LETTER LIKE A->B
                        INT 21H         ; ENTRING NEW LETTER

                        CMP AL, BH
                        JNE CHECK2

                        JMP CHECK1


                CHECK2:                 ; CHECK IF NEW LENGHT IS GREATER THEN PREVIOUS
                        CMP CH, DH      ; COMPAIRING THE LENGTHS
                        JA ENDCHECK     
                        MOV CH, DH
                        MOV CL, DL


                ENDCHECK:               ; CHECK IF CRRIAGE RETURN ENTERD
                        CMP AL, 0DH
                        JNE WHILE1
        SHOW1:
                CMP CH, 0               ; FOR CHECKING ANY LETTER ENTERED OR NOT
                JE END1

                MOV AH, 9
                LEA DX, MSG2
                INT 21H

                MOV AH, 2
                MOV DL, CL
                LOOP1:                  ; DISPLY LONGEST CONECUTIVELY INCREASING STRING
                        INT 21H
                        INC DL
                        DEC CH
                        CMP CH, 0
                        JNE LOOP1

END1:
MOV AH,4CH
INT 21H
MAIN ENDP
END MAIN


