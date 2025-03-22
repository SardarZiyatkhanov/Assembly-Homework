.global _start
_start:
    // Load the address of test_case_1 into a register
    ldr r0, =test_case_1

    // Call the to_upper function
    bl to_upper

    // Uncomment the following line to test to_lower
    // bl to_lower

    // End of program
    b _exit

to_upper:
    // Iterate over the string and convert lowercase letters to uppercase
    push {r1, r2, lr}  // Save registers
    mov r1, r0         // Copy the address of the string to r1

upper_loop:
    ldrb r2, [r1]      // Load the current character into r2
    cmp r2, #0         // Check if the character is null (end of string)
    beq upper_end      // If null, end the loop

    // Check if the character is a lowercase letter (a-z)
    cmp r2, #'a'
    blt upper_next     // If less than 'a', skip
    cmp r2, #'z'
    bgt upper_next     // If greater than 'z', skip

    // Convert to uppercase by subtracting 32 (ASCII difference)
    sub r2, r2, #32
    strb r2, [r1]      // Store the updated character back to memory

upper_next:
    add r1, r1, #1     // Move to the next character
    b upper_loop       // Repeat the loop

upper_end:
    pop {r1, r2, lr}   // Restore registers
    bx lr              // Return from the function

to_lower:
    // Iterate over the string and convert uppercase letters to lowercase
    push {r1, r2, lr}  // Save registers
    mov r1, r0         // Copy the address of the string to r1

lower_loop:
    ldrb r2, [r1]      // Load the current character into r2
    cmp r2, #0         // Check if the character is null (end of string)
    beq lower_end      // If null, end the loop

    // Check if the character is an uppercase letter (A-Z)
    cmp r2, #'A'
    blt lower_next     // If less than 'A', skip
    cmp r2, #'Z'
    bgt lower_next     // If greater than 'Z', skip

    // Convert to lowercase by adding 32 (ASCII difference)
    add r2, r2, #32
    strb r2, [r1]      // Store the updated character back to memory

lower_next:
    add r1, r1, #1     // Move to the next character
    b lower_loop       // Repeat the loop

lower_end:
    pop {r1, r2, lr}   // Restore registers
    bx lr              // Return from the function

_exit:
    // End of program
    mov r7, #1         // syscall: exit
    swi 0

data:
    test_case_1: .asciz "... This STRIng conTainS test data: likE the AT @ SIGn and the PERCent % sign TOo!"
    test_case_2: .asciz "ANOTHER EXAMPLE STRING 123!"
