INCLUDE Irvine32.inc

; Materia:     Lenguajes de Interfaz 
; Alumno:      Santiago Sicairos Angel Bulmaro
; Horario:     9:00 a 10:00 AM
; Docente:     Dr. José Luis Medina Jiménez 
; Práctica:    5.1. Repetir hasta que el usuario ingrese cero.
; Descripción: Programa que implementa un ciclo interactivo que solicita repetidamente números al usuario mediante ReadInt 
;              hasta que se ingresa el valor 0, momento en el cual el programa muestra un mensaje de finalización y termina.

.data
    numero          BYTE "Escribe un numero: ", 0
    mensajeIntentar BYTE "Ingrese nuevamente un numero", 0
    mensajeCero     BYTE "Programa terminado, se ingreso el 0", 0

.code

main PROC

ciclo:
    ; --- Mostrar mensaje de solicitud ---
    mov edx, OFFSET numero 
    call Crlf             ; Imprime un salto de línea
    call WriteString      ; Muestra "Escribe un numero: "

    ; --- Lectura de datos ---
    call ReadInt          ; Lee el entero ingresado por consola y lo almacena en EAX

    ; --- Evaluación de la condición de salida ---
    cmp eax, 0            ; Compara la entrada del usuario (EAX) con el número 0
    je fin                ; Si EAX == 0 (ZF = 1), salta a la etiqueta 'fin' para terminar

    ; --- Procesamiento solo si el número es distinto de cero ---
    mov edx, OFFSET mensajeIntentar 
    call Crlf 
    call WriteString      ; Informa que debe ingresar otro número

    jmp ciclo             ; Salto incondicional al inicio del ciclo para volver a pedir una entrada

fin:
    ; --- Finalización del programa ---
    mov edx, OFFSET mensajeCero 
    call Crlf 
    call WriteString      ; Imprime el mensaje de terminación
    call Crlf

    exit                  ; Termina la ejecución del programa y regresa el control al SO
main ENDP

END main