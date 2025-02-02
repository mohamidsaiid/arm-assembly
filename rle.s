.global _start

_start:
	ldr r0, =str
	ldr r3, =output
	ldr r4, =len
	add r4, r4, r0
	mov r6, #0x31
	bl count
	
	b exit
	
	
count:
	ldrb r1, [r0], #1
	cmp r4, r0
	bxeq lr
	ldrb r2, [r0]
	cmp r1,r2
	addeq r6, r6, #1
	beq count
	push {lr}
	bl save_in_mem
	pop {lr}
	b count
	
save_in_mem:
	strb r6, [r3], #1
	strb r1, [r3], #1
	mov r6, #0x31
	bx lr
	

exit:
	mov r7, #1
	mov r0, #0
	swi 0
	
.data
str:
	.asciz "AAABBBCC"
	len = .-str

output:
	.space 256
