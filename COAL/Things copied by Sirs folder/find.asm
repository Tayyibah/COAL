
; An assembly program to find the first, second first , last and second last character in give input of a character array.

; pseduocode: 
			;take first input in first, last , sf(second first) and sl(second last) variable
			;
			;take input(AL) again.
			; WHILE (AL != 13) 
			;{

                        ; if(AL >= "A" && AL <= "z")
                        ; {
                        ;    if(AL <= "Z" || AL >= "a")
                        ;    {
                        ;       ///correct input
			;	if(FIRST > AL)
			;	{
			;	  SF = FIRST
			;	  FIRST = AL
			;	
			;	}
			;	else if( SF == FIRST || SF> AL)
			;	{
			;		SF = FIRST
			;	}
			;
			;	if(LAST < AL)
			;	{
 			;		SL = LAST
			;		LAST = AL		
			;
			;	}	
			;	else if(SL == LAST || SL < AL)
			;	{
			;		SL = AL
				;}		
			

			
                        ;    }
                        ;     else
                        ;    {
                        ;        ignoring the given input
                        ;     }
                        ;
                        ; }
                        ; else
                        ; {
                        ;      ignore the given input
                        ; }
                        ;
			; take input in al	
			;}



.MODEL SMALL

.STACK 100H

.data
m1 db 10,13, "enter a character arrays: $"
m2 db 10,13, "entered string contains the first letter:  "


first db ?
      db "  last letter: "
last db ? , "$"

m3 db 10,13, "entered string contains the second first letter:  "
sf   db ?
      db "  second last letter:  "
sl  db ?, "$"


.CODE

MAIN PROC

 mov ax, @data
 mov ds, ax

 mov ah, 9
 lea dx, m1
 int 21h


  mov ah, 1
  int 21h

  
  mov last, al
  mov first, al

  mov sf, al
  mov sl, al

  mov ah, 1
  int 21h

  while1:

  cmp al, 13
  je end_while1


  cmp al, "A"
  jb inputnext

  cmp al, "z"
  ja inputnext

  cmp al, "Z"
  jbe then2
  
 cmp al, "a"
  jae then2
	 	
 jmp inputnext


then2:
         cmp first, al
         jbe end_if1

         mov bh, first
         mov sf, bh
         mov first, al

         jmp  inputnext




       end_if1:

         mov bh, first
         cmp sf, bh
         je then1
         cmp sf, al
         ja then1
         jmp s_if2

         then1:

            mov sf, al


         s_if2:



         cmp last, al
         jae end_if4

                   mov bh, last
                   mov sl, bh
                   mov last, al
                   jmp inputnext

         end_if4:
                mov bh, last
                 cmp sl, bh
                 je then4
                 cmp sl, al
                 jb then4
                       jmp inputnext

                 then4:
                      mov  sl, al

            


  
  inputnext:

  mov ah, 1
  int 21h
  jmp while1

  end_while1:

              mov ah, 9
              lea dx, m2
              int 21h

mov dx, offset m3
int 21h
MOV AH, 4CH
INT 21H



MAIN ENDP
END MAIN
