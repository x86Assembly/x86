; 3.10 Programming Exercises pg 94

; 2. Symbolic Integer Constants



; This program creates an array of days of the week using

; symbolic constants



.386

.model flat,stdcall

.stack 4096

ExitProcess proto,dwExitCode:dword



.data

s equ <"Sunday">

m equ <"Monday">

tu equ <"Tuesday">

w equ <"Wednesday">

th equ <"Thursday">

f equ <"Friday">

sa equ <"Saturday">



DaysArray byte s, m, tu, w, th, f, sa



.code

main proc

	

	



	invoke Exitprocess,0

main endp

end main
