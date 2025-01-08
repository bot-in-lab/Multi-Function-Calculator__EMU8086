.MODEL SMALL

MACRO PROMPT_PRINTER P 
    LEA DX,P
    MOV AH,9
    INT 21H
ENDM

.STACK 1000H
.DATA
P1 DB 10,13,10,13,'                 <<< Multi Function Calculator >>>$',10,13 
P2 DB 10,13,10,13,'         Enter your Choice: $'

PR1 DB 10,13,'         **                                           **$'
PR2 DB 10,13,'         ***********************************************$'

P3 DB 10,13,'         **             1.Simple Calculator           **$' 
P4 DB 10,13,'         **             2.Base Converter              **$'
P5 DB 10,13,'         **             3.Temperature Converter       **$'  
               
               
P6 DB 10,13,10,13,10,13,10,13,10,13,10,13,'                  <<< Choise your Opration >>>$'
  
;=============================Simple Calculator===============================================  
P7 DB 10,13,'         **           1.Addition                      **$'
P8 DB 10,13,'         **           2.Subtraction                   **$'
P9 DB 10,13,'         **           3.Multiplication                **$'
P10 DB 10,13,'         **           4.Division                      **$'

;Variable For Simple Calculator
1ST_NUM DW ?
2ND_NUM DW ?
TEMP1 DW 10
TEMP2 DW ?
RESULT dw ?
FLOAT DW 0
REMAINDER dw ?

;Input for Simple Calculator
P11 DB 10,13,'         Enter Operation number: $'
P12 DB 10,13,10,13,'         Enter 1st number: $'
P13 DB 10,13,'         Enter 2nd number: $' 
;=============================================================================================

 

;=============================Base Converter================================================== 
P14 DB 10,13,'         **              1.DEC --> BIN                **$'
P15 DB 10,13,'         **              2.DEC --> HEX                **$'
P16 DB 10,13,'         **              3.BIN --> DEC                **$'
P17 DB 10,13,'         **              4.HEX --> DEC                **$'

BINARY DB 15 DUP(?)
HEXADECIMAL DB 3 DUP(?)
DECIMAL DB 4 DUP(?)
COUNTER DW ?
;=============================================================================================
 


;Input for Base and Tempreture Converter
P18 DB 10,13,10,13,'         Enter Tempreture: $'
P38 DB 10,13,10,13,'         Enter Your Number: $'
 
 
;===========================Tempreture Converter==============================================
P19 DB 10,13,'         **        1.Celsius --> Fahrenheit,Kelvin    **$'
P20 DB 10,13,'         **        2.Fahrenheit --> Celsius,Kelvin    **$'
P21 DB 10,13,'         **        3.Kelvin --> Celsius,Fahrenheit    **$'

;Variable For Tempreture Converter
FLAG DW ?
NUM DW ?
CEL DW ?
TEMP3 DW ?

;============================================================================================= 
 
 
 
;===========================Invalid Prompt=====================================================
P22 DB 10,13,10,13,'         INVALID ENTRY$'
P23 DB 10,13,'                        Try Again$'

;===========================Result Prompt=====================================================
P24 DB 10,13,10,13,'         Result: $'

P25 DB 10,13,'         Dec: $'
P26 DB 10,13,'         Hex: $'
P27 DB 10,13,'         Bin: $'
P28 DB 10,13,'         Oct: $'

P29 DB 10,13,'         Celsius: $'
P30 DB 10,13,'         Fahrenheit: $'
P31 DB 10,13,'         Kelvin: $'
;=============================================================================================



P32 DB 10,13,10,13,'         Do you want to try again. Enter(y/n)$'
P33 DB 'Math Error.$'
P34 DB '0$'
P35 DB '.$'
P36 DB '-$'
P37 DB 'More than 5 DIGIT is impossible to show in emu8086.$'


