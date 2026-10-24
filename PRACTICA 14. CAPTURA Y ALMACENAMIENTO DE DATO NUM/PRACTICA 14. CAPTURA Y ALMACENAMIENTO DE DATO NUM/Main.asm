INCLUDE Irvine32.inc

; Materia:     Lenguajes de Interfaz 
; Alumno:      Santiago Sicairos Angel Bulmaro
; Horario:     9:00 a 10:00 AM
; Docente:     Dr. José Luis Medina Jiménez 
; Práctica:    14. Captura y almacenamiento de datos numéricos.
; Descripción: Programa que captura una cantidad en texto (1 a 99), valida su rango y formato, la 
;              convierte a valor numérico entero y actualiza el inventario sumándola a la existencia inicial.

.data
    cantidadInicial  DWORD 25
    cantidadRecibida DWORD ?
    existenciaActual DWORD ?
    recepcion        BYTE "Ingrese una cantidad (1-99): ",0
    msgError         BYTE "Cantidad recibida invalida",0
    msg1             BYTE "Existencia inicial ",0
    msg2             BYTE " + recepcion de ",0
    msg3             BYTE " existencia actual ",0
    msg4             BYTE " unidades",0
    cadena           BYTE 10 DUP(0)      ; Buffer para convertir a texto
    buffer           BYTE 3 DUP(0)       ; Buffer de captura (2 dígitos + nulo)

.code
main PROC

capturar:
    ; --- Captura de entrada del usuario ---
    mov edx, OFFSET recepcion 
    call WriteString 

    mov edx, OFFSET buffer 
    mov ecx, SIZEOF buffer 
    call ReadString                      ; EAX devuelve la cantidad de caracteres ingresados

    ; --- Validaciones iniciales de longitud ---
    cmp eax, 0 
    je error                             ; Error si entrada está vacía

    cmp eax, 2 
    ja error                             ; Error si ingresó más de 2 caracteres

    ; --- Validación del primer carácter ---
    mov bl, buffer[0] 

    cmp bl, '0' 
    jb error                             ; Error si ASCII < '0'

    cmp bl, '9' 
    ja error                             ; Error si ASCII > '9'

    cmp eax, 1 
    je unDigito                          ; Si es 1 solo dígito, salta a procesarlo

    ; --- Validación del segundo carácter (si existe) ---
    mov bl, buffer[1] 

    cmp bl, '0'  
    jb error

    cmp bl, '9' 
    ja error

    ; --- Conversión de 2 dígitos ASCII a valor entero ---
    movzx eax, buffer[0]                 ; Primer dígito en EAX
    sub eax, '0'                         ; Convierte ASCII a número

    mov ebx, 10 
    mul ebx                              ; Multiplica las decenas por 10

    movzx ebx, buffer[1]                 ; Segundo dígito en EBX
    sub ebx, '0'                         ; Convierte ASCII a número

    add eax, ebx                         ; Suma las unidades: EAX = (D1 * 10) + D2
    jmp validarRango

unDigito:
    ; --- Conversión de 1 solo dígito ---
    movzx eax, buffer[0] 
    sub eax, '0'                         ; Convierte ASCII a número

validarRango:
    ; --- Validación de rango (1 - 99) ---
    cmp eax, 1 
    jb error                             ; Error si es < 1

    cmp eax, 99 
    ja error                             ; Error si es > 99

    ; --- Operación de inventario ---
    mov cantidadRecibida, eax            ; Almacena la cantidad válida en variable
    mov eax, cantidadInicial 
    add eax, cantidadRecibida            ; Suma recepcion a existencia inicial
    mov existenciaActual, eax            ; Guarda resultado en existenciaActual

    ; --- Despliegue de resultados ---
    mov edx, OFFSET msg1
    call WriteString

    mov eax, cantidadInicial
    mov esi, OFFSET cadena
    call convertirDecimal                ; Convierte a texto
    mov edx, OFFSET cadena
    call WriteString

    mov edx, OFFSET msg2
    call WriteString

    mov eax, cantidadRecibida
    mov esi, OFFSET cadena
    call convertirDecimal                ; Convierte a texto
    mov edx, OFFSET cadena
    call WriteString

    mov edx, OFFSET msg3
    call WriteString

    mov eax, existenciaActual
    mov esi, OFFSET cadena
    call convertirDecimal                ; Convierte a texto
    mov edx, OFFSET cadena
    call WriteString

    mov edx, OFFSET msg4
    call WriteString

    call Crlf 
    exit                                 ; Termina la ejecución del programa

error:
    ; --- Manejo de errores ---
    mov edx, OFFSET msgError 
    call WriteString 
    call Crlf 
    jmp capturar                         ; Reintenta la captura

main ENDP

; --- Procedimiento para convertir EAX a cadena ASCII ---
convertirDecimal PROC
    mov ecx, 0 
    mov ebx, 10 

convertirLoop:
    mov edx, 0 
    div ebx                              ; Divide entre 10 (EAX = Cociente, EDX = Residuo)

    push edx                             ; Guarda el residuo en la pila
    inc ecx 

    cmp eax, 0 
    jne convertirLoop 

cadenaLoop:
    pop edx 
    add dl, '0'                          ; Convierte dígito a ASCII

    mov [esi], dl 
    inc esi 

    loop cadenaLoop 

    mov BYTE PTR [esi], 0                ; Terminador nulo

    ret 
convertirDecimal ENDP

END main