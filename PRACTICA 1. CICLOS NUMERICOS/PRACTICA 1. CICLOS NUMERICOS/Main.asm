INCLUDE Irvine32.inc

; Materia:     Lenguajes de Interfaz 
; Alumno:      Santiago Sicairos Angel Bulmaro
; Horario:     9:00 a 10 AM.
; Docente:     Dr. José Luis Medina Jiménez 
; Práctica:    1. Ciclos numéricos.
; Descripción: Programa que utiliza un ciclo de bucle (loop) para imprimir los números enteros del 20 al 1 en la consola.

.data
    ; No se requieren variables declaradas en datos
.code
main PROC
    mov ecx, 20   ; Inicializa el contador del bucle (ECX = 20)

ciclo: 
    mov eax, ecx  ; Copia el valor actual del contador a EAX para de esta manera imprimirlo

    call WriteDec ; Muestra el contenido de EAX como un entero decimal sin signo
    call Crlf     ; Imprime un salto de línea
    loop ciclo    ; Decrementa ECX en 1; si ECX != 0, salta a la etiqueta 'ciclo'

    exit          ; Termina la ejecución del programa y regresa el control al SO
    
main ENDP

END main
