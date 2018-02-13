; fileHandling

.MODEL SMALL
.STACK 100H

.DATA

FILENAME DB "dataBase.txt",0
BUFFER DB 100 DUP (0)
BUFFER1 DB 10 DUP(0)
HANDLE DW ?

NAME DB 10 DUP (10)

.CODE


MAIN PROC
	MOV AX, @DATA
	MOV DS, AX
	MOV ES, AX

; open the already created file

	MOV AH,3cH
	LEA DX, FILENAME
	MOV cL, 0    ; open it read and write
	INT 21H
	MOV HANDLE, AX

; take input from user and save into BUFFER file


	LEA DI, BUFFER
	CLD


	MOV AH, 2
	MOV DL, "?"
	INT 21H

	MOV AH,1
	WHILE1:

		INT 21H
		CMP AL, 13
	
		JE END_WHILE1
		STOSB
		JMP WHILE1


	END_WHILE1:

; writting on that file

	MOV AH, 40H
	MOV BX, HANDLE
	MOV CX, 10       ; write 10 characters on that file
	LEA DX, BUFFER
	INT 21H

; move the file pointer to the start of file

	MOV AH, 42H
	MOV AL, 0   
	MOV BX, HANDLE
	XOR CX, CX   
	XOR DX, DX  ;
	INT 21H

;reading from file and save into BUFFER1

	MOV AH, 3FH
	MOV BX, HANDLE
	MOV CX, 10
	LEA DX, BUFFER1
	INT 21H

; Display from buffer
	MOV AH, 2
	MOV DL, 10
	INT 21H
	MOV DL, 13
	INT 21H


	MOV AH, 40H
	MOV BX, 1
	MOV CX, 20
	LEA DX, BUFFER1
	INT 21H


; close that file
	MOV BX,HANDLE
	MOV AH, 3EH
	INT 21H 


	MOV AH, 4CH
	INT 21H

MAIN ENDP
END MAIN