INCLUDE Irvine32.inc

; Materia:     Lenguajes de Interfaz 
; Alumno:      Santiago Sicairos Angel Bulmaro
; Horario:     9:00 a 10:00 AM
; Docente:     Dr. José Luis Medina Jiménez 
; Práctica:    10. Obtención de una cadena decimal.
; Descripción: Programa que realiza cálculos aritméticos sobre descargas de datos y convierte los resultados numéricos 
;              a cadenas ASCII de texto mediante divisiones sucesivas entre 10 y la pila (LIFO) para imprimirlos en consola.

.data
    bytesDesc   DWORD ?          ; Guarda bytes descargados
    bytesPend   DWORD ?          ; Guarda bytes pendientes
    gruposComp  DWORD ?          ; Guarda bloques completos
    porcentaje  DWORD ?          ; Guarda el porcentaje procesado
    residuo     DWORD ?          ; Guarda el residuo sobrante
    bufferASCII BYTE 11 DUP(0)   ; Buffer para la cadena ASCII convertida

.code
main PROC
    ; --- 1. Cálculo de bytes descargados (125 * 512) ---
    mov eax, 125
    mov ebx, 512
    mul ebx
    mov bytesDesc, eax           ; bytesDesc = 64,000

    mov esi, OFFSET bufferASCII
    call convertirDecimal        ; Convierte EAX a texto ASCII
    mov edx, OFFSET bufferASCII
    call WriteString             ; Imprime "64000"
    call Crlf

    ; --- 2. Cálculo de bytes pendientes (100,000 - bytesDesc) ---
    mov eax, 100000
    sub eax, bytesDesc
    mov bytesPend, eax           ; bytesPend = 36,000

    mov eax, bytesPend
    mov esi, OFFSET bufferASCII
    call convertirDecimal
    mov edx, OFFSET bufferASCII
    call WriteString             ; Imprime "36000"
    call Crlf

    ; --- 3. Cálculo de porcentaje de avance ((bytesDesc * 100) / 100,000) ---
    mov eax, bytesDesc
    mov ebx, 100
    mul ebx
    mov ebx, 100000
    mov edx, 0
    div ebx
    mov porcentaje, eax          ; porcentaje = 64%

    mov esi, OFFSET bufferASCII
    call convertirDecimal
    mov edx, OFFSET bufferASCII
    call WriteString             ; Imprime "64"
    call Crlf

    ; --- 4. Cálculo de grupos completos (1024 bytes) y residuo ---
    mov eax, bytesDesc
    mov ebx, 1024
    mov edx, 0
    div ebx
    mov gruposComp, eax          ; gruposComp = 62
    mov residuo, edx             ; residuo = 512

    mov esi, OFFSET bufferASCII
    call convertirDecimal
    mov edx, OFFSET bufferASCII
    call WriteString             ; Imprime "62"
    call Crlf

    ; --- 5. Imprimir el residuo ---
    mov eax, residuo
    mov esi, OFFSET bufferASCII
    call convertirDecimal
    mov edx, OFFSET bufferASCII
    call WriteString             ; Imprime "512"
    call Crlf

    exit                         ; Termina el programa
main ENDP

; --- Procedimiento para convertir entero en EAX a cadena ASCII en [ESI] ---
convertirDecimal PROC
    mov ecx, 0                   ; Contador de dígitos
    mov ebx, 10                  ; Divisor constante (base 10)

convertirLoop:
    mov edx, 0                   ; Limpia parte alta para DIV
    div ebx                      ; EAX = Cociente, EDX = Residuo (dígito)
    push edx                     ; Empuja dígito hacía la pila
    inc ecx                      ; Incrementa el número de dígitos

    cmp eax, 0
    jne convertirLoop            ; Repite mientras el cociente sea > 0

cadenaLoop:
    pop edx                      ; Extrae los dígitos en orden inverso
    add dl, '0'                  ; Convierte valor numérico a carácter ASCII
    mov [esi], dl                ; Guarda en el buffer
    inc esi                      ; Avanza puntero del buffer
    loop cadenaLoop              ; Repite para todos los dígitos

    mov byte ptr [esi], 0        ; Agrega terminador nulo al final

    ret                          ; Regresa al llamador
convertirDecimal ENDP

END main