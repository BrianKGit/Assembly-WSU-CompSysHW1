*-----------------------------------------------------------
* Title      : Bubble Sort
* Written by : Brian Klein
* Date       : 10/15/18
* Description: Bubble Sort
*               Bubble Sorting Method in JAVA
*
*                   int n = arr.length;
*                   for (int i=0; i< n; i++)
*                       for (int j=1; j < n-i; j++)
*                           if (list[i] > list[j])
*                           {
*                               int temp = list[i];
*                               list[i] = list[j];
*                               list[j] = temp;
*                           }
* Registers: D0 holds n
*            D4 holds n-i
*            D1 holds i
*            D2 holds j
*            D3 holds temp value for swap
*            A0 points to list --> (A0) = list[i]
*            A1 points to list --> (A1) = list[j]
--------------------------------------------------------------
START   ORG         $400

*Sorting code starts here
        MOVE.B      COUNT,D0        Moves COUNT to D0
        LEA         LIST,A0         Sets pointer to beginning of array
        LEA         LIST,A1         Sets second pointer for array traversal
        ADD         #1,A1           Moves second pointer by 1 from start of array
        MOVE        #0,D1           Sets D1 to 0, acting as "i"
        MOVE        #1,D2           Sets D2 to 1, acting as "j"
LOOP1   MOVE.B      COUNT,D4        Copy Count to D4
        SUB         D1,D4           Sets D4 to (D4 - D1), acting as "n-i"
        CMP.B       D0,D1           Compare D0 to D1
        BEQ         END             Branch to END when D1 = D0
        ADD         #1,D1           Increment D1 by 1
        MOVE.B      #1,D2           Reset D2 to 1
LOOP2   CMP.B       D4,D2           Compare D2 to D4
        BGE         POINT           Branch to POINT when D2 >= D4
        ADD         #1,D2           Increment D2 by 1
        CMPM.B      (A0)+,(A1)+     Compare (A0) to (A1) and post increment both
        SUB         #1,A0           Decrement A0 by 1
        BGE         LOOP2           Branch to LOOP2 when (A1) is >= (A0)
SWAP    SUB         #1,A1           Decrement A1 by 1
        MOVE.B      (A0),D3         Move (A0) to D3     temp = list[i]
        MOVE.B      (A1),(A0)       Move (A1) to (A0)   list[i] = list[j]
        MOVE.B      D3,(A1)         Move D3 to (A1)     list[j] = temp
        ADD         #1,A1           Increment A1 by 1
        BRA         LOOP2           Branch unconditionally to LOOP2
POINT   ADD         #1,A0           Increment A0 by 1
        MOVE        A0,A1           A1 points to same spot as A0
        ADD         #1,A1           Increment A1 by 1
        BRA         LOOP1           Branch unconditionally to LOOP1
END
        
*Sorting code ends here
*
*Code to output data in the list to the Output Window
*(Do not modify code below this point)
        MOVE.B      COUNT,D7        Size of the array
        LEA         LIST,A0         A0 references the array
LOOP    MOVE.B      (A0)+,D1    `   Put value to display into D1
        EXT.W       D1              Sign extend D1 to word
        EXT.L       D1                  and then to longword
        MOVE        #3,D0           Task number 3 (display [D1])
        TRAP        #15             Display [D1]
        BSR         NEWLINE         Display "/n"
        SUB         #1,D7
        BNE         LOOP
*
        STOP        #$2700
        
*-----------------------------------------------------------
*Subroutine to display Carriage Return and Line Feed
*(Do not modify)
*-----------------------------------------------------------
NEWLINE MOVEM.L     D0/A1,-(A7)     Push D0 & A1
        MOVE        #14,D0          Task number 14 (display null-ended string)
        LEA         CRLF,A1         Put address of string in A1
        TRAP        #15             Display return, linefeed
        MOVEM.L     (A7)+,D0/A1     Restore D0 & A1
        RTS                         Return
*
*-----------------------------------------------------------
*Data Section
*Comment current and uncomment next data set for a different test
*-----------------------------------------------------------
        ORG         $1000
*Data 1
COUNT   DC.B        4
LIST    DC.B        2,9,5,3
*Data 2
*COUNT   DC.B        8
*LIST    DC.B        1,2,5,4,7,5,4,2
*Data 3
*COUNT   DC.B        9
*LIST    DC.B        82,73,64,55,46,37,28,4,2
*Data 4
*COUNT   DC.B        9
*LIST    DC.B        1,0,-3,5,-4,2,-44,8,-10
*Data 5
*COUNT   DC.B        10
*LIST    DC.B        1,3,5,7,8,11,15,22,33,44

*
*Do not change the following
CRLF    DC.B        $D,$A,0         Carriage return & line feed null
        END         START


























*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
