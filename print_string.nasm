; Procedura per la stampa di una stringa
; il primo parametro è il puntatore alla stringa da stampare
; il secondo parametro è la lunghezza della stringa (a 32 bit)
; Il chiamante dovrà quindi effettuare le seguenti istruzioni:
;	push	s			; dove s è l'indirizzo della stringa
;	push	dword len	; dove len è la lunghezza della stringa
;	call	write_string

section .text

global write_string			; rende l'etichetta write_string disponibile all'esterno

write_string:
	push	EBP
	mov		EBP, ESP
	add		EBP, 8
	
	push	EAX
	push	EBX
	push	ECX
	push	EDX
	
	mov		EDX, [EBP]		; lunghezza della stringa da stampare
	mov		ECX, [EBP+4]	; puntatore alla stringa da stampare
	mov		EBX, 1			; stampa a video
	mov		EAX, 4			; codice del comando di stampa
	int		80h				; interrupt 80 hex, call kernel

	pop		EDX
	pop		ECX
	pop		EBX
	pop		EAX

	pop		EBP
	ret		8
