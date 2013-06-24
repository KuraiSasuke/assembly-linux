section .data
	add1 dw 5
	add2 dw 7

section .text
	global _start
	extern write_int

_start:
	xor ax, ax		; risultato della somma
	sub esp, 2
	push add1
	push add2
	call somma
	pop ax

stampa_risultato:
	push ax
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

	mov ax, [ebp]		; primo operando
	mov bx, [ebp + 2]	; secondo operando

	add ax, bx

	mov [ebp+4], ax

	popad
	pop ebp
	ret 4