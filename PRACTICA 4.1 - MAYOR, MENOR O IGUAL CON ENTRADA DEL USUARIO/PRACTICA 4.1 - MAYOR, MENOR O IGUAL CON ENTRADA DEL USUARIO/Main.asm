INCLUDE Irvine32.inc

; Materia:     Lenguajes de Interfaz 
; Alumno:      Santiago Sicairos Angel Bulmaro
; Horario:     9:00 a 10:00 AM
; Docente:     Dr. José Luis Medina Jiménez 
; Práctica:    4.1. Mayor, menor o igual con entrada del usuario.
; Descripción: Programa que solicita al usuario dos números enteros, los compara mediante la instrucción CMP y utiliza saltos,
;              condicionales (JE, JG, JL) para determinar e imprimir si el primer número es mayor, menor o igual al segundo.

.data
    n1 BYTE "Escribe el primer numero a comparar: ", 0
    n2 BYTE "Escribe el segundo numero a comparar: ", 0

    msgIguales BYTE "Los numeros son iguales", 0
    msgMayor   BYTE "El primer numero es mayor", 0
    msgMenor   BYTE "El primer numero es menor", 0

    num1 DWORD ?      ; Variable que almacena el primer número ingresado
    num2 DWORD ?      ; Variable que almacena el segundo número ingresado

.code
main PROC

    ; --- Lectura del primer número ---
    mov edx, OFFSET n1  
    call WriteString   ; Muestra la solicitud del primer número
    call ReadInt       ; Lee un número entero ingresado por teclado (que se guarda en EAX)
    mov num1, eax      ; Almacena el valor de EAX en la variable 'num1'

    ; --- Lectura del segundo número ---
    mov edx, OFFSET n2  
    call WriteString   ; Muestra la solicitud del segundo número
    call ReadInt       ; Lee el segundo entero por teclado (que se guarda en EAX)
    mov num2, eax      ; Almacena el valor de EAX en la variable 'num2'

    ; --- Carga de variables en registros para comparación ---
    mov eax, num1      ; Carga el primer número en EAX
    mov ebx, num2      ; Carga el segundo número en EBX

    ; --- Comparación ---
    cmp eax, ebx       ; Compara EAX con EBX (num1 - num2)

    ; --- Evaluación de condiciones mediante saltos ---
    je iguales         ; Salta a 'iguales' si num1 == num2
    jg mayor           ; Salta a 'mayor' si num1 > num2 (con signo)
    jl menor           ; Salta a 'menor' si num1 < num2 (con signo)

iguales:
    mov edx, OFFSET msgIguales 
    call WriteString   ; Imprime el mensaje de: números iguales
    jmp fin            ; Salta al final del programa

mayor:
    mov edx, OFFSET msgMayor  
    call WriteString   ; Imprime el mensaje de: primer número mayor
    jmp fin            ; Salta al final del programa

menor:
    mov edx, OFFSET msgMenor 
    call WriteString   ; Imprime el mensaje de: primer número menor

fin:
    call Crlf          ; Salto de línea para darle formato al texto
    exit               ; Termina la ejecución del programa y regresa el control al SO

main ENDP

END main