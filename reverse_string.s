.global _start
.equ end_str, 0x00000000
_start:
        ldr r0, =end_str
        ldr r2, =str
        push {r2}
        bl find_end
        pop {r1, r2}
        bl reverse
        mov r0, #1
        mov r2, #12 
        mov r7, #4
        swi 0
        b exit

find_end:
        ldrb r1, [r2], #1 @current byte then post increment r0
        ldrb r3, [r2] @load the next byte
        cmp r3, r0 @check if we reached the last char in str
        subeq r2, r2, #1
        pusheq {r2}
        bxeq lr
        bal find_end

reverse:
        cmp r2, r1
        bxge lr
        ldrb r3, [r2]
        ldrb r4, [r1]
        strb r4, [r2], #1
        strb r3, [r1], #-1
        bal reverse


exit:
        mov r0, #0
        mov r7, #0
        swi 0
.data
str:
        .asciz "hello, world!"
                            
