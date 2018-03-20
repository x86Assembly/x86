;7.10.3.packedDecimalConversion

; This program demonstrates a packedToAsc and ascToPacked
; procedure by accepting a value from the user, converting 
; it to packed, then back to ascii and displaying the result.

; Pseudocode

; display purpose
; get value from user as packed decimal
; convert packed string to ascii string
; display ascii string

; Procedures defined

; 1. displayPurpose
; 2. getPackedDecimal	ret: eax = packed decimal
; 3. packedToAscii		rec: eax=packed decimal  esi= buffer for ascii string




include irvine32.inc


.data

asciiString byte 10h dup (0)
Stringlength byte 10h


.code

main proc
		
	call displayPurpose
l1: call getPackedDecimal
	call packedToAscii
	call writeString
	jmp l1

exit
main endp





; 1




displayPurpose proc
	
	.data

	disp1 byte "This program demostrates the use of a procedure which converts a packed decimal to an ascii string.",0ah,0dh
		  byte "A value is accepted from the user, converted to packed decimal, then back to ascii and displayed as a string. ", 0ah, 0dh, 0
	.code
mov edx, offset disp1
	call writeString

ret
displayPurpose endp









; 2



getPackedDecimal proc
	; rec: nothing
	; ret: eax = packed decimal value
	.data
	
	disp3 byte 0ah, 0dh,"Enter 8 digit string: ", 0
	err byte 0ah, 0dh, "Invalid character", 0ah,0dh,0
		
	.code
	
l1: mov edx, offset disp3
	call writeString

	;call readHex


	mov ebx, 0

inp: call readchar
	call writechar
	cmp al, 13d			; enter enter
	je done
	call isdigit
	jne err1

	ror eax, 4
	shld ebx, eax, 4
	jmp inp

err1:
	mov edx, offset err
	call writeString
	jmp l1

done:

mov eax, ebx
call crlf



ext:
mov edx, offset asciiString
ret
getpackedDecimal endp





; 3



packedToAscii proc
	; rec: eax = packed decimal
	;	   edx = offset buffer for ascii string
	
	mov edi, 0			; edi will be used to prevent leading
						; zeros from entering string - we don't want them
	
	mov ecx, 8
	mov ebx, eax		; copy packed decimal into ebx
	mov eax, 0			; clear eax for clarity
l1:	rol ebx, 4			; mov the upper nibble to the lower nibble
	mov al, bl			; get the lower byte
	and al, 0fh			; clear upper nibble
	or al, 30h			; convert to ascii
	
	cmp edi, 0			; if no longer leading, jmp over skipzero
	jne notLead

	cmp al, '0'			; cmp value to zero
	je skipzero				; if zero
	jne setNotLead

notLead:
	mov [edx], al		; place in ascii string (beginning with msb)
	inc edx
skipzero:		
	loop l1
	jmp ext
setNotLead:
	or edi, 1			; set edi so that we longer skip zeros
	jmp notLead		; because we are no longer leading

ext:
mov al, 0
mov [edx], al			; null terminator
mov edx, offset asciiString
ret
packedToAscii endp
	


end main





