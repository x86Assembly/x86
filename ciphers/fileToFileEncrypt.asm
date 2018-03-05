; encrypt file

; This program copies the contents of a given
; file to a new encrypted file. The user is asked for 
; the current filename,(must be in same folder as exe), 
; asked for a new file name, and is asked for a(the) key.
; A new encrypted(or decrypted) file is then created in
; the current folder

; pseudocode
; get file name of file to encrypt from user
; get new file name from user
; get key from user
; read file into buffer
; encrypt buffer
; write buffer to file
; close file

; procedures defined
; 1. displayPurpose
; 2. getFileName
; 3. getNewFileName
; 4. getKey
; 5. readToBuffer
; 6. encryptBuffer
; 7. writeBufferToFile
; 8. displayVerification

include irvine32.inc

.data
bufferSize = 10000
buffer byte bufferSize dup(0)
bytesRead dword 0
key byte 0
fileHandle dword 0
newFileHandle dword 0
filename byte 21 dup(0)
newFilename byte 21 dup(0)

.code
main proc
	call displayPurpose
	call getFileName
	call getNewFileName
	call getKey
	call readToBuffer
	call encryptBuffer
	call writeBufferToFile
	call waitmsg
	exit
main ENDP

displayPurpose proc
	.data
	disp byte 10,13, "This program creates an encrypted ",
				  "file with the contents of a given ",
				  "file using a key.", 10,13,0
	.code
	mov edx, offset disp
	call writeString
	ret
displayPurpose ENDP

getFileName proc
	.data
	prompt1 byte 10,13, "Enter name of current file(include .txt if txt): ", 0
	.code
l3: mov edx, offset prompt1
	call writeString
	mov edx, offset filename
	mov ecx, lengthof filename
	call readString
	mov edx, offset filename
	call openInputFile
	.if ax == 0ffffh
		call writeWindowsMsg
		jmp l3
    .endif
	call closeFile
	ret
getFileName ENDP

getNewFileName proc
	.data
	prompt2 byte 10,13, "Enter a new file name: ", 0
	.code
	mov edx, offset prompt2
	call writeString
	mov edx, offset newFilename
	mov ecx, lengthof filename
	call readString
	ret
getNewFileName ENDP

getKey proc
	.data
	prompt3 byte 10,13, "Enter a key(1-255): ", 0
	.code
	mov edx, offset prompt3
	call writeString
	call readDec
	mov key, al
	ret
getKey ENDP

readToBuffer proc
	mov edx, offset filename
	call openInputFile
	mov fileHandle, eax
	mov edx, offset buffer
	mov ecx, lengthof buffer
	call readFromFile
	jnz l1
	call writeWindowsMsg
l1: mov bytesRead, eax
	mov eax, fileHandle
	call closeFile
	.if eax == 0
		call writeWindowsMsg
	.endif
	ret
readToBuffer ENDP

encryptBuffer proc
	mov esi, 0
	mov ecx, bytesRead
	mov bl, key
l1: xor buffer[esi], bl
	inc esi
	loop l1
	ret
encryptBuffer ENDP

writeBufferToFile proc
	mov edx, offset newFilename
	call createOutputFile
	mov newFileHandle, eax
	mov edx, offset buffer
	mov ecx, bytesRead
	call writeToFile
	.if eax <= 0
		call writeWindowsMsg
	.endif
	mov eax, newFileHandle
	call closeFile
	.if eax == 0
		call writeWindowsMsg
	.endif
	ret
writeBufferToFile ENDP

END main

	
