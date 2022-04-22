; 使用递归子程序求N！以十进制形式显示结果
.386
DATA SEGMENT USE16
    INPUT   DB  'PLEASE INPUT N;$'
    ans DB  15  DUP(0)
DATA    ENDS

STACK   SEGMENT USE16   STACK
    DB  200 DUP(0)
STACK   ENDS

CODE SEGMENT USE16
    ASSUME  CS:CODE,    DS:DATA,    SS: STACK

BEGIN:  MOV AX, DATA
        MOV DS, AX
        mov di, 15
        mov ans[di], '$'
        dec di
        LEA DX, INPUT
        MOV AH, 9
        INT 21H

        MOV AH, 1
        INT 21H         ;这里希望输入一个数字送入AL中，本题做出了我们打算实现的目标是个位数的阶乘
        MOV AH, 0
        SUB AL, 30H     ;将ascll变成数字
        MOV EBX,  1
NEXT:   CMP AX, 1
        je  show
        call    factorial
        mov EAX,    EBX

show:   mov cx, 10
LOOP:   xor edx,    edx ;使得这个寄存器变成0，dx将会存储余数，ax存储商
        div cx    
        add dx, 30H
        MOV ans[di],    dl
        dec di
        and ax, ax      ;判断目前的商是不是为0
        JNZ LOOP

        lea dx, ans     ;这里执行的是希望将结果进行输出的操作
        mov AH, 9
        int 21H


EXIT:   MOV AH, 4CH
        INT 21H

factorial   PROC        ;这里是执行递归求解的函数（子程序）
        CMP AX, 1
        je  out
        push    AX
        dec AX
        call    factorial
        pop AX
        IMUL    EBX,    EAX
out:
        ret
factorial   ENDP

CODE    ENDS
    END BEGIN