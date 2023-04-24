
./bin/lock_kernel_1:	file format elf32-dpu


Disassembly of section .text:

80000000 <__bootstrap>:
80000000: 06 00 00 83 73 3c 00 00      	jnz id, __sys_start_thread
80000008: 00 00 00 46 e3 7c 00 00      	sd zero, 16, 0
80000010: 00 00 ac 00 e3 6b 00 00      	move r23, 202

80000018 <__sys_atomic_bit_clear>:
80000018: 06 00 8c 82 5f 3c 00 00      	jeq r23, 200, __sys_start_thread
80000020: 05 00 00 80 5f 7c 00 00      	release r23, 0, nz, 0x80000028
80000028: 03 00 ff 01 df 2f 00 00      	add r23, r23, -1, true, __sys_atomic_bit_clear

80000030 <__sys_start_thread>:
80000030: 08 00 00 82 73 3c 00 00      	jz id, 0x80000040
80000038: 00 00 10 20 f3 7d 00 00      	boot id, 1
80000040: 00 00 81 46 7f 7b 00 00      	ld d22, id8, 24
80000048: 00 00 b0 00 e3 8b 00 00      	call r23, main

80000050 <__sys_end>:
80000050: 0a 00 00 21 f3 7e 00 00      	stop true, __sys_end

