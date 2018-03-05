;5.8.2.1
; exchange eax and ebx using the stack

include Irvine32.inc
.data
array dword 4 dup(0)
.code
main proc
	mov eax, 10
	mov ebx, 20
	push eax
	push ebx
	pop eax
	pop ebx
	exit
main ENDP


END main
