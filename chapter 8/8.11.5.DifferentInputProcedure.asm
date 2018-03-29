; 8.11.5.DifferentInputsProcedure


; This program compares three values enter by the user
; and display whether they are the same

include irvine32.inc
; procedures


; 1. displayPurpose
get3Values proto v1:ptr dword, v2:ptr dword, v3:ptr dword
differentInputs proto v11:dword, v22:dword, v33:dword
; displayresult		rec: eax


.data

val1 dword 0
val2 dword 0
val3 dword 0


.code 

main proc
	call displayPurpose
l1: invoke get3Values, addr val1, addr val2, addr val3
	invoke differentInputs, val1, val2, val3
	call displayResult
	jmp l1
exit
main endp



; 1


displayPurpose proc

	.data
	msg byte "This program displays whether three values are equal", 0ah,0dh,0
	
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






differentInputs proc	vall1:dword, vall2:dword, vall3:dword
	
	mov eax, 0  ; assume not equal
	
	mov ebx, vall1
	cmp ebx, vall2
	jne ext			; not equal
	cmp ebx, vall3
	jne ext			; not equal
	mov eax, 1		; else equal

ext:
ret
differentInputs endp








; 4


displayResult proc
	; rec: eax
	.data
	
	msg4 byte "All the same.", 0ah, 0dh,0
	msg5 byte "All not the same.", 0ah,0dh,0
	
	.code
	
	cmp eax, 1
	jne  notsame
	mov edx, offset msg4
	call writeString
	jmp ext

notsame:
	mov edx, offset msg5
	call writeString
	jmp ext

ext:
ret
displayResult endp



end main
