.global _start
.align 2

_start:
    // write(stdout, message, message_len)
    mov    x0, #1                       // File descriptor: stdout

    // Load address of message using Mach-O syntax
    adrp   x1, message@PAGE
    add    x1, x1, message@PAGEOFF

    // Load message length from memory using PC-relative addressing
    adrp   x2, message_len@PAGE
    ldr    w2, [x2, message_len@PAGEOFF]  // Load 32-bit length into w2

    // Setup syscall: write -> 0x2000004
    movz   x16, #0x2000, lsl #16         // Build 0x2000000
    orr    x16, x16, #4                 // Add the 4 for write syscall
    svc    #0

    // exit(0)
    mov    x0, #0                       // Exit status
    movz   x16, #0x2000, lsl #16         // Build 0x2000000
    orr    x16, x16, #1                 // Add the 1 for exit syscall
    svc    #0

.section __DATA,__data
message:     .asciz "Hello, ARM!\n"
.align 2                // Align to 4 bytes
message_len: .word 12
