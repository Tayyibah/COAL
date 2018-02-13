.MODEL SMALL
.STACK 100H
.DATA
    ARR DB 2,3,5,4,9
    MSGLARGE DB 0AH,0DH,'LARGEST NUMBER FOUND IN ARRAY IS ','$'
    MSGSMALL DB 0AH,0DH,'SMALLEST NUMBER FOUND IN ARRAY IS ','$'
.CODE
MAIN PROC
    mov ax, @DATA
    MOV DS, AX

    LEA DX, ARR 
    MOV BX,5

    PUSH DX
    PUSH BX

    CALL MIN
                                                         
    MOV AH,09                                            
    LEA DX,MSGSMALL                                           
    INT 21H                                              
             
    MOV DL,AL
    MOV AH, 2
    INT 21H

    LEA DX, ARR 
    MOV BX,5

    PUSH DX
    PUSH BX

    CALL MAX
                                         
    MOV AH,09                                            
    LEA DX,MSGLARGE                                          
    INT 21H     

    MOV AH, 2
    MOV DL,AL
    INT 21H

MOV AH,4CH
INT 21H
MAIN ENDP

MIN PROC
            PUSH BP
            MOV BP,SP

            PUSH SI
            PUSH CX
            MOV SI,[BP+6]
            MOV CX,[BP+4]
            XOR AL, AL
	
            MOV AL,[SI]
        FOR1:
            CMP AL,[SI]
	    JAE MIN_NUM
            JMP FOR2 

	MIN_NUM:
	
            MOV AL,[SI]
            
	FOR2:
	    INC SI
            LOOP FOR1

	    ADD AL,48
            POP CX
            POP SI

            POP BP
            RET 4
 
MIN ENDP

MAX PROC
            PUSH BP
            MOV BP,SP

            PUSH SI
            PUSH CX
            MOV SI,[BP+6]
            MOV CX,[BP+4]
            XOR AL, AL
	
            MOV AL,[SI]
        FOR1:
            CMP AL,[SI]
	    JBE MIN_NUM
            JMP FOR2 

	MIN_NUM:
	
            MOV AL,[SI]

	FOR2:
            INC SI
            LOOP FOR1

	    ADD AL,48
            POP CX
            POP SI

            POP BP
            RET 4
 
MAX ENDP


            END MAIN
