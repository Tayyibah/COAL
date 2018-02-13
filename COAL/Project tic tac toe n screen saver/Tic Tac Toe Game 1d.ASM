.MODEL SMALL
.STACK 100H
.DATA
    NUMS DB '?','?','?','?','?','?','?','?','?'
		
		
    MSG0 DB 0Ah,0Dh,'              ---------------TIC TAC TOE GAME---------------              ',0Ah,0Dh,'$'
    MSG1 DB 0Ah,0Dh,'              -------------THE GAME START NOW-------------              ',0Ah,0Dh,'$'
    MSG2 DB 0Ah,0Dh,'                  PLAYER1 NAME = X AND PLAYER2 NAME = O                  ',0Ah,0Dh,'$'
    MSG3 DB 0Ah,0Dh,'                       PLAYER ONES ENTER A POSITION                       ',0Ah,0Dh,'$'
    MSG4 DB 0Ah,0Dh,'                       PLAYER TWOS ENTER A POSITION                       ',0Ah,0Dh,'$'
    MSG5 DB 0Ah,0Dh,'ENTER INDEX : $'
    MSG6 DB 0Ah,0Dh,'INVALID INPUT , TRY AGAIN$'
    MSG7 DB 0Ah,0Dh,'PLAYER 1 WIN$'
    MSG8 DB 0Ah,0Dh,'PLAYER 2 WINS$'     
    MSG9 DB 0Ah,0Dh,'GAME TIE',0Ah,0Dh,'$' 
    MSG10 DB 0Ah,0Dh,'PLAY AGAIN ? (Y/N)$'      

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
        
    MOV AH,09
    LEA DX,MSG0
    INT 21H
        
PLAY:
    MOV AH,09
    LEA DX,MSG1
    INT 21H
	                                                         
    LEA DX,MSG2                                          
    INT 21H                                              
          
    LEA SI,NUMS
    MOV CX,9
FOR1:
    MOV BYTE PTR [SI],'?'
    INC SI
    LOOP FOR1

	MOV BL,0
	JMP SHOW1
TURNS:
    MOV BL,1
    MOV CX,9                        
                                                                                                  
WHILE1:     ;LOOP FOR TURNS                                                           
    LEA SI,NUMS                                                    
                                                                       
    CMP BL,1                                                       
    JE PLAYER1_                                                     
    JMP PLAYER2_                                                    
                                                                       
                                                                
                                                                     
PLAYER1_:           ;TURN OF***PLAYER 1***                                                 
                                                                     
    MOV AH,09                                            
    LEA DX,MSG3                                          
    INT 21H                                              
                                                                       
    LEA DX,MSG5                                          
    INT 21H                                              
                                                                     
    MOV AH,01                                            
    INT 21H                                              
                                                                     
    CMP AL,'9'                                           
    JA INCORRECT 

    CMP AL,'1'                                           
    JB INCORRECT                                                                                    
                                                                     
    SUB AL,48                                            
                                                                     
    CMP AL,1                                             
    JE JUMP_CHECKING1                                                
                                                                     
PUT1:                                               
        INC SI                                          
        DEC AL                                                      
        CMP AL,1                                        
        JNE PUT1                                                                                           
JUMP_CHECKING1:                                                                                                                     
	JMP CHECKING1                                           
                                                                     
CONTINUE1_1:                                         
                                                                     
    MOV BYTE PTR [SI],'X'                        
    JMP SHOW1                                 
                                                                     
CONTINUE1_2:                                         
    MOV BL,2                                                         
    JMP WIN1_ 

PLAYER2_:         ;TURN OF PLAYER 2                                                 
                                                                     
    MOV AH,09                                            
    LEA DX,MSG4                                          
    INT 21H                                              
                                                                    
    LEA DX,MSG5                                          
    INT 21H                                              
                                                                     
    MOV AH,01                                            
    INT 21H                                              
                                                                     
    CMP AL,'1'                                           
    JB INCORRECT                                          
                                                                     
    CMP AL,'9'                                           
    JA INCORRECT                                          
                                                                    
    SUB AL,48                                            
                                                                     
    CMP AL,1                                             
    JE JUMP_CHECKING2                                                
                                                                     
PUT2:                                              
    INC SI                                          
    DEC AL                                          
    CMP AL,1                                        
    JNE PUT2                                      
                                                                     
JUMP_CHECKING2:                                                  
    JMP CHECKING1                                           
                                                                     
CONTINUE2_1:                                         
    MOV BYTE PTR [SI],'O'                        
    JMP SHOW1                                 
                                                                     
CONTINUE2_2:                                         
    MOV BL,1                                                         
    JMP WIN2_                                          
                                         
                     
                                         
CHECKING1:          ;CHECKING IF ALREADY EXISTED OR NOT                                                    
    CMP BYTE PTR [SI],'X'                                
    JE INCORRECT                                          
                                                                     
    CMP BYTE PTR [SI],'O'                                
    JE INCORRECT                                          
                                                                     
    CMP BL,1                                             
    JE CONTINUE1_1                                       
    JMP CONTINUE2_1                                      
                                                                     
