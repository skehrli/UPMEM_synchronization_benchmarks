
./bin/bar_kernel_1:	file format elf32-dpu


Disassembly of section .text:

80000000 <__bootstrap>:
80000000: 06 00 00 83 73 3c 00 00      	jnz id, __sys_start_thread
80000008: 00 00 00 46 e3 7c 00 00      	sd zero, 16, 0
80000010: 00 00 9c 00 e3 6b 00 00      	move r23, 201

80000018 <__sys_atomic_bit_clear>:
80000018: 06 00 8c 82 5f 3c 00 00      	jeq r23, 200, __sys_start_thread
80000020: 05 00 00 80 5f 7c 00 00      	release r23, 0, nz, 0x80000028
80000028: 03 00 ff 01 df 2f 00 00      	add r23, r23, -1, true, __sys_atomic_bit_clear

80000030 <__sys_start_thread>:
80000030: 08 00 00 82 73 3c 00 00      	jz id, 0x80000040
80000038: 00 00 10 20 f3 7d 00 00      	boot id, 1
80000040: 00 00 81 46 7f 7b 00 00      	ld d22, id8, 24
80000048: 00 00 63 00 e3 8b 00 00      	call r23, main

80000050 <__sys_end>:
80000050: 0a 00 00 21 f3 7e 00 00      	stop true, __sys_end

80000058 <timer_start>:
80000058: 00 00 8d 46 5a 7c 00 00      	sd r22, 8, d22
80000060: 00 00 01 00 5b 0b 00 00      	add r22, r22, 16
80000068: ff ff 00 45 d8 7f 00 00      	sw r22, -16, r0
80000070: 00 00 4a 00 e3 8b 00 00      	call r23, perfcounter_get
80000078: ff ff 0f 44 5b 71 00 00      	lw r2, r22, -16
80000080: 00 00 01 46 08 7c 00 00      	sd r2, 0, d0
80000088: ff ff 8f 46 5b 7b 00 00      	ld d22, r22, -8
80000090: 00 00 00 00 5f 8c 00 00      	jump r23

80000098 <timer_stop>:
80000098: 00 00 8d 46 5a 7c 00 00      	sd r22, 8, d22
800000a0: 00 00 01 00 5b 0b 00 00      	add r22, r22, 16
800000a8: ff ff 00 45 d8 7f 00 00      	sw r22, -16, r0
800000b0: 00 00 4a 00 e3 8b 00 00      	call r23, perfcounter_get
800000b8: ff ff 0f 44 5b 71 00 00      	lw r2, r22, -16
800000c0: 00 00 81 46 08 7c 00 00      	sd r2, 8, d0
800000c8: 00 00 4a 00 e3 8b 00 00      	call r23, perfcounter_get
800000d0: ff ff 0f 44 5b 71 00 00      	lw r2, r22, -16
800000d8: 00 00 01 46 88 7c 00 00      	sd r2, 16, d0
800000e0: ff ff 0f 44 5b 70 00 00      	lw r0, r22, -16
800000e8: 00 00 80 46 03 71 00 00      	ld d2, r0, 8
800000f0: 00 00 4d 40 8b 80 00 00      	lsrx r1, r2, 4
800000f8: 00 00 42 20 8c 82 00 00      	lsr_add r5, r1, r3, 4
80000100: 00 00 4c 40 0b 82 00 00      	lsr r4, r2, 4
80000108: 00 00 00 46 03 71 00 00      	ld d2, r0, 0
80000110: 00 00 4d 40 8b 80 00 00      	lsrx r1, r2, 4
80000118: 00 00 42 20 8c 83 00 00      	lsr_add r7, r1, r3, 4
80000120: 00 00 4c 40 0b 83 00 00      	lsr r6, r2, 4
80000128: 00 00 ce 80 94 0d 00 00      	sub r3, r5, r7
80000130: 00 00 cc a0 10 0d 00 00      	subc r2, r4, r6
80000138: 00 00 01 46 03 70 00 00      	ld d0, r0, 16
80000140: 00 00 4d 40 03 83 00 00      	lsrx r6, r0, 4
80000148: 00 00 4c 20 84 83 00 00      	lsr_add r7, r6, r1, 4
80000150: 00 00 4c 40 03 83 00 00      	lsr r6, r0, 4
80000158: 00 00 ce 80 94 0c 00 00      	sub r1, r5, r7
80000160: 00 00 cc a0 10 0c 00 00      	subc r0, r4, r6
80000168: 00 00 c2 00 8c 0c 00 00      	add r1, r3, r1
80000170: 00 00 c0 20 08 0c 00 00      	addc r0, r2, r0
80000178: ff ff ff ff 87 51 00 00      	and r3, r1, -1
80000180: 00 00 00 00 03 51 00 00      	and r2, r0, 0
80000188: 00 00 45 40 0f 80 00 00      	lslx r0, r3, 4
80000190: 00 00 40 40 08 80 00 00      	lsl_add r0, r0, r2, 4
80000198: 00 00 44 40 8f 80 00 00      	lsl r1, r3, 4
800001a0: ff ff 8f 46 5b 7b 00 00      	ld d22, r22, -8
800001a8: 00 00 00 00 5f 8c 00 00      	jump r23

