.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC    
	MOV AH,1
INT 21H

	CMP AL,"0"
	JLE TAKENEG_
	
	MOV AH,2
	MOV DL, AL
	INT 21H
TAKENEG_:
	NEG AL
	
	MOV AH,2
	MOV DL, AL
	INT 21H	

MOV AH , 4CH
INT 21H
MAIN ENDP
	END MAIN
