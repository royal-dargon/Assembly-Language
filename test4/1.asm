.386
DATA SEGMENT USE16
    BUF DB  80
        DB  ?
        DB  80  DUP(0)
    TEMP DB "****$" 
DATA ENDS

STACK SEGMENT USE16 STACK
    DB  200 DUP(0)
STACK ENDS

CODE SEGMENT USE16
    ASSUME CS:CODE, DS:DATA, SS: STACK

START:  MOV AX, DATA
        MOV DS, AX

        LEA DX, BUF     ;进行数字串的输入
        MOV AH, 10
        INT 21H

        MOV AX, 0       ;存储接下来循环的结果
        MOV CX, BUF+1   ;将输入的字符数作为循环的次数
        AND CH, 0
        LEA BX, BUF+2   ;取输入字符数的偏移地址

    S:  IMUL    EAX,    10
        MOV DX, [BX]
        AND DX, 0FH
        ADD AX, DX
        INC BX
        DEC CX
        JNZ S

        MOV SI,OFFSET TEMP+3;输出的偏移地址

        XOR CX,CX
        MOV CL,04H

        PRINT:
        MOV DH,AL
        ;逻辑位移，保留低位,CL不能用
        SHR AX,1
        SHR AX,1
        SHR AX,1
        SHR AX,1

        AND DH,0FH;取低位
        ADD DH,30H;变字母

        CMP DH,':';数字与字母的ascll界限
        JA IS;高于，是字符
        JB NO;低于，是数字

        IS:
        ADD DH,07H;变字母
        NO:
        MOV [SI],DH

        DEC SI
        LOOP PRINT


        LEA DX, TEMP
        MOV AH, 9
        INT 21H

        MOV AH, 4CH
        INT 21H        
CODE ENDS
        END START