800001b0 <main>:
800001b0: 00 00 8d 46 5a 7e 00 00      	sd r22, 72, d22
800001b8: 00 00 05 00 5b 0b 00 00      	add r22, r22, 80
800001c0: 00 f0 00 45 db 7d 00 00      	sw r22, -80, 0
800001c8: ff ff 8b ff 5b 00 00 00      	add r0, r22, -72
800001d0: 00 00 96 00 e3 8b 00 00      	call r23, mram_read
800001d8: 00 00 57 00 e3 8b 00 00      	call r23, me
800001e0: ff ff 80 45 58 7e 00 00      	sw r22, -56, r0
800001e8: ff ff 8c 44 5b 70 00 00      	lw r0, r22, -56
800001f0: 42 00 00 83 03 3c 00 00      	jnz r0, 0x80000210
800001f8: 00 00 04 00 63 8c 00 00      	jump 0x80000200
80000200: 00 00 aa 00 e3 8b 00 00      	call r23, perfcounter_config
80000208: 00 00 24 00 63 8c 00 00      	jump 0x80000210
80000210: 00 00 28 00 e3 8b 00 00      	call r23, barrier_wait
80000218: ff ff 0d ff 5b 00 00 00      	add r0, r22, -48
80000220: 00 00 b0 00 e3 8b 00 00      	call r23, timer_start
80000228: ff ff 8c 44 5b 70 00 00      	lw r0, r22, -56
80000230: ff ff 80 45 58 7f 00 00      	sw r22, -24, r0
80000238: 00 00 84 00 63 8c 00 00      	jump 0x80000240
80000240: ff ff 8e 44 5b 70 00 00      	lw r0, r22, -24
80000248: ff ff 8b 44 db 70 00 00      	lw r1, r22, -72
80000250: 5e 00 c2 97 00 3c 00 00      	jges r0, r1, 0x800002f0
80000258: 00 00 c4 00 63 8c 00 00      	jump 0x80000260
80000260: 00 f0 c0 45 5b 7f 00 00      	sw r22, -20, 0
80000268: 00 00 e4 00 63 8c 00 00      	jump 0x80000270
80000270: ff ff ce 44 5b 70 00 00      	lw r0, r22, -20
80000278: ff ff 0c 44 db 70 00 00      	lw r1, r22, -64
80000280: 58 00 c2 97 00 3c 00 00      	jges r0, r1, 0x800002c0
80000288: 00 00 25 00 63 8c 00 00      	jump 0x80000290
80000290: 00 00 00 00 63 7c 00 00      	nop
80000298: 00 00 45 00 63 8c 00 00      	jump 0x800002a0
800002a0: ff ff ce 44 5b 70 00 00      	lw r0, r22, -20
800002a8: 00 00 10 00 03 00 00 00      	add r0, r0, 1
800002b0: ff ff c0 45 58 7f 00 00      	sw r22, -20, r0
800002b8: 00 00 e4 00 63 8c 00 00      	jump 0x80000270
800002c0: 00 00 28 00 e3 8b 00 00      	call r23, barrier_wait
800002c8: 00 00 a5 00 63 8c 00 00      	jump 0x800002d0
800002d0: ff ff 8e 44 5b 70 00 00      	lw r0, r22, -24
800002d8: 00 00 10 00 03 00 00 00      	add r0, r0, 1
800002e0: ff ff 80 45 58 7f 00 00      	sw r22, -24, r0
800002e8: 00 00 84 00 63 8c 00 00      	jump 0x80000240
800002f0: ff ff 0d ff 5b 00 00 00      	add r0, r22, -48
800002f8: 00 00 31 00 e3 8b 00 00      	call r23, timer_stop
80000300: ff ff 01 47 d8 7f 00 00      	sd r22, -16, d0
80000308: ff ff 8c 44 5b 70 00 00      	lw r0, r22, -56
80000310: 00 00 01 00 e3 60 00 00      	move r1, 16
80000318: 00 00 32 40 80 80 00 00      	lsl_add r1, r1, r0, 3
80000320: ff ff 0f ff 5b 00 00 00      	add r0, r22, -16
80000328: 00 00 77 00 e3 8b 00 00      	call r23, mram_write
80000330: 00 00 00 00 63 60 00 00      	move r0, 0
80000338: ff ff 8f 46 5b 7b 00 00      	ld d22, r22, -8
80000340: 00 00 00 00 5f 8c 00 00      	jump r23

