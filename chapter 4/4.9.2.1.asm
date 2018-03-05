
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword
.data
three dd 12345678h
.code
main proc
	mov ax, word ptr three
	xchg ax, word ptr [three+2]
	mov word ptr three, ax
	mov eax, three

	main ENDP
	END main

h
