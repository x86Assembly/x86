; 3.10 Programming Exercises pg 94
; 3. Data Definitions

; This program defines 12 variables of
; different data types 

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data
v1 real4 - 1.3e+20;				          	2 ^ 4
v2 real8 2.2e-250;					          2 ^ 8
v3 real10 2.3e+3233;					        2 ^ 10
v4 byte 255;					  	            2 ^ 8
v5 sbyte - 22;						            2 ^ 8
v6 word 65535;						            2 ^ 16
v7 sword - 65535;					            2 ^ 16
v8 dword 123456789;					          2 ^ 32
v9 sdword - 123456789;					      2 ^ 32
v10 fword 123456789012345;				    2 ^ 48
v11 qword 12345678901234567890;				2 ^ 64
v12 tbyte 123456789012345678901234; 	2 ^ 80






.code
main proc
	
	

	invoke Exitprocess,0
main endp
end main
