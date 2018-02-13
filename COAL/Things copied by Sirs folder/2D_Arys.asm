; program to find the class average on each exam
; display the avg marks of each quiz

.MODEL SMALL
.STACK 100H
.DATA

FIVE DW 5
SCORES DW 67, 45, 98, 33  ;ahmed
       DW 70, 56, 87, 44  ;ali
       DW 82, 72, 89, 40  ;ammara
       DW 80, 67, 95, 50  ;saba
       DW 78, 76, 92, 60  ;rizwan

AVG DW 4 DUP(0)

.CODE
MAIN PROC
mov ax, @data
mov ds, ax

                XOR SI, SI
                D01:
                    XOR AX, AX
                    MOV CX, 5
                    XOR BX, BX
                    FOR2:
                        ADD AX, SCORES[BX][SI]
                        ADD BX, 8
                        LOOP FOR2

                     XOR DX,DX
                     DIV FIVE
                     MOV AVG[SI], AX

                     ADD SI, 2

                     CMP SI, 8
                     JL  D01

                    ; display the result that is store in AVG..
                   MOV CX, 4
                   XOR SI, SI

                   MOV AH, 2
                   FOR3:
                       PUSH AVG[SI]
                       CALL OUTDEC
                       ADD SI, 2
                       MOV DL, ","
                       INT 21H
                     LOOP FOR3
                   
MOV AH, 4CH
INT 21H
MAIN ENDP
        OUTDEC PROC
                PUSH BP
                MOV BP, SP
                PUSH AX
                PUSH BX
                PUSH CX
                PUSH DX

                MOV AX, [BP+4]
                MOV BX, 10
                XOR CX, CX

             TOP1:
                XOR DX, DX
                DIV BX
                ADD DX, 48
                PUSH DX
                INC CX
                CMP AX, 0
                JNE TOP1

                 MOV AH, 2
                                   
               TOP2:
                        POP DX
                        INT 21H
                        LOOP TOP2


                 POP DX
                 POP CX
                 POP BX
                 POP AX
                 POP BP

        RET 2
        OUTDEC ENDP




END MAIN
