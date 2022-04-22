.386
DATA SEGMENT USE16
    LIST    DB  '6705762998'
            DB  '4322687321'
    SUM1    DD   ?
DATA ENDS

STACK SEGMENT USE16 STACK
          DB 200 DUP(0)
STACK ENDS

CODE SEGMENT USE16
          ASSUME CS:CODE, DS:DATA, SS: STACK

START:  MOV AX, DATA
        MOV DS, AX

        MOV CX, 20
        MOV SI, 0
        MOV AL, 0
        
LOPA:   ADD AL, LIST[SI]
        AAA
        INC SI
        DEC CX
        JNZ LOPA

        MOV BYTE PTR SUM1, AL
        MOV AL, AH
        MOV AH, 0
        AAM
        MOV WORD PTR SUM1+1, AX
        MOV BYTE PTR SUM1+3, 0
	
        MOV AH, 4CH
        INT 21H
CODE ENDS
	END START
	