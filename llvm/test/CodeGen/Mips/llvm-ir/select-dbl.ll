; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips2 -verify-machineinstrs | FileCheck %s \
; RUN:    -check-prefix=M2
; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips32 -verify-machineinstrs | FileCheck %s \
; RUN:    -check-prefix=CMOV32R1
; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips32r2 -verify-machineinstrs | FileCheck %s \
; RUN:    -check-prefix=CMOV32R2
; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips32r3 -verify-machineinstrs | FileCheck %s \
; RUN:    -check-prefix=CMOV32R2
; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips32r5 -verify-machineinstrs | FileCheck %s \
; RUN:    -check-prefix=CMOV32R2
; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips32r6 -verify-machineinstrs | FileCheck %s \
; RUN:    -check-prefix=32R6
; RUN: llc < %s -mtriple=mips64-unknown-linux-gnu -mcpu=mips3 -verify-machineinstrs | FileCheck %s \
; RUN:    -check-prefix=M3
; RUN: llc < %s -mtriple=mips64-unknown-linux-gnu -mcpu=mips4 -verify-machineinstrs | FileCheck %s \
; RUN:    -check-prefix=CMOV64
; RUN: llc < %s -mtriple=mips64-unknown-linux-gnu -mcpu=mips64 -verify-machineinstrs | FileCheck %s \
; RUN:    -check-prefix=CMOV64
; RUN: llc < %s -mtriple=mips64-unknown-linux-gnu -mcpu=mips64r2 -verify-machineinstrs | FileCheck %s \
; RUN:    -check-prefix=CMOV64
; RUN: llc < %s -mtriple=mips64-unknown-linux-gnu -mcpu=mips64r3 -verify-machineinstrs | FileCheck %s \
; RUN:    -check-prefix=CMOV64
; RUN: llc < %s -mtriple=mips64-unknown-linux-gnu -mcpu=mips64r5 -verify-machineinstrs | FileCheck %s \
; RUN:    -check-prefix=CMOV64
; RUN: llc < %s -mtriple=mips64-unknown-linux-gnu -mcpu=mips64r6 -verify-machineinstrs | FileCheck %s \
; RUN:    -check-prefix=64R6
; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips32r3 \
; RUN:   -asm-show-inst -mattr=+micromips -verify-machineinstrs | FileCheck %s \
; RUN:    -check-prefix=MM32R3
; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips32r6 -mattr=+micromips -verify-machineinstrs | FileCheck %s \
; RUN:    -check-prefix=MM32R6

