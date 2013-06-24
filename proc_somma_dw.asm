section .data
	add1 dd 5
	add2 dd 7

section .text
	global _start
	extern write_int
	
_start:
	sub esp, 4
	push add1
	push add2
	call somma
	pop eax

	push eax
	call write_int

exit:
	mov ebx, 0
	mov eax, 1
	int 80h

somma:
	push ebp
	mov ebp, esp
	add ebp, 8
	pushad

	mov eax, [ebp]		; primo addendo
	mov ebx, [ebp+4]	; secondo addendo

	add eax, ebx

	mov [ebp+8], eax
	popad
	pop ebp
	ret 8