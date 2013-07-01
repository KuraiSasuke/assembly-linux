section .data
	M dd 16,4,17,7,5,25,6,12,14,15,28,6,14,19,19,15,9,15,13,14,6,22,25,9,23
	n equ 5

	vero db "vero",10
	v_len equ ($-vero)

	falso db "falso",10
	f_len equ ($-falso)

section .bss
	s_diag_pr resd 1
	s_diag_npr resd 1
	
section .text
	global _start:
	extern somma_diagonale
	extern write_int
	
_start:	
	; si calcola la somma della diag. principale

	xor eax, eax		; somma della diagonale
	mov edx, n
	imul edx, edx		; num elementi matrice
	xor esi, esi		; indice

ciclo:
	cmp esi, edx
	jge fine_ciclo

	add eax, [M + esi*4]
	
	add esi, n
	inc esi
	jmp ciclo

fine_ciclo:
	; si sommano gli elementi sopra e sotto la diag. principale
	sub esp, 4
	push dword n
	push dword M
	call somma_diagonale
	pop ebx
	
verifica:
	; si verifica quale somma sia maggiore
	mov [s_diag_pr], eax
	mov [s_diag_npr], ebx
	cmp eax, ebx
	jg stampa_vero

stampa_falso:
	mov edx, f_len
	mov ecx, falso
	mov ebx, 1
	mov eax, 4
	int 80h
	jmp debug

stampa_vero:
	mov edx, v_len
	mov ecx, vero
	mov ebx, 1
	mov eax, 4
	int 80h

debug:
	push dword [s_diag_pr]
	call write_int
	push dword [s_diag_npr]
	call write_int

exit:
	mov ebx, 0
	mov eax, 1
	int 80h