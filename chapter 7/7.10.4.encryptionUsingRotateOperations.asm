; 7.10.4.EncyptionUsingRotateOperations

; This program accepts a message and key from the user.
; Then a random key is generated which is used to shift
; the bits of the message. The user is prompted to save the 
; message to a file


; Pseudocode


; option 1
; get message from user
; get key from user
; encrypt message using key
; generate random shifting key
; encyrpt message using shifting key
; prompt user to save to file
;		get filename
;       get filename for shifting key

; option 2
; get filename of message from user
; get filename of shifting key from user
; get key from user
; read message into buffer
; read shifting key into buffer
; decrypt message using shifting key
; decrypt message using user key


; procedures defined

; 1. getSelection

; procedures for option 1

; 2. getMessage
; 3. getKey
; 4. generateShiftingKey
; 5. shiftingKeyEncrypt
; 6. userKeyEncrypt
; 7. displayMessage
; 8. promptSave
;      9. getFilename
;      10. getShiftingFilename
;	   11. saveMessage
;      12. saveShiftingkey



; procedures for option 2

; 13. getMessageFromFile
; 14. getShiftingkeyFromFile
;			getkey
;			decrypt using procedures already defined
;			display message



include irvine32.inc

.data

message byte 0ffh dup (0)
messageLength dword 0
key byte 0ffh dup (0)
keyLength dword 0
shiftingKey byte 0ffh dup (0)
shiftingKeyLength dword 0ffh

.code

main proc
	
	 call displayPurpose
l1:	 call getSelection
	 cmp eax, 1
	 je create
	 cmp eax, 2
	 je read

create:
	call getMessage
	call getKey
	call generateShiftingKey
	call shiftingKeyEncrypt
	call userKeyEncrypt
	call displaymessage
	call promptSave
	jmp l1

read:
	call getDataFromFiles
	call getkey
	call userKeyEncrypt
	call shiftingKeyDecrypt
	call displayMessage
	call promptSave
	jmp l1

exit
main endp






;  1



displayPurpose proc
	
	.data
	disp1 byte "This program encrypts and saves a message using two keys.", 0ah, 0dh
		  byte "The first key is defined by the user and xor's each byte of the message.", 0ah, 0dh
	      byte "The second key is 255 randomly generated integers wg rotates the bits of the message.", 0ah,0dh
		  byte "The random key is saved to a file and must be in the folder of this exe to decrypt the file.", 0ah,0dh, 0

	.code

	mov edx, offset disp1
	call writeString
	
ret
displayPurpose endp






; 2




getSelection proc
; ret: eax = 1 or 2
	
		.data
		disp2 byte 0ah, 0dh,"MENU", 0ah, 0dh
		      byte "1. create Message", 0ah, 0dh
			  byte "2. get message from file", 0ah,0dh,0ah,0dh, 0

		disp3 byte 0ah,0dh, "Enter selection: ", 0
		err1 byte "Invalid selection", 0ah, 0dh, 0

		.code

		mov edx, offset disp2
		call writeString
		
l1:		mov edx, offset disp3
		call writeString
		call readDec
		cmp al, 1
		jb err
		cmp al, 2
		ja err
		jmp ext

err:
		mov edx, offset err1
		call writeString
		jmp l1

ext:

ret
getSelection endp













; 3







getMessage proc

	.data
	
	disp4 byte "Enter message: ", 0

		
	.code

	mov edx, offset disp4
	call writeString
	mov edx, offset message
	mov ecx, lengthof message
	call readString
	mov messageLength, eax
	
ret
getMessage endp







; 4







getKey proc

	.data
	disp5 byte "Enter key: ", 0
	
	.code
		
	mov edx, offset disp5
	call writeString
	mov edx, offset key
	mov ecx, lengthof key
	call readstring
	mov keyLength, eax

ret
getKey endp






; 5






generateShiftingKey proc
		
		call randomize
		mov ecx, 0ffh
		mov esi, offset shiftingKey
l1:		jmp getRandom
l2:		mov [esi], al
		inc esi
		loop l1
		jmp ext

getRandom:
 		mov eax, 8d
		call randomRange
		jmp l2


ext:
ret
generateShiftingKey endp








; 6

		

shiftingKeyDecrypt proc
	
		mov edx, offset shiftingKey
		mov esi, offset message
		mov ecx, shiftingKeyLength
		mov edi, messageLength
		mov ebx, 0
		
l1:	    push ecx
		mov cl, byte ptr [edx]
		mov al, byte ptr [esi]
		rol al, cl
		mov [esi], al
		pop ecx
		inc esi
		inc ebx
		inc edx
		cmp edi, ebx
		je restartMessage
		loop l1
		jmp ext

restartMessage:
		mov esi, offset message
		mov ebx, 0
		loop l1
ext:
ret
shiftingKeyDecrypt endp

			

