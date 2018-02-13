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

	MOV AH,3dH
	LEA DX, FILENAME
	MOV aL, 2    ; open it read and write
	INT 21H
	MOV HANDLE, AX

; 

; move the file pointer to the end of file

	MOV AH, 42H
	MOV AL, 2   
	MOV BX, HANDLE
	XOR CX, CX   
	XOR DX, DX  ;
	INT 21H


; write or append data at the end of file

	MOV AH, 40H
	MOV CX, 13
	MOV DX, OFFSET FILENAME
	INT 21H




; close that file
	MOV BX,HANDLE
	MOV AH, 3EH
	INT 21H 


	MOV AH, 4CH
	INT 21H

MAIN ENDP
END MAIN