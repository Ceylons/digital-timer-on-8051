CNTA EQU 00H;judge whether 4 cols have shown completely
CNTB EQU 01H;number in second bit
CNTC EQU 02H;number in first bit
Binit EQU 03H;judge whether 4 cols have shown completely
Cinit EQU 04H;judge whether 4 cols have shown completely
numR EQU  05H; first number in LED
numL EQU 06H;second number in LED
CNTF EQU 07H;0 for first bit, 1 for second bit

ORG 0000H
MOV CNTF, #0
LOOP:
	mov p3,#0ffh
	MOV P2, #0F0h ; set rows 1111 cols 0000!
	MOV A, P2 ; read back P2!
	CJNE A, #0F0h, DECODE ; decode if key pressed!
	SJMP LOOP
DECODE:	INC CNTF
	MOV P2, #0FEh ; check col0: 11111110!
	JNB P2.4, C0R0 ; '1'
	JNB P2.5, C0R1 ; '4'
	JNB P2.6, C0R2 ; '7'
	MOV P2, #0FDh ; check col1: 11111101!
	JNB P2.4, L2 ; '2'
	JNB P2.5, L5; '5'
	JNB P2.6, L8; '8'
	JNB P2.7, L0 ; '0'
	MOV P2, #0FBh ; check col2: 11111011!
	JNB P2.4, L3 ;'3'
	JNB P2.5, L6 ;'6'
	JNB P2.6, L9 ;'9'
	Mov p2, #0f7h;check the last col
        JNB P2.4,pres;check A 
	L0:LJMP C1R3 ; '0'
	L2:LJMP C1R0;2
	L3:LJMP C2R0 ; '3'
	L6:LJMP C2R1 ; '6'
	L9:LJMP C2R2 ; '9'
	L5:LJMP C1R1 ;'5‘
	L8:LJMP C1R2 ; '8'
	pres:lcall ok
	SJMP Loop
; preset to register
;'1'
C0R0: 	MOV A,CNTF
	JB ACC.0,L00;if ACC.0 =1, jump to LOO to set the second bit
	MOV CNTC,#32
	MOV numR,#1 ;set bit
	LJMP STARTPreset
	L00:MOV CNTB,#32
	MOV numL, #1
	LCALL DELAY2
	LJMP LOOP
;'4'	
C0R1: 	MOV A,CNTF
	JB ACC.0,L01
	MOV CNTC,#20
	MOV numR,#4
	LJMP STARTPreset
	L01:MOV CNTB,#20
	MOV numL, #4
	LCALL DELAY2
	LJMP LOOP
;'7'	
C0R2: 	MOV A,CNTF
	JB ACC.0,L02
	MOV CNTC,#8
	MOV numR, #7
	LJMP STARTPreset
	L02:MOV CNTB,#8
	MOV numL, #7
	LCALL DELAY2
	LJMP LOOP
;'2'	
C1R0: 	MOV A,CNTF
	JB ACC.0,L10
	MOV CNTC,#28
	MOV numR, #2
	LJMP STARTPreset
	L10:MOV CNTB,#28
	MOV numL, #2
	LCALL DELAY2
	LJMP LOOP
;'5'	
C1R1: 	MOV A,CNTF
	JB ACC.0,L11
	MOV CNTC,#16
	MOV numR, #5
	LJMP STARTPreset
	L11:MOV CNTB,#16
	MOV numL, #5
	LCALL DELAY2
	LJMP LOOP
;'8'	
C1R2: 	MOV A,CNTF
	JB ACC.0,L12
	MOV CNTC,#4
	MOV numR, #8
	LJMP STARTPreset
	L12:MOV CNTB,#4
	MOV numL, #8
	LCALL DELAY2
	LJMP LOOP
;'0'	
C1R3: 	MOV A,CNTF
	JB ACC.0,L13
	MOV CNTC,#36
	MOV numR, #0
	LJMP STARTPreset
	L13:MOV CNTB,#36
	MOV numL, #0
	LCALL DELAY2
	LJMP LOOP