80000348 <mram_read>:
80000348: 00 00 00 00 e3 60 00 00      	move r1, 0
80000350: 00 00 02 44 58 7c 00 00      	sw r22, 0, r1
80000358: 00 00 40 44 58 7c 00 00      	sw r22, 4, r0
80000360: 01 00 80 44 5b 7c 00 00      	sw r22, 8, 16
80000368: 00 00 40 44 5b 70 00 00      	lw r0, r22, 4
80000370: 00 00 00 44 db 70 00 00      	lw r1, r22, 0
80000378: 00 00 80 44 5b 71 00 00      	lw r2, r22, 8
80000380: ff ff ff ff e3 61 00 00      	move r3, -1
80000388: 00 00 36 20 08 81 00 00      	lsr_add r2, r3, r2, 3
80000390: 00 00 80 50 08 80 00 00      	lsl_add r0, r0, r2, 24
80000398: 00 00 02 00 00 70 00 00      	ldma r0, r1, 0
800003a0: 00 00 00 00 5f 8c 00 00      	jump r23

800003a8 <me>:
800003a8: 00 00 00 b0 73 80 00 00      	move r0, id
800003b0: 00 00 00 00 5f 8c 00 00      	jump r23

800003b8 <mram_write>:
800003b8: 00 00 00 44 58 7c 00 00      	sw r22, 0, r0
800003c0: 00 00 42 44 58 7c 00 00      	sw r22, 4, r1
800003c8: 00 00 88 44 5b 7c 00 00      	sw r22, 8, 8
800003d0: 00 00 00 44 5b 70 00 00      	lw r0, r22, 0
800003d8: 00 00 40 44 db 70 00 00      	lw r1, r22, 4
800003e0: 00 00 80 44 5b 71 00 00      	lw r2, r22, 8
800003e8: ff ff ff ff e3 61 00 00      	move r3, -1
800003f0: 00 00 36 20 08 81 00 00      	lsr_add r2, r3, r2, 3
800003f8: 00 00 80 50 08 80 00 00      	lsl_add r0, r0, r2, 24
80000400: 02 00 02 00 00 70 00 00      	sdma r0, r1, 0
80000408: 00 00 00 00 5f 8c 00 00      	jump r23

