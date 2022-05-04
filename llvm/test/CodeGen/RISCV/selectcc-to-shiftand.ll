; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=riscv32 \
; RUN:   | FileCheck %s --check-prefixes=CHECK,RV32,RV32I
; RUN: llc < %s -mtriple=riscv64 \
; RUN:   | FileCheck %s --check-prefixes=CHECK,RV64,RV64I
; RUN: llc < %s -mtriple=riscv32 -mattr=+zbb \
; RUN:   | FileCheck %s --check-prefixes=CHECK,RV32,RV32ZBB
; RUN: llc < %s -mtriple=riscv64 -mattr=+zbb \
; RUN:   | FileCheck %s --check-prefixes=CHECK,RV64,RV64ZBB

; Compare if negative and select of constants where one constant is zero.
define i32 @neg_sel_constants(i32 signext %a) {
; RV32-LABEL: neg_sel_constants:
; RV32:       # %bb.0:
; RV32-NEXT:    srai a0, a0, 31
; RV32-NEXT:    andi a0, a0, 5
; RV32-NEXT:    ret
;
; RV64-LABEL: neg_sel_constants:
; RV64:       # %bb.0:
; RV64-NEXT:    srai a0, a0, 63
; RV64-NEXT:    andi a0, a0, 5
; RV64-NEXT:    ret
  %tmp.1 = icmp slt i32 %a, 0
  %retval = select i1 %tmp.1, i32 5, i32 0
  ret i32 %retval
}

; Compare if negative and select of constants where one constant is zero and the
; other is a single bit.
define i32 @neg_sel_special_constant(i32 signext %a) {
; RV32-LABEL: neg_sel_special_constant:
; RV32:       # %bb.0:
; RV32-NEXT:    srli a0, a0, 31
; RV32-NEXT:    slli a0, a0, 9
; RV32-NEXT:    ret
;
; RV64-LABEL: neg_sel_special_constant:
; RV64:       # %bb.0:
; RV64-NEXT:    li a1, 1
; RV64-NEXT:    slli a1, a1, 31
; RV64-NEXT:    and a0, a0, a1
; RV64-NEXT:    srli a0, a0, 22
; RV64-NEXT:    ret
  %tmp.1 = icmp slt i32 %a, 0
  %retval = select i1 %tmp.1, i32 512, i32 0
  ret i32 %retval
}

; Compare if negative and select variable or zero.
define i32 @neg_sel_variable_and_zero(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: neg_sel_variable_and_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    srai a0, a0, 31
; CHECK-NEXT:    and a0, a0, a1
; CHECK-NEXT:    ret
  %tmp.1 = icmp slt i32 %a, 0
  %retval = select i1 %tmp.1, i32 %b, i32 0
  ret i32 %retval
}

; Compare if not positive and select the same variable as being compared:
; smin(a, 0).
define i32 @not_pos_sel_same_variable(i32 signext %a) {
; CHECK-LABEL: not_pos_sel_same_variable:
; CHECK:       # %bb.0:
; CHECK-NEXT:    srai a1, a0, 31
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    ret
  %tmp = icmp slt i32 %a, 1
  %min = select i1 %tmp, i32 %a, i32 0
  ret i32 %min
}

; Flipping the comparison condition can be handled by getting the bitwise not of
; the sign mask.
; TODO: We aren't doing a good job of this.

; Compare if positive and select of constants where one constant is zero.
define i32 @pos_sel_constants(i32 signext %a) {
; CHECK-LABEL: pos_sel_constants:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mv a1, a0
; CHECK-NEXT:    li a0, 5
; CHECK-NEXT:    bgez a1, .LBB4_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    li a0, 0
; CHECK-NEXT:  .LBB4_2:
; CHECK-NEXT:    ret
  %tmp.1 = icmp sgt i32 %a, -1
  %retval = select i1 %tmp.1, i32 5, i32 0
  ret i32 %retval
}

; Compare if positive and select of constants where one constant is zero and the
; other is a single bit.
; TODO: Why do RV32 and RV64 generate different code? RV64 uses more registers,
; but the addi isn't part of the dependency chain of %a so may be faster.
define i32 @pos_sel_special_constant(i32 signext %a) {
; RV32-LABEL: pos_sel_special_constant:
; RV32:       # %bb.0:
; RV32-NEXT:    not a0, a0
; RV32-NEXT:    srli a0, a0, 31
; RV32-NEXT:    slli a0, a0, 9
; RV32-NEXT:    ret
;
; RV64-LABEL: pos_sel_special_constant:
; RV64:       # %bb.0:
; RV64-NEXT:    slti a0, a0, 0
; RV64-NEXT:    xori a0, a0, 1
; RV64-NEXT:    slli a0, a0, 9
; RV64-NEXT:    ret
  %tmp.1 = icmp sgt i32 %a, -1
  %retval = select i1 %tmp.1, i32 512, i32 0
  ret i32 %retval
}