;'3'	
C2R0: 	MOV A,CNTF
	JB ACC.0,L20
	MOV CNTC,#24
	MOV numR, #3
	LJMP STARTPreset
	L20:MOV CNTB,#24
	MOV numL, #3
	LCALL DELAY2
	LJMP LOOP
;'6'	
C2R1: 	MOV A,CNTF
	JB ACC.0,L21
	MOV CNTC,#12
	MOV numR, #6
	LJMP STARTPreset
	L21:MOV CNTB,#12
	MOV numL, #6
	LCALL DELAY2
	LJMP LOOP
;'9'	
C2R2: 	MOV A,CNTF
	JB ACC.0,L22
	MOV CNTC,#0
	MOV numR, #9
	LJMP STARTPreset
	L22:MOV CNTB,#0
	MOV numL, #9
	LCALL DELAY2
	LJMP LOOP

STARTPreset:
mov p3, #0ffh
mov p1,#00H
MOV CNTA,#0
Mov Binit,CNTB;store CNTB to judge whether 4 cols have shown completely
Mov Cinit,CNTC;store CNTC to judge whether 4 cols have shown completely
LCALL T0L
LCALL T0R
LCALL Renumber
ACALL judgemode
LJMP COUNTMode

;if # is pressed, enter COUNTMode or back to STARTPreset
judgemode:
	MOV P2, #0FBh
	MOV A, P2 ; read back P2!
	CJNE A, #07Bh,STARTPreset ;'#'
	LCALL DELAY2
	RET

COUNTMode:
	mov p3, #00h
	LOOP3: 
		MOV P2, #0FEh
		MOV A, P2 ; read back P1!
		CJNE A, #07Eh, LOOP3 ; if * is not pressed, back to LOOP3, or go on STARTCount
		LJMP STARTCount

STARTCount:
;Initial value is 99
;Mov numR,#9
;Mov numL,#9
;MOV CNTC,#0
mov p1,#00H
MOV CNTA,#0
Mov Binit,CNTB;store CNTB to judge whether 4 cols have shown completely
Mov Cinit,CNTC

Main:
ACALL timer
Main2:
LCALL T0L;firstly light up the number at first bit
LCALL T0R;then light up the number at second bit
ACALL judgetime;associated with timer
AJMP judge0; judge whether 0 is pressed?
LL2:
ACALL judgestop;judge whether * is pressed for pausing
ACALL judgenumR;the second number would minus 1 if the first number turns 0 into 9
LCALL CountdownR;
SJMP Main; re-start

;if 0 is pressed, back to initial state
judge0:
MOV P2, #0FDh
MOV A, P2 ; read back P2!
CJNE A, #07Dh,LL2 ;'0'
LCALL DELAY2
MOV CNTF, #0
LJMP LOOP

;if * is pressed, turn "stop" into "resume"
judgestop:
	MOV P2, #0FEh
	MOV A, P2 ; read back P1!
	CJNE A, #07Eh, RleaseStop;
	mov p3, #00h
	SETB TF0
	RET

;the second number would minus 1 if the first number turns 0 into 9
judgenumR:
Mov A,numR
JZ L;
RET
L:
   LJMP CountdownL

judgetime:
JNB TF0,Redisplay;if timer does not end, back to Redisplay
CLR TR0;or clean timer
CLR TF0
RET

RleaseStop:
mov p3,#0ffh
LCALL timer
Redisplay:
   LCALL Renumber
   SJMP  Main2


;1ms timer
timer: 	MOV TMOD, #01h
	MOV TH0, #0FCH
	MOV TL0, #066H
	SETB TR0;start timer
RET
ORG 0800H
;light up left number
T0L:
MOV DPTR,#TAB
MOV A,CNTA
MOVC A, @A+DPTR
MOV P0,A

MOV DPTR,#Number3
MOV A,CNTB
MOVC A,@A+DPTR
MOV P1,A

mov B,#00H
mov p1,B

INC CNTB
INC CNTA

