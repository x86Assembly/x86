


; 7.10.5.primenumbers
; This program displays prime numbers using the Sieve of Eratosthenes method

; Pseudocode


; create array of numbers and linked array
; display numbers 1-1000, colors are based on linked array
; calculate a series of composites, clear screen and redisplay array every interation


; Procedures


; 1. initalizeArray
; 2. calculateComposites
; 3. loopArray
; 4. displayArray
; 5. displayCurrentPrimes
; 6. displayPurpose
; 7. lineBreak


include irvine32.inc


.data

array word 1000d dup (0)
linkedArray word 1000d dup (0)


.code

main proc
	call displayPurpose
l1: call initializeArray
	call calculateComposites
	call displayPrimes
	call waitmsg
	call displayArray
	jmp l1

exit
main endp











;  1 




initializeArray proc
	
	mov esi, offset array		; create array of numbers 2-1000d
	mov ecx, lengthof array
	mov eax, 0
l1: mov word ptr [esi], ax
	inc eax
	add esi, 2
	loop l1

	mov esi, offset linkedArray		; reset linked array to 0
	mov ecx, lengthof linkedArray
	mov ebx, 0
l2:	mov word ptr [esi], bx
	inc esi
	loop l2

ret
initializeArray endp












; 2



calculateComposites proc
	
	mov esi, 0
	mov edx, 0
	mov ebx, 2
	mov ecx, 33
	
	mov linkedArray[0], 1	; 0 and 1 are not considered prime
	mov linkedArray[2], 1



l2:


	
push ecx
mov eax, lengthof linkedArray
mov edx, 0
cmp bx, 0
je zerodivision
idiv bx
zerodivision:
mov ecx, eax

call looparray

	inc ebx
	pop ecx
	loop l2


	
		
out1:
ret
calculateComposites endp











; 3

loopArray proc
	mov edx, 0
	mov edx, ebx
l1: 
	add edx, ebx
	;mov linkedArray[edx], 1
	mov linkedArray[edx*type word], 1
	;call displaycurrentprimes
	loop l1

ret
loopArray endp










; 4




displayArray proc

	mov esi, offset array
	mov ecx, lengthof array
	mov ebx, 2
	call dumpmem

	mov esi, offset linkedarray
	mov ecx, lengthof linkedarray
	call dumpmem
	call waitmsg

ret
displayArray endp	
	
	








; 4 



displayPrimes proc



	call crlf
	;call linebreak

	mov esi, 0
	mov edx, 0
	mov ecx, lengthof array

	
l1: cmp linkedArray[esi], 1
	je notPrime
	mov ax, word ptr array[esi]
	call writeDec
	mov al, ' '
	call writechar

notPrime:
	add esi, 2
	loop l1

call crlf
;call linebreak
call crlf
ret
displayPrimes endp










; 5




displaycurrentprimes proc
	call clrscr
	call displayPrimes
	mov eax, 100
	call delay
ret
displaycurrentprimes endp






; 6




displayPurpose proc
	
	.data
	disp1 byte "This program uses the Sieve of Eratosthenes method", 0ah, 0dh
          byte "to display primes 2-1000", 0ah,0dh,0
	
	.code

	mov edx, offset disp1
	call writeString

ret
displayPurpose endp







; 7






linebreak proc

	call crlf

	mov ecx, 110
	mov al, '-'
l1:	call writechar
	loop l1

call crlf
ret
linebreak endp



end main