NEWLINE DB 10,13,' $'

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
  START:
  
    PROMPT_PRINTER P1
    
    CALL BORDER_START
                
    PROMPT_PRINTER P3    
    PROMPT_PRINTER PR1    
    PROMPT_PRINTER P4    
    PROMPT_PRINTER PR1    
    PROMPT_PRINTER P5
           
    CALL BORDER_END
    
    PROMPT_PRINTER P2
         
    MOV AH,1
    INT 21H
    SUB AL,48
    
    CMP AL,1
    JE SIM_CAL
    
    CMP AL,2
    JE BASE_CON   
     
    CMP AL,3
    JE TEMP_CON 
        
    
    JMP INVALID
    
       
    
;Simple Calculator
    
SIM_CAL:
     
    PROMPT_PRINTER P6
    
    CALL BORDER_START 
       
    PROMPT_PRINTER P7    ;Addition        
    PROMPT_PRINTER PR1    
    PROMPT_PRINTER P8   ;Subtraction     
    PROMPT_PRINTER PR1        
    PROMPT_PRINTER P9   ;Multiplication        
    PROMPT_PRINTER PR1                
    PROMPT_PRINTER P10   ;Division   
    
    CALL BORDER_END
        
    PROMPT_PRINTER P11              
    
    
    MOV AH,1
    INT 21H
    SUB AL,48 
    
    CMP AL,1
    JE  ADDI
    
    CMP AL,2
    JE SUBT
    
    CMP AL,3
    JE MULT 
    
    CMP AL,4
    JE DIVI
    
    JMP INVALID
     
;============================THE SIMPLE CALCULATOR CALCULATION CODE===========================
;


ADDI:
                       ;Addition
    PROMPT_PRINTER P12
    CALL INPUT_NUM
    MOV 1ST_NUM,BX
    
    PROMPT_PRINTER P13
    CALL INPUT_NUM
    MOV 2ND_NUM,BX
    
    PROMPT_PRINTER P24
    
    CMP 1ST_NUM,0
    JE SECOND_NUM_CHECK
    
    BACK_ADD:
    MOV AX,1ST_NUM
    ADD AX,2ND_NUM
    MOV RESULT,AX
    
    CALL PRINT_NUM
    
    SECOND_NUM_CHECK:
        CMP 2ND_NUM,0
        JE PRINT_ZERO
        JMP BACK_ADD
    
    JMP AGAIN
             
SUBT:                       ;Subtraction

    PROMPT_PRINTER P12
    CALL INPUT_NUM
    MOV 1ST_NUM,BX
    
    PROMPT_PRINTER P13
    CALL INPUT_NUM
    MOV 2ND_NUM,BX
    
    PROMPT_PRINTER P24
    MOV AX,1ST_NUM
    MOV BX,2ND_NUM
    CMP BX,AX
    JE PRINT_ZERO
    JG PRINT_NEG
    
    MOV AX,1ST_NUM
    SUB AX,2ND_NUM
    MOV RESULT,AX
     
    CALL PRINT_NUM
    JMP AGAIN
    
    PRINT_ZERO:
        PROMPT_PRINTER P34
    JMP AGAIN    
    
    PRINT_NEG:
        MOV AX,2ND_NUM
        SUB AX,1ST_NUM
        MOV RESULT,AX
        PROMPT_PRINTER P36
        CALL PRINT_NUM
    
    JMP AGAIN

MULT:                       ;Multiplication

    PROMPT_PRINTER P12
    CALL INPUT_NUM
    MOV 1ST_NUM,BX
    
    PROMPT_PRINTER P13
    CALL INPUT_NUM
    MOV 2ND_NUM,BX
    
    PROMPT_PRINTER P24
    MOV AX,1ST_NUM
    MOV BX,2ND_NUM
    MOV DX,0
    CMP AX,0
    JE PRINT_ZERO
    CMP BX,0
    JE PRINT_ZERO
    
    NO_PROBMEL:
    MUL 2ND_NUM
    MOV RESULT,AX
    
    CMP DX,0
    JNE BIT_ERROR
    
    CALL PRINT_NUM
    JMP AGAIN
    
    BIT_ERROR:
        PROMPT_PRINTER P37
        JMP AGAIN        
    
