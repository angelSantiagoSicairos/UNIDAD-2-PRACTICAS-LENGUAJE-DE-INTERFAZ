INCLUDE Irvine32.inc

; Materia:     Lenguajes de Interfaz 
; Alumno:      Santiago Sicairos Angel Bulmaro
; Horario:     9:00 a 10:00 AM
; Docente:     Dr. José Luis Medina Jiménez 
; Práctica:    12. Desplazamiento y rotación.
; Descripción: Programa que demuestra el funcionamiento de las instrucciones de desplazamiento (SHL, SHR, SAR)
;              y rotación de bits (ROR, ROL, RCL, RCR) en registros de 8 bits utilizando el acarreo (CF).

.data

.code

main PROC
    ; --- Limpieza inicial de registros ---
    mov eax, 0
    mov ebx, 0
    mov ecx, 0
    mov edx, 0

    ; --- 1. SHL: Desplazamiento lógico a la izquierda (Multiplica por 2) ---
    mov al, 10000000b     ; AL = 10000000b (128)
    shl al, 1             ; Desplaza 1 bit a la izquierda; el bit 7 pasa a CF (AL = 00000000b)

    call DumpRegs
    call WriteBin
    call Crlf

    ; --- 2. SHR: Desplazamiento lógico a la derecha (Divide sin signo entre 2) ---
    mov al, 00001101b     ; AL = 00001101b (13)
    shr al, 1             ; Desplaza 1 bit a la derecha; el bit 0 pasa a CF (AL = 00000110b)

    call DumpRegs
    call WriteBin
    call Crlf

    ; --- 3. SAR: Desplazamiento aritmético a la derecha (Conserva bit de signo) ---
    mov al, -9            ; AL = -9 (11110111b)
    sar al, 1             ; Desplaza a la derecha replicando el bit de signo (AL = 11111011b = -5)

    call DumpRegs
    call WriteBin
    call Crlf

    ; --- 4. SHL con constante ---
    mov al, 00001111b     ; AL = 00001111b (15)
    shl al, 2             ; Desplaza 2 bits a la izquierda (AL = 00111100b = 60)

    call DumpRegs
    call WriteBin
    call Crlf

    ; --- 5. SHR utilizando el registro CL como contador ---
    mov al, 00010100b     ; AL = 00010100b (20)
    mov cl, 2             ; CL = 2 (Cantidad de desplazamientos)
    shr al, cl            ; Desplaza a la derecha tantas posiciones indica CL (AL = 00000101b = 5)

    call DumpRegs
    call WriteBin
    call Crlf

    ; --- 6. Instrucciones de Rotación ---

    ; ROR: Rotación circular a la derecha
    mov al, 10000001b     ; AL = 10000001b
    ror al, 1             ; Rota 1 bit a la derecha; bit 0 pasa a la posición 7 y a CF (AL = 11000000b)

    call DumpRegs
    call WriteBin
    call Crlf

    ; ROL: Rotación circular a la izquierda
    mov al, 10000001b     ; AL = 10000001b
    rol al, 1             ; Rota 1 bit a la izquierda; bit 7 pasa a la posición 0 y a CF (AL = 00000011b)

    call DumpRegs
    call WriteBin
    call Crlf

    ; RCL: Rotación a la izquierda a través del acarreo (CF)
    clc                   ; Limpia el bit de acarreo (CF = 0)
    mov al, 10000001b     ; AL = 10000001b
    rcl al, 1             ; Rota 9 bits a la izquierda incorporando CF (AL = 00000010b, CF = 1)

    call DumpRegs
    call WriteBin
    call Crlf

    ; RCR: Rotación a la derecha a través del acarreo (CF)
    clc                   ; Limpia el bit de acarreo (CF = 0)
    mov al, 10000001b     ; AL = 10000001b
    rcr al, 1             ; Rota 9 bits a la derecha incorporando CF (AL = 01000000b, CF = 1)

    call DumpRegs
    call WriteBin
    call Crlf

    exit                  ; Termina la ejecución del programa
main ENDP

END main