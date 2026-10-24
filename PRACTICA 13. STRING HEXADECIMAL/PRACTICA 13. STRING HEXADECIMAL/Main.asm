INCLUDE Irvine32.inc

; Materia:     Lenguajes de Interfaz 
; Alumno:      Santiago Sicairos Angel Bulmaro
; Horario:     9:00 a 10:00 AM
; Docente:     Dr. José Luis Medina Jiménez 
; Práctica:    13. Obtención de una cadena hexadecimal.
; Descripción: Programa que convierte un valor entero numérico de 32 bits a su representación en cadena ASCII 
;              exadecimal procesando sus nibbles (4 bits) de derecha a izquierda mediante máscaras (AND) y desplazamientos (SHR).

.data
    valorOriginal DWORD 12AB34CDh       ; Valor entero de 32 bits a convertir
    bufferHex     BYTE 9 DUP(0)         ; Buffer de 8 caracteres + terminador nulo (0)

.code
main PROC
    mov eax, 12AB34CDh                  ; Carga el valor a convertir en EAX
    mov ecx, 8                          ; Contador para procesar los 8 nibbles (4 bits c/u)
    mov esi, 7                          ; Índice inicial (escribe de derecha a izquierda en el buffer)

conv_loop:
    push eax                            ; Resguarda el valor original de EAX en la pila
    and eax, 0Fh                        ; Aísla únicamente los 4 bits menos significativos (nibble actual)
    
    cmp al, 9                           ; Compara el nibble con 9
    jbe es_num                          ; Si al <= 9, salta a la conversión numérica ('0'-'9')
    
    add al, 'A' - 10                    ; Convierte valores de 10 a 15 a su carácter ASCII ('A'-'F')
    jmp almacenar

es_num:
    add al, '0'                         ; Convierte valores de 0 a 9 a su carácter ASCII ('0'-'9')

almacenar:
    mov bufferHex[esi], al              ; Guarda el carácter ASCII en la posición del buffer

    pop eax                             ; Recupera el valor completo de EAX desde la pila
    shr eax, 4                          ; Desplaza 4 bits a la derecha para evaluar el siguiente nibble
    dec esi                             ; Retrocede una posición en el índice del buffer
    loop conv_loop                      ; Decrementa ECX y repite mientras ECX != 0

    ; --- Despliegue en consola ---
    mov edx, OFFSET bufferHex           ; EDX apunta a la cadena hexadecimal construida
    call WriteString                    ; Muestra la cadena en pantalla
    call Crlf                           ; Imprime un salto de línea

    exit                                ; Termina la ejecución del programa
main ENDP

END main