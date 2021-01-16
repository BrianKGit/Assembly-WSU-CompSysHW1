*------------------------------------------------------------------------------------
* Title      : Recursion Program
* Written by : Brian Klein
* Date       : 11/14/18
* Description: 
* Registers  : (A7)    --> Stack Pointer
*              D0      --> Product of multiplication
*              D1      --> Input1 = 1st number for multiplication, M
*              D2      --> Input2 = 2nd number for multiplication,
N
*------------------------------------------------------------------------------------
           ORG          $200
Input1     DC.W         200              1st number to multiply
Input2     DC.W         256              2nd number to multiply
PROD       DS.W         1               Input1*Input2 if no overflow, -1 otherwise

*Main code goes here
          
           ORG          $400
          
           LEA          $2000,A7        Load $2000 to stack pointer
           MOVE.W       Input1,D1       Input1 --> D1
           MOVE.W       Input2,D2       Input2 --> D2
           BSR          EGP             Call EGP
           LEA          $2000,A7        Load $2000 to stack pointer(clean up)
           MOVE.W       D0,PROD         D0 --> PROD
           
*Display output
           MOVE.W       PROD, D1        *Code to display the output
           EXT.L        D1              *
           MOVE         #3,D0           *
           TRAP         #15             *
                                        *
           STOP         #$2700          *
           
*------------------------------------------------------------------------------------
* Subroutine  : EGP
* Written by  : Brian Klein
* Date        : 11/14/18
* Description : 
* Registers   : D0      --> Product, M*N
*               D1      --> Input 1, M
*               D2      --> Input 2, N
*               (A7)    --> Stack Pointer
*               -4(A0)  --> Offset Frame Pointer to Local Temp N = N*2
*               -2(A0)  --> Offset Frame Pointer to Local Temp M = M/2
*               (A0)    --> Frame Pointer
*               4(A0)   --> Return Address
*               8(A0)   --> Offset Frame Pointer to Parameter N
*               10(A0)  --> Offset Frame Pointer to Parameter M
*------------------------------------------------------------------------------------
EGP
TN         EQU          -4              Offset by -4 for local 2
TM         EQU          -2              Offset by -2 for local 1
*N          EQU          8               Offset by 8 for N
*M          EQU          10              Offset by 10 for M

           LINK         A0,#-4          Create stackframe
           
*If M=0, then return 0
           CMP.W        #0,D1           Check D1, if 0 then exit
           BEQ          EXIT            Branch to exit if D1 = 0             
           
*Is M even?
           BTST         #0,D1           Bit-test: Is D1 even?
           BEQ          EGP2            If D1 is even, branch to EGP2
           
           ADD.W        D2,D0           D2 + D0 --> D0, Product + N
           ASR          #1,D1           D1 / 2  --> D1, M = M/2
           ASL          #1,D2           D2 * 2  --> D2, N = N*2
           BVS          OVRF            Branch to OVRF if D2*2 causes overflow
           
           MOVE.W       D1,TM(A0)       Move D1 --> -2(A0), TM = M
           MOVE.W       D2,TN(A0)       Move D2 --> -4(A0), TN = N

           BSR          EGP             Branch to subroutine EGP
           UNLK         A0              Destroy stack frame
           RTS                          Return to stack
           
EGP2       ASR          #1,D1           D1 / 2  --> D1, M = M/2
           ASL          #1,D2           D1 * 2  --> D2, N = N*2
           
           MOVE.W       D1,TM(A0)       Move D1 --> -2(A0), TM = M
           MOVE.W       D2,TN(A0)       Move D2 --> -4(A0), TN = N
           BSR          EGP             Branch to begining of subroutine EGP
           
EXIT       UNLK         A0              Destroy stack frame
           RTS                          Return to stack
           
*Handle overflow by assigning designated value to D0
OVRF       MOVE         (A7)+,D1        Move stack pointer to D1 then increment
           MOVE.W       #-1,D0          Move value -1 to D0
           UNLK         A0              Destroy stack frame
           RTS                          Return to stack
           


           END         $400







*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
