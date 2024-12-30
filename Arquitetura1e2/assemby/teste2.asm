.686
.model flat, stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
includelib \masm32\lib\kernel32.lib
include \masm32\include\msvcrt.inc
includelib \masm32\lib\msvcrt.lib
include \masm32\macros\macros.asm

.data

    texto1 db "Insira o nome do arquivo de entrada: ", 0
    texto2 db "Insira o nome do arquivo de saida: ", 0    
    tamanho_texto dd 0
    console_cont dd 0
    arrayBytes db 6480 dup(?)
    bytesEntrada dd 0
    bytesSaida dd 0
    bytesLargura dd 0
    largura dd 0
    totalPixels dd 0
    
.data?

    arquivoEntrada db 50 dup(?)
    arquivoSaida db 50 dup(?)
    handleEntrada dd ?
    handleSaida dd ?

.code
start:

    invoke GetStdHandle, STD_INPUT_HANDLE
    mov handleEntrada, eax  
    invoke GetStdHandle, STD_OUTPUT_HANDLE
    mov handleSaida, eax

    invoke WriteConsole, handleSaida, addr texto1, sizeof texto1, addr console_cont, NULL
    invoke ReadConsole, handleEntrada, addr arquivoEntrada, sizeof arquivoEntrada, addr console_cont, NULL

    mov esi, offset arquivoEntrada
   proximo:
    mov al, [esi]
    inc esi
    cmp al, 13
    jne proximo
    dec esi
    xor al, al
    mov [esi], al

    invoke WriteConsole, handleSaida, addr texto2, sizeof texto2, addr console_cont, NULL
    invoke ReadConsole, handleEntrada, addr arquivoSaida, sizeof arquivoSaida, addr console_cont, NULL

    mov esi, offset arquivoSaida
   proximo2:
    mov al, [esi]
    inc esi
    cmp al, 13
    jne proximo2
    dec esi
    xor al, al
    mov [esi], al

    invoke CreateFile, addr arquivoEntrada, GENERIC_READ, 0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL
    mov handleEntrada, eax

    invoke CreateFile, addr arquivoSaida, GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL
    mov handleSaida, eax

    invoke ReadFile, handleEntrada, addr arrayBytes, 18, addr bytesEntrada, NULL
    invoke WriteFile, handleSaida, addr arrayBytes, 18, addr bytesSaida, NULL

    invoke ReadFile, handleEntrada, addr largura, 4, addr bytesEntrada, NULL
    invoke WriteFile, handleSaida, addr largura, 4, addr bytesSaida, NULL

    invoke ReadFile, handleEntrada, addr arrayBytes, 32, addr bytesEntrada, NULL
    invoke WriteFile, handleSaida, addr arrayBytes, 32, addr bytesSaida, NULL

    mov eax, largura
    imul eax, [3]
    mov totalPixels, eax
        
   releitura:
    invoke ReadFile, handleEntrada, addr arrayBytes, totalPixels, addr bytesEntrada, NULL
    invoke WriteFile, handleSaida, addr arrayBytes, totalPixels, addr bytesSaida, NULL
    
    cmp bytesEntrada, 0
    JG releitura
    
    invoke CloseHandle, handleEntrada
    invoke CloseHandle, handleSaida
    invoke ExitProcess, 0
    
end start
