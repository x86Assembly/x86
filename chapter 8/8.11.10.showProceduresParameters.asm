; 8.11.10.showProcedureParameters

; This program demonstrates a procedure
; that shows the parameters on the stack


include irvine32.inc
; procedures


; 1. displayPurpose
get3Values proto v1:ptr dword, v2:ptr dword, v3:ptr dword
pushonstack proto va1:dword, va2:dword, va3:dword
showparams proto num:dword

.data

val1 dword 0
val2 dword 0
val3 dword 0


.code 

main proc
	call displayPurpose
l1: invoke get3Values, addr val3, addr val2, addr val1
	invoke pushonstack, val1, val2, val3
	jmp l1
exit
main endp



; 1


displayPurpose proc

	.data
	msg byte "This program demonstrates a procedure that shows the parameters on the stack", 0ah,0dh,0
	
	.code

	mov edx, offset msg
	call writeString

ret
displayPurpose endp 










; 2




get3Values proc v111:ptr dword, v222:ptr dword, v333:ptr dword

	.data

	msg1 byte "Val 1: ", 0
	msg2 byte "Val 2: ", 0
	msg3 byte "Val 3: ", 0

	.code
	
	call crlf
	
	mov edx, offset msg1
	call writeString
		
	call readInt
	mov esi, v111
	mov [esi], eax

	mov edx, offset msg2
	call writeString
	
	call readInt
	mov esi, v222
	mov [esi], eax


	mov edx, offset msg3
	call writeString
	
	call readInt
	mov esi, v333
	mov [esi], eax
		
ret
get3Values endp






; 3



pushonstack proc   vaa1:dword, vaa2:dword, vaa3:dword
	
	invoke showparams, 3
ret
pushonstack endp





; 4


showparams proc		num1:dword

	.data
	msg13 byte "Stack parameters:",0ah,0dh,0
	br byte "--------------------------",0ah,0dh,0
	msg23 byte "address ", 0
	space byte " = ", 0
	
	.code

	call crlf

	mov edx, offset msg13
	call writeString
	mov edx, offset br
	call writeString
	
	mov ecx, num1
l1:
	mov edx, offset msg23
	call writeString
	mov eax, ecx
	mov ebx, 4
	mul ebx
	add eax, [ebp]
	add eax, 4
	call writeHex

	mov edx, offset space
	call writestring
	
	mov eax, [eax]
	call writeHex
	call crlf
	loop l1

call crlf
ret
showparams endp
	
	
	




end main
