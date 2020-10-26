section .text
  global _start
    _start:
      ; Store the argument string on stack
      xor  eax, eax 
      push eax          ; Use 0 to terminate the string
      push "/env"
      push "/bin"
      push "/usr"
      mov  ebx, esp     ; Get the string address

      ; Construct the argument array argv[]
      push eax          ; argv[1] = 0
      push ebx          ; argv[0] points "/usr/bin/env"
      mov  ecx, esp     ; Get the address of argv[]
   
      ; For environment variable 
      push eax
      push "1234"
      push "aaa="

      push eax
      push "5678"
      push "bbb="

      mov  edx, "4###"
      shl  edx, 24
      shr  edx, 24
      push edx
      push "=123"
      push "cccc"   

      mov  edx, esp
      push eax
      push edx
      lea  edx, [edx+12]
      push edx
      lea  edx, [edx+12]
      push edx
      mov  edx, esp 

      ; Invoke execve()
      xor  eax, eax     ; eax = 0x00000000
      mov   al, 0x0b    ; eax = 0x0000000b
      int 0x80
