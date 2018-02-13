.MODEL SMALL
.STACK 100H
.DATA
    ARR DW 2,4,5,4,1
    MSGFOUND DB 0AH,0DH,'THE NUMBER IS FOUND IN ARRAY  ','$'
    MSGNOTFOUND DB 0AH,0DH,'THE NUMBER IS NOT FOUND IN ARRAY ','$'
.CODE
MAIN PROC
    mov ax, @DATA
    MOV DS, AX

    LEA DX, ARR 
    MOV BX,3
    MOV CX,5

    PUSH DX
    PUSH BX
    PUSH CX
    CALL LINEARSEARCH1 

    CMP AX,'0'
    JE NOTFOUNT
                                   
    MOV AH,09                                            
    LEA DX,MSGFOUND                                          
    INT 21H                                              
             
    MOV DL,AL
    MOV AH, 2
    INT 21H
    JMP END_

NOTFOUNT:
                  
    MOV AH,09                                            
    LEA DX,MSGNOTFOUND                                          
    INT 21H                                              
             
    MOV DL,AL
    MOV AH, 2
    INT 21H
END_:
	MOV AH,4CH
	INT 21H
MAIN ENDP

LINEARSEARCH1 PROC
        PUSH BP
        MOV BP,SP

        PUSH SI
        PUSH CX
        PUSH BX
        MOV SI,[BP+8]
        MOV CX,[BP+6]
        MOV CX,[BP+4]
        XOR AX, AX
FOR1:
        CMP BX,[SI]
	    JE FOUND
	    ADD SI,2
        JMP FOR2

FOUND:
        MOV AX,1
        JMP END1

FOR2:
	LOOP FOR1
	MOV AX,0
END1:
	ADD AX,48
	POP BX
	POP CX
	POP SI

	POP BP
	RET 4
 
	LINEARSEARCH1 ENDP
END MAIN
