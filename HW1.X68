*-----------------------------------------------------------
* Title      : Egyptian Multiplication
* Written by : Brian Klein
* Date       : 10/10/18
* Description: Multiply two positive integers using Egyptian multiplication
* Registers  : [D0] --> Product and Output
*              [D1]--> First Input
*              [D2] --> Second Input
*-----------------------------------------------------------
        ORG     $400        Program starts here
START   
* Put program code here
        MOVE    M,D1        M --> D1 Move M to register D1
        MOVE    N,D2        N --> D2 Move N to register D2
        MOVE    P,D0        P --> D0 Move P to register D0
        CLR     D0          Set register D0 to 0
WHILE   CMP     #0,D1       Compare M to 0
        BLE     DONE        Branch to DONE if D1 is less than or equal to 0
        BTST    #0,D1       Check LSB of M to determine if it is odd
        BEQ     IF          If D1 is even, branch to IF
        ADD     D2,D0       Add D2 to D0
        BVS     OVFW        Branch to OVFW if there is overflow
IF      ASR     #1,D1       Shift D1 right by 1 space (to divide by 2)
        ASL     #1,D2       Shift D2 left by 1 space (to multiple by 2)
        BVS     OVFW        Branch to OVFW if there is overflow
        BRA     WHILE       Branch unconditionally to WHILE
OVFW    MOVE    #-1,D0      If product have overflow, set D0 to -1

DONE    MOVE    D0,P        Move D0 to P
        MOVE    P,D1        Move P to D1
        EXT.L   D1          Extend Word to Longword in D1
        MOVE    #3,D0       Task 3
        TRAP    #15         Request OS to do I/O

* Put variables here
        ORG     $1000       Data starts here
M       DC.W    111         First Input
N       DC.W    112         Second Input
P       DS.W    1           Output
        END     START
        
*--------------------------------------------------------------
*TEST CASES
*1. 5   x   3 = 15
*2. 28  x 17 = 476
*3. 99  x 121 = 11979
*4. 234 x 567 = -1
*5. 111 x 112 = 12432
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
