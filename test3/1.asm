.386
DATA SEGMENT USE16
    INPUT DB 'PLEASE INPUT X(0~9);$'
    TAB DB  '0  $','1  $','8  $','27 $','64 $','125$','216$','343$','512$','729$'
    X   DB  ?
    XXX DB  ?
    INERR   DB 0AH,0DH,'INPUT ERROR! TRY AGAIN.',0AH,0DH,'$'    
DATA ENDS

STACK SEGMENT USE16 STACK
    DB 200 DUP(0)
STACK ENDS

CODE SEGMENT USE16
    ASSUME CS:CODE,DS:DATA,SS:STACK
BEGIN:  MOV AX,DATA
        MOV DS,AX
NEXT:   MOV DX,OFFSET   INPUT
        MOV AH,9
        INT 21H
        MOV AH,1
        INT 21H
        CMP AL,'0'
        JB  ERR
        CMP AL, '9'
        JA  ERR
        AND AL,0FH
        MOV X,AL
        XOR EBX,EBX
        MOV BL,AL
        MOV AX,TAB[EBX * 4]
        MOV XXX, AX
        LEA DX, TAB[EBX * 4]
        MOV AH,9
        INT 21H
EXIT:   MOV AH, 4CH
        INT 21H
ERR:    MOV DX,OFFSET INERR
        MOV AH,9
        INT 21H
        JMP NEXT
CODE    ENDS
    END BEGIN