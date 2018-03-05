
; 6.11.2.1
; Filling an Array
; This program creates an array of random
; doubleword integers.
; upperbound, lowerbound, and number of integers
; are defined by the user.
;
;
; Pseudocode
; display purpose 
; get arraylength
; get lower bound
; get upper bound
; generate array
; display array


; procedures defined

; 1. displaypurpose
; 2. getuserinput
; 3. calculatedata
; 4. getrandomarray
; 5. betterrandomrange
; 6. displayoutput


include Irvine32.inc

.code
main proc
	call displaypurpose
l1: call getuserinput
	call calculatedata
	call displayoutput
	jmp l1
exit
main endp

; 1
displaypurpose proc
	.data
	disp byte 10,13,"This program creates and saves an array",
			  " of random integers.", 10,13,
			  "Length, lowerbound, and upperbound is",
		      " defined by the user.", 10, 13, 0
	.code
	mov edx, offset disp
	call writeString
	call crlf
	ret
displaypurpose endp

; 2
getuserinput proc ;ret:eax=upperb:ebx=lower:ecx:length
	.data
	prompt1 byte "Enter arraylength: ",0
	prompt2 byte "Enter  lowerbound: ", 0
	prompt3 byte "Enter  upperbound: ", 0
	lower dword 0
	upper dword 0
	lengtharray dword 0
	
	.code
	mov edx, offset prompt1

l1: call writeString
	call readDec
	cmp eax, 0ffffh
	ja l1
	mov lengtharray, eax
	
l2: mov edx, offset prompt2
	call writeString
	call readDec
	mov lower, eax

	mov edx, offset prompt3
	call writeString
	call readDec
	mov upper, eax
	

	
	mov ebx, lower
	mov eax, upper
	mov ecx, lengtharray

	cmp eax, ebx
	je l2
	
ret
getuserinput endp

; 3
calculatedata proc
;rec:eax=upper:ebx=lower:ecx=length
	.data
	randomarray dword 0ffffh dup(0)
	.code
	mov edx, offset randomarray
	call getrandomarray
ret
calculatedata endp

; 4
getrandomarray proc
pushad
;rec:eax=upper:ebx=lower:ecx=length:edx=offsetbuffer
l2:
	call betterrandomrange
	mov [edx], eax
	mov eax, upper
	add edx, 4
	loop l2

popad
ret
getrandomarray endp

; 5
betterrandomrange proc 
;rec:eax=max:ebx=min;ret:eax=randominteger
	sub eax, ebx
	call randomrange
	add eax, ebx
ret
betterrandomrange endp
	
; 6
displayoutput proc
;rec:edx=offsetbuffer:ecx=length
	mov esi, edx
	mov ebx, 4
	call dumpmem
ret
displayoutput endp

end main