define double @tst_select_i1_double(i1 signext %s, double %x, double %y) {
; M2-LABEL: tst_select_i1_double:
; M2:       # %bb.0: # %entry
; M2-NEXT:    andi $1, $4, 1
; M2-NEXT:    bnez $1, $BB0_2
; M2-NEXT:    nop
; M2-NEXT:  # %bb.1: # %entry
; M2-NEXT:    ldc1 $f0, 16($sp)
; M2-NEXT:    jr $ra
; M2-NEXT:    nop
; M2-NEXT:  $BB0_2:
; M2-NEXT:    mtc1 $7, $f0
; M2-NEXT:    jr $ra
; M2-NEXT:    mtc1 $6, $f1
;
; CMOV32R1-LABEL: tst_select_i1_double:
; CMOV32R1:       # %bb.0: # %entry
; CMOV32R1-NEXT:    mtc1 $7, $f2
; CMOV32R1-NEXT:    mtc1 $6, $f3
; CMOV32R1-NEXT:    andi $1, $4, 1
; CMOV32R1-NEXT:    ldc1 $f0, 16($sp)
; CMOV32R1-NEXT:    jr $ra
; CMOV32R1-NEXT:    movn.d $f0, $f2, $1
;
; CMOV32R2-LABEL: tst_select_i1_double:
; CMOV32R2:       # %bb.0: # %entry
; CMOV32R2-NEXT:    mtc1 $7, $f2
; CMOV32R2-NEXT:    mthc1 $6, $f2
; CMOV32R2-NEXT:    andi $1, $4, 1
; CMOV32R2-NEXT:    ldc1 $f0, 16($sp)
; CMOV32R2-NEXT:    jr $ra
; CMOV32R2-NEXT:    movn.d $f0, $f2, $1
;
; 32R6-LABEL: tst_select_i1_double:
; 32R6:       # %bb.0: # %entry
; 32R6-NEXT:    mtc1 $7, $f1
; 32R6-NEXT:    mthc1 $6, $f1
; 32R6-NEXT:    mtc1 $4, $f0
; 32R6-NEXT:    ldc1 $f2, 16($sp)
; 32R6-NEXT:    jr $ra
; 32R6-NEXT:    sel.d $f0, $f2, $f1
;
; M3-LABEL: tst_select_i1_double:
; M3:       # %bb.0: # %entry
; M3-NEXT:    andi $1, $4, 1
; M3-NEXT:    bnez $1, .LBB0_2
; M3-NEXT:    mov.d $f0, $f13
; M3-NEXT:  # %bb.1: # %entry
; M3-NEXT:    mov.d $f0, $f14
; M3-NEXT:  .LBB0_2: # %entry
; M3-NEXT:    jr $ra
; M3-NEXT:    nop
;
; CMOV64-LABEL: tst_select_i1_double:
; CMOV64:       # %bb.0: # %entry
; CMOV64-NEXT:    mov.d $f0, $f14
; CMOV64-NEXT:    andi $1, $4, 1
; CMOV64-NEXT:    jr $ra
; CMOV64-NEXT:    movn.d $f0, $f13, $1
;
; 64R6-LABEL: tst_select_i1_double:
; 64R6:       # %bb.0: # %entry
; 64R6-NEXT:    mtc1 $4, $f0
; 64R6-NEXT:    jr $ra
; 64R6-NEXT:    sel.d $f0, $f14, $f13
;
; MM32R3-LABEL: tst_select_i1_double:
; MM32R3:       # %bb.0: # %entry
; MM32R3:       mtc1 $7, $f2 # <MCInst #{{.*}} MTC1
; MM32R3:       mthc1 $6, $f2 # <MCInst #{{.*}} MTHC1_D32_MM
; MM32R3:       andi16 $2, $4, 1 # <MCInst #{{.*}} ANDI16_MM
; MM32R3:       ldc1 $f0, 16($sp) # <MCInst #{{.*}} LDC1_MM
; MM32R3:       jr $ra # <MCInst #{{.*}} JR_MM
; MM32R3:       movn.d $f0, $f2, $2 # <MCInst #{{.*}} MOVN_I_D32_MM
;
; MM32R6-LABEL: tst_select_i1_double:
; MM32R6:       # %bb.0: # %entry
; MM32R6-NEXT:    mtc1 $7, $f1
; MM32R6-NEXT:    mthc1 $6, $f1
; MM32R6-NEXT:    mtc1 $4, $f0
; MM32R6-NEXT:    ldc1 $f2, 16($sp)
; MM32R6-NEXT:    sel.d $f0, $f2, $f1
; MM32R6-NEXT:    jrc $ra
entry:
  %r = select i1 %s, double %x, double %y
  ret double %r
}

define double @tst_select_i1_double_reordered(double %x, double %y,
; M2-LABEL: tst_select_i1_double_reordered:
; M2:       # %bb.0: # %entry
; M2-NEXT:    lw $1, 16($sp)
; M2-NEXT:    andi $1, $1, 1
; M2-NEXT:    bnez $1, $BB1_2
; M2-NEXT:    mov.d $f0, $f12
; M2-NEXT:  # %bb.1: # %entry
; M2-NEXT:    mov.d $f0, $f14
; M2-NEXT:  $BB1_2: # %entry
; M2-NEXT:    jr $ra
; M2-NEXT:    nop
;
; CMOV32R1-LABEL: tst_select_i1_double_reordered:
; CMOV32R1:       # %bb.0: # %entry
; CMOV32R1-NEXT:    mov.d $f0, $f14
; CMOV32R1-NEXT:    lw $1, 16($sp)
; CMOV32R1-NEXT:    andi $1, $1, 1
; CMOV32R1-NEXT:    jr $ra
; CMOV32R1-NEXT:    movn.d $f0, $f12, $1
;
; CMOV32R2-LABEL: tst_select_i1_double_reordered:
; CMOV32R2:       # %bb.0: # %entry
; CMOV32R2-NEXT:    mov.d $f0, $f14
; CMOV32R2-NEXT:    lw $1, 16($sp)
; CMOV32R2-NEXT:    andi $1, $1, 1
; CMOV32R2-NEXT:    jr $ra
; CMOV32R2-NEXT:    movn.d $f0, $f12, $1
;
; 32R6-LABEL: tst_select_i1_double_reordered:
; 32R6:       # %bb.0: # %entry
; 32R6-NEXT:    lw $1, 16($sp)
; 32R6-NEXT:    mtc1 $1, $f0
; 32R6-NEXT:    jr $ra
; 32R6-NEXT:    sel.d $f0, $f14, $f12
;
; M3-LABEL: tst_select_i1_double_reordered:
; M3:       # %bb.0: # %entry
; M3-NEXT:    andi $1, $6, 1
; M3-NEXT:    bnez $1, .LBB1_2
; M3-NEXT:    mov.d $f0, $f12
; M3-NEXT:  # %bb.1: # %entry
; M3-NEXT:    mov.d $f0, $f13
; M3-NEXT:  .LBB1_2: # %entry
; M3-NEXT:    jr $ra
; M3-NEXT:    nop
;
; CMOV64-LABEL: tst_select_i1_double_reordered:
; CMOV64:       # %bb.0: # %entry
; CMOV64-NEXT:    mov.d $f0, $f13
; CMOV64-NEXT:    andi $1, $6, 1
; CMOV64-NEXT:    jr $ra
; CMOV64-NEXT:    movn.d $f0, $f12, $1
;
; 64R6-LABEL: tst_select_i1_double_reordered:
; 64R6:       # %bb.0: # %entry
; 64R6-NEXT:    mtc1 $6, $f0
; 64R6-NEXT:    jr $ra
; 64R6-NEXT:    sel.d $f0, $f13, $f12
;
; MM32R3-LABEL: tst_select_i1_double_reordered:
; MM32R3:       # %bb.0: # %entry
; MM32R3:       mov.d $f0, $f14 # <MCInst #{{.*}} FMOV_D32
; MM32R3:       lw $2, 16($sp) # <MCInst #{{.*}} LWSP_MM
; MM32R3:       andi16 $2, $2, 1 # <MCInst #{{.*}} ANDI16_MM
; MM32R3:       jr $ra # <MCInst #{{.*}} JR_MM
; MM32R3:       movn.d $f0, $f12, $2 # <MCInst #{{.*}} MOVN_I_D32_MM
;
; MM32R6-LABEL: tst_select_i1_double_reordered:
; MM32R6:       # %bb.0: # %entry
; MM32R6-NEXT:    lw $1, 16($sp)
; MM32R6-NEXT:    mtc1 $1, $f0
; MM32R6-NEXT:    sel.d $f0, $f14, $f12
; MM32R6-NEXT:    jrc $ra
                                              i1 signext %s) {
entry:
  %r = select i1 %s, double %x, double %y
  ret double %r
}

