; Recursively computes Fibonacci numbers.
; CSC 225, Assignment 6
; Given code, Fall '23

        .ORIG x4000

; int fib(int)
; TODO: Implement this function.
        ; R6 is stack pointer
        ; R5 is frame pointer
        ; R1, R2 is for math
        
        ; callee setup
FIBFN   ADD R6, R6, #-1 ; push space for return value

        ADD R6, R6, #-1 ; push space for return address
        STR R7, R6, #0  ; put return address into return address

        ADD R6, R6, #-1 ; push space for dynamic link
        STR R5, R6, #0  ; push dynamic link

        ADD R5, R6, #-1 ; set new frame pointer (R5 points to first local variable)

        ADD R6, R6, #-1 ; push up to first local variable
        ADD R6, R6, #-1 ; push up to top of stack (second local variable)
        
        
        ; body case checks
        LDR R0, R5, #4  ; puts "n" into R0
        ADD R1, R0, #-1 ; "n - 1"
        BRnz RET01      ; return as "0" case has been found
        BRnzp ELSE      ; neither base case so we must call again
        
        
        
        
        ; callee teardown "0" or "1" case
RET01   BRzp POS        ; branch if non-negative
        NOT R1, R0
        ADD R1, R1, #1  
        ADD R0, R1, R0  ; negates a negative number to make it zero

POS     STR R0, R5, #3  ; stores return value into return adress
        
        ADD R6, R5, #1  ; pops local varuables
        
        LDR R5, R6, #0  ; loads vale of dynamic link (old R5) into R5 (resetting to old R5)
        ADD R6, R6, #1  ; pops dynamic link
        
        LDR R7, R6, #0  ; puts the return address into R7
        ADD R6, R6, #1  ; pops return address
        
        RET
        
        
        ; caller setup (a)
ELSE    LDR R0, R5, #4  ; Push "n".
        ADD R6, R6, #-1
        ADD R0, R0, #-1 ; 
        STR R0, R6, #0  ; push "n - 1" onto stack
        JSR FIBFN
        
        
        ; caller teardown (a)
        LDR R0, R6 #0   ; load return value (current top of stack from callee teardown)
        
        STR R0, R5, #0  ; assignes return value into R5's address
        
        ADD R6, R6, #1  ; pop return value
        
        ADD R6, R6, #1  ; pop arguments
        
        ; caller setup (b)
        LDR R0, R5, #4  ; Push "n".
        ADD R6, R6, #-1
        ADD R0, R0, #-2 ; make n -> n-2
        STR R0, R6, #0  ; push "n - 2" onto stack into arguments
        JSR FIBFN
        
        ; caller teardown (b)
        LDR R0, R6 #0   ; load return value (current top of stack from callee teardown)
        
        STR R0, R5, #-1 ; assignes return value into R5's address
        
        ADD R6, R6, #1  ; pop return value
        
        ADD R6, R6, #1  ; pop arguments
        
        ; Callee teardown
        LDR R1, R5, #-1 ; loads b into R1
        LDR R2, R5, #0  ; loads a into R2
        ADD R0, R1, R2  ; a + b
        STR R0, R5, #3  ; stores return value into return adress
        
        ADD R6, R5, #1  ; pops local varuables
        
        LDR R5, R6, #0  ; loads vale of dynamic link (old R5) into R5 (resetting to old R5)
        ADD R6, R6, #1  ; pops dynamic link
        
        LDR R7, R6, #0  ; puts the return address into R7
        ADD R6, R6, #1  ; pops return address
        
        RET
        
        
        .END
