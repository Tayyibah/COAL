.MODEL SMALL
.STACK 100H
.CODE

MAIN PROC
        MOV AH,1
        INT 21H
        MOV BH, AL                     ; BH HAS THAT NUMBER 
        SUB BH, 30H
        INT 21H
        SUB AL, 30H                    ; AL HAS POWER OF THAT NUMBER
        MOV CL, 1                      ; RESULT WILL BE IN CL
        CMP AL, 0                      
        JBE END1
        MOV CL, AL
        WHILE1:                         ; FIRST LOOP
                CMP AL, 1
                JE END1
                MOV CH, 0
                MOV BL, BH
                WHILE2:                 ; SECOND LOOP
                        ADD CH, CL
                        DEC BL
                        CMP BL, 0
                        JNBE WHILE2
                        MOV CL, CH
                        DEC AL
                JMP WHILE1
                                        
END1:
MOV AH, 4CH
INT 21H
MAIN ENDP
END MAIN