shiftingKeyEncrypt proc
	
		mov edx, offset shiftingKey
		mov esi, offset message
		mov ecx, shiftingKeyLength
		mov edi, messageLength
		mov ebx, 0
		
l1:	    push ecx
		mov cl, byte ptr [edx]
		mov al, byte ptr [esi]
		ror al, cl
		mov [esi], al
		pop ecx
		inc esi
		inc ebx
		inc edx
		cmp edi, ebx
		je restartMessage
		loop l1
		jmp ext

restartMessage:
		mov esi, offset message
		mov ebx, 0
		loop l1
ext:
ret
shiftingKeyEncrypt endp








; 7




userKeyEncrypt proc
	
	mov esi, offset message
	mov edi, offset key
	mov ecx, messageLength
	mov ebx, keyLength
	mov eax, 0

l1: mov dl, byte ptr [edi]
	xor byte ptr [esi], dl
	inc esi
	inc edi
	inc eax
	cmp eax, ebx
	je restartKey
	loop l1
	jmp ext

restartKey:
	mov edi, offset key
	mov eax, 0
	loop l1

ext:

ret
userKeyEncrypt endp







; 8




displayMessage proc
	
	.data
	disp7 byte "Message: ",0
		
	.code 
	
	mov edx, offset message
	call writeString
	call crlf
	
ret
displayMessage endp






; 9






promptSave proc
	
	.data
	
	disp8 byte 0ah, 0dh,"Save file?(y/n): ", 0
	disp9 byte 0ah, 0dh,"Enter filename w/ .txt: ", 0
	disp10 byte 0ah, 0dh,"Enter filename for generated key w/ .txt: ", 0
	disp11 byte "Files saved.",0ah, 0dh,0
	filename byte 21 dup (0)
	filenamehandle dword 0
	keyFilename byte 21 dup (0)
	keyFilenameHandle dword 0
	
	.code
	
	mov edx, offset disp8    ; prompt to save
	call writeString
	call readChar
	and al, 11011111b
	cmp al, 'Y'
	jne ext

	mov edx, offset disp9		; get filename
	call writeString
	mov edx, offset filename
	mov ecx, lengthof filename
	call readString

	mov edx, offset disp10		; get filename for key
	call writeString
	mov edx, offset keyFilename
	mov ecx, lengthof keyFilename
	call readString

	mov edx, offset filename	; save message to file
	call createOutputFile
	mov filenameHandle, eax
	mov edx, offset message
	mov ecx, messageLength
	call writeToFile
	mov eax, filenameHandle
	call closeFile

	; convert key to ascii
	mov edx, offset shiftingKey
	mov ecx, shiftingKeyLength
l1: mov al, byte ptr [edx]
	or al, 30h
	mov [edx], al
	inc edx
	loop l1
	

	mov edx, offset keyFilename   ; save key to file
	call createOutputFile
	mov keyfilenameHandle, eax
	mov edx, offset shiftingkey
	mov ecx, shiftingKeyLength
	call writeToFile
	mov eax, keyfilenameHandle
	call closeFile
	
	mov edx, offset disp11
	call writeString

ext:
ret
promptSave endp





; 10




getDataFromFiles proc

	.data
	
	disp12 byte "Enter existing filename of message w/ .txt: ", 0
	disp13 byte "Enter existing filename of key w/ .txt: ", 0
	disp14 byte "File not found", 0ah, 0dh, 0
	filename2 byte 21 dup (0)
	filenamehandle2 dword 0
	keyFilename2 byte 21 dup (0)
	keyFilenameHandle2 dword 0
	.code
	 
l1: mov edx, offset disp12		; get message from file
	call writeString
	mov edx, offset filename2
	mov ecx, lengthof filename2
	call readString
	call openInputFile
	cmp al, 0ffh
	je err
	mov filenameHandle2, eax
	mov edx, offset message
	mov ecx, lengthof message
	call readFromFile
	mov messageLength, eax
	mov eax, filenamehandle2
	call closeFile
	

l2: mov edx, offset disp13		; get key from file
	call writeString
	mov edx, offset keyfilename2
	mov ecx, lengthof keyfilename2
	call readString
	call openInputFile
	cmp al, 0ffh
	je err2

	mov keyfilenameHandle2, eax
	mov edx, offset shiftingKey
	mov ecx, lengthof shiftingKey

	call readFromFile
	


	mov shiftingKeyLength, 0ffh
	mov eax, keyfilenamehandle2
	call closeFile
	

	; convert key to binary
	mov edx, offset shiftingKey
	mov ecx, shiftingKeyLength

l3: and byte ptr [edx], 0fh
	inc edx
	loop l3
	
jmp ext

err:
	mov edx, offset disp14
	call writeString
	jmp l1
err2:
	mov edx, offset disp14
	call writeString
	jmp l2

ext:
ret
getDataFromFiles endp
	


end main