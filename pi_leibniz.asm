; SECTION .data
;     message1: db "Enter the first number: ", 0
;     message2: db "Enter the second number: ", 0
;     formatin: db "%d", 0
;     formatout: db "%d", 10, 0 ; newline, nul terminator
;     integer1: times 4 db 0 ; 32-bits integer = 4 bytes
;     integer2: times 4 db 0 ;
; SECTION .text
;    global _main 
;    extern _scanf 
;    extern _printf     

; _main:

;    push ebx ; save registers
;    push ecx
;    push message1
;    call printf

;    add esp, 4 ; remove parameters
;    push integer1 ; address of integer1 (second parameter)
;    push formatin ; arguments are right to left (first parameter)
;    call scanf

;    add esp, 8 ; remove parameters
;    push message2
;    call printf

;    add esp, 4 ; remove parameters
;    push integer2 ; address of integer2
;    push formatin ; arguments are right to left
;    call scanf

;    add esp, 8 ; remove parameters

;    mov ebx, dword [integer1]
;    mov ecx, dword [integer2]
;    add ebx, ecx ; add the values          ; the addition
;    push ebx
;    push formatout
;    call printf                            ; call printf to display the sum
;    add esp, 8                             ; remove parameters
;    pop ecx
;    pop ebx ; restore registers in reverse order
;    mov eax, 0 ; no error
;    ret
; Which is the asm version of this C function:

; #include <stdio.h>
; int main(int argc, char *argv[])
; {
;     int integer1, integer2;
;     printf("Enter the first number: ");
;     scanf("%d", &integer1);
;     printf("Enter the second number: ");
;     scanf("%d", &integer2);
;     printf("%d\n", integer1+integer2);
;     return 0;
; }

section .data
n: times 4 dw 0

string: db 'Number: %d.', 10, 0
str_scanf: db '%d', 0

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

	push dword[n]
	push string
	call printf
	add esp, 4

jmp end


end:
mov eax, 1	;exit
 mov ebx, 0	;error code
 int 80h