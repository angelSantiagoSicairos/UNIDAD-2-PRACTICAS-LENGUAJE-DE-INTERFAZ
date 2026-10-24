INCLUDE Irvine32.inc

; Materia:     Lenguajes de Interfaz 
; Alumno:      Santiago Sicairos Angel Bulmaro
; Horario:     9:00 a 10:00 AM
; Docente:     Dr. José Luis Medina Jiménez 
; Práctica:    15. Manipulación de archivos.
; Descripción: Programa que crea un archivo de texto en el disco local utilizando CreateOutputFile, escribe una 
;              cadena en él mediante WriteToFile y cierra el manejador (handle) adecuadamente con la librería Irvine32.

.data
    nombreArchivo BYTE "Inventario.txt", 0
    texto         BYTE "125", 0
    archivoHandle DWORD ?

    mensajeExito BYTE "Archivo guardado correctamente.", 0
    mensajeError BYTE "No se pudo guardar el archivo.", 0

.code
main PROC
    ; --- 1. Crear / Abrir el archivo para escritura ---
    mov edx, OFFSET nombreArchivo
    call CreateOutputFile            ; Retorna el manejador (handle) en EAX

    cmp eax, INVALID_HANDLE_VALUE    ; Verifica si hubo un error al crear el archivo
    je error                         ; Si falló, salta a la etiqueta 'error'

    mov archivoHandle, eax           ; Guarda el handle retornado en variable

    ; --- 2. Escribir contenido en el archivo ---
    mov eax, archivoHandle           ; Carga el handle del archivo
    mov edx, OFFSET texto            ; EDX apunta a la cadena a escribir
    mov ecx, LENGTHOF texto - 1      ; Cantidad de bytes a escribir (sin contar el terminador nulo)
    call WriteToFile                 ; Escribe el texto en el archivo
    
    jc errorEscritura                ; Si la bandera Carry Flag (CF) está activa, ocurrió error al escribir

    ; --- 3. Cerrar el archivo ---
    mov eax, archivoHandle
    call CloseFile

    ; --- 4. Notificar éxito ---
    mov edx, OFFSET mensajeExito
    call WriteString
    call Crlf
    jmp fin

errorEscritura:
    ; --- Manejo de error con archivo abierto ---
    mov eax, archivoHandle
    call CloseFile                   ; Cierra el archivo antes de salir

error:
    ; --- Manejo de error general ---
    mov edx, OFFSET mensajeError
    call WriteString
    call Crlf

fin:
    exit                             ; Termina la ejecución del programa
main ENDP

END main