INCORRECT:                                                    
    MOV AH,09                                            
    LEA DX,MSG6                                          
    INT 21H                                              
                                                                     
	JMP WHILE1                                                   
                                                                                                                                    
CHECK_WHILE_:                                                   
	DEC CX                                                         
	CMP CX,0                                                       
	JE END_WHILE_                                                   
	JMP WHILE1                                                     
                                                                       
END_WHILE_:                                                     
                                                                       
	MOV AH,09                                                      
	LEA DX,MSG9                                                    
   	INT 21H                                                        
                                                                       
    JMP START_AGAIN_                                                 
                                                       
SHOW1:                       ;DISPLAYING GAME BOARD                              
                                                                                                           
    LEA SI,NUMS                                             
    MOV BH,0                                                 
                                                                
DISPLAYBOARD_:                                                                                                                     
    MOV AH,02                                               
    MOV DL,10                                               
    INT 21H                                                 
                                                               
    MOV DL,' '                                              
    INT 21H                                                 
                                                                
    MOV DL,[SI]                                             
    INT 21H                                                 
    INC SI                                                  
                                                                
    MOV DL,[SI]                                             
    INT 21H                                                 
    INC SI                                                  
                                                                
    MOV DL,[SI]                                             
    INT 21H                                                 
    INC SI                                                  
                                                                                                                   
    INC BH                                                  
    CMP BH,3                                           
    JNE DISPLAYBOARD_                                               
                                                                
    CMP BL,1                                                
    JE CONTINUE1_2                                          
                                                                
    CMP BL,2                                                
    JE CONTINUE2_2                                          
                                                                
    JMP TURNS                                                                                                 
                                                                
START_AGAIN_:                 ;PLAY AGAIN                                                   
                                                                
    MOV AH,09                                               
    LEA DX,MSG10                                             
    INT 21H                                                 
                                                                
    MOV AH,01                                               
    INT 21H                                                 
                                                                
    CMP AL,'N'                                              
    JE GAME_END_                                             
    CMP AL,'n'                                              
    JE GAME_END_                                             
    CMP AL,'Y'                                              
    JE PLAY                                               
    CMP AL,'y'                                              
    JE PLAY                                               
                                                                
    JMP START_AGAIN_                      
; CHECK WHETHER PLAYER 2 WINS OR NOT                     
    ; CHECKING ALL POSSIBILITIES                        
                                          
                                                                    
WIN1_:                                                            
    LEA SI,NUMS                                                 
                                                                    
    CMP BYTE PTR [SI+0], 'X'                                       
    JNE CHECKWIN1_1                                                  
    CMP BYTE PTR [SI+1], 'X'                                     
    JNE CHECKWIN1_1                                                  
    CMP BYTE PTR [SI+2], 'X'                                     
    JNE CHECKWIN1_1                                                  
    JMP WIN1                                                    
                                                                    
CHECKWIN1_1:                                                        
    CMP BYTE PTR [SI+0], 'X'                                       
    JNE CHECKWIN1_2                                                  
    CMP BYTE PTR [SI+3], 'X'                                     
    JNE CHECKWIN1_2                                                  
    CMP BYTE PTR [SI+6], 'X'                                     
    JNE CHECKWIN1_2                                                  
    JMP WIN1                                                    
                                                                    
CHECKWIN1_2:                                                        
    CMP BYTE PTR [SI+0], 'X'                                       
    JNE CHECKWIN1_3                                                  
    CMP BYTE PTR [SI+4], 'X'                                     
    JNE CHECKWIN1_3                                                  
    CMP BYTE PTR [SI+8], 'X'                                     
    JNE CHECKWIN1_3                                                  
    JMP WIN1                                                    
                                                                    
CHECKWIN1_3:                                                        
    CMP BYTE PTR [SI+1], 'X'                                     
    JNE CHECKWIN1_4                                                  
    CMP BYTE PTR [SI+4], 'X'                                     
    JNE CHECKWIN1_4                                                  
    CMP BYTE PTR [SI+7], 'X'                                     
    JNE CHECKWIN1_4                                                  
    JMP WIN1                                                    
                                                                    
CHECKWIN1_4:                                                         
    CMP BYTE PTR [SI+2], 'X'                                     
    JNE CHECKWIN1_5                                                  
    CMP BYTE PTR [SI+4], 'X'                                     
    JNE CHECKWIN1_5                                                  
    CMP BYTE PTR [SI+6], 'X'                                     
    JNE CHECKWIN1_5                                                  
    JMP WIN1                                                    
                                                                    
                                                                    
CHECKWIN1_5:                                                         
    CMP BYTE PTR [SI+2], 'X'                                     
    JNE CHECKWIN1_6                                                  
    CMP BYTE PTR [SI+5], 'X'                                     
    JNE CHECKWIN1_6                                                  
    CMP BYTE PTR [SI+8], 'X'                                     
    JNE CHECKWIN1_6                                                  
    JMP WIN1                                                    
                                                                    
                                                                    
