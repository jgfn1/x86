section .data
n: times 4 db 0
numerator: times 4 db 0
denominator: times 4 db 0
i:	times 4 db 0
signal: dd 1
pi: dq 0
two: dd 2
four: dd 4
zero: dd 0
teste: dq 0
aux: dd 0

string: db 'Pi: %.20f.', 10, 0
str_scanf: db ' %d', 0
str_scanf1: db ' %d', 10, 0

section .text
extern printf, scanf
global main

main:
	xor eax, eax
	mov ebx, eax

	push n
	push str_scanf
	call scanf 
	add esp, 6

	mov ecx, dword[n]
	mov dword[i], ecx
	
	leibniz_is_awesome:

		mov dword[signal], 1;resets the signal
		mov ecx, dword[i]

		fild dword[two]		;st0 = 2
		fild dword[i]
		fprem
		fst dword[teste]
		mov eax, dword[teste]
		cmp eax, 0			;checks if i is even
		
		fstp dword[teste]
		fstp dword[teste]
		
		je positive 		;if it's odd, the partial
							;sum will be negative

		mov dword[signal], -1
		positive: 
			fild dword[two]	;st0 = 2
			fild dword[i] 	;st0 = i, st1 = 2
			fmul st0, st1	;st0 = 2 * i
			fld1 			
			fadd st0, st1 	;st0 = 2 * i + 1
			fld1
			fdiv st0, st1	;st0 = 1 / (2 * i + 1)
			fild dword[signal]
			fmul st0, st1	;st0 = unsigned_result * signal
			fld qword[pi]
			fadd st0, st1	;pi(st0) = pi + result
			fstp qword[pi] 	;stores the updated pi value
			fstp dword[teste]
			fstp dword[teste]
			fstp dword[teste]
			fstp dword[teste]
			fstp dword[teste]
			fstp dword[teste]
			fstp dword[teste]

			mov ecx, dword[i]
			add ecx, -1
			mov dword[i], ecx
	cmp ecx, -1
	jne leibniz_is_awesome

	fld qword[pi]
	fild dword[four]
	fmul st0, st1 			;st0 = (pi/4) * 4
	fst qword[pi] 			;stores the final pi value
	
	push dword[pi+4]
	push dword[pi]
	push string
	call printf
	add esp, 12

jmp end

end:
mov eax, 1	;exit
 mov ebx, 0	;error code
 int 80h
