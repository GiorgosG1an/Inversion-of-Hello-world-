TITLE test2
INCLUDE Irvine32.inc

.data
message1 BYTE "Hello World",0
length1= $ - message1
message2 BYTE length1  DUP('@')
.code
;inputs: 
;		message1 adress +8
;		message2 adress +12
;		message1 length +16
;char* foo(char* message1,int legth, char* message2)
foo PROC
	;PROLOGUE:
	push EBP 
	mov EBP , ESP 
	sub ESP , 4 
	;Save registers used in main  body
	push ebx
	push ecx
	push edx
	push esi
	push edi

	;main body
	mov esi , [ebp + 8] ;esi=&message1 
	mov edi , [ebp + 16] ;edi=&message2
	mov ecx , [ebp + 12] ;ecx=&length=12
	mov edx , ecx	;edx=ecx=12
	dec edx	;edx=edx-1=11 
	mov BYTE PTR [edi + edx] ,  0 ;
	dec ecx
	mov ebx , 0
	mov eax , ecx ; go to the 11 cell of eax
	dec eax

	l1:
		mov dl , [esi + ebx]
		mov [edi + eax],dl 
		inc ebx ;go to the next cell ebx+1
		dec eax ;eax-1
		
	loop l1

	mov eax , edi ;move the final string 
	;epilogue
	;Pop the used registers 
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	mov esp , ebp
	pop ebp
	ret 12
foo ENDP

MAIN PROC

	PUSH offset message2 ; +16
	PUSH length1 ; +12
	PUSH offset message1 ; +8
	call foo
	mov edx , offset message2
	call writestring
	exit

main ENDP

END main 