80000058 <main>:
80000058: 00 00 00 b0 73 80 00 00      	move r0, id
80000060: 00 00 00 00 e3 60 00 00      	move r1, 0
80000068: 00 00 00 00 5b 01 00 00      	add r2, r22, 0
80000070: 00 00 02 01 08 70 00 00      	ldma r2, r1, 1
80000078: 12 00 00 83 03 3c 00 00      	jnz r0, 0x80000090
80000080: 00 00 30 00 e3 60 00 00      	move r1, 3
80000088: 00 00 82 20 e4 0c 00 00      	time_cfg r1, r1
80000090: 00 00 8d 00 63 61 00 00      	move r2, 216
80000098: 00 00 30 41 8b 70 00 00      	lbs r1, r2, 3
800000a0: 14 00 00 83 07 7c 00 00      	acquire r1, 0, nz, 0x800000a0
800000a8: 00 00 10 40 8b 71 00 00      	lbu r3, r2, 1
800000b0: 00 00 8d 40 63 71 00 00      	lbu r2, zero, 216
800000b8: 51 00 10 82 0f 3c 00 00      	jeq r3, 1, 0x80000288
800000c0: 5f 00 ff 82 0b 3c 00 00      	jeq r2, 255, 0x800002f8
800000c8: 00 00 cd 41 0b 72 00 00      	lbs r4, r2, 220
800000d0: 00 00 c8 41 80 7e 00 00      	sb r0, 220, r4
800000d8: 00 00 c0 41 88 7e 00 00      	sb r2, 220, r0
800000e0: 00 00 80 41 e0 7e 00 00      	sb zero, 216, r0
800000e8: 00 00 8d 00 63 61 00 00      	move r2, 216
800000f0: ff ff ff ff 8f 01 00 00      	add r3, r3, -1
800000f8: 00 00 16 40 08 7c 00 00      	sb r2, 1, r3
80000100: 21 00 00 80 07 7c 00 00      	release r1, 0, nz, 0x80000108
80000108: 00 00 00 20 f3 7e 00 00      	stop
80000110: 00 00 80 20 e0 0c 00 00      	time r1
80000118: 00 00 00 44 5b 71 00 00      	lw r2, r22, 0
80000120: 3b 00 c4 97 00 3c 00 00      	jges r0, r2, 0x800001d8
80000128: 29 00 00 b1 03 81 00 00      	move r2, r0, true, 0x80000148
80000130: 00 00 00 44 db 71 00 00      	lw r3, r22, 0
80000138: 00 00 10 00 0b 01 00 00      	add r2, r2, 1
80000140: 3b 00 c6 97 08 3c 00 00      	jges r2, r3, 0x800001d8
80000148: 00 00 8c 00 e3 61 00 00      	move r3, 200
80000150: 2a 00 00 83 0f 7c 00 00      	acquire r3, 0, nz, 0x80000150
80000158: 00 00 40 44 5b 72 00 00      	lw r4, r22, 4
80000160: 32 00 10 96 13 3c 00 00      	jlts r4, 1, 0x80000190
80000168: 00 00 00 00 63 62 00 00      	move r4, 0
80000170: 00 00 00 00 63 7c 00 00      	nop
80000178: 00 00 40 44 db 72 00 00      	lw r5, r22, 4
80000180: 00 00 10 00 13 02 00 00      	add r4, r4, 1
80000188: 2e 00 ca 96 10 3c 00 00      	jlts r4, r5, 0x80000170
80000190: 33 00 00 80 0f 7c 00 00      	release r3, 0, nz, 0x80000198
80000198: 00 00 80 44 db 71 00 00      	lw r3, r22, 8
800001a0: 26 00 10 96 0f 3c 00 00      	jlts r3, 1, 0x80000130
800001a8: 00 00 00 00 e3 61 00 00      	move r3, 0
800001b0: 00 00 00 00 63 7c 00 00      	nop
800001b8: 00 00 80 44 5b 72 00 00      	lw r4, r22, 8
800001c0: 00 00 10 00 8f 01 00 00      	add r3, r3, 1
800001c8: 36 00 c8 96 0c 3c 00 00      	jlts r3, r4, 0x800001b0
800001d0: 00 00 62 00 63 8c 00 00      	jump 0x80000130
800001d8: 00 00 00 b0 87 91 00 00      	move.s d2, r1
800001e0: 00 00 80 20 e0 0c 00 00      	time r1
800001e8: 00 00 14 40 87 80 00 00      	lsl r1, r1, 1
800001f0: 00 00 00 b0 87 92 00 00      	move.s d4, r1
800001f8: 00 00 80 20 e0 0c 00 00      	time r1
80000200: 00 00 00 b0 87 93 00 00      	move.s d6, r1
80000208: 00 00 c6 00 9c 0d 00 00      	add r3, r7, r3
80000210: 00 00 c4 20 18 0d 00 00      	addc r2, r6, r2
80000218: 00 00 c6 80 94 0d 00 00      	sub r3, r5, r3
80000220: 00 00 c4 a0 10 0d 00 00      	subc r2, r4, r2
80000228: 00 00 45 40 8f 80 00 00      	lslx r1, r3, 4
80000230: 00 00 42 40 08 82 00 00      	lsl_add r4, r1, r2, 4
80000238: 00 00 44 40 8f 82 00 00      	lsl r5, r3, 4
80000240: ff ff 0f ff 97 51 00 00      	and r3, r5, -16
80000248: 00 00 f0 00 13 51 00 00      	and r2, r4, 15
80000250: 00 00 05 46 d8 7c 00 00      	sd r22, 16, d2
80000258: 00 00 01 00 e3 60 00 00      	move r1, 16
80000260: 00 00 32 40 80 80 00 00      	lsl_add r1, r1, r0, 3
80000268: 00 00 01 00 5b 01 00 00      	add r2, r22, 16
80000270: 00 00 00 00 63 60 00 00      	move r0, 0
80000278: 02 00 02 00 08 70 00 00      	sdma r2, r1, 0
80000280: 00 00 00 00 5f 8c 00 00      	jump r23
80000288: 5d 00 ff 82 0b 3c 00 00      	jeq r2, 255, 0x800002e8
80000290: 00 00 cd 40 8b 71 00 00      	lbu r3, r2, 220
80000298: 58 00 c4 82 0c 3c 00 00      	jeq r3, r2, 0x800002c0
800002a0: 54 00 00 23 0f 7d 00 00      	resume r3, 0, nz, 0x800002a0
800002a8: 00 00 ff 00 8f 51 00 00      	and r3, r3, 255
800002b0: 00 00 cd 40 8f 71 00 00      	lbu r3, r3, 220
800002b8: 54 00 c4 83 0c 3c 00 00      	jneq r3, r2, 0x800002a0
800002c0: 58 00 00 23 0b 7d 00 00      	resume r2, 0, nz, 0x800002c0
800002c8: 00 00 8d 00 63 61 00 00      	move r2, 216
800002d0: 0f 00 0f 40 0b 7c 00 00      	sb r2, 0, -1
800002d8: 00 00 20 41 8b 71 00 00      	lbs r3, r2, 2
800002e0: 00 00 16 40 08 7c 00 00      	sb r2, 1, r3
800002e8: 5e 00 00 80 07 7c 00 00      	release r1, 0, nz, 0x800002f0
800002f0: 00 00 22 00 63 8c 00 00      	jump 0x80000110
800002f8: 00 00 c0 41 80 7e 00 00      	sb r0, 220, r0
80000300: 00 00 c1 00 63 8c 00 00      	jump 0x800000e0
