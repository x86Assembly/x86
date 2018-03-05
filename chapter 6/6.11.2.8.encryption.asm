; 6.11.2.8
; message encryption

; This program encrypts a message
; using a key with multiple bytes

; pseudocode

; display menu
;	1. retrieve message from file
;	2. create new message

; get message from user
; get key from user
; encrypt message
; display message
; prompt to save message to txt file
; repeat program

; defined procedures	recieves/returns							EXPLAINATION

; 1. getSelection		rec:nothing ret: al=selection				gets a selection from user
; 2. getKey			rec:edx=offset buffer	ret:nothing			gets key from user, puts in buffer
; 3. tableSelect		rec:al=selection ret:nothing				executes a selection using a table
; 4. loadFromFile		rec:nothing		ret:esi=offset buffer		gets filename, loads file into buffer
; 5. createMessage		rec:nothing		ret:esi=offset buffer		gets message from user, saves to buffer
; 6. encryptBuffer		rec:nothing     ret:nothing					encrypts buffer using a key
; 7. displayMessage     	
; 8. saveToFile										prompts user to save file, creates, and saves

include Irvine32.inc

.data

message byte 0ffffh dup (0)
messageLength dword 0
key		byte 21 dup (0)
keyLength dword 0
caseTable byte 1
		  dword loadFromFile
caselength = ($-caseTable)
		  byte 2
		  dword createMessage
numberOfCases = ($-caseTable) / caselength

.code

main proc

l1: call getSelection
	call getKey
	call tableSelect
	call encryptBuffer
	call displayMessage
	call saveToFile
	loop l1

exit
main endp








; 1

getSelection proc
	
	.data ; rec:nothing  ret: al = selection
	disp1 byte 0ah, 0dh, "Menu", 0ah, 0dh
		  byte "1. Get message from file", 0ah, 0dh
		  byte "2. Create new message", 0ah,0dh
	disp2 byte 0ah, 0dh,"Enter selection (1-2): ", 0
	invalid byte "Invalid Selection", 0ah, 0dh

	.code
	
	mov edx, offset disp1
l1: call writeString
	call readDec

	cmp al, 1
	jb inv
	cmp al, 2
	ja inv
	jmp ext

inv:
	mov edx, offset invalid
	call writeString
	jmp l1

ext:
ret
getSelection endp
	

	





; 2

getKey proc uses eax
	
	.data ; rec:nothing ret: edx = offset key
	disp3 byte "Enter multiple char key: ", 0
	
	.code

	mov edx, offset disp3
	call writeString
	mov edx, offset key
	mov ecx, sizeof key
	call readString
	mov keyLength, eax
	
mov edx, offset key
ret
getKey endp







; 3

tableSelect proc

	mov esi, offset caseTable
	mov ecx, numberOfCases
	l1:
		cmp [esi], al
		jne next
		call near ptr [esi + 1]
		jmp ext
	
	next:
		add esi, caseLength
		loop l1
	
		
ext:
ret
tableSelect endp







; 4

loadFromFile proc uses edx
	
	.data  ; rec:nothing   ret: esi = offset message
	filename byte 21 dup (0)
	disp6 byte "Include .txt", 0ah, 0dh
	disp4 byte "Enter filename: ", 0
	disp5 byte "File not found", 0ah, 0dh, 0

	.code

l1: mov edx, offset disp6
	call writeString
	
	mov edx, offset filename
	mov ecx, lengthof filename
	call readString
	call openInputFile
	
	cmp ax, 0ffffh
	mov filehandle, eax
	je error
	jmp valid

error:
	mov edx, offset disp5
	call writeString
	jmp l1

valid:
	mov edx, offset message
	mov ecx, lengthof message
	call readFromFile
	mov messageLength, eax
	mov eax, filehandle
	call closefile

mov esi, offset message
ret
loadFromFile endp









; 5

createMessage proc uses edx
	
	.data  ;rec nothing ret esi=offset message
	disp7 byte "Enter message: ", 0

	.code

	mov edx, offset disp7
	call writeString
	
	mov edx, offset message
	mov ecx, lengthof message
	call readString
	mov messageLength, eax

mov esi, offset message
ret
createMessage endp








; 6

encryptBuffer proc
	
	 ; rec: esi = offset mesasge edx = offset key
	mov edi, keyLength
	mov ecx, messageLength
	mov esi, offset message
	mov edx, offset key
	mov ebx, 0


l1:	mov al, [edx]
	xor [esi], al
	inc esi
	inc edx
	inc ebx
	cmp edi, ebx
	je restartKey
	jmp l2
restartKey:
	mov edx, offset key
	mov ebx, 0
l2:
	loop l1

ret
encryptBuffer endp










; 7

displayMessage proc uses edx

	.data

	disp8 byte 0ah, 0dh, "Message: ", 0
	
	.code
	mov edx, offset disp8
	call writeString
	mov edx, offset message
	mov ecx, messageLength
	l1:
	mov al, [edx]
	call writeChar
	inc edx
	loop l1

call crlf
call crlf
ret
displayMessage endp









; 8

saveToFile proc uses edx

	.data
	
	disp11 byte "Save file?(y/n): ", 0
	disp9 byte 0ah, 0dh, "Enter filename w/ .txt: ", 0
	filename1 byte 21 dup (0)
	filehandle dword 0
	disp10 byte "File written", 0ah, 0dh, 0
	
	.code
		
	mov edx, offset disp11
	call writeString
	call readChar
	and al, 11011111b
	cmp al, 'Y'
	jne ext

	mov edx, offset disp9
	call writeString
	
	mov edx, offset filename1
	mov ecx, lengthof filename1
	call readString

	call createOutputFile
	mov filehandle, eax
	mov edx, offset message
	mov ecx, messageLength
	call writeToFile
	cmp eax, 0
	je error
	mov eax, filehandle
	call closeFile

	mov edx, offset disp10
	call writeString
	jmp ext

error:
	call WriteWindowsMsg

ext:
call crlf
ret
saveToFile endp



end main