80000410 <barrier_wait>:
80000410: 00 00 8d 00 e3 60 00 00      	move r1, 216
80000418: 00 00 30 41 07 70 00 00      	lbs r0, r1, 3
80000420: 84 00 00 83 03 7c 00 00      	acquire r0, 0, nz, 0x80000420
80000428: 00 00 10 40 07 71 00 00      	lbu r2, r1, 1
80000430: 00 00 8d 40 e3 70 00 00      	lbu r1, zero, 216
80000438: 94 00 10 82 0b 3c 00 00      	jeq r2, 1, 0x800004a0
80000440: 00 00 00 b0 f3 81 00 00      	move r3, id
80000448: a2 00 ff 82 07 3c 00 00      	jeq r1, 255, 0x80000510
80000450: 00 00 cd 41 07 72 00 00      	lbs r4, r1, 220
80000458: 00 00 c8 41 8c 7e 00 00      	sb r3, 220, r4
80000460: 00 00 c6 41 84 7e 00 00      	sb r1, 220, r3
80000468: 00 00 86 41 e0 7e 00 00      	sb zero, 216, r3
80000470: 00 00 8d 00 e3 60 00 00      	move r1, 216
80000478: ff ff ff ff 0b 01 00 00      	add r2, r2, -1
80000480: 00 00 14 40 04 7c 00 00      	sb r1, 1, r2
80000488: 92 00 00 80 03 7c 00 00      	release r0, 0, nz, 0x80000490
80000490: 00 00 00 20 f3 7e 00 00      	stop
80000498: 00 00 00 00 5f 8c 00 00      	jump r23
800004a0: a0 00 ff 82 07 3c 00 00      	jeq r1, 255, 0x80000500
800004a8: 00 00 cd 40 07 71 00 00      	lbu r2, r1, 220
800004b0: 9b 00 c2 82 08 3c 00 00      	jeq r2, r1, 0x800004d8
800004b8: 97 00 00 23 0b 7d 00 00      	resume r2, 0, nz, 0x800004b8
800004c0: 00 00 ff 00 0b 51 00 00      	and r2, r2, 255
800004c8: 00 00 cd 40 0b 71 00 00      	lbu r2, r2, 220
800004d0: 97 00 c2 83 08 3c 00 00      	jneq r2, r1, 0x800004b8
800004d8: 9b 00 00 23 07 7d 00 00      	resume r1, 0, nz, 0x800004d8
800004e0: 00 00 8d 00 e3 60 00 00      	move r1, 216
800004e8: 0f 00 0f 40 07 7c 00 00      	sb r1, 0, -1
800004f0: 00 00 20 41 07 71 00 00      	lbs r2, r1, 2
800004f8: 00 00 14 40 04 7c 00 00      	sb r1, 1, r2
80000500: a1 00 00 80 03 7c 00 00      	release r0, 0, nz, 0x80000508
80000508: 00 00 00 00 5f 8c 00 00      	jump r23
80000510: 00 00 c6 41 8c 7e 00 00      	sb r3, 220, r3
80000518: 00 00 d8 00 63 8c 00 00      	jump 0x80000468

80000520 <perfcounter_get>:
80000520: 00 00 80 20 60 0c 00 00      	time r0
80000528: 00 00 00 b0 03 91 00 00      	move.u d2, r0
80000530: 00 00 45 40 0f 80 00 00      	lslx r0, r3, 4
80000538: 00 00 40 40 08 80 00 00      	lsl_add r0, r0, r2, 4
80000540: 00 00 44 40 8f 80 00 00      	lsl r1, r3, 4
80000548: 00 00 00 00 5f 8c 00 00      	jump r23

80000550 <perfcounter_config>:
80000550: 00 00 30 00 63 60 00 00      	move r0, 3
80000558: 00 00 80 20 64 0c 00 00      	time_cfg r0, r0
80000560: 00 00 00 00 5f 8c 00 00      	jump r23
