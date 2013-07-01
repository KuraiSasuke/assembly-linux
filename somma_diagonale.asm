; somma_diagonale è una procedura che somma gli elementi che stanno sopra e sotto la diagonale principale di una matrice quadrata NxN di dword.
; La procedura deve essere invocata così:
; sub esp, 4
; push dword n	; numero righe/colonne
; push dword M	; matrice
; call somma_diagonale
; pop (somma)	; restituisce la somma
	
section .text
	global somma_diagonale
	
somma_diagonale:	
	push ebp
	mov ebp, esp
	add ebp, 8
	pushad

	mov eax, [ebp]		; matrice
	mov ebx, [ebp+4]	; numero righe/colonne

	xor ecx, ecx		; somma
	mov edx, ebx
	imul edx, edx		; numero elementi matrice
	xor esi, esi		; indice
	
	; vengono sommati gli elementi sopra la diagonale
	mov esi, 1		; potrebbe essere 1?
	
somma_sopra:
	cmp esi, edx
	jge fine_somma_sopra

	add ecx, [eax + esi*4]
	
	add esi, ebx
	inc esi
	jmp somma_sopra

fine_somma_sopra:
	; vengono sommati gli elemento sotto la diagonale
	mov esi, ebx

somma_sotto:
	cmp esi, edx
	jge fine_somma_sotto

	add ecx, [eax + esi*4]

	add esi, ebx
	inc esi
	jmp somma_sotto

fine_somma_sotto:
	mov [ebp+8], ecx
	popad
	pop ebp
	ret 8