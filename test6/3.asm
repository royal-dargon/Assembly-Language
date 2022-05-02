;这道题是书上的习题4.8
.386
DATA SEGMENT USE16
    BUF DW 0ffH, 0ffH, 0ffH, 0ffH, 00H, 0ffH, 00H
    NUM DW $ - BUF
    TEMP DB "****=对应寄存器$"  ;尝试对寄存器中的数输出

DATA ENDS
STACK SEGMENT USE16 STACK
    DB 200 DUP(0)
STACK ENDS
CODE SEGMENT USE16
    ASSUME CS:CODE, DS:DATA, SS:STACK
START:
    MOV AX, DATA
    MOV DS, AX

    MOV CX, NUM     ;记录一共存储了多少个数字
    XOR DX, DX      ;把dx变成0
    XOR SI, SI
    MOV BX, 0FCH    ;最高的六位全是1
L:  MOV AX, WORD PTR BUF[SI]
    CMP AX, BX
    JB L1
    INC DX;         ;发现大的话就加一
L1: INC SI          ;跳了两位
    INC SI        
    LOOP L

  

OK: MOV AH, 4CH
    INT 21H


CODE ENDS
    END START
