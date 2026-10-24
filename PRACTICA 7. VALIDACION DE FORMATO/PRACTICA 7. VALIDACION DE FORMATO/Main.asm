INCLUDE Irvine32.inc

; Materia:     Lenguajes de Interfaz 
; Alumno:      Santiago Sicairos Angel Bulmaro
; Horario:     9:00 a 10:00 AM
; Docente:     Dr. José Luis Medina Jiménez 
; Práctica:    7. Validación de formato.
; Descripción: Programa que valida si una cadena ingresada por el usuario cumple estrictamente con 
;              el formato "LLL-NNN" (3 letras mayúsculas, un guion y 3 dígitos numéricos) evaluando longitud y rangos de código ASCII.

.data
    cadena      BYTE "Escribe una cadena (ejemplo TEC-123): ", 0
    msgValido   BYTE "Cadena valida", 0
    msgInvalido BYTE "Cadena invalida", 0
    MAX = 20                           ; Constante para definir el tamaño máximo de lectura
    stringIn    BYTE MAX+1 DUP(?)      ; Buffer para la cadena (+1 byte para el terminador nulo)

.code
main PROC
    ; --- Solicitar y capturar la cadena ---
    mov edx, OFFSET cadena 
    call WriteString 

    mov edx, OFFSET stringIn 
    mov ecx, MAX 
    call ReadString                   ; EAX retorna la cantidad exacta de caracteres ingresados

    ; --- Validación 1: Verificamos longitud exacta de 7 caracteres ---
    cmp eax, 7 
    jne cadenaInvalida                ; Si la longitud != 7, rechaza la cadena inmediatamente

    ; --- Validación 2: Verificamos que los primeros 3 caracteres sean letras mayúsculas ('A'-'Z') ---
    mov esi, 0                        ; ESI actúa como índice inicial de la cadena
    mov ecx, 3                        ; Contador de bucle para evaluar los 3 caracteres

validarLetras:
    mov al, stringIn[esi]             ; Lee el carácter en la posición actual
    cmp al, 'A' 
    jl cadenaInvalida                 ; Si ASCII < 'A', es inválida

    cmp al, 'Z' 
    jg cadenaInvalida                 ; Si ASCII > 'Z', es inválida

    inc esi                           ; Avanza al siguiente carácter
    loop validarLetras                ; Decrementa ECX y repite mientras ECX != 0

    ; --- Validación 3: Verificamos el carácter separador ('-') en la posición 4 (índice 3) ---
    mov al, stringIn[3] 
    cmp al, '-' 
    jne cadenaInvalida                ; Si el cuarto carácter != '-', rechaza la cadena

    ; --- Validación 4: Para finalizar verificamos que los últimos 3 caracteres sean dígitos ('0'-'9') ---
    mov esi, 4                        ; Índice inicial para el bloque numérico
    mov ecx, 3                        ; Contador de bucle para evaluar 3 dígitos

validarNumeros:
    mov al, stringIn[esi]             ; Lee el carácter en la posición actual

    cmp al, '0' 
    jb cadenaInvalida                 ; Si ASCII < '0' (sin signo), es inválida

    cmp al, '9' 
    ja cadenaInvalida                 ; Si ASCII > '9' (sin signo), es inválida

    inc esi                           ; Avanza al siguiente carácter
    loop validarNumeros               ; Decrementa ECX y repite

    jmp cadenaValida                  ; Si superó todas las pruebas, la cadena es válida

cadenaValida:
    mov edx, OFFSET msgValido 
    call WriteString 
    jmp fin 

cadenaInvalida:
    mov edx, OFFSET msgInvalido 
    call WriteString 

fin:
    call Crlf 
    exit                              ; Termina la ejecución del programa y regresa el control al SO
main ENDP

END main