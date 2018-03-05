; encrypt

; 1. displayPurpose
; 1. getString, prompts user for string, returns to buffer
; 2. savetofile, recieves data offset in ebx, file name in edx
; 3. getFileName, returns filename in buffer
include Irvine32.inc
key = 239
bufmax = 128

.data
buffer byte bufmax+1 dup(0)
bufsize dword ?
keybuffer byte 0

.code
main proc
	l1:
	call displayPurpose
	call getString
	call getKey
	call translatebuffer
	call displaybuffer
	call crlf
	call getFileName
	call savetofile
	call crlf
	jmp l1
	exit
	ret
main ENDP

getString proc
	.data
	prompt byte "Enter string to encrypt: ", 0
	.code
	mov edx, offset prompt
	call writeString
	mov edx, offset buffer
	mov ecx, lengthof buffer
	call readString
	mov bufsize, eax
	ret
getString ENDP

translatebuffer proc
	mov edx, offset buffer
	mov ecx, bufsize
	mov esi, 0
	mov al, keybuffer
l1: xor buffer[esi], al
	inc esi
	loop l1
	ret 
translatebuffer ENDP

displaybuffer proc
	mov edx, offset buffer
	call writeString
	ret
displaybuffer ENDP

getKey proc
	.data
	prompt1 byte "Enter key: ", 0
	.code
	mov edx, offset prompt1
	call writeString
	call readDec
	mov keybuffer, al
	ret
getKey ENDP

savetofile proc ; rec filename in edx, rec data offset in ebx
	.data
	filehandle dword ?
	success byte "The encryption has been saved to the file, check where you opened this program.", 10, 13,
				 "Copy and paste the encrytion into this program with the key to display the message", 10, 13, 0
	.code
	mov edx, offset filename
	call createOutputFile
	mov filehandle, eax
	mov edx, offset buffer
	mov ecx, bufsize
	call writeToFile
	.if eax == 0
		call writeWindowsMsg
	.endif
	mov eax, filehandle
	call closeFile
	mov edx, offset success
	call writeString
	ret
savetofile ENDP

getFileName proc
	.data
	prompt3 byte "Enter filename: ", 0
	filename byte 21 dup(0)
	.code
	mov edx, offset prompt3
	call writeString
	mov edx, offset filename
	mov ecx, sizeof buffer
	call readString
	ret
getFileName ENDP

displayPurpose proc
	pushad
	.data
	disp byte 10, "This program encrypts a string using a key and saves it to a file.", 10, 10,  13, 0
	.code
	mov edx, offset disp
	call writeString
	popad
	ret
displayPurpose ENDP
	
END main
	
