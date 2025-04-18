name "DRIFTYY_777"

.MODEL SMALL 
.STACK 100H 
.DATA 
 
; The string to be printed 

STRING db 32, 0, 78 DUP('$')
msg db 'Enter a String: ', 0Dh,0Ah, "$"
output_msg db 'You entered: $'


 
.CODE 
MAIN PROC FAR 
MOV AX,@DATA 
MOV DS,AX 
      
      
      
MOV AH,9
LEA Dx,msg
int 21H
      
      
; call reverse function 
CALL REVERSE 



; load address of the string 
LEA DX,STRING 
 
; output the string
; loaded in dx 
MOV AH, 09H 

INT 21H 
  
  
  
  

; interrupt to exit
MOV AH, 4CH

INT 21H 









MAIN ENDP 
REVERSE PROC     
    
    
    
    
      
    MOV AH, 0AH
    LEA Dx, STRING
    int 21H 
    
    ;MOV AH,9
    ;LEA Dx,output_msg
    ;int 21H

    
    ; load the offset of

    ; the string 

    MOV SI, OFFSET STRING 
    
    


    ; count of characters of the; 

    ;string 

    MOV CX, 0H 
 

    LOOP1:

    ; compare if this is; 

    ;the last character 

    MOV AX, [SI] 

    CMP AL, '$'

    JE LABEL1 
 

    ; else push it in the; 

    ;stack 

    PUSH [SI] 
 

    ; increment the pointer; 

    ;and count 

    INC SI 

    INC CX 
 

    JMP LOOP1 
 

    LABEL1:

    ; again load the starting; 

    ;address of the string 

    MOV SI, OFFSET STRING 
 

        LOOP2: 

        ;if count not equal to zero 

        CMP CX,0 

        JE EXIT 
 

        ; pop the top of stack 

        POP DX 
 

        ; make dh, 0 

        XOR DH, DH 
 

        ; put the character of the; 

        ;reversed string 

        MOV [SI], DX 
 

        ; increment si and; 

        ;decrement count 

        INC SI 

        DEC CX 
 

        JMP LOOP2 
 

                 

    EXIT:

    ; add $ to the end of string 

    ;MOV [SI],'$'  
    
    
     
    
    ; remove CR LF characters
    MOV CX, 0  ; set CX to 0 to find the end of the string
    MOV SI, OFFSET STRING
    FIND_END:
        CMP BYTE PTR [SI], 0  ; check if end of string
        JE  REMOVE_CR
        INC SI
        INC CX
        JMP FIND_END

    REMOVE_CR:
        DEC CX  ; decrement CX to point to the last character
        MOV BYTE PTR [SI-2], '$'  ; replace CR with '$'
        MOV BYTE PTR [SI-1], 0    ; set LF to null terminator
        RET
    
    
    

    RET 

            

