; 冒泡排序
.386
DATA SEGMENT USE16
    BUF1 DB 30H, 10H, 40H, 20H, 50H, 70H, 60H, 90H, 80H, 0, 0FFH
    N1 = $ - BUF1
    BUF2 DB 22H, 11H, 33H, 55H, 44H, 77H, 66H, 99H, 88H, 0AAH, 0EEH, 0
    N2 = $ - BUF2
    BUFA DB 150 DUP(0)
    ENDL DB 0DH, 0AH, '$'
DATA ENDS
STACK SEGMENT USE16 STACK
    DB 200 DUP(0)
STACK ENDS
CODE SEGMENT USE16
    ASSUME CS:CODE, DS:DATA, SS:STACK
START:
    MOV AX, DATA
    MOV DS, AX

    LEA BX, BUF1
    MOV CX, N1
    CALL SORT
    MOV BX, 0
    XOR EAX, EAX
L1: LEA SI, BUFA
    MOV AL, BUF1[BX]
    CALL PADIX
    INC BX
    LOOP L1

    PUSH AX
    PUSH DX
    LEA DX, ENDL
    MOV AH, 9
    INT 21H
    POP DX
    POP AX

    LEA BX, BUF2
    MOV CX, N2
    CALL SORT
    MOV BX, 0
    XOR EAX, EAX
L2: LEA SI, BUFA
    MOV AL, BUF2[BX]
    CALL PADIX
    INC BX
    LOOP L2

    MOV AH, 4CH
    INT 21H

SORT PROC
    PUSH AX     
    PUSH CX
    PUSH DX
    
S0: XOR SI, SI
S1: INC SI          
    CMP SI, CX
    JAE S3
    DEC SI
    MOV AL, BYTE PTR [BX + SI]
    MOV DL, BYTE PTR [BX + SI + 1]
    CMP AL, DL
    JBE S2
    MOV BYTE PTR [BX + SI], DL
    MOV BYTE PTR [BX + SI + 1], AL
S2: INC SI
    JMP S1
S3: LOOP S0

    POP DX
    POP CX
    POP AX

    RET
SORT ENDP


PADIX PROC          
    PUSH EAX      
    PUSH EBX
    PUSH ECX         
    PUSH EDX 
    MOV EBX, 10H    
    XOR CX, CX

    MOV BYTE PTR [SI], ' '
    ADD SI, 1

LOP1:XOR EDX, EDX
    DIV EBX
    PUSH DX
    INC CX
    OR EAX, EAX
    JNZ LOP1

LOP2:POP AX
    CMP AL, 10
    JB L3
    ADD AL, 7

L3: ADD AL, 30H
    MOV [SI], AL
    INC SI
    LOOP LOP2

    MOV BYTE PTR [SI], '$'
    LEA DX, BUFA
    MOV AH, 9
    INT 21H

    POP EDX
    POP ECX
    POP EBX
    POP EAX
    RET 
PADIX ENDP

    
CODE ENDS
	END START
