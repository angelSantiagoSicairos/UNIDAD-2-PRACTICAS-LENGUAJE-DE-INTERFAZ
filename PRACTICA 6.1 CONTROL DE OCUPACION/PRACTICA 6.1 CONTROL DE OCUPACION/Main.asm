INCLUDE Irvine32.inc

; Materia:     Lenguajes de Interfaz 
; Alumno:      Santiago Sicairos Angel Bulmaro
; Horario:     9:00 a 10:00 AM
; Docente:     Dr. José Luis Medina Jiménez 
; Práctica:    6.1. Control de ocupación de un estacionamiento.
; Descripción: Programa que simula el control de ocupación de un estacionamiento, reduciendo la cantidad de lugares 
;              disponibles con la instrucción DEC cada vez que ingresa un auto hasta que la capacidad llega a cero.

.data
    msg1        BYTE "Cantidad de espacios del estacionamiento: ", 0
    msg2        BYTE "Ingrese 1 para estacionar un auto: ", 0
    msg3        BYTE "Espacios disponibles: ", 0
    msg4        BYTE "Estacionamiento lleno, no se pueden estacionar mas autos", 0
    espacios   DWORD ?    ; Variable que guarda el total de lugares iniciales y actuales
    estacionar DWORD ?    ; Variable para almacenar la opción ingresada por el usuario

.code
main PROC
    ; --- Captura de la capacidad total del estacionamiento ---
    mov edx, OFFSET msg1 
    call WriteString 
    call ReadInt 
    mov espacios, eax      ; Guarda la capacidad inicial en la variable 'espacios'

ciclo:
    ; --- Evaluación de disponibilidad ---
    cmp espacios, 0        ; Compara la cantidad de lugares disponibles con 0
    je lleno               ; Si espacios == 0 (ZF = 1), salta a la etiqueta 'lleno'

    ; --- Menú interactivo de ingreso ---
    mov edx, OFFSET msg2 
    call WriteString 
    call ReadInt 
    mov estacionar, eax    ; Guarda la opción ingresada en 'estacionar'

    ; --- Validación de comando ---
    cmp estacionar, 1      ; Verifica si la opción ingresada fue el número 1
    jne ciclo              ; Si no es 1, reinicia el ciclo sin descontar lugares

    ; --- Actualización y el despliegue de espacios ---
    dec espacios           ; Decrementa en 1 la variable 'espacios' (ocupa ya un lugar)

    mov edx, OFFSET msg3 
    call WriteString 
    mov eax, espacios      ; Carga el total de espacios restantes en EAX para imprimirlo
    call WriteDec          ; Imprime los lugares disponibles como un entero sin signo
    call Crlf 

    jmp ciclo              ; Salto incondicional para procesar la siguiente entrada

lleno:
    ; --- Notificación para saber si el estacionamiento esta saturado ---
    mov edx, OFFSET msg4 
    call WriteString 
    call Crlf 

    exit                   ; Termina la ejecución del programa y regresa el control al SO

main ENDP
END main