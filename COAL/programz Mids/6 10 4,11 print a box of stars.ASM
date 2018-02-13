.MODEL SMALL
.DATA
	STARS DB 0AH,0DH,'**********','$'
.CODE
	MAIN PROC
	MOV AX,@DATA ;initialize DS
	MOV DS,AX
	MOV AH,9 ; prepare to display
	LEA DX,STARS
	INT 21H ; display 10 times *
	INT 21H
	INT 21H
	INT 21H
	INT 21H
	INT 21H
	INT 21H
	INT 21H
	INT 21H
	INT 21H

MOV AH,4CH ;return to DOS
INT 21H
MAIN ENDP
END MAIN
		;* it will be easy after study loop statement ch.6 to replace
		;10 statement by the code :
		;MOV CX,10
		;L: INT 21H
		;LOOP L