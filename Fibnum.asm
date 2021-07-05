;TITLE Program Template     (template.asm)

; Author: Jawad Alamgir
; Last Modified: 07/12/2020
; OSU email address: alamgirj@oregonstate.edu
; Course number/section: (CS_271_X400_U2020)
; Assignment Number: Program 2                Due Date: 07/12/2020
; Description: Takes the users name and then a number(between 1-46 inclusive) and prints the fibonacci numbers till that point

INCLUDE Irvine32.inc

; (insert constant definitions here)


.data

;intro
intro BYTE "Hi my name is Jawad Alamgir welcome to Fibnum.asm",0 ;	introduction for the program

;name
name_instructions BYTE "Please enter your name: ",0	;	prompt for user to input name
user_name BYTE 100 DUP(0)	;	name of the user

;number input from user
num_prompt BYTE "Please enter the number of fibonacci terms in the range [1...46] you would like to see ",0	;	prompt to enter number
usernum DWORD ?	;	number input by user

;fibonacci
sum DWORD 1	;	sum of last two numbers from sequence
space BYTE "     ", 0	;	empty space to put in between values
line_counter DWORD ?	;counts if there is a need for newline

;range check
error_range BYTE "The number you entered is outside the inclusive range 1-46",0	;	error if user input is utside range
RANGE_MAX equ 46	;	constant holding max range

;termination
term_message_0 BYTE "Thank you ", 0	;	terminating message
term_message_1 BYTE " for using Prog02", 0	;	terminating message


.code
main PROC
;introduction
	mov edx, OFFSET intro
	call WriteString
	call CrLF

;prompt for and read name
	mov edx, OFFSET name_instructions
	call WriteString
	call CrLF
	mov edx, OFFSET user_name
	mov ecx, 32
	call ReadString
	call CrLF

;prompt user to input number and read it
num_area:
	mov edx, OFFSET num_prompt
	call WriteString
	call Crlf
	call ReadDec
	mov usernum, eax
	call CrLF
	jmp range_test

;checks if input is invalid
input_invalid:
	mov edx, OFFSET error_range
	call WriteString
	call Crlf
	jmp num_area

range_test:
	cmp usernum, RANGE_MAX
	jg input_invalid
	mov ebx, 0
	cmp usernum, ebx
	jle input_invalid

;fibonacci calculation
;if user input is 1 or 2
	mov eax, 1
	cmp usernum, eax
	je only_one
	mov eax, 2
	cmp usernum, eax
	je only_two

;initialisation
	;sub usernum,2
	mov ecx, usernum
	jmp past_one_two

;prints only the first fibonacci term
only_one:
	mov edx, OFFSET sum
	call WriteDec
	mov edx, OFFSET space
	call WriteString
	call crlf
	jmp pre_term_message

;prits the second fibonacci term
only_two:
	mov eax, sum
	call WriteDec
	mov edx, OFFSET space
	call WriteString
	mov eax, sum
	call WriteDec
	mov edx, OFFSET space
	call WriteString
	call crlf
	jmp pre_term_message

;if user wants more than two fibonacci terms
past_one_two:
	mov ebx, 1
	mov edx, 0
	mov ecx, usernum
beforeloop:
	mov line_counter, 5
loopcounter:
	mov eax, ebx
	add eax, edx
	mov ebx, edx
	mov edx, eax
	call WriteDec
	mov esi, edx
	mov edx, OFFSET space
	call WriteString
	mov edx, esi
	dec line_counter
	cmp line_counter, 0
	je linechange
	loop loopcounter
	jmp afterlinechange

;adds new line
linechange:
	call CrLF
	jmp beforeloop
afterlinechange:

pre_term_message:
;terminating message
	call Crlf
	mov edx, OFFSET term_message_0
	call WriteString
	mov edx, OFFSET user_name
	call WriteString
	mov edx, OFFSET term_message_1
	call WriteString
	call Crlf

	exit	; exit to operating system
main ENDP

END main
