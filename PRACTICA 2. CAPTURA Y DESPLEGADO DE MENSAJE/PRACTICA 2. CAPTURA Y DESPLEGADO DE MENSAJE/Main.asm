INCLUDE Irvine32.inc

; Materia:     Lenguajes de Interfaz 
; Alumno:      Santiago Sicairos Angel Bulmaro
; Horario:     9:00 a 10:00 AM
; Docente:     Dr. José Luis Medina Jiménez 
; Práctica:    2. Captura y desplegado de mensajes.
; Descripción: Programa que solicita al usuario ingresar su nombre por consola utilizando 
;              ReadString y posteriormente lo despliega en pantalla mediante WriteString.

.data
    mensaje BYTE "Escribe tu nombre: ", 0    ; Cadena de texto para la petición, terminada en nulo (0)
    nombre  BYTE 30 DUP(0)                   ; Arreglo de 30 bytes inicializados en 0 para almacenar el nombre 

.code
main PROC

    ; --- Mostrar el mensaje de petición ---
    mov edx, OFFSET mensaje     ; Carga en EDX la dirección de memoria del mensaje a mostrar
    call WriteString            ; Muestra en consola la cadena señalada por EDX

    ; --- Capturar el texto desde el teclado ---
    mov edx, OFFSET nombre      ; EDX apunta al buffer 'nombre' donde se guardarán los caracteres
    mov ecx, SIZEOF nombre      ; ECX establece el límite máximo de lectura (30 bytes)
    call ReadString             ; Lee la cadena introducida por el usuario y le agrega un nulo al final

    ; --- Desplegar el nombre ingresado ---
    mov edx, OFFSET nombre      ; EDX apunta nuevamente a la dirección de memoria de 'nombre'
    call WriteString            ; Imprime la cadena almacenada en el buffer 'nombre'
    call Crlf                   ; Imprime un salto de línea en consola

    exit                        ; Termina la ejecución del programa y regresa el control al SO

main ENDP

END main