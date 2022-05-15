;这是书上的练习题，书上p110的例4.4
.386
DATA SEGMENT USE16
    X DB 8
    Y DB 9
    res DB ?
DATA ENDS

STACK SEGMENT USE16 STACK
    DB 200 DUP(0)
STACK ENDS

CODE SEGMENT USE16
    ASSUME CS:CODE, DS:DATA, SS:STACK

START:
    MOV AX, DATA
    MOV DS, AX      ;这是开始的代码

    CMP X, 0        ;将0与x进行比较
    JNL L1          ;如果发现x大于等于0就跳转
    CMP Y, 0        ;将0与y进行比较
    JGE L3          ;这里发现y是非负数
    MOV res, -1
    JMP EXIT

L1: CMP Y, 0        ;将0与y进行比较
    JL L3          ;如果发现y小于0就发生跳转
    MOV res, 1
    JMP EXIT

L3: MOV res, 0      ;这个是发现两数的符号不相同了

EXIT: MOV DX, res
      MOV AH, 4CH
      INT 21H

CODE ENDS
    END START