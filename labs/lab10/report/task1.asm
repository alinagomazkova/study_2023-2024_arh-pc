%include 'in_out.asm'
SECTION .data
msg1 db 'Как Вас зовут?', 0h ; Сообщение
filename db 'name.txt', 0h ; Имя файла
msg2 db 'Меня зовут ', 0h ; Сообщение

SECTION .bss
name resb 255 ; переменная для вводимой строки

SECTION .text
global _start
_start:

mov eax,msg1
call sprintLF

mov ecx, name
mov edx, 255
call sread

mov ecx, 0777o ; Создание файла.
mov ebx, filename ; в случае успешного создания файла,
mov eax, 8 ; в регистр eax запишется дескриптор файла
int 80h

mov ecx, 2 ; Открытие файла (2 - для записи).
mov ebx, filename
mov eax, 5
int 80h

mov esi, eax

mov eax, msg2
call slen

mov edx, eax
mov ecx, msg2
mov ebx, esi
mov eax, 4
int 80h

; --- Расчет длины введенной строки
mov eax, name  ; в `eax` запишется количество
call slen ; введенных байтов

; --- Записываем в файл `name` (`sys_write`)
mov edx, eax
mov ecx, name
mov ebx, esi
mov eax, 4
int 80h

; --- Закрываем файл (`sys_close`)
mov ebx, esi
mov eax, 6
int 80h

call quit