MOV A,Binit
add A,#4
mov 07H,A;最初的CNTB+4的值存入21H（98: Binit = 0，如果显示到第4列，CNTB 应该= 4)

mov A,CNTB
CJNE A,07H,T0L
RET


;light up right number
T0R:
MOV DPTR,#TAB
MOV A,CNTA
MOVC A, @A+DPTR
MOV P0,A

MOV DPTR,#Number3
MOV A,CNTC
MOVC A,@A+DPTR
MOV P1,A


mov B,#00H
mov p1,B

INC CNTC
INC CNTA


MOV A,Cinit
add A,#4
mov 07H,A;

mov A,CNTC
CJNE A,07H,T0R;
		;
MOV CNTA,#0;
RET
		

Renumber:
    MOV CNTC,CINIT
    MOV CNTB,BINIT
    RET


   
    CountdownR:
    	DEC numR
    	MOV B,#4
        MOV A,CNTB
    	SUBB A,B;CTNB = CTNB-4,保证从原来那个数的第一列开始重新亮（98：CNTB=0）
        MOV CNTB,A; (98: CNTA = 0, CNTB = 0，CNTC = 4)
        Mov Binit,CNTB;store CNTB to judge whether 4 cols have shown completely
	Mov Cinit,CNTC
    RET

   
   CountdownL:
 
   	mov A,#0; now first bit is 0 and judge the second number
   	CJNE A,CNTC,next;if second number is not 0, resume
   	mov R7,#5
   	ACALL Loop2
   	LCALL DELAY2
   	LJMP LOOP
   	Loop2:
   	      LCALL T0L
   	      LCALL T0R
   	      LCALL Renumber
   	      DJNZ R7,Loop2
   	   RET
   next:
   	Mov numR,#9
   	DEC numL
	MOV CNTC,#0
        Mov Binit,CNTB;store CNTB to judge whether 4 cols have shown completely
	Mov Cinit,CNTC
   	LJMP MAIN

DELAY2:	MOV R6,#7
LOOP4: 	NOP
	DJNZ R6,LOOP4
	RET

ok:   mov DPTR,#o
        lcall dis_no_10
        mov DPTR,#k
        lcall dis_no
      	ret

dis_No_10:
	
	MOV R0, #0 
	MOV R1, #0FEh 
	;MOV DPTR, #FONT ; load lookup table!
	SCAN_No_10: MOV P1, #0 ; turn off LEDs !
	MOV P0, R1 ; select col!
	MOV A, R0 ; load from table "font"!
	INC R0 ; prepare the next round!
	MOVC A, @A+DPTR ; access the table!
	MOV P1, A ; send LED bits!
	MOV A, R1 ; left shift col scan!
	RL A 
	MOV R1, A
	CJNE R0, #3, SCAN_No_10 ; repeat!
	
	ret

dis_No:  
	 MOV R0, #0 
	MOV R1, #0DFh ; col scan 11011111 !
	SCAN_No: MOV P1, #0 
	MOV P0, R1 
	MOV A, R0 
	INC R0 
	MOVC A, @A+DPTR ; access the table!
	MOV P1, A ; send LED bits!
	MOV A, R1 ; left shift col scan!
	RL A 
	MOV R1, A
	CJNE R0, #3, SCAN_No; repeat!
	ret
o: 	DB 7Fh,41h,7fh
k:	DB 7Fh,14h,22h

TAB:  
DB 0FEH, 0FDH, 0FBH, 0F7H, 0EFH, 0DFH, 0BFH, 07FH

Number3:
DB 017H, 015H, 01FH, 000H;9
DB 01FH, 015H, 01FH, 000H;8
DB 001H, 001H, 01FH, 000H;7
DB 01FH, 015H, 01DH, 000H;6
DB 017H, 015H, 01DH, 000H;5
DB 007H, 004H, 01FH, 000H;4
DB 015H, 015H, 01FH, 000H;3
DB 01DH, 015H, 017H, 000H;2
DB 000H, 01FH, 000H, 000H;1
DB 01FH, 011H, 01FH, 000H;0

end
