.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC
        MOV AX,5
;add ax,48
        MOV BX,4
;add bx,48
        ADD AX, BX
;sub AX,48
;commented karo or neeche wala na likho tou b theek hai
	add ax,48
        MOV AH,2
        MOV DX,AX
        INT 21H

MOV AH,4CH
INT 21H
MAIN ENDP
END MAIN


