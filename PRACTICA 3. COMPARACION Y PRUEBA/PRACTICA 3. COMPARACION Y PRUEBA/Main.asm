INCLUDE Irvine32.inc

; Materia:     Lenguajes de Interfaz 
; Alumno:      Santiago Sicairos Angel Bulmaro
; Horario:     9:00 a 10:00 AM
; Docente:     Dr. José Luis Medina Jiménez 
; Práctica:    3. Comparación y prueba
; Descripción: Programa que demuestra la comparación de valores usando la instrucción CMP y saltos 
;              condicionales (JE/JMP) para determinar e informar si dos números son iguales o diferentes.

.data
    msgIguales    BYTE "Los numeros son iguales", 0      ; Mensaje a mostrar si la comparación resulta en igualdad
    msgDiferentes BYTE "Los numeros son diferentes", 0   ; Mensaje a mostrar si los valores son distintos

.code
main PROC

    ; --- Carga de datos a comparar ---
    mov eax, 30                    ; Carga el valor 30 en el registro EAX
    mov ebx, 30                    ; Carga el valor 30 en el registro EBX

    ; --- Comparación lógica ---
    cmp eax, ebx                   ; Compara EAX con EBX internamente (resta EAX - EBX y actualiza la bandera ZF)

    ; --- Control de flujo condicional ---
    je iguales                     ; Si los valores son iguales (ZF = 1), salta a la etiqueta 'iguales'
    
    ; --- Bloque para cuando SON DIFERENTES ---
    mov edx, OFFSET msgDiferentes  ; Carga la dirección del mensaje de diferencia en EDX
    call WriteString               ; Imprime en pantalla que los números son diferentes
    jmp fin                        ; Salto incondicional a 'fin' para evitar ejecutar el bloque 'iguales'

iguales: 
    ; --- Bloque para cuando SON IGUALES ---
    mov edx, OFFSET msgIguales     ; Carga la dirección del mensaje de igualdad en EDX
    call WriteString               ; Imprime en pantalla : los dos números son iguales

fin: 
    exit                           ; Termina la ejecución del programa y regresa el control al SO

main ENDP

END main