DIVI:                       ;Division

    PROMPT_PRINTER P12
    CALL INPUT_NUM
    MOV 1ST_NUM,BX
    
    PROMPT_PRINTER P13
    CALL INPUT_NUM
    MOV 2ND_NUM,BX
              
    PROMPT_PRINTER P24          
    MOV AX,1ST_NUM 

    MOV BX,2ND_NUM
    CMP AX,BX
    CMP BX,0
    JE INFINIT
    
    CMP AX,0
    JE PRINT_ZERO
    
    MOV DX,0
    DIV 2ND_NUM
    CMP AX,0
    JE PRINT_DOT_ZERO
    MOV RESULT,AX
    MOV FLOAT,DX
    
    CALL PRINT_NUM
    JMP AGAIN
    
    PRINT_DOT_ZERO:
        PROMPT_PRINTER P34
        JMP PRINT_FLOAT
    
    PRINT_FLOAT:
        PROMPT_PRINTER P35
        MOV CX,3
        MOV AX,1ST_NUM
        MOV DX,0
        
        FLOAT_CAL:
            DIV 2ND_NUM
            MOV AX,DX
            MUL TEMP1
            DIV 2ND_NUM
            MOV RESULT,AX
            MOV BX,DX
            
            MOV AH,2
            MOV DX,RESULT
            ADD DX,48
            INT 21H
            
            MOV DX,0
            MOV AX,BX
        LOOP FLOAT_CAL
        
        MOV FLOAT,0
        JMP AGAIN
    
    INFINIT:
        PROMPT_PRINTER P33
        JMP AGAIN                      
;=============================================================================================


BASE_CON:
    
    PROMPT_PRINTER P6
    
    CALL BORDER_START 
       
    PROMPT_PRINTER P14   ;1.DEC --> HEX,BIN,OCT        
    PROMPT_PRINTER PR1    
    PROMPT_PRINTER P15   ;2.HEX --> DEC,BIN,OCT     
    PROMPT_PRINTER PR1        
    PROMPT_PRINTER P16   ;3.BIN --> DEC,HEX,OCT        
    PROMPT_PRINTER PR1                
    PROMPT_PRINTER P17   ;3.OCT --> DEC,HEX,BIN   
    
    CALL BORDER_END
        
    PROMPT_PRINTER P11              
    
    
    MOV AH,1
    INT 21H
    SUB AL,48 
    
    CMP AL,1
    JE DEC_TO_BIN
    
    CMP AL,2
    JE DEC_TO_HEX
    
    CMP AL,3
    JE BIN_TO_DEC 
    
    CMP AL,4
    JE HEX_TO_DEC
    
    JMP INVALID
    
;=============================================================================================


; DO THE BASE CONVERSION CODE HERE
DEC_TO_BIN:
    
    PROMPT_PRINTER P38
    CALL INPUT_NUM
    MOV AX,BX
    MOV BX,2
    MOV DX,0
    
    MOV CX,15
    MOV SI,15
    
    DECI_TO_BIN:
        DIV BX
        MOV BINARY[SI],DL
        SUB SI,1
        MOV DX,0
    LOOP DECI_TO_BIN
    
    PROMPT_PRINTER NEWLINE
    PROMPT_PRINTER P27
    MOV CX,16
    MOV SI,0
    MOV AH,2
    
    PRINT_BIN:
        MOV DL,BINARY[SI]
        ADD DL,48
        INT 21H
        ADD SI,1
    LOOP PRINT_BIN

    JMP AGAIN

DEC_TO_HEX:
    
    PROMPT_PRINTER P38
    CALL INPUT_NUM
    MOV AX,BX
    MOV BX,16
    MOV DX,0
    
    MOV CX,4
    MOV SI,4
    
    DECI_TO_HEX:
        DIV BX
        MOV HEXADECIMAL[SI],DL
        SUB SI,1
        MOV DX,0
    LOOP DECI_TO_HEX
    
    PROMPT_PRINTER NEWLINE
    PROMPT_PRINTER P26
    MOV CX,5
    MOV SI,0
    MOV AH,2
    
    PRINT_HEX:
        MOV DL,HEXADECIMAL[SI]
        
        CMP DL,10
        JGE ABCDEF
        
        COMP:
        ADD DL,48
        INT 21H
        ADD SI,1
    LOOP PRINT_HEX
    JMP AGAIN
    
    ABCDEF:
        ADD DX,7H
        JMP COMP
        
