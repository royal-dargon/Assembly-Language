;这个是书上的4.4
.386
DATA SEGMENT USE16
TAB DW 11H,12H,11H
A DW ?,'$'
B DW ?,'$'
DATA ENDS
STACK SEGMENT USE16 STACK
DB 200 DUP(0)
STACK ENDS
CODE SEGMENT USE16
ASSUME CS:CODE,DS:DATA,SS:STACK
BEGIN:mov ax,DATA
      mov ds,ax
      lea di,TAB
      mov bx,0
      mov si,0
fir:  mov ax,TAB[bx]
      lea di,TAB[bx]
cm:   mov dx,TAB[si]
      cmp ax,dx
      je cnt
      jne ncnt
cnt:  inc cx
ncnt: inc si
      cmp si,3
      jne cm
      cmp cx,2
      je  next
      jne song
next: mov cx,0
      mov si,0
      inc bx
      jmp fir
song: mov A,ax
      mov B,di

EXIT: MOV AH,4CH
      INT 21H
code ENDS
     END BEGIN