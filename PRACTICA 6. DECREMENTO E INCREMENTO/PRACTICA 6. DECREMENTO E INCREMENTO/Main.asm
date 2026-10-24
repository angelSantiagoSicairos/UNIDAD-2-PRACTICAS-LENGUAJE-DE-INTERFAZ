INCLUDE Irvine32.inc

; Materia:     Lenguajes de Interfaz 
; Alumno:      Santiago Sicairos Angel Bulmaro
; Horario:     9:00 a 10:00 AM
; Docente:     Dr. José Luis Medina Jiménez 
; Práctica:    6. Decremento e incremento.
; Descripción: Programa que solicita un número entero al usuario y demuestra el uso de las 
;              instrucciones INC y DEC para incrementar y decrementar dicho valor en una unidad, respectivamente.

.data
    msg        BYTE "Escribe un numero: ", 0
    incremento BYTE "Incremento: ", 0
    decremento BYTE "Decremento: ", 0

.code
main PROC

    ; --- Lectura del número inicial ---
    mov edx, OFFSET msg 
    call WriteString   ; Muestra "Escribe un numero: "
    call ReadInt       ; Lee el valor ingresado por el usuario y lo almacena en EAX correspondientemente
    mov ebx, eax       ; Respalda el valor original en EBX para usarlo posteriormente

    ; --- Operación de Incremento ---
    mov edx, OFFSET incremento 
    call WriteString   ; Se encarga de mostrar "Incremento: "
    inc eax            ; Suma 1 a EAX (EAX = EAX + 1) sin alterar la bandera CF (Carry Flag)
    call WriteInt      ; Imprime el valor incrementado con signo
    call Crlf          ; Da un salto de línea

    ; --- Restauración del valor original ---
    mov eax, ebx       ; Restaura el valor original desde EBX hacia EAX

    ; --- Operación de Decremento ---
    mov edx, OFFSET decremento 
    call WriteString   ; Se encarga de mostrar "Decremento: "
    dec eax            ; Resta 1 a EAX (EAX = EAX - 1) sin alterar la bandera CF (Carry Flag)
    call WriteInt      ; Imprime el valor decrementado con signo
    call Crlf          ; Da un salto de línea

    exit               ; Termina la ejecución del programa y regresa el control al SO
main ENDP

END main