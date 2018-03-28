; 8.11.1.findLargest

; This program demestrates a procedure that finds the largest
; value in an array and returns it in eax

; Pseudocode

; get array from user
; find largest
; displayresult

; procedures

; 1. displayPurpose
; 2. getArray
; 3. findLargest
; 4. displayResult

include irvine32.inc

displayPurpose proto pmsg:ptr byte
getArray proto	pa:ptr dword,  la:dword, getA:ptr byte ; rec: offset & length
findlargest proto pa:ptr dword,  la: dword ; ret: eax = largest
displayResult proto, pdisp1:ptr byte,  val1:dword


.data

a1 dword 5 dup (0)
la dword lengthof a1
msg byte "This program displays the largest value of an array of 5 integers.", 0ah,0dh, 0
getA byte " integer array: ", 0
pdisp3 byte "Larget: ", 0
.code

main proc
	invoke displayPurpose, addr msg
l1: invoke getArray, addr a1, la, addr getA
	invoke findLargest, addr a1, la
	invoke displayResult, addr pdisp3, eax
	jmp l1
exit
main endp





; 1



displayPurpose proc uses edx, pmsg:ptr byte
	
	mov edx, pmsg
	call writestring
ret
displayPurpose endp








; 2




getArray proc uses edx eax ecx esi, pa:ptr dword,   la1:dword, pgetA: ptr byte

	call crlf
	mov edi, pa
	mov eax, la1
	call writeDec

	mov edx, pgetA
	call writeString
	call crlf

	mov ecx, la1
	mov esi, 0
	mov eax, 0
l1: call readDec
	mov [edi], eax
	add edi, 4
	loop l1

ret
getArray endp








; 3





findlargest proc uses esi pa:ptr dword, la2: dword
	
	mov ecx, la2
	cmp ecx, 0
	jl ext
	mov esi, pa
	mov eax, [esi]
l1: cmp eax, [esi]
	jl greater
	add esi, 4
	loop l1
	jmp ext

greater: 
	mov eax, [esi]
	add esi, 4
	loop l1
	
ext:
ret
findLargest endp





; 4


displayResult proc uses edx, pdisp:ptr byte, val1:dword

	mov edx, pdisp
	call writeString
	
	call writeInt
	call crlf

ret
displayResult endp


end main
	
	