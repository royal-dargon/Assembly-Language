.386
DATA SEGMENT USE16
    BUF DW  -5, 100, 258, 16
    N = ($ - BUF) / 2       ;存储buf中元素的个数
    BUF1 DW N DUP(?), '$'
    BUF2 DW N DUP(?), '$'      ;保存了两个用来放置下面进行判断得出的结果的数值
DATA ENDS

STACK SEGMENT USE16 STACK
    DB 200 DUP(0)
STACK ENDS

CODE SEGMENT USE16
    ASSUME CS:CODE, DS:DATA, SS:STACK

START:
    MOV AX, DATA
    MOV DS, AX
    ;这道题目接下来的思路是希望能够对buf进行一个遍历的操作，每次操作的结果进行一个判断
    LEA BX, BUF
    LEA SI, BUF1
    LEA DI, BUF2
    MOV CX, N

Loop1: MOV AX, [BX]
    CMP AX, 0
    JNL Loop2
    MOV [DI], AX
    ADD BX, 2
    ADD DI, 1
    DEC CX
    JZ EXIT

Loop2:  MOV [SI], AX
        ADD SI, 1
        ADD BX, 2
        DEC CX
        JZ EXIT
        JMP Loop1

EXIT:   LEA DX, BUF1
        MOV AH, 9
        INT 21H
        MOV AH, 4CH
        INT 21H
    CODE ENDS
END START