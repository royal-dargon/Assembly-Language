.386
DATA SEGMENT USE16
    MESS    DB 0DH, 0AH, "Input some text please : $"
    OUTMESS DB 0DH, 0AH, "The text after conver : $"
    BUFFER  DB 80
            DB ?
            DB 80 DUP(0)
DATA ENDS

STACK SEGMENT USE16 STACK
          DB 200 DUP(0)
STACK ENDS

CODE SEGMENT USE16
          ASSUME CS:CODE, DS:DATA, SS: STACK

START:  MOV AX, DATA
        MOV DS, AX

        LEA DX, MESS        
        MOV AH, 9
        INT 21H

        LEA DX, BUFFER      
        MOV AH, 10
        INT 21H

        MOV BL, BUFFER+1    
        MOV BH, 0
        MOV BYTE PTR BUFFER + 2[BX], '$'

        MOV CL, BUFFER+1    
        MOV CH, 0
        LEA SI, BUFFER+2
        MOV AL, 'A' - '0'
LOPA:   ADD [SI], AL
        INC SI
        DEC CX
        JNZ LOPA

        LEA DX, OUTMESS     
        MOV AH, 9
        INT 21H

        LEA DX, BUFFER+2    
        MOV AH, 9
        INT 21H
        
        MOV AH, 4CH
        INT 21H
CODE ENDS
	END START
	