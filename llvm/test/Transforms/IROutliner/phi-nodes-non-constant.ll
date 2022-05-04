; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --include-generated-funcs
; RUN: opt -S -verify -iroutliner -ir-outlining-no-cost < %s | FileCheck %s

; Show that we do extract phi nodes from the regions.

define void @function1(i32* %a, i32* %b) {
entry:
  %0 = alloca i32, align 4
  %c = load i32, i32* %0, align 4
  br label %test1
test1:
  %e = load i32, i32* %0, align 4
  br label %first
test:
  %d = load i32, i32* %0, align 4
  br label %first
first:
  %1 = phi i32 [ %c, %test ], [ %e, %test1 ]
  store i32 2, i32* %a, align 4
  store i32 3, i32* %b, align 4
  ret void
}

define void @function2(i32* %a, i32* %b) {
entry:
  %0 = alloca i32, align 4
  %c = load i32, i32* %0, align 4
  br label %test1
test1:
  %e = load i32, i32* %0, align 4
  br label %first
test:
  %d = load i32, i32* %0, align 4
  br label %first
first:
  %1 = phi i32 [ %c, %test ], [ %e, %test1 ]
  store i32 2, i32* %a, align 4
  store i32 3, i32* %b, align 4
  ret void
}
; CHECK-LABEL: @function1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @outlined_ir_func_0(i32* [[TMP0]], i32* [[A:%.*]], i32* [[B:%.*]])
; CHECK-NEXT:    ret void
;
;
; CHECK-LABEL: @function2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @outlined_ir_func_0(i32* [[TMP0]], i32* [[A:%.*]], i32* [[B:%.*]])
; CHECK-NEXT:    ret void
;
;
; CHECK: define internal void @outlined_ir_func_0(
; CHECK-NEXT:  newFuncRoot:
; CHECK-NEXT:    br label [[ENTRY_TO_OUTLINE:%.*]]
; CHECK:       entry_to_outline:
; CHECK-NEXT:    [[C:%.*]] = load i32, i32* [[TMP0:%.*]], align 4
; CHECK-NEXT:    br label [[TEST1:%.*]]
; CHECK:       test1:
; CHECK-NEXT:    [[E:%.*]] = load i32, i32* [[TMP0]], align 4
; CHECK-NEXT:    br label [[FIRST:%.*]]
; CHECK:       test:
; CHECK-NEXT:    [[D:%.*]] = load i32, i32* [[TMP0]], align 4
; CHECK-NEXT:    br label [[FIRST]]
; CHECK:       first:
; CHECK-NEXT:    [[TMP3:%.*]] = phi i32 [ [[C]], [[TEST:%.*]] ], [ [[E]], [[TEST1]] ]
; CHECK-NEXT:    store i32 2, i32* [[TMP1:%.*]], align 4
; CHECK-NEXT:    store i32 3, i32* [[TMP2:%.*]], align 4
; CHECK-NEXT:    br label [[ENTRY_AFTER_OUTLINE_EXITSTUB:%.*]]
; CHECK:       entry_after_outline.exitStub:
; CHECK-NEXT:    ret void
;