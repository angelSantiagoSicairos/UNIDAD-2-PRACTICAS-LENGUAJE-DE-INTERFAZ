INCLUDE Irvine32.inc

; Materia:     Lenguajes de Interfaz 
; Alumno:      Santiago Sicairos Angel Bulmaro
; Horario:     9:00 a 10:00 AM
; Docente:     Dr. José Luis Medina Jiménez 
; Práctica:    4. Saltos.
; Descripción: Programa que demuestra el uso de saltos incondicionales (JMP) para modificar el flujo de ejecución, 
;              omitiendo la modificación de un registro y mostrando el estado final de los registros con DumpRegs.

.data
    ; No se requieren variables declaradas

.code
main PROC
    mov eax, 5           ; Carga el valor 5 en el registro EAX

    jmp continuar        ; Da un salto incondicional a la etiqueta 'continuar' (saltando la siguiente instrucción)
    mov eax, 10          ; Esta instrucción NUNCA se ejecuta debido al JMP

continuar: 
    call DumpRegs        ; Muestra en consola el contenido actual de todos los registros de la CPU (EAX mantendrá el valor 5)
    exit                 ; Termina la ejecución del programa y regresa el control al SO
main ENDP

END main