INCLUDE Irvine32.inc

; Materia:     Lenguajes de Interfaz 
; Alumno:      Santiago Sicairos Angel Bulmaro
; Horario:     9:00 a 10:00 AM
; Docente:     Dr. José Luis Medina Jiménez 
; Práctica:    11. Operaciones lógicas.
; Descripción: Programa que manipula el registro de estado de un equipo utilizando operaciones lógicas 
;              a nivel de bits (AND, OR, XOR y TEST) para evaluar, encender, alternar y probar banderas de control de hardware.

.data
    alarmaEncencida BYTE "Alarma encendida", 0
    alarmaApagada   BYTE "Alarma apagada", 0

    ; Mapa de bits de estado:
    ; Bit 0: Computadora encendida (1) / apagada (0)
    ; Bit 1: Alarma encendida (1) / apagada (0)
    ; Bit 2: Conectada a internet (1) / desconectada (0)
    ; Estado inicial: 0000 0101b

.code
main PROC

    ; --- 1. Operación AND: Aislar bit de la alarma ---
    mov eax, 0            ; Limpia EAX
    mov al, 00000101b     ; Carga estado inicial en AL
    and al, 00000010b     ; Aplica mascara AND para aislar el bit 1

    call WriteBin         ; Muestra el resultado en binario
    call Crlf

    ; --- 2. Operación OR: Encender la alarma ---
    mov eax, 0            ; Limpia EAX
    mov al, 00000101b     ; Carga el estado inicial
    or al, 00000010b      ; Fuerza a 1 el bit 1 (activa alarma)

    call WriteBin         ; Muestra el nuevo estado en binario
    call Crlf

    ; --- 3. Operación XOR: Invertir estado de la computadora ---
    mov eax, 0            ; Limpia EAX
    mov al, 00000101b     ; Carga estado inicial
    xor al, 00000001b     ; Alterna el bit 0 (si es 1 pasa a 0, si es 0 pasa a 1)

    call WriteBin         ; Muestra resultado en binario
    call Crlf

    ; --- 4. Operación TEST: Evaluar bit sin modificar el registro ---
    mov eax, 0            ; Limpia EAX
    mov al, 00000111b     ; Estado con alarma activa (bit 1 = 1)

    test al, 00000010b    ; Ejecuta AND interno para actualizar Zero Flag (ZF)
    jz apagarAlarma       ; Salta si el resultado es 0 (ZF = 1)

    mov edx, OFFSET alarmaEncencida
    call WriteString      ; Imprime "Alarma encendida"
    call Crlf
    jmp fin

apagarAlarma:
    mov edx, OFFSET alarmaApagada
    call WriteString      ; Imprime "Alarma apagada"
    call Crlf

fin:
    exit                  ; Termina el programa
main ENDP

END main