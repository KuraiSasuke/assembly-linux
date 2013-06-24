; test della procedura "write_string"

section .data		; sezione dati
	msg		db	"hello world",`\n` 
	len		equ $-msg

	n		dd	-5410

section .text						; sezione codice
	global _start					; rende l'etichetta _start disponibile al linker (identificando il "main")
	extern write_string, write_int	; lista delle procedure esterne che verranno utilizzate

_start:
	push	msg				; puntatore alla stringa da stampare
	push	dword len		; lunghezza della stringa da stampare
	call	write_string

	push	dword [n]
	call	write_int

	push	dword 0
	call	write_int

	push	dword 2314
	call	write_int

exit:
	mov	ebx,0		; codice di uscita, 0 = normale
	mov	eax,1		; codice del comando di "uscita"
	int	80h			; interrupt 80 hex, call kernel