define double @tst_select_fcmp_olt_double(double %x, double %y) {
; M2-LABEL: tst_select_fcmp_olt_double:
; M2:       # %bb.0: # %entry
; M2-NEXT:    c.olt.d $f12, $f14
; M2-NEXT:    nop
; M2-NEXT:    bc1t $BB2_2
; M2-NEXT:    mov.d $f0, $f12
; M2-NEXT:  # %bb.1: # %entry
; M2-NEXT:    mov.d $f0, $f14
; M2-NEXT:  $BB2_2: # %entry
; M2-NEXT:    jr $ra
; M2-NEXT:    nop
;
; CMOV32R1-LABEL: tst_select_fcmp_olt_double:
; CMOV32R1:       # %bb.0: # %entry
; CMOV32R1-NEXT:    mov.d $f0, $f14
; CMOV32R1-NEXT:    c.olt.d $f12, $f14
; CMOV32R1-NEXT:    jr $ra
; CMOV32R1-NEXT:    movt.d $f0, $f12, $fcc0
;
; CMOV32R2-LABEL: tst_select_fcmp_olt_double:
; CMOV32R2:       # %bb.0: # %entry
; CMOV32R2-NEXT:    mov.d $f0, $f14
; CMOV32R2-NEXT:    c.olt.d $f12, $f14
; CMOV32R2-NEXT:    jr $ra
; CMOV32R2-NEXT:    movt.d $f0, $f12, $fcc0
;
; 32R6-LABEL: tst_select_fcmp_olt_double:
; 32R6:       # %bb.0: # %entry
; 32R6-NEXT:    cmp.lt.d $f0, $f12, $f14
; 32R6-NEXT:    mfc1 $1, $f0
; 32R6-NEXT:    mtc1 $1, $f0
; 32R6-NEXT:    jr $ra
; 32R6-NEXT:    sel.d $f0, $f14, $f12
;
; M3-LABEL: tst_select_fcmp_olt_double:
; M3:       # %bb.0: # %entry
; M3-NEXT:    c.olt.d $f12, $f13
; M3-NEXT:    nop
; M3-NEXT:    bc1t .LBB2_2
; M3-NEXT:    mov.d $f0, $f12
; M3-NEXT:  # %bb.1: # %entry
; M3-NEXT:    mov.d $f0, $f13
; M3-NEXT:  .LBB2_2: # %entry
; M3-NEXT:    jr $ra
; M3-NEXT:    nop
;
; CMOV64-LABEL: tst_select_fcmp_olt_double:
; CMOV64:       # %bb.0: # %entry
; CMOV64-NEXT:    mov.d $f0, $f13
; CMOV64-NEXT:    c.olt.d $f12, $f13
; CMOV64-NEXT:    jr $ra
; CMOV64-NEXT:    movt.d $f0, $f12, $fcc0
;
; 64R6-LABEL: tst_select_fcmp_olt_double:
; 64R6:       # %bb.0: # %entry
; 64R6-NEXT:    cmp.lt.d $f0, $f12, $f13
; 64R6-NEXT:    mfc1 $1, $f0
; 64R6-NEXT:    mtc1 $1, $f0
; 64R6-NEXT:    jr $ra
; 64R6-NEXT:    sel.d $f0, $f13, $f12
;
; MM32R3-LABEL: tst_select_fcmp_olt_double:
; MM32R3:       # %bb.0: # %entry
; MM32R3:       mov.d $f0, $f14 # <MCInst #{{.*}} FMOV_D32
; MM32R3:       c.olt.d $f12, $f14 # <MCInst #{{.*}} FCMP_D32_MM
; MM32R3:       jr $ra # <MCInst #{{.*}} JR_MM
; MM32R3:       movt.d $f0, $f12, $fcc0 # <MCInst #{{.*}} MOVT_D32_MM
;
; MM32R6-LABEL: tst_select_fcmp_olt_double:
; MM32R6:       # %bb.0: # %entry
; MM32R6-NEXT:    cmp.lt.d $f0, $f12, $f14
; MM32R6-NEXT:    mfc1 $1, $f0
; MM32R6-NEXT:    mtc1 $1, $f0
; MM32R6-NEXT:    sel.d $f0, $f14, $f12
; MM32R6-NEXT:    jrc $ra
entry:
  %s = fcmp olt double %x, %y
  %r = select i1 %s, double %x, double %y
  ret double %r
}

