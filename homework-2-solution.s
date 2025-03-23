.global _start

.section .text

_start:
    // Load address of the test string
    ldr r0, =test_case_1

    // Call to_upper
    bl to_upper

    // Print uppercase result
    ldr r0, =test_case_1
    mov r1, r0
    mov r2, #90            // Length of the string (approx)
    mov r7, #4             // syscall: write
    mov r0, #1             // file descriptor: stdout
    svc #0

    // Print a newline
    ldr r0, =newline
    mov r1, r0
    mov r2, #1
    mov r7, #4
    mov r0, #1
    svc #0

    // Call to_lower
    ldr r0, =test_case_1
    bl to_lower

    // Print lowercase result
    ldr r0, =test_case_1
    mov r1, r0
    mov r2, #90
    mov r7, #4
    mov r0, #1
    svc #0

    // Exit the program
    mov r7, #1
    mov r0, #0
    svc #0

// -----------------------------
// Function: to_upper
// Description: Convert a-z to A-Z
// -----------------------------
to_upper:
    push {r1, r2, lr}

loop_upper:
    ldrb r1, [r0]
    cmp r1, #0
    beq end_upper

    cmp r1, #'a'
    blt skip_upper
    cmp r1, #'z'
    bgt skip_upper

    sub r1, r1, #32
    strb r1, [r0]

skip_upper:
    add r0, r0, #1
    b loop_upper

end_upper:
    pop {r1, r2, lr}
    bx lr

// -----------------------------
// Function: to_lower
// Description: Convert A-Z to a-z
// -----------------------------
to_lower:
    push {r1, r2, lr}

loop_lower:
    ldrb r1, [r0]
    cmp r1, #0
    beq end_lower

    cmp r1, #'A'
    blt skip_lower
    cmp r1, #'Z'
    bgt skip_lower

    add r1, r1, #32
    strb r1, [r0]

skip_lower:
    add r0, r0, #1
    b loop_lower

end_lower:
    pop {r1, r2, lr}
    bx lr

// -----------------------------
.section .data

test_case_1:
    .asciz "... This STRIng conTainS test data: likE the AT @ SIGn and the PERCent % sign TOo!"

test_case_2:
    .asciz ""

newline:
    .asciz "\n"
