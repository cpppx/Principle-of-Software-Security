section .text
  global _start
    _start:
	BITS 32
	jmp short two
    one:
 	pop ebx
 	xor eax, eax
 
        ; Use 0 to terminate string
        mov [ebx+12], eax	; '/usr/bin/env'
        mov [ebx+20], eax	; 'a=11'
        mov [ebx+28], eax	; 'b=22'

        ; Construct the argument array argv[]
 	mov [ebx+32], ebx	; argv[0] points to '/usr/bin/env'
	mov [ebx+36], eax	; argv[1] = 0
	lea ecx, [ebx+32]	; Get the address of argv[]

	; For environment variable
	lea edx, [ebx+16]	; Get the address to 'a=11'
        mov [ebx+40], edx	; env[0] = address to 'a=11'
        lea edx, [ebx+24]	; Get the address to 'b=22'	
        mov [ebx+44], edx	; env[1] = address to 'b=22'
        mov [ebx+48], eax	; env[2] = 0
        lea edx, [ebx+40]	; Get the address of env[]

	; Invoke execve()
 	mov al,  0x0b
 	int 0x80
     two:
 	call one
 	db '/usr/bin/envAAAAa=11BBBBb=22CCCCDDDDEEEEFFFFGGGGHHHH'