define double @tst_select_fcmp_ole_double(double %x, double %y) {
; M2-LABEL: tst_select_fcmp_ole_double:
; M2:       # %bb.0: # %entry
; M2-NEXT:    c.ole.d $f12, $f14
; M2-NEXT:    nop
; M2-NEXT:    bc1t $BB3_2
; M2-NEXT:    mov.d $f0, $f12
; M2-NEXT:  # %bb.1: # %entry
; M2-NEXT:    mov.d $f0, $f14
; M2-NEXT:  $BB3_2: # %entry
; M2-NEXT:    jr $ra
; M2-NEXT:    nop
;
; CMOV32R1-LABEL: tst_select_fcmp_ole_double:
; CMOV32R1:       # %bb.0: # %entry
; CMOV32R1-NEXT:    mov.d $f0, $f14
; CMOV32R1-NEXT:    c.ole.d $f12, $f14
; CMOV32R1-NEXT:    jr $ra
; CMOV32R1-NEXT:    movt.d $f0, $f12, $fcc0
;
; CMOV32R2-LABEL: tst_select_fcmp_ole_double:
; CMOV32R2:       # %bb.0: # %entry
; CMOV32R2-NEXT:    mov.d $f0, $f14
; CMOV32R2-NEXT:    c.ole.d $f12, $f14
; CMOV32R2-NEXT:    jr $ra
; CMOV32R2-NEXT:    movt.d $f0, $f12, $fcc0
;
; 32R6-LABEL: tst_select_fcmp_ole_double:
; 32R6:       # %bb.0: # %entry
; 32R6-NEXT:    cmp.le.d $f0, $f12, $f14
; 32R6-NEXT:    mfc1 $1, $f0
; 32R6-NEXT:    mtc1 $1, $f0
; 32R6-NEXT:    jr $ra
; 32R6-NEXT:    sel.d $f0, $f14, $f12
;
; M3-LABEL: tst_select_fcmp_ole_double:
; M3:       # %bb.0: # %entry
; M3-NEXT:    c.ole.d $f12, $f13
; M3-NEXT:    nop
; M3-NEXT:    bc1t .LBB3_2
; M3-NEXT:    mov.d $f0, $f12
; M3-NEXT:  # %bb.1: # %entry
; M3-NEXT:    mov.d $f0, $f13
; M3-NEXT:  .LBB3_2: # %entry
; M3-NEXT:    jr $ra
; M3-NEXT:    nop
;
; CMOV64-LABEL: tst_select_fcmp_ole_double:
; CMOV64:       # %bb.0: # %entry
; CMOV64-NEXT:    mov.d $f0, $f13
; CMOV64-NEXT:    c.ole.d $f12, $f13
; CMOV64-NEXT:    jr $ra
; CMOV64-NEXT:    movt.d $f0, $f12, $fcc0
;
; 64R6-LABEL: tst_select_fcmp_ole_double:
; 64R6:       # %bb.0: # %entry
; 64R6-NEXT:    cmp.le.d $f0, $f12, $f13
; 64R6-NEXT:    mfc1 $1, $f0
; 64R6-NEXT:    mtc1 $1, $f0
; 64R6-NEXT:    jr $ra
; 64R6-NEXT:    sel.d $f0, $f13, $f12
;
; MM32R3-LABEL: tst_select_fcmp_ole_double:
; MM32R3:       # %bb.0: # %entry
; MM32R3:       mov.d $f0, $f14 # <MCInst #{{.*}} FMOV_D32
; MM32R3:       c.ole.d $f12, $f14 # <MCInst #{{.*}} FCMP_D32_MM
; MM32R3:       jr $ra # <MCInst #{{.*}} JR_MM
; MM32R3:       movt.d $f0, $f12, $fcc0 # <MCInst #{{.*}} MOVT_D32_MM
;
; MM32R6-LABEL: tst_select_fcmp_ole_double:
; MM32R6:       # %bb.0: # %entry
; MM32R6-NEXT:    cmp.le.d $f0, $f12, $f14
; MM32R6-NEXT:    mfc1 $1, $f0
; MM32R6-NEXT:    mtc1 $1, $f0
; MM32R6-NEXT:    sel.d $f0, $f14, $f12
; MM32R6-NEXT:    jrc $ra
entry:
  %s = fcmp ole double %x, %y
  %r = select i1 %s, double %x, double %y
  ret double %r
}

