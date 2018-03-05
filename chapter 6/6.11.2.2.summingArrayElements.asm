; 6.11.2.2
; Summing array elements in a range
; This program gets the size of the
; array, the upperbound, and the lowerbound
; from the user, sums the values found in that
; range.

; pseudocode
; get size of array, upper, lower bound.
; prepare registers
; call sumarrayrange
; display sum
; repeat program

; procedures defined
; 1. displayPurpose
; 2. generaterandomarray
; 3. getabc
; 4. sumarrayrange
; 5. displaysum

include Irvine32.inc
.data
myarray dword 1,3,3,2,3,5,6,9,3,5,4,8,7,2,1,5
sum dword 0
.code
main proc
	call displayPurpose
	call displayArray
l1: call getabc
	mov esi, offset myarray
	call sumArrayRange
	call displaySum
	jmp l1
exit
main endp

; 1
displayPurpose proc
	.data
	disp byte 10,13, "This program sums array elements ",
			  "of a given range.",10,13
	.code
	mov edx, offset disp
	call writeString
ret
displayPurpose endp

; 2
generateRandomArray proc uses eax ebx ecx
;rec:nothing;ret:esi=offsetRandomArray
	.data
	randomArray dword 0ffffh dup(0)
	.code
	call randomize
	mov ecx, lengthof randomarray
	mov esi, offset randomArray
l1: call random32
	mov [esi], eax
	add esi, type randomArray
	loop l1

mov esi, offset randomArray
ret
generateRandomArray endp

; 3
getabc proc uses esi
;rec:nothing;ret:ebx=min:edx=max:ecx=length
	.data
	prompt1 byte "Enter lowest value: ", 0
	prompt2 byte "Enter highest value: ", 0
	prompt3 byte "Enter length to sum: ",0
	lower dword 0
	upper dword 0
	range dword 0
	.code
l1: mov edx, offset prompt1
	call writeString
	call readDec

	mov lower, eax

	mov edx, offset prompt2
	call writeString
	call readDec
	mov upper, eax

	cmp eax, lower
	je l1

	mov edx, offset prompt3
	call writeString
	call readDec
	mov range, eax



	mov ebx, lower
	mov edx, upper
	mov ecx, range
ret
getabc endp

; 4 
sumArrayRange proc uses ebx ecx edx esi
;rec ebx=min edx=max ecx=range esi=offsetarray
;ret eax=sum, regs preserved
	.data
	carryFlag byte 0
	.code
	mov eax, 0
	mov sum, 0
l1: cmp [esi], ebx
	jb outRange
	cmp [esi], edx
	ja outRange
	mov eax, [esi]
	add sum, eax
outRange:
	add esi, 4
	loop l1

mov eax, sum
ret
SumArrayRange endp

; 5
displaySum proc
;rec eax=sum ret nothing
pushad
	.data
	disp2 byte "Sum: ", 0
	.code
	mov edx, offset disp2
	call writeString
	call writeDec
	call crlf
popad
ret
displaySum endp

; 6
displayArray proc
	.data
	disp3 byte "Array: ", 0
	.code
	mov edx, offset disp3
	call writeString
	mov esi, offset myArray
	mov ecx, lengthof myArray
	mov ebx, type myArray
l1: movzx eax, byte ptr [esi]
	call writeDec
	mov al, ' '
	call writeChar
	add esi, ebx
	loop l1
	call crlf
	ret
displayArray endp

end main
