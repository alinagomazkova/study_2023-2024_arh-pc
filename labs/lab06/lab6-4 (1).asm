%include 'in_out.asm' ; подключение внешнего файла 10+(31x-5)
SECTION .data
msg: DB 'Введите значение переменной x: ',0
rem: DB 'Результат: ',0 
SECTION .bss
x: RESB 80 ; Переменная, значение к-рой будем вводить с клавиатуры
SECTION .text
GLOBAL _start
_start:
; ---- Вычисление выражения
mov eax, msg
call sprint
mov ecx, x
mov edx, 80
call sread
mov eax, x ; вызов подпрограммы преобразования
call atoi ; ASCII кода в число, `eax=x`
mov ebx,31
mul ebx; EAX=EAX*EBX = x*31 
add eax,-5; eax = eax-5 = 31x - 5    
add eax,10; eax = eax+10 = (31x-5)+10
mov edi,eax ; запись результата вычисления в 'edi'
; ---- Вывод результата на экран
mov eax,rem ; вызов подпрограммы печати
call sprint ; сообщения 'Результат: '
mov eax,edi ; вызов подпрограммы печати значения
call iprintLF ; из 'edi' в виде символов
call quit ; вызов подпрограммы завершения