define double @tst_select_fcmp_ogt_double(double %x, double %y) {
; M2-LABEL: tst_select_fcmp_ogt_double:
; M2:       # %bb.0: # %entry
; M2-NEXT:    c.ule.d $f12, $f14
; M2-NEXT:    nop
; M2-NEXT:    bc1f $BB4_2
; M2-NEXT:    mov.d $f0, $f12
; M2-NEXT:  # %bb.1: # %entry
; M2-NEXT:    mov.d $f0, $f14
; M2-NEXT:  $BB4_2: # %entry
; M2-NEXT:    jr $ra
; M2-NEXT:    nop
;
; CMOV32R1-LABEL: tst_select_fcmp_ogt_double:
; CMOV32R1:       # %bb.0: # %entry
; CMOV32R1-NEXT:    mov.d $f0, $f14
; CMOV32R1-NEXT:    c.ule.d $f12, $f14
; CMOV32R1-NEXT:    jr $ra
; CMOV32R1-NEXT:    movf.d $f0, $f12, $fcc0
;
; CMOV32R2-LABEL: tst_select_fcmp_ogt_double:
; CMOV32R2:       # %bb.0: # %entry
; CMOV32R2-NEXT:    mov.d $f0, $f14
; CMOV32R2-NEXT:    c.ule.d $f12, $f14
; CMOV32R2-NEXT:    jr $ra
; CMOV32R2-NEXT:    movf.d $f0, $f12, $fcc0
;
; 32R6-LABEL: tst_select_fcmp_ogt_double:
; 32R6:       # %bb.0: # %entry
; 32R6-NEXT:    cmp.lt.d $f0, $f14, $f12
; 32R6-NEXT:    mfc1 $1, $f0
; 32R6-NEXT:    mtc1 $1, $f0
; 32R6-NEXT:    jr $ra
; 32R6-NEXT:    sel.d $f0, $f14, $f12
;
; M3-LABEL: tst_select_fcmp_ogt_double:
; M3:       # %bb.0: # %entry
; M3-NEXT:    c.ule.d $f12, $f13
; M3-NEXT:    nop
; M3-NEXT:    bc1f .LBB4_2
; M3-NEXT:    mov.d $f0, $f12
; M3-NEXT:  # %bb.1: # %entry
; M3-NEXT:    mov.d $f0, $f13
; M3-NEXT:  .LBB4_2: # %entry
; M3-NEXT:    jr $ra
; M3-NEXT:    nop
;
; CMOV64-LABEL: tst_select_fcmp_ogt_double:
; CMOV64:       # %bb.0: # %entry
; CMOV64-NEXT:    mov.d $f0, $f13
; CMOV64-NEXT:    c.ule.d $f12, $f13
; CMOV64-NEXT:    jr $ra
; CMOV64-NEXT:    movf.d $f0, $f12, $fcc0
;
; 64R6-LABEL: tst_select_fcmp_ogt_double:
; 64R6:       # %bb.0: # %entry
; 64R6-NEXT:    cmp.lt.d $f0, $f13, $f12
; 64R6-NEXT:    mfc1 $1, $f0
; 64R6-NEXT:    mtc1 $1, $f0
; 64R6-NEXT:    jr $ra
; 64R6-NEXT:    sel.d $f0, $f13, $f12
;
; MM32R3-LABEL: tst_select_fcmp_ogt_double:
; MM32R3:       # %bb.0: # %entry
; MM32R3:       mov.d $f0, $f14 # <MCInst #{{.*}} FMOV_D32
; MM32R3:       c.ule.d $f12, $f14 # <MCInst #{{.*}} FCMP_D32_MM
; MM32R3:       jr $ra # <MCInst #{{.*}} JR_MM
; MM32R3:       movf.d $f0, $f12, $fcc0 # <MCInst #{{.*}} MOVF_D32_MM
;
; MM32R6-LABEL: tst_select_fcmp_ogt_double:
; MM32R6:       # %bb.0: # %entry
; MM32R6-NEXT:    cmp.lt.d $f0, $f14, $f12
; MM32R6-NEXT:    mfc1 $1, $f0
; MM32R6-NEXT:    mtc1 $1, $f0
; MM32R6-NEXT:    sel.d $f0, $f14, $f12
; MM32R6-NEXT:    jrc $ra
entry:
  %s = fcmp ogt double %x, %y
  %r = select i1 %s, double %x, double %y
  ret double %r
}