BIN_TO_DEC:
    
    PROMPT_PRINTER P38
    CALL INPUT_NUM 
    
    PROMPT_PRINTER P25
    CMP BX,0
    JE PRINT_ZERO
    
    MOV RESULT,0
    MOV AX,BX
    MOV DX,0
    
    DIV TEMP1 ;1ST NUMBER
    MOV CX,AX
    MOV AX,DX
    MOV BX,1
    MUL BX
    ADD RESULT,AX
    
    MOV AX,CX
    
    DIV TEMP1 ;2ND NUMBER
    MOV CX,AX
    MOV AX,DX
    MOV BX,2
    MUL BX
    ADD RESULT,AX
    
    MOV AX,CX
    
    DIV TEMP1 ;3RD NUMBER
    MOV CX,AX
    MOV AX,DX
    MOV BX,4
    MUL BX
    ADD RESULT,AX
    
    MOV AX,CX
    
    DIV TEMP1 ;4TH NUMBER
    MOV CX,AX
    MOV AX,DX
    MOV BX,8
    MUL BX
    ADD RESULT,AX
    
    CALL PRINT_NUM  
    
    
HEX_TO_DEC:
        
    PROMPT_PRINTER P38
    MOV RESULT,0
    MOV AX,0
    MOV BX,0
    MOV CX,4
    MOV SI,0
    
    INPUT_HEX:
        MOV AH,1
        INT 21H
        
        CMP AL,13
        JE END_INPUT_HEX
        
        CMP AL,48
        JL INVALID
        
        CMP AL,70
        JG INVALID
        
        CMP AL,65
        JGE ABC
        
        SUB AL,48
        
        BACK_HEX:
        MOV DECIMAL[SI],AL
        INC COUNTER
        ADD SI,1
    LOOP INPUT_HEX
    
    END_INPUT_HEX:
    MOV CX,COUNTER
    SUB CX,1
    MOV AX,1
    
    CMP COUNTER,1
    JE SKIP_GGG
    GGG:
        MOV BX,16
        MUL BX
        MOV TEMP2,AX
        MOV AX,TEMP2
    LOOP GGG    
    
    SKIP:
    MOV AX,0
    MOV BX,0
    MOV CX,4
    MOV SI,0
    MOV RESULT,0
    MOV COUNTER,0
    
    HEX_TO_DECI:
        MOV AH,0
        MOV AL,DECIMAL[SI]
        MUL TEMP2
        ADD RESULT,AX
        
        MOV AX,TEMP2
        MOV BX,16
        DIV BX
        MOV TEMP2,AX
        ADD SI,1
    LOOP HEX_TO_DECI
    
    PROMPT_PRINTER P25
    CALL PRINT_NUM
    
    JMP AGAIN   
        
    ABC:
        MOV AH,0
        SUB AL,55
        JMP BACK_HEX
    SKIP_GGG:
        MOV TEMP2,1
        JMP SKIP     
;=============================================================================================

TEMP_CON:

    PROMPT_PRINTER P6
    
    CALL BORDER_START 
       
    PROMPT_PRINTER P19   ;1.Celsius --> Fahrenheit,Kelvin        
    PROMPT_PRINTER PR1    
    PROMPT_PRINTER P20   ;2.Fahrenheit --> Celsius,Kelvin     
    PROMPT_PRINTER PR1        
    PROMPT_PRINTER P21   ;3.Kelvin --> Celsius,Fahrenheit           
    
    CALL BORDER_END
        
    PROMPT_PRINTER P11              
    
    
    MOV AH,1
    INT 21H
    SUB AL,48 
    
    CMP AL,1
    JE  CEL_TO_OTHER
    
    CMP AL,2
    JE FAR_TO_OTHER
    
    CMP AL,3
    JE KAL_TO_OTHER 
    
    
    JMP INVALID

