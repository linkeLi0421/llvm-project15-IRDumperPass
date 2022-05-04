; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel -mtriple=aarch64-linux-gnu -o - %s | FileCheck %s

declare i8* @foo()

define void @call_assert_align() {
; CHECK-LABEL: call_assert_align:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    bl foo
; CHECK-NEXT:    strb wzr, [x0]
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %ptr = call align 8 i8* @foo()
  store i8 0, i8* %ptr
  ret void
}

define i8* @tailcall_assert_align() {
; CHECK-LABEL: tailcall_assert_align:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    b foo
entry:
  %call = tail call align 4 i8* @foo()
  ret i8* %call
}