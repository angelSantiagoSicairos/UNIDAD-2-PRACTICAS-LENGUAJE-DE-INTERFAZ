INCLUDE Irvine32.inc

; Materia:     Lenguajes de Interfaz 
; Alumno:      Santiago Sicairos Angel Bulmaro
; Horario:     9:00 a 10:00 AM
; Docente:     Dr. José Luis Medina Jiménez 
; Práctica:    8. Operaciones aritméticas.
; Descripción: Programa que demuestra el uso de operaciones aritméticas básicas (ADD, SUB, MUL,
;              IMUL, DIV e IDIV) e instruccione de extensión como CDQ en lenguaje ensamblador x86.

.data
.code

main PROC

    ; --- Suma y Resta Básica ---
    mov eax, 60         ; EAX = 60
    mov ebx, 24         ; EBX = 24
    add eax, ebx        ; EAX = EAX + EBX (84)
    sub eax, 15         ; EAX = EAX - 15 (69)
    nop                 ; Punto de depuración

    ; --- Aritmética de 8 bits y desbordamiento (CF) ---
    mov eax, 12         ; Limpia EAX
    mov al, 253         ; AL = 253
    add al, 4           ; AL = 1 (Afecta CF por acarreo de byte)
    nop

    ; --- Aritmética con signo (OF) ---
    mov eax, 0          ; Limpia EAX
    mov al, 127         ; AL = 127 (Límite positivo de 8 bits)
    add al, 1           ; AL = -128 (Afecta OF por desbordamiento de signo)
    nop

    ; --- Multiplicación Sin Signo (MUL) ---
    mov eax, 25         ; Multiplicando en EAX
    mov ebx, 5          ; Multiplicador
    mul ebx             ; EAX = EAX * EBX (125)
    nop

    ; --- Multiplicación Con Signo (IMUL) ---
    mov eax, -7         ; EAX = -7
    imul eax, eax, 3    ; EAX = EAX * 3 (-21)
    nop

    ; --- Multiplicación de valores grandes ---
    mov eax, 94854      ; EAX = 94854
    mov ebx, 94854      ; EBX = 94854
    mul ebx             ; EDX:EAX = EAX * EBX (Resultado de 64 bits)
    nop

    ; --- División Sin Signo (DIV) ---
    mov eax, 130        ; Dividendo (parte baja)
    mov edx, 0          ; Dividendo (parte alta)
    mov ebx, 13         ; Divisor
    div ebx             ; EAX = Cociente (10), EDX = Residuo (0)
    nop

    ; --- División Con Signo (IDIV) ---
    mov eax, -130       ; Dividendo con signo
    cdq                 ; Extiende el signo de EAX a EDX:EAX
    mov ebx, 13         ; Divisor
    idiv ebx            ; EAX = Cociente (-10), EDX = Residuo (0)

    exit                ; Termina el programa
main ENDP

END main