define double @tst_select_fcmp_oge_double(double %x, double %y) {
; M2-LABEL: tst_select_fcmp_oge_double:
; M2:       # %bb.0: # %entry
; M2-NEXT:    c.ult.d $f12, $f14
; M2-NEXT:    nop
; M2-NEXT:    bc1f $BB5_2
; M2-NEXT:    mov.d $f0, $f12
; M2-NEXT:  # %bb.1: # %entry
; M2-NEXT:    mov.d $f0, $f14
; M2-NEXT:  $BB5_2: # %entry
; M2-NEXT:    jr $ra
; M2-NEXT:    nop
;
; CMOV32R1-LABEL: tst_select_fcmp_oge_double:
; CMOV32R1:       # %bb.0: # %entry
; CMOV32R1-NEXT:    mov.d $f0, $f14
; CMOV32R1-NEXT:    c.ult.d $f12, $f14
; CMOV32R1-NEXT:    jr $ra
; CMOV32R1-NEXT:    movf.d $f0, $f12, $fcc0
;
; CMOV32R2-LABEL: tst_select_fcmp_oge_double:
; CMOV32R2:       # %bb.0: # %entry
; CMOV32R2-NEXT:    mov.d $f0, $f14
; CMOV32R2-NEXT:    c.ult.d $f12, $f14
; CMOV32R2-NEXT:    jr $ra
; CMOV32R2-NEXT:    movf.d $f0, $f12, $fcc0
;
; 32R6-LABEL: tst_select_fcmp_oge_double:
; 32R6:       # %bb.0: # %entry
; 32R6-NEXT:    cmp.le.d $f0, $f14, $f12
; 32R6-NEXT:    mfc1 $1, $f0
; 32R6-NEXT:    mtc1 $1, $f0
; 32R6-NEXT:    jr $ra
; 32R6-NEXT:    sel.d $f0, $f14, $f12
;
; M3-LABEL: tst_select_fcmp_oge_double:
; M3:       # %bb.0: # %entry
; M3-NEXT:    c.ult.d $f12, $f13
; M3-NEXT:    nop
; M3-NEXT:    bc1f .LBB5_2
; M3-NEXT:    mov.d $f0, $f12
; M3-NEXT:  # %bb.1: # %entry
; M3-NEXT:    mov.d $f0, $f13
; M3-NEXT:  .LBB5_2: # %entry
; M3-NEXT:    jr $ra
; M3-NEXT:    nop
;
; CMOV64-LABEL: tst_select_fcmp_oge_double:
; CMOV64:       # %bb.0: # %entry
; CMOV64-NEXT:    mov.d $f0, $f13
; CMOV64-NEXT:    c.ult.d $f12, $f13
; CMOV64-NEXT:    jr $ra
; CMOV64-NEXT:    movf.d $f0, $f12, $fcc0
;
; 64R6-LABEL: tst_select_fcmp_oge_double:
; 64R6:       # %bb.0: # %entry
; 64R6-NEXT:    cmp.le.d $f0, $f13, $f12
; 64R6-NEXT:    mfc1 $1, $f0
; 64R6-NEXT:    mtc1 $1, $f0
; 64R6-NEXT:    jr $ra
; 64R6-NEXT:    sel.d $f0, $f13, $f12
;
; MM32R3-LABEL: tst_select_fcmp_oge_double:
; MM32R3:       # %bb.0: # %entry
; MM32R3:       mov.d $f0, $f14 # <MCInst #{{.*}} FMOV_D32
; MM32R3:       c.ult.d $f12, $f14 # <MCInst #{{.*}} FCMP_D32_MM
; MM32R3:       jr $ra # <MCInst #{{.*}} JR_MM
; MM32R3:       movf.d $f0, $f12, $fcc0 # <MCInst #{{.*}} MOVF_D32_MM
;
; MM32R6-LABEL: tst_select_fcmp_oge_double:
; MM32R6:       # %bb.0: # %entry
; MM32R6-NEXT:    cmp.le.d $f0, $f14, $f12
; MM32R6-NEXT:    mfc1 $1, $f0
; MM32R6-NEXT:    mtc1 $1, $f0
; MM32R6-NEXT:    sel.d $f0, $f14, $f12
; MM32R6-NEXT:    jrc $ra
entry:
  %s = fcmp oge double %x, %y
  %r = select i1 %s, double %x, double %y
  ret double %r
}