;=================================THE TEMP CONVERSION CODE====================================

CEL_TO_OTHER:
    PROMPT_PRINTER P18
    CALL INPUT_NUM
    MOV NUM,BX
    ;Fahrenheit
    MOV AX,NUM
    MOV BX,9
    MUL BX
    MOV 1ST_NUM,AX
    MOV 2ND_NUM,5
    MOV BX,5
    DIV BX
    ADD AX,32
    MOV RESULT,AX
    MOV FLOAT,DX    
    
    PROMPT_PRINTER NEWLINE
    PROMPT_PRINTER P30
    MOV FLAG,1
    CALL PRINT_NUM
    
    NEXT1:
        ;Kelvin 
        PROMPT_PRINTER P31
        MOV AX,NUM
        ADD AX,273
        MOV RESULT,AX
        MOV FLAG,0
        CALL PRINT_NUM        
    JMP AGAIN

FAR_TO_OTHER:
    PROMPT_PRINTER P18
    CALL INPUT_NUM
    MOV NUM,BX
    
    CMP NUM,30
    JLE CEL_NEG1
    ;Celsious
    MOV AX,NUM
    SUB AX,32
    MOV BX,5
    MUL BX
    MOV 1ST_NUM,AX
    MOV 2ND_NUM,9
    MOV BX,9
    DIV BX
    MOV RESULT,AX
    MOV CEL,AX
    MOV FLOAT,DX
    MOV TEMP3,DX
    MOV FLAG,2
    
    PROMPT_PRINTER NEWLINE
    PROMPT_PRINTER P29
    OTP1:
    CALL PRINT_NUM
    
    NEXT2:
        PROMPT_PRINTER P31
        CMP NUM,30
        JLE KAL_NEG1
        ;Kelvin   
        MOV AX,CEL
        ADD AX,273
        MOV RESULT,AX
        MOV BX,TEMP3
        MOV FLOAT,BX
        MOV FLAG,0
        CALL PRINT_NUM        
    JMP AGAIN
    
    CEL_NEG1:
        MOV AX,32
        SUB AX,NUM
        MOV BX,5
        MUL BX
        MOV 1ST_NUM,AX
        MOV 2ND_NUM,9
        MOV BX,9
        DIV BX
        MOV RESULT,AX
        MOV CEL,AX
        MOV FLOAT,DX
        MOV TEMP3,DX
        MOV FLAG,2
        PROMPT_PRINTER NEWLINE
        PROMPT_PRINTER P29
        PROMPT_PRINTER P36
        JMP OTP1
        
    KAL_NEG1:
        MOV AX,273
        SUB AX,CEL
        MOV RESULT,AX
        MOV BX,TEMP3
        MOV FLOAT,BX
        MOV FLAG,0
        CALL PRINT_NUM        
    JMP AGAIN 

KAL_TO_OTHER:
    PROMPT_PRINTER P18
    CALL INPUT_NUM
    MOV NUM,BX
    CMP NUM,273
    JL CEL_NEG
    ;Celsious
    MOV AX,NUM
    SUB AX,273
    MOV RESULT,AX
    MOV CEL,AX
    MOV FLAG,3
    
    PROMPT_PRINTER NEWLINE
    PROMPT_PRINTER P29
    
    OTP:
    CALL PRINT_NUM
    

    
    NEXT3:
        PROMPT_PRINTER P30
        
        CMP NUM,273
        JL FAR_NEG
        ;Kelvin   
        MOV AX,CEL                                          
        MOV BX,9
        MUL BX
        MOV 1ST_NUM,AX
        MOV 2ND_NUM,5
        MOV BX,5
        DIV BX
        ADD AX,32
        MOV RESULT,AX
        MOV FLOAT,DX
        MOV FLAG,0
        CALL PRINT_NUM        
    JMP AGAIN
    
    CEL_NEG:
        MOV AX,273
        SUB AX,NUM
        MOV RESULT,AX
        MOV CEL,AX
        ;SUB CEL,63
        MOV FLAG,3
        PROMPT_PRINTER NEWLINE
        PROMPT_PRINTER P29
        PROMPT_PRINTER P36    
        JMP OTP
        
    FAR_NEG:
        PROMPT_PRINTER P36
        MOV AX,CEL                                          
        MOV BX,9
        MUL BX
        MOV 1ST_NUM,AX
        MOV 2ND_NUM,5
        MOV BX,5
        DIV BX
        SUB AX,32
        MOV RESULT,AX
        MOV FLOAT,DX
        MOV FLAG,0
        CALL PRINT_NUM
    JMP AGAIN         
