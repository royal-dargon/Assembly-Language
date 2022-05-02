;这是书上的习题4.6，主要需要实现的是删除字符串中的第五行的内容，然后输出
.386
DATA SEGMENT USE16
    BUF DB  '11111', 0DH, 0AH
        DB  '22222', 0DH, 0AH
        DB  '33333', 0DH, 0AH
        DB  '44444', 0DH, 0AH
    p1 = $ - BUF
    BUF1 DB '55555', 0AH, 0DH
    p2 = $ - BUF
    BUF2 DB '66666', 0AH, 0DH
         DB '$'
    ENDL DB 0AH, 0DH, 'new:', 0AH, 0DH, 0AH, 0DH, '$'
DATA ENDS

STACK SEGMENT USE16 STACK
    DB  200 DUP(0)
STACK ENDS

CODE SEGMENT USE16
    ASSUME CS:CODE, DS:DATA, SS:STACK

COUT MACRO k
    LEA DX, k
    MOV AH, 9
    INT 21H
ENDM
START:
    MOV AX, DATA
    MOV DS, AX
    COUT BUF
    COUT ENDL
    
    XOR AX, AX 
    MOV SI, p1 
    MOV BX, p2

L:  MOV AL, BYTE PTR [BX]
    MOV BYTE PTR [SI], AL
    INC BX
    INC SI 
    CMP AL, '$'
    JNZ L

    COUT BUF

OK: MOV AH, 4CH
    INT 21H

CODE ENDS
    END START
