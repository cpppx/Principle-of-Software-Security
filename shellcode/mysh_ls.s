section .text
  global _start
    _start:
      ; Store the argument string on stack
      xor  eax, eax 
      push eax          ; Use 0 to terminate the string
      push "//sh"
      push "/bin"

      push eax
      mov  ebx, "-c##"
      shl  ebx, 16
      shr  ebx, 16
      push ebx

      push eax
      push " -la"
      push "ls  "

      mov  ebx, esp     ; Get the string address

      ; Construct the argument array argv[]
      push eax          ; argv[3] = 0
      push ebx          ; argv[2] points "ls -la"
      lea ebx, [ebx+12]
      push ebx		; argv[1] points "-c"
      lea ebx, [ebx+8]
      push ebx		; argv[0] points "/bin//sh"
      mov  ecx, esp     ; Get the address of argv[]
   
      ; For environment variable 
      xor  edx, edx     ; No env variables 

      ; Invoke execve()
      xor  eax, eax     ; eax = 0x00000000
      mov   al, 0x0b    ; eax = 0x0000000b
      int 0x80
