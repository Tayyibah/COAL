.MODEL SMALL
.STACK 100H
.DATA
	MSG1 DB 0AH,0DH,'Type two digits and an operator: $'
	M2 DB 0AH,0DH,'THE ASCII CODE OF '
	C1 DB ?,' IN BINARY IS :','$'
	M3 DB 0AH,0DH,'THE NUMBER OF 1 BIT IS '
	C2 DB ?,'$'
.CODE
MAIN PROC
        MOV AX,@DATA
        MOV DS,AX

	LEA DX,MSG1
        MOV AH,9
        INT 21H

        MOV AH,1
        INT 21H
        SUB AL,48

	MOV BL,AL

        INT 21H
	MOV CL,AL
        SUB CL,48

        INT 21H

	CMP AL,43
        JE ELSE1_ 
        SUB BL,CL
        ADD BL,48
	MOV AH,2
        MOV DL,BL
	INT 21H

        JMP END_IF1                                               
ELSE1_:
        ADD BL,CL
        ADD BL,48
	MOV AH,2
        MOV DL,BL
	INT 21H

END_IF1:
	MOV BL,AL
	MOV C1,AL ;store character
	MOV AH,9 ;display results
	LEA DX,M2
	INT 21H
	MOV BH,0 ;counter for one’s
	MOV CX,8
	MOV AH,2
L1:
	ROL BL,1 ;display content of BL
	JC L2
	MOV DL,'0'
	INT 21H
	JMP L4
L2:
	MOV DL,'1'
	INT 21H
	INC BH ;count number of one’s
L4: 
	LOOP L1
	ADD BH,30H ;convert to char.
	;XOR BH,00110000B
	MOV C2,BH
	MOV AH,9 ;display number of one’s
	LEA DX,M3
	INT 21H

MOV AH,4CH
INT 21H
MAIN ENDP

END MAIN
