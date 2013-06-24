; Procedura per la stampa di un intero (positivo o negativo) n passato come parametro
; Il chiamante dovrà effettuare le seguenti istruzioni:
;	push	n			; dove n è l'intero da stampare
;	call	write_int

section .bss
	; è necessario costruire in memoria una stringa contenente la rappresentaione in ASCII del numero
	; un intero è composto da al più 10 cifre, cui si aggiunge l'eventuale segno "-" e il carattere "\n"
	; quindi la string sarà al più composta da 12 caratteri
	num:	resb	12

section .text
	global write_int		; rende l'etichetta write_int disponibile all'esterno

write_int:

	push	EBP
	mov		EBP, ESP
	add		EBP, 8
	
	pushad
	
	mov		EAX, [EBP]			; numero da stampare
	mov		EDI, 0				; indice della cifra corrente
	mov		ESI, 10				; divisore per le conversioni

	cmp		EAX, 0
	je		zero				; se il numero è pari a 0, salta la fase di conversione
	jg		convert
	neg		EAX					; se il numero è negativo, inverte il segno

convert:
	cmp		EAX, 0
	je		end_conversion
	mov		EDX, 0
	div		ESI					; quoziente in EAX, resto in EDX
	add		EDX, 48				; EDX contiene ora il carattere ASCII della cifra
	mov		[num + EDI], DL
	inc		EDI
	jmp		convert


end_conversion:
	; stampa la stringa che rappresenta il numero
	; se il numero è negativo inserisce il segno "-" davanti
	cmp		[EBP], dword 0
	jge		positive
	mov		[num+EDI], byte '-'
	inc		EDI

positive:
	; inverte la stringa, in quanto è stata costruita a partire dalla cifra meno significativa
	; in particolare, scambia il carattere in posizione ESI, con quello in posizione EDI
	mov		EBX, EDI
	shr		EBX, 1				; EBX contiene la lunghezza di metà della stringa
	mov		ESI, 0

invert:
	cmp		ESI, EBX
	je		write
	mov		AH, [num + ESI]
	mov		AL, [num + EDI - 1]
	mov		[num+ESI], AL
	mov		[num+EDI-1], AH
	inc		ESI
	dec		EDI
	jmp		invert

zero:
	mov		[num], byte 48		; viene caricato il carattere ASCII corrispondente a 0
	mov		ESI, 1				; la lunghezza del numero da stampare è 1

write:
	add		EDI, ESI
	; aggiunge il carattere per il ritorno a capo
	mov		[num + EDI], byte `\n`
	inc		EDI

	mov		EDX, EDI			; lunghezza della stringa da stampare
	mov		ECX, num			; puntatore alla stringa da stampare
	mov		EBX, 1				; stampa a video
	mov		EAX, 4				; codice del comando di stampa
	int		80h					; interrupt 80 hex, call kernel
	
	popad

	pop		EBP
	
	ret		4