define double @tst_select_fcmp_oeq_double(double %x, double %y) {
; M2-LABEL: tst_select_fcmp_oeq_double:
; M2:       # %bb.0: # %entry
; M2-NEXT:    c.eq.d $f12, $f14
; M2-NEXT:    nop
; M2-NEXT:    bc1t $BB6_2
; M2-NEXT:    mov.d $f0, $f12
; M2-NEXT:  # %bb.1: # %entry
; M2-NEXT:    mov.d $f0, $f14
; M2-NEXT:  $BB6_2: # %entry
; M2-NEXT:    jr $ra
; M2-NEXT:    nop
;
; CMOV32R1-LABEL: tst_select_fcmp_oeq_double:
; CMOV32R1:       # %bb.0: # %entry
; CMOV32R1-NEXT:    mov.d $f0, $f14
; CMOV32R1-NEXT:    c.eq.d $f12, $f14
; CMOV32R1-NEXT:    jr $ra
; CMOV32R1-NEXT:    movt.d $f0, $f12, $fcc0
;
; CMOV32R2-LABEL: tst_select_fcmp_oeq_double:
; CMOV32R2:       # %bb.0: # %entry
; CMOV32R2-NEXT:    mov.d $f0, $f14
; CMOV32R2-NEXT:    c.eq.d $f12, $f14
; CMOV32R2-NEXT:    jr $ra
; CMOV32R2-NEXT:    movt.d $f0, $f12, $fcc0
;
; 32R6-LABEL: tst_select_fcmp_oeq_double:
; 32R6:       # %bb.0: # %entry
; 32R6-NEXT:    cmp.eq.d $f0, $f12, $f14
; 32R6-NEXT:    mfc1 $1, $f0
; 32R6-NEXT:    mtc1 $1, $f0
; 32R6-NEXT:    jr $ra
; 32R6-NEXT:    sel.d $f0, $f14, $f12
;
; M3-LABEL: tst_select_fcmp_oeq_double:
; M3:       # %bb.0: # %entry
; M3-NEXT:    c.eq.d $f12, $f13
; M3-NEXT:    nop
; M3-NEXT:    bc1t .LBB6_2
; M3-NEXT:    mov.d $f0, $f12
; M3-NEXT:  # %bb.1: # %entry
; M3-NEXT:    mov.d $f0, $f13
; M3-NEXT:  .LBB6_2: # %entry
; M3-NEXT:    jr $ra
; M3-NEXT:    nop
;
; CMOV64-LABEL: tst_select_fcmp_oeq_double:
; CMOV64:       # %bb.0: # %entry
; CMOV64-NEXT:    mov.d $f0, $f13
; CMOV64-NEXT:    c.eq.d $f12, $f13
; CMOV64-NEXT:    jr $ra
; CMOV64-NEXT:    movt.d $f0, $f12, $fcc0
;
; 64R6-LABEL: tst_select_fcmp_oeq_double:
; 64R6:       # %bb.0: # %entry
; 64R6-NEXT:    cmp.eq.d $f0, $f12, $f13
; 64R6-NEXT:    mfc1 $1, $f0
; 64R6-NEXT:    mtc1 $1, $f0
; 64R6-NEXT:    jr $ra
; 64R6-NEXT:    sel.d $f0, $f13, $f12
;
; MM32R3-LABEL: tst_select_fcmp_oeq_double:
; MM32R3:       # %bb.0: # %entry
; MM32R3:       mov.d $f0, $f14 # <MCInst #{{.*}} FMOV_D32
; MM32R3:       c.eq.d $f12, $f14 # <MCInst #{{.*}} FCMP_D32_MM
; MM32R3:       jr $ra # <MCInst #{{.*}} JR_MM
; MM32R3:       movt.d $f0, $f12, $fcc0 # <MCInst #{{.*}} MOVT_D32_MM
;
; MM32R6-LABEL: tst_select_fcmp_oeq_double:
; MM32R6:       # %bb.0: # %entry
; MM32R6-NEXT:    cmp.eq.d $f0, $f12, $f14
; MM32R6-NEXT:    mfc1 $1, $f0
; MM32R6-NEXT:    mtc1 $1, $f0
; MM32R6-NEXT:    sel.d $f0, $f14, $f12
; MM32R6-NEXT:    jrc $ra
entry:
  %s = fcmp oeq double %x, %y
  %r = select i1 %s, double %x, double %y
  ret double %r
}

