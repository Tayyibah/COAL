.MODEL SMALL
.DATA
	B1 DB ?
	B2 DB ?
	M1 DB 0AH,0DH,'TYPE A BINARY NUMBER , UP TO 8 DIGITS :','$'
	M11 DB 0AH,'TYPE A HEXA NUMBER 0 -FFFF :$'
	M2 DB 0AH,0DH,'THE BINARY SUM IS ','$'
	M22 DB 0AH,'THE SUM IN HEXA IS $'
	COUNTER DB 4
	NUM DW ?
.CODE
MAIN PROC
	MOV AX,@DATA ;initialize DS
	MOV DS,AX

	MOV AH,9 ;prompt user for 2nd number
	LEA DX,M1
	INT 21H
	CALL READbinary 
	MOV NUM,BX ;store 1st num.
;because it will still in BX
;-----------
	MOV AH,9 ;display result msg
	LEA DX,M2
	INT 21H
	ADD BX,NUM
	JC SHOW1 ;if there carry
	MOV AH,2 ;no carry
	MOV DL,'0'
	INT 21H
	JMP NEXT
SHOW1:
	MOV AH,2
	MOV DL,'1'
	INT 21H
NEXT: 
	CALL SHOWbinary 
;-----------	

	MOV AH,9 ;prompt user for 2nd number
	LEA DX,M11
	INT 21H
	CALL READhex ;no need to store 2nd num.
	MOV NUM,BX ;store 1st num.
;because it will still in BX
;-----------
	MOV AH,9 ;display result msg
	LEA DX,M22
	INT 21H
	ADD BX,NUM
	JC SHOW2 ;if there carry
	MOV AH,2 ;no carry
	MOV DL,'0'
	INT 21H
	JMP NEXT1
SHOW2:
	MOV AH,2
	MOV DL,'1'
	INT 21H
NEXT1: 
	CALL SHOWhex 


MOV AH,4CH ;return to DOS
INT 21H
MAIN ENDP

;-----------------
READbinary PROC ;for read hexa digit
	
	MOV BL,0
	MOV CX,8
	MOV AH,1
L1:
	INT 21H
	CMP AL,0DH
	JE OUT1
	SUB AL,30H ;or use AND AL,01H
	SHL BL,1
	OR BL,AL
	LOOP L1
OUT1: 
	MOV B1,BL ;1st no. read and store
	
	MOV BL,0 ;read 2nd no.
	MOV CX,8
END_W:
	RET
	READbinary ENDP
;------------------------------------
SHOWbinary PROC ;to display result of addition
	
	MOV B2,BL ;2nd no. read and store
	
	ADD BL,B1 ;BL has 2nd no. (last one read)
	MOV AH,2
	MOV CX,8
L3: 
	SHL BL,1 ;display binary
	JC ONE
	MOV DL,'0'
	INT 21H
	JMP continue
ONE:
	MOV DL,'1'
	INT 21H
continue: 
	LOOP L3
	RET
	SHOWbinary ENDP
;-----------------
READhex PROC ;for read hexa digit
	XOR BX,BX
	MOV CL,4
	MOV AH,1
	INT 21H
WHILE_:
	CMP AL,0DH
	JE END_W
	CMP AL,'9' ;detect for letter hexa
	JG LETTER
	AND AL,0FH
	JMP SHIFT
LETTER: 
	SUB AL,37H
SHIFT:
	SHL BX,CL
	OR BL,AL
	INT 21H
	JMP WHILE_
END_W:
	RET
	READhex ENDP
;------------------------------------
SHOWhex PROC ;to display result of addition
	MOV CL,4
START:
	MOV DL,BH
	SHR DL,CL
	CMP DL,9
	JG LETTER1
	ADD DL,30H
	JMP SHOW1
LETTER1:
	ADD DL,37H
SHOW1:
	MOV AH,2
	INT 21H
	ROL BX,CL
	DEC COUNTER
	CMP COUNTER,0
	JNE START
	RET
	SHOWhex ENDP
;----------------------------------------
END MAIN