CHECKWIN1_6:                                                         
    CMP BYTE PTR [SI+3], 'X'                                     
    JNE CHECKWIN1_7                                                  
    CMP BYTE PTR [SI+4], 'X'                                     
    JNE CHECKWIN1_7                                                  
    CMP BYTE PTR [SI+5], 'X'                                     
    JNE CHECKWIN1_7                                                  
    JMP WIN1                                                    
                                                                    
                                                                    
CHECKWIN1_7:                                                         
    CMP BYTE PTR [SI+6], 'X'                                     
    JNE CHECKWIN1_8                                                  
    CMP BYTE PTR [SI+7], 'X'                                     
    JNE CHECKWIN1_8                                                  
    CMP BYTE PTR [SI+8], 'X'                                     
    JNE CHECKWIN1_8                                                  
    JMP WIN1                                                    
                                                                    
CHECKWIN1_8:                                                         
                                                                    
    JMP CHECK_WHILE_                                             
                                                                 
WIN1:                                                               
    MOV AH,09                                                   
    LEA DX,MSG7         ;IF PLAYER 1 WIN THE GAME THEN DISPLAY MSG7                                           
    INT 21H                                                     
    JMP START_AGAIN_                                              
                                          
    ;CHECK WHETHER PLAYER 2 WINS OR NOT                     
    ;CHECKING ALL POSSIBILITIES                        
                                          
                                                                    
WIN2_:                                                            
                                                                    
    LEA SI,NUMS                                                 
                                                                    
    CMP BYTE PTR [SI+0], 'O'                                       
    JNE CHECKWIN2__1                                                  
    CMP BYTE PTR [SI+1], 'O'                                     
    JNE CHECKWIN2__1                                                  
    CMP BYTE PTR [SI+2], 'O'                                     
    JNE CHECKWIN2__1                                                  
    JMP WIN2                                                    
                                                                    
CHECKWIN2__1:                                                        
    CMP BYTE PTR [SI], 'O'                                       
    JNE CHECKWIN2__2                                                  
    CMP BYTE PTR [SI+3], 'O'                                     
    JNE CHECKWIN2__2                                                  
    CMP BYTE PTR [SI+6], 'O'                                     
    JNE CHECKWIN2__2                                                  
    JMP WIN2                                                    
                                                                    
CHECKWIN2__2:                                                        
    CMP BYTE PTR [SI], 'O'                                       
    JNE CHECKWIN2__3                                                  
    CMP BYTE PTR [SI+4], 'O'                                     
    JNE CHECKWIN2__3                                                  
    CMP BYTE PTR [SI+8], 'O'                                     
    JNE CHECKWIN2__3                                                  
    JMP WIN2                                                    
                                                                    
CHECKWIN2__3:                                                        
    CMP BYTE PTR [SI+1], 'O'                                     
    JNE CHECKWIN2__4                                                  
    CMP BYTE PTR [SI+4], 'O'                                     
    JNE CHECKWIN2__4                                                  
    CMP BYTE PTR [SI+7], 'O'                                     
    JNE CHECKWIN2__4                                                  
    JMP WIN2                                                    
                                                                    
CHECKWIN2__4:                                                         
    CMP BYTE PTR [SI+2], 'O'                                     
    JNE CHECKWIN2__5                                                  
    CMP BYTE PTR [SI+4], 'O'                                     
    JNE CHECKWIN2__5                                                  
    CMP BYTE PTR [SI+6], 'O'                                     
    JNE CHECKWIN2__5                                                  
    JMP WIN2                                                    
                                                                    
                                                                    
CHECKWIN2__5:                                                         
    CMP  BYTE PTR [SI+2],'O'                                     
    JNE CHECKWIN2__6                                                  
    CMP  BYTE PTR [SI+5],'O'                                     
    JNE CHECKWIN2__6                                                  
    CMP  BYTE PTR [SI+8],'O'                                     
    JNE CHECKWIN2__6                                                  
    JMP WIN2                                                    
                                                                    
                                                                    
CHECKWIN2__6:                                                         
    CMP BYTE PTR [SI+3], 'O'                                     
    JNE CHECKWIN2__7                                                  
    CMP BYTE PTR [SI+4], 'O'                                     
    JNE CHECKWIN2__7                                                  
    CMP BYTE PTR [SI+5], 'O'                                     
    JNE CHECKWIN2__7                                                  
    JMP WIN2                                                    
                                                                    
                                                                    
CHECKWIN2__7:                                                         
    CMP BYTE PTR [SI+6], 'O'                                     
    JNE CHECKWIN2__8                                                  
    CMP BYTE PTR [SI+7], 'O'                                     
    JNE CHECKWIN2__8                                                  
    CMP BYTE PTR [SI+8], 'O'                                     
    JNE CHECKWIN2__8                                                  
    JMP WIN2                                                    
                                                                    
CHECKWIN2__8:                                                                                                                             
    JMP CHECK_WHILE_                                             
        ;IN CASE PLAYER 2 WIN                        
                                          
WIN2:                                                               
    MOV AH,09                                                   
    LEA DX,MSG8                                                
    INT 21H                                                     
    JMP START_AGAIN_                                              
                                          
GAME_END_:        

	MOV AH,4CH
	INT 21H
MAIN ENDP
END MAIN
