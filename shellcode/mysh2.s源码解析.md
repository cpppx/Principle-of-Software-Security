# mysh2.s源码解析

```assembly
pop ebx           ; Get the string address
xor eax, eax      ; eax = 0x00000000
mov [ebx+7], al   ; replace character '*' to '\0' which can terminate the string

; Construct the argument array argv[]
mov [ebx+8], ebx  ; argv[0] points to the cmd string
mov [ebx+12], eax ; argv[1] = 0
lea ecx, [ebx+8]  ; Get the address of argv[]

; For environment variable
xor edx, edx      ; No env variable

; Invoke execve()
mov al,  0x0b     ; eax = 0x0000000b
int 0x80
```

