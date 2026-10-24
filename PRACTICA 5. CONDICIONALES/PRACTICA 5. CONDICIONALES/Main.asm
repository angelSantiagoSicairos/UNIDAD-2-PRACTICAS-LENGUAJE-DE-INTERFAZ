INCLUDE Irvine32.inc

; Materia:     Lenguajes de Interfaz 
; Alumno:      Santiago Sicairos Angel Bulmaro
; Horario:     9:00 a 10:00 AM
; Docente:     Dr. José Luis Medina Jiménez 
; Práctica:    5. Condicionales.
; Descripción: Programa que demuestra la implementación de estructuras de control condicionales tipo 
;              While y Do-While en ensamblador para imprimir una secuencia numérica del 1 al 100.

.data
    ; No se requieren variables declaradas

.code
main PROC

    ; =======================================================
    ; --- ESTRUCTURA WHILE (Evalúa la condición al inicio) ---
    ; =======================================================
    mov ebx, 1             ; Inicializa el contador EBX en 1

cicloWhile:
    cmp ebx, 100           ; Compara el contador con el límite que es 100
    jg fin                 ; Si EBX > 100 (condición de salida), rompe el ciclo y salta a 'fin'

    mov eax, ebx           ; Copia el valor actual del contador a EAX
    call WriteDec          ; Imprime el entero decimal en pantalla
    call Crlf              ; Imprime un salto de línea

    inc ebx                ; Incrementa el contador en 1 (EBX = EBX + 1) sin alterar la bandera CF
    jmp cicloWhile         ; Vuelve al inicio del ciclo para evaluar la condición nuevamente

fin:
    call Crlf              ; Salto de línea de separación entre ciclos
    mov ebx, 1             ; Reinicia el contador EBX en 1 para la siguiente estructura

    ; ==========================================================
    ; --- ESTRUCTURA DO-WHILE (Evalúa la condición al final) ---
    ; ==========================================================
cicloDoWhile:

    mov eax, ebx           ; Copia el valor actual a EAX
    call WriteDec          ; Imprime el valor
    call Crlf              ; Imprime un salto de línea

    inc ebx                ; Incrementa el contador en 1
    cmp ebx, 100           ; Compara el nuevo valor de EBX con 100

    jle cicloDoWhile       ; Si EBX <= 100, vuelve a repetir el cuerpo del ciclo

    exit                   ; Termina la ejecución del programa y regresa el control al SO
main ENDP

END main