define double @tst_select_fcmp_one_double(double %x, double %y) {
; M2-LABEL: tst_select_fcmp_one_double:
; M2:       # %bb.0: # %entry
; M2-NEXT:    c.ueq.d $f12, $f14
; M2-NEXT:    nop
; M2-NEXT:    bc1f $BB7_2
; M2-NEXT:    mov.d $f0, $f12
; M2-NEXT:  # %bb.1: # %entry
; M2-NEXT:    mov.d $f0, $f14
; M2-NEXT:  $BB7_2: # %entry
; M2-NEXT:    jr $ra
; M2-NEXT:    nop
;
; CMOV32R1-LABEL: tst_select_fcmp_one_double:
; CMOV32R1:       # %bb.0: # %entry
; CMOV32R1-NEXT:    mov.d $f0, $f14
; CMOV32R1-NEXT:    c.ueq.d $f12, $f14
; CMOV32R1-NEXT:    jr $ra
; CMOV32R1-NEXT:    movf.d $f0, $f12, $fcc0
;
; CMOV32R2-LABEL: tst_select_fcmp_one_double:
; CMOV32R2:       # %bb.0: # %entry
; CMOV32R2-NEXT:    mov.d $f0, $f14
; CMOV32R2-NEXT:    c.ueq.d $f12, $f14
; CMOV32R2-NEXT:    jr $ra
; CMOV32R2-NEXT:    movf.d $f0, $f12, $fcc0
;
; 32R6-LABEL: tst_select_fcmp_one_double:
; 32R6:       # %bb.0: # %entry
; 32R6-NEXT:    cmp.ueq.d $f0, $f12, $f14
; 32R6-NEXT:    mfc1 $1, $f0
; 32R6-NEXT:    not $1, $1
; 32R6-NEXT:    mtc1 $1, $f0
; 32R6-NEXT:    jr $ra
; 32R6-NEXT:    sel.d $f0, $f14, $f12
;
; M3-LABEL: tst_select_fcmp_one_double:
; M3:       # %bb.0: # %entry
; M3-NEXT:    c.ueq.d $f12, $f13
; M3-NEXT:    nop
; M3-NEXT:    bc1f .LBB7_2
; M3-NEXT:    mov.d $f0, $f12
; M3-NEXT:  # %bb.1: # %entry
; M3-NEXT:    mov.d $f0, $f13
; M3-NEXT:  .LBB7_2: # %entry
; M3-NEXT:    jr $ra
; M3-NEXT:    nop
;
; CMOV64-LABEL: tst_select_fcmp_one_double:
; CMOV64:       # %bb.0: # %entry
; CMOV64-NEXT:    mov.d $f0, $f13
; CMOV64-NEXT:    c.ueq.d $f12, $f13
; CMOV64-NEXT:    jr $ra
; CMOV64-NEXT:    movf.d $f0, $f12, $fcc0
;
; 64R6-LABEL: tst_select_fcmp_one_double:
; 64R6:       # %bb.0: # %entry
; 64R6-NEXT:    cmp.ueq.d $f0, $f12, $f13
; 64R6-NEXT:    mfc1 $1, $f0
; 64R6-NEXT:    not $1, $1
; 64R6-NEXT:    mtc1 $1, $f0
; 64R6-NEXT:    jr $ra
; 64R6-NEXT:    sel.d $f0, $f13, $f12
;
; MM32R3-LABEL: tst_select_fcmp_one_double:
; MM32R3:       # %bb.0: # %entry
; MM32R3:       mov.d $f0, $f14 # <MCInst #{{.*}} FMOV_D32
; MM32R3:       c.ueq.d $f12, $f14 # <MCInst #{{.*}} FCMP_D32_MM
; MM32R3:       jr $ra # <MCInst #{{.*}} JR_MM
; MM32R3:       movf.d $f0, $f12, $fcc0 # <MCInst #{{.*}} MOVF_D32_MM
;
; MM32R6-LABEL: tst_select_fcmp_one_double:
; MM32R6:       # %bb.0: # %entry
; MM32R6-NEXT:    cmp.ueq.d $f0, $f12, $f14
; MM32R6-NEXT:    mfc1 $1, $f0
; MM32R6-NEXT:    not $1, $1
; MM32R6-NEXT:    mtc1 $1, $f0
; MM32R6-NEXT:    sel.d $f0, $f14, $f12
; MM32R6-NEXT:    jrc $ra
entry:
  %s = fcmp one double %x, %y
  %r = select i1 %s, double %x, double %y
  ret double %r
}
