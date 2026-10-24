INCLUDE Irvine32.inc

; Materia:     Lenguajes de Interfaz 
; Alumno:      Santiago Sicairos Angel Bulmaro
; Horario:     9:00 a 10:00 AM
; Docente:     Dr. José Luis Medina Jiménez 
; Práctica:    9. PUSH Y POP.
; Descripción: Programa que demuestra el uso de la pila (Stack) con las instrucciones PUSH y POP 
;              para resguardar valores, invertir registros y manejar el paso de ejecución con procedimientos (CALL y RET).

.data
.code
main PROC

    ; --- 1. Push y Pop ---
    mov eax, 40         ; Carga 40 en EAX
    push eax            ; Modifica ESP (-4) y mete 40 a la cima de la pila

    call DumpRegs       ; Muestra los registros/ESP tras el PUSH

    mov eax, 0          ; Limpia EAX
    pop ebx             ; Modifica ESP (+4) y saca el valor de la pila hacia EBX (EBX = 40)

    call DumpRegs       ; Muestra el resultado del POP

    ; --- 2. Comportamiento LIFO (Last In, First Out) ---
    mov eax, 10         ; Carga 10
    push eax            ; Mete 10 a la pila
    mov eax, 20         ; Carga 20
    push eax            ; Mete 20 a la pila
    mov eax, 30         ; Carga 30
    push eax            ; Mete 30 a la pila

    call DumpRegs       ; Muestra la pila cargada con 3 elementos

    pop eax             ; Saca el último ingresado (EAX = 30)
    pop ebx             ; Saca el siguiente (EBX = 20)
    pop ecx             ; Saca el primero (ECX = 10)

    call DumpRegs       ; Muestra registros tras vaciar la pila

    ; --- 3. Intercambio de valores entre registros usando la pila ---
    mov eax, 100        ; EAX = 100
    mov ebx, 200        ; EBX = 200

    push eax            ; Guarda 100 en la pila
    push ebx            ; Guarda 200 en la pila

    pop ebx             ; EBX recibe 200
    pop eax             ; EAX recibe 100

    call DumpRegs       ; Muestra el intercambio de datos

    ; --- 4. Llamada a procedimiento y la pila (CALL / RET) ---
    mov eax, 50         ; EAX = 50
    mov ebx, 100        ; EBX = 100

    call aumentarDiez   ; Empuja la dirección de retorno a la pila y salta a la subrutina

    call DumpRegs       ; Muestra el resultado tras volver de la subrutina (EAX = 60)

    exit                ; Termina el programa
main ENDP

; --- Procedimiento secundario ---
aumentarDiez PROC
    add eax, 10         ; Suma 10 a EAX
    ret                 ; Saca la dirección de retorno de la pila y regresa a main
aumentarDiez ENDP

END main