;=============================================================================================                 
    
AGAIN:
    CMP FLOAT,0
    JG PRINT_FLOAT
    
    CMP FLAG,1
    JE NEXT1
    
    CMP FLAG,2
    JE NEXT2
    
    CMP FLAG,3
    JE NEXT3
           
    PROMPT_PRINTER P32
    MOV AH,1
    INT 21H
        
    CMP AL,79H
    JE START
    
    CMP AL,6EH
    JE EXIT
    
    JMP INVALID

INVALID:
   
    LEA DX,P22
    MOV AH,9
    INT 21H 
        
    LEA DX,P23 
    MOV AH,9
    INT 21H         
    
    JMP START 
        
    
    EXIT:
    
    MOV AH,4CH
    INT 21H
    MAIN ENDP
    
    PROC BORDER_START 
        
        LEA DX,NEWLINE
        MOV AH,9
        INT 21H
    
        LEA DX,PR2
        MOV AH,9
        INT 21H
           
        LEA DX,PR2
        MOV AH,9
        INT 21H     
        
        LEA DX,PR1
        MOV AH,9
        INT 21H
        
        RET        
    ENDP
    
    PROC BORDER_END
        
        LEA DX,PR1
        MOV AH,9
        INT 21H
        
        LEA DX,PR2
        MOV AH,9
        INT 21H
        
        LEA DX,PR2
        MOV AH,9
        INT 21H
        
        RET               
    ENDP
    
    PROC INPUT_NUM
        MOV AX,0
        MOV BX,0
        MOV CX,4
        MOV TEMP2,1000
        
        INPUT_LOOP:
            MOV AH,1
            INT 21H
            
            CMP AL,13
            JE END_INPUT
            
            CMP AL,48
            JL INVALID
            
            CMP AL,57
            JG INVALID
            
            SUB AL,48
            
            MOV AH,0
            MUL TEMP2
            ADD BX,AX
            MOV AX,TEMP2
            DIV TEMP1
            
            MOV TEMP2,AX   
            MOV AX,0    
        LOOP INPUT_LOOP
        MOV TEMP2,1000
        RET
         
        END_INPUT:
            MOV AX,TEMP1
            MUL TEMP2
            MOV TEMP2,AX
            MOV AX,BX
            DIV TEMP2
            MOV BX,AX
            MOV TEMP2,1000
        RET
    ENDP
   
    PROC PRINT_NUM
        MOV TEMP2,10000        
        MOV AX, RESULT
        MOV DX,0
        ALO:
        DIV TEMP2
        CMP AX,0
        JE ZERO_CHECK ;==> 00011 TO 11
        
        P_NUM:    
            MOV REMAINDER,DX
            MOV DL,AL
            ADD DL,48
            MOV AH,2
            INT 21H
            
            MOV DX,0
            MOV AX,TEMP2
            DIV TEMP1
            MOV TEMP2,AX
            
            CMP TEMP2,0
            JE AGAIN
            MOV AX,REMAINDER
            DIV TEMP2
            JNE P_NUM
            
            RET
        
            ZERO_CHECK:
                MOV BX,DX
                MOV DX,0
                MOV AX,TEMP2
                DIV TEMP1
                MOV TEMP2,AX
                MOV DX,0
                
                CMP TEMP2,0
                MOV AX,BX
                JNE ALO  
        RET
    ENDP     
        
    
END MAIN