; Compare if positive and select variable or zero.
define i32 @pos_sel_variable_and_zero(i32 signext %a, i32 signext %b) {
; RV32I-LABEL: pos_sel_variable_and_zero:
; RV32I:       # %bb.0:
; RV32I-NEXT:    bgez a0, .LBB6_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    li a1, 0
; RV32I-NEXT:  .LBB6_2:
; RV32I-NEXT:    mv a0, a1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: pos_sel_variable_and_zero:
; RV64I:       # %bb.0:
; RV64I-NEXT:    bgez a0, .LBB6_2
; RV64I-NEXT:  # %bb.1:
; RV64I-NEXT:    li a1, 0
; RV64I-NEXT:  .LBB6_2:
; RV64I-NEXT:    mv a0, a1
; RV64I-NEXT:    ret
;
; RV32ZBB-LABEL: pos_sel_variable_and_zero:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    srai a0, a0, 31
; RV32ZBB-NEXT:    andn a0, a1, a0
; RV32ZBB-NEXT:    ret
;
; RV64ZBB-LABEL: pos_sel_variable_and_zero:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    srai a0, a0, 31
; RV64ZBB-NEXT:    andn a0, a1, a0
; RV64ZBB-NEXT:    ret
  %tmp.1 = icmp sgt i32 %a, -1
  %retval = select i1 %tmp.1, i32 %b, i32 0
  ret i32 %retval
}

; Compare if not negative or zero and select the same variable as being
; compared: smax(a, 0).
define i32 @not_neg_sel_same_variable(i32 signext %a) {
; RV32I-LABEL: not_neg_sel_same_variable:
; RV32I:       # %bb.0:
; RV32I-NEXT:    bgtz a0, .LBB7_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    li a0, 0
; RV32I-NEXT:  .LBB7_2:
; RV32I-NEXT:    ret
;
; RV64I-LABEL: not_neg_sel_same_variable:
; RV64I:       # %bb.0:
; RV64I-NEXT:    bgtz a0, .LBB7_2
; RV64I-NEXT:  # %bb.1:
; RV64I-NEXT:    li a0, 0
; RV64I-NEXT:  .LBB7_2:
; RV64I-NEXT:    ret
;
; RV32ZBB-LABEL: not_neg_sel_same_variable:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    max a0, a0, zero
; RV32ZBB-NEXT:    ret
;
; RV64ZBB-LABEL: not_neg_sel_same_variable:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    max a0, a0, zero
; RV64ZBB-NEXT:    ret
  %tmp = icmp sgt i32 %a, 0
  %min = select i1 %tmp, i32 %a, i32 0
  ret i32 %min
}

; ret = (x-y) > 0 ? x-y : 0
define i32 @sub_clamp_zero(i32 signext %x, i32 signext %y) {
; RV32I-LABEL: sub_clamp_zero:
; RV32I:       # %bb.0:
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    bgtz a0, .LBB8_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    li a0, 0
; RV32I-NEXT:  .LBB8_2:
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sub_clamp_zero:
; RV64I:       # %bb.0:
; RV64I-NEXT:    subw a0, a0, a1
; RV64I-NEXT:    bgtz a0, .LBB8_2
; RV64I-NEXT:  # %bb.1:
; RV64I-NEXT:    li a0, 0
; RV64I-NEXT:  .LBB8_2:
; RV64I-NEXT:    ret
;
; RV32ZBB-LABEL: sub_clamp_zero:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    sub a0, a0, a1
; RV32ZBB-NEXT:    max a0, a0, zero
; RV32ZBB-NEXT:    ret
;
; RV64ZBB-LABEL: sub_clamp_zero:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    subw a0, a0, a1
; RV64ZBB-NEXT:    max a0, a0, zero
; RV64ZBB-NEXT:    ret
  %sub = sub nsw i32 %x, %y
  %cmp = icmp sgt i32 %sub, 0
  %sel = select i1 %cmp, i32 %sub, i32 0
  ret i32 %sel
}

define i8 @sel_shift_bool_i8(i1 %t) {
; CHECK-LABEL: sel_shift_bool_i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    andi a1, a0, 1
; CHECK-NEXT:    li a0, -128
; CHECK-NEXT:    bnez a1, .LBB9_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    li a0, 0
; CHECK-NEXT:  .LBB9_2:
; CHECK-NEXT:    ret
  %shl = select i1 %t, i8 128, i8 0
  ret i8 %shl
}

define i16 @sel_shift_bool_i16(i1 %t) {
; CHECK-LABEL: sel_shift_bool_i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    andi a0, a0, 1
; CHECK-NEXT:    slli a0, a0, 7
; CHECK-NEXT:    ret
  %shl = select i1 %t, i16 128, i16 0
  ret i16 %shl
}

define i32 @sel_shift_bool_i32(i1 %t) {
; CHECK-LABEL: sel_shift_bool_i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    andi a0, a0, 1
; CHECK-NEXT:    slli a0, a0, 6
; CHECK-NEXT:    ret
  %shl = select i1 %t, i32 64, i32 0
  ret i32 %shl
}

define i64 @sel_shift_bool_i64(i1 %t) {
; RV32-LABEL: sel_shift_bool_i64:
; RV32:       # %bb.0:
; RV32-NEXT:    andi a0, a0, 1
; RV32-NEXT:    slli a0, a0, 16
; RV32-NEXT:    li a1, 0
; RV32-NEXT:    ret
;
; RV64-LABEL: sel_shift_bool_i64:
; RV64:       # %bb.0:
; RV64-NEXT:    andi a0, a0, 1
; RV64-NEXT:    slli a0, a0, 16
; RV64-NEXT:    ret
  %shl = select i1 %t, i64 65536, i64 0
  ret i64 %shl
}