.MODEL SMALL
.STACK 100H
.DATA
    ARR DW 1,2,3,4,5,6
    MSGFOUND DB 0AH,0DH,'THE NUMBER IS FOUND IN ARRAY  ','$'
    MSGNOTFOUND DB 0AH,0DH,'THE NUMBER IS NOT FOUND IN ARRAY ','$'
	START1 DW 0
	END1 DW 6
.CODE
MAIN PROC
    mov ax, @DATA
    MOV DS, AX

    LEA SI, ARR 
    MOV CX,6     ;COUNT
    MOV BX,6  ;KEY
    MOV DX,0    ;MID

    PUSH CX
    PUSH BX
    PUSH DX
    PUSH SI
    CALL BINARYSEARCH1 

    CMP AX,'0'
    JE NOTFOUNT
                                   
    MOV AH,09                                            
    LEA DX,MSGFOUND                                          
    INT 21H                                              
             
    MOV DX,AX
    MOV AH, 2
    INT 21H
    JMP END_

NOTFOUNT:
                  
    MOV AH,09                                            
    LEA DX,MSGNOTFOUND                                          
    INT 21H                                              
   
    MOV DX,AX
    MOV AH, 2
    INT 21H
END_:
	MOV AH,4CH
	INT 21H
MAIN ENDP

BINARYSEARCH1 PROC
        PUSH BP
        MOV BP,SP

        MOV SI,[BP+8]	;OFFSET ADRESS
        MOV DX,[BP+6]	;MID
        MOV BX,[BP+4]	;KEY
        MOV CX,[BP+2]	;SIZE
       	MOV END1,CX
        XOR AX, AX
FOR1:
		ADD DX,START1   ;MID=MID+START1
		ADD DX,END1	;MID=MID+END1
		SHR DX,1	;MID=MID/2
		CMP ARR[SI],BX
		JB LAST_DEC_
		JA START_INC_
		JE FOUND
LAST_DEC_:
		MOV END1,DX	
		DEC END1	;END=MID-1
		ADD SI,2
		JMP FOR2
START_INC_:
		MOV START1,DX
		INC START1	;START1=MID+1
		ADD SI,2
		JMP FOR2
FOR2:
		LOOP FOR1
		JMP ELSE1
FOUND:
	MOV AX,'1'
JMP TERMINATE

ELSE1:
	MOV AX,'0'
TERMINATE:

	POP BP
	RET 8
 
	BINARYSEARCH1 ENDP
END MAIN



