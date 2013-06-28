section .data
	M dd 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
	n equ 4

section .text
	global _start
	extern write_int

_start:
	xor edi, edi		; indice colonna
	xor ebx, ebx		; righe da saltare
	lea eax, [n*n*4]	; dimensione matrice
	
ext_loop:
	cmp ebx, eax
	jz end_ext_loop
	
	xor edi, edi
	
int_loop:
	cmp edi, n
	jz end_int_loop

	mov ecx, [M + ebx + edi*4]

	push ecx
	call write_int

	inc edi
	jmp int_loop

end_int_loop:
	lea ebx, [ebx + n*4]
	jmp ext_loop

end_ext_loop:
	mov ebx, 0
	mov eax, 1
	int 80h