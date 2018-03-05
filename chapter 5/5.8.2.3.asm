;5.8.2.3
; declaring local variables
; (even though you can use them in
; main)
include Irvine32.inc
.data
.code
main proc
	call getVariables
	call dumpmem
	mov eax, var1
	exit
main ENDP

getVariables proc
	.data
	var1 dword ?
	var2 dword ?
	.code
	mov var1, 1000h
	mov var2, 2000h
	mov esi, offset var1
	mov ebx, type var1
	mov ecx, 2

	ret
getVariables ENDP
END main
