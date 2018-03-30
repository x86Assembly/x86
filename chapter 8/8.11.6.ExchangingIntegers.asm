; 8.11.6.ExchangingIntegers

; This program creates a random array, then uses a procedure to 
; swap eax consecutive pair of integers

include irvine32.inc
; Procedures

; 1. displayPurpose
randomizeArray proto ar1:ptr dword, al1:dword
swap proto ptr1:ptr dword,  ptr2:ptr dword
swapArrayElements proto parray:ptr dword, a1Length:dword
dumpMemory proto esi1: ptr dword, ecx1:dword, ebx1:dword



.data
array1 dword 20 dup (0)
aLength dword lengthof array1
msg4 byte "Before swap", 0ah,0dh,0
msg5 byte "After swap", 0ah,0dh,0


.code

main proc
	
	call displayPurpose
l1: invoke randomizeArray, addr array1, aLength
	mov edx, offset msg4
	call writeString
	invoke dumpMemory, addr array1, aLength, type array1
	invoke swapArrayElements, addr array1, aLength
	mov edx, offset msg5
	call writeString
	invoke dumpMemory, addr array1, aLength, type array1
	call crlf
	call crlf
	call waitmsg
	jmp l1

exit
main endp












; 1





displayPurpose proc

	.data

	msg byte "This program swaps each consecutive element of an array",0ah,0dh,0

	.code

	mov edx, offset msg
	call writeString
	call crlf
	call crlf

ret
displayPurpose endp 






; 2





randomizeArray proc		ptra1:ptr dword, alength1:dword
	
	call randomize
	mov ecx, alength1
	mov esi, ptra1

l1:	mov eax, 100
	call randomRange
	mov [esi], eax
	add esi, 4
	loop l1

ret
randomizeArray endp






; 3






swap proc uses esi edi eax	ptr11:ptr dword, ptr22:ptr dword

	mov esi, ptr11
	mov edi, ptr22
	mov eax, [edi]
	xchg [esi], eax
	mov [edi], eax

ret
swap endp





; 4




swapArrayElements  proc ptrarray:ptr dword, arrayLength:dword
	
	mov esi, ptrarray
	mov edi, ptrarray
	add edi, 4 
	mov ecx, arraylength
	shr ecx, 1		; divide by two
	
l1: invoke swap, esi, edi 
	add esi, 8
	add edi, 8
	loop l1

ret
swapArrayElements endp














; 5




dumpMemory proc  esi2:ptr dword, ecx2:dword, ebx2:dword

	mov esi, esi2
	mov ecx, ecx2
	mov ebx, ebx2

	call dumpmem
	call crlf
	call crlf


ret
dumpMemory endp


end main
	




