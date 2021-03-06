; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -O3 -S | FileCheck %s

target triple = "x86_64-unknown-linux-gnu"

%struct.data_t = type { [16 x i8] }

declare void @process6data_t(i64, i64)
declare void @process36data_tS_S_(i64, i64, i64, i64, i64, i64)

; See https://llvm.org/PR47023 for source examples.
; In all tests, we expect the i8 constant stores to get merged optimally
; (through SROA, combining, etc.) so that there are no store insts left.

define void @bad1() #0 {
; CHECK-LABEL: @bad1(
; CHECK-NEXT:    call void @process6data_t(i64 21542142465, i64 0)
; CHECK-NEXT:    ret void
;
  %1 = alloca %struct.data_t, align 1
  %2 = getelementptr inbounds %struct.data_t, %struct.data_t* %1, i32 0, i32 0
  %3 = getelementptr inbounds [16 x i8], [16 x i8]* %2, i64 0, i64 0
  store i8 1, i8* %3, align 1
  %4 = getelementptr inbounds i8, i8* %3, i64 1
  store i8 2, i8* %4, align 1
  %5 = getelementptr inbounds i8, i8* %4, i64 1
  store i8 3, i8* %5, align 1
  %6 = getelementptr inbounds i8, i8* %5, i64 1
  store i8 4, i8* %6, align 1
  %7 = getelementptr inbounds i8, i8* %6, i64 1
  store i8 5, i8* %7, align 1
  %8 = getelementptr inbounds i8, i8* %7, i64 1
  %9 = getelementptr inbounds i8, i8* %3, i64 16
  br label %10

10:                                               ; preds = %10, %0
  %11 = phi i8* [ %8, %0 ], [ %12, %10 ]
  store i8 0, i8* %11, align 1
  %12 = getelementptr inbounds i8, i8* %11, i64 1
  %13 = icmp eq i8* %12, %9
  br i1 %13, label %14, label %10

14:                                               ; preds = %10
  %15 = bitcast %struct.data_t* %1 to { i64, i64 }*
  %16 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %15, i32 0, i32 0
  %17 = load i64, i64* %16, align 1
  %18 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %15, i32 0, i32 1
  %19 = load i64, i64* %18, align 1
  call void @process6data_t(i64 %17, i64 %19)
  ret void
}

define void @bad2() #0 {
; CHECK-LABEL: @bad2(
; CHECK-NEXT:    call void @process6data_t(i64 216736853120975361, i64 1411785848587524)
; CHECK-NEXT:    ret void
;
  %1 = alloca %struct.data_t, align 1
  %2 = getelementptr inbounds %struct.data_t, %struct.data_t* %1, i32 0, i32 0
  %3 = getelementptr inbounds [16 x i8], [16 x i8]* %2, i64 0, i64 0
  store i8 1, i8* %3, align 1
  %4 = getelementptr inbounds i8, i8* %3, i64 1
  store i8 2, i8* %4, align 1
  %5 = getelementptr inbounds i8, i8* %4, i64 1
  store i8 3, i8* %5, align 1
  %6 = getelementptr inbounds i8, i8* %5, i64 1
  store i8 4, i8* %6, align 1
  %7 = getelementptr inbounds i8, i8* %6, i64 1
  store i8 5, i8* %7, align 1
  %8 = getelementptr inbounds i8, i8* %7, i64 1
  store i8 1, i8* %8, align 1
  %9 = getelementptr inbounds i8, i8* %8, i64 1
  store i8 2, i8* %9, align 1
  %10 = getelementptr inbounds i8, i8* %9, i64 1
  store i8 3, i8* %10, align 1
  %11 = getelementptr inbounds i8, i8* %10, i64 1
  store i8 4, i8* %11, align 1
  %12 = getelementptr inbounds i8, i8* %11, i64 1
  store i8 5, i8* %12, align 1
  %13 = getelementptr inbounds i8, i8* %12, i64 1
  store i8 1, i8* %13, align 1
  %14 = getelementptr inbounds i8, i8* %13, i64 1
  store i8 2, i8* %14, align 1
  %15 = getelementptr inbounds i8, i8* %14, i64 1
  store i8 3, i8* %15, align 1
  %16 = getelementptr inbounds i8, i8* %15, i64 1
  store i8 4, i8* %16, align 1
  %17 = getelementptr inbounds i8, i8* %16, i64 1
  store i8 5, i8* %17, align 1
  %18 = getelementptr inbounds i8, i8* %17, i64 1
  %19 = getelementptr inbounds i8, i8* %3, i64 16
  br label %20

20:                                               ; preds = %20, %0
  %21 = phi i8* [ %18, %0 ], [ %22, %20 ]
  store i8 0, i8* %21, align 1
  %22 = getelementptr inbounds i8, i8* %21, i64 1
  %23 = icmp eq i8* %22, %19
  br i1 %23, label %24, label %20

24:                                               ; preds = %20
  %25 = bitcast %struct.data_t* %1 to { i64, i64 }*
  %26 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %25, i32 0, i32 0
  %27 = load i64, i64* %26, align 1
  %28 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %25, i32 0, i32 1
  %29 = load i64, i64* %28, align 1
  call void @process6data_t(i64 %27, i64 %29)
  ret void
}

define void @bad3() {
; CHECK-LABEL: @bad3(
; CHECK-NEXT:    call void @process36data_tS_S_(i64 21542142465, i64 0, i64 723401749922909195, i64 723401728380766730, i64 1446803478303675925, i64 5651576002974730)
; CHECK-NEXT:    ret void
;
  %1 = alloca %struct.data_t, align 1
  %2 = alloca %struct.data_t, align 1
  %3 = alloca %struct.data_t, align 1
  %4 = getelementptr inbounds %struct.data_t, %struct.data_t* %1, i32 0, i32 0
  %5 = getelementptr inbounds [16 x i8], [16 x i8]* %4, i64 0, i64 0
  store i8 1, i8* %5, align 1
  %6 = getelementptr inbounds i8, i8* %5, i64 1
  store i8 2, i8* %6, align 1
  %7 = getelementptr inbounds i8, i8* %6, i64 1
  store i8 3, i8* %7, align 1
  %8 = getelementptr inbounds i8, i8* %7, i64 1
  store i8 4, i8* %8, align 1
  %9 = getelementptr inbounds i8, i8* %8, i64 1
  store i8 5, i8* %9, align 1
  %10 = getelementptr inbounds i8, i8* %9, i64 1
  store i8 0, i8* %10, align 1
  %11 = getelementptr inbounds i8, i8* %10, i64 1
  store i8 0, i8* %11, align 1
  %12 = getelementptr inbounds i8, i8* %11, i64 1
  store i8 0, i8* %12, align 1
  %13 = getelementptr inbounds i8, i8* %12, i64 1
  store i8 0, i8* %13, align 1
  %14 = getelementptr inbounds i8, i8* %13, i64 1
  store i8 0, i8* %14, align 1
  %15 = getelementptr inbounds i8, i8* %14, i64 1
  store i8 0, i8* %15, align 1
  %16 = getelementptr inbounds i8, i8* %15, i64 1
  store i8 0, i8* %16, align 1
  %17 = getelementptr inbounds i8, i8* %16, i64 1
  store i8 0, i8* %17, align 1
  %18 = getelementptr inbounds i8, i8* %17, i64 1
  store i8 0, i8* %18, align 1
  %19 = getelementptr inbounds i8, i8* %18, i64 1
  store i8 0, i8* %19, align 1
  %20 = getelementptr inbounds i8, i8* %19, i64 1
  store i8 0, i8* %20, align 1
  %21 = getelementptr inbounds %struct.data_t, %struct.data_t* %2, i32 0, i32 0
  %22 = getelementptr inbounds [16 x i8], [16 x i8]* %21, i64 0, i64 0
  store i8 11, i8* %22, align 1
  %23 = getelementptr inbounds i8, i8* %22, i64 1
  store i8 12, i8* %23, align 1
  %24 = getelementptr inbounds i8, i8* %23, i64 1
  store i8 13, i8* %24, align 1
  %25 = getelementptr inbounds i8, i8* %24, i64 1
  store i8 14, i8* %25, align 1
  %26 = getelementptr inbounds i8, i8* %25, i64 1
  store i8 15, i8* %26, align 1
  %27 = getelementptr inbounds i8, i8* %26, i64 1
  store i8 10, i8* %27, align 1
  %28 = getelementptr inbounds i8, i8* %27, i64 1
  store i8 10, i8* %28, align 1
  %29 = getelementptr inbounds i8, i8* %28, i64 1
  store i8 10, i8* %29, align 1
  %30 = getelementptr inbounds i8, i8* %29, i64 1
  store i8 10, i8* %30, align 1
  %31 = getelementptr inbounds i8, i8* %30, i64 1
  store i8 10, i8* %31, align 1
  %32 = getelementptr inbounds i8, i8* %31, i64 1
  store i8 10, i8* %32, align 1
  %33 = getelementptr inbounds i8, i8* %32, i64 1
  store i8 10, i8* %33, align 1
  %34 = getelementptr inbounds i8, i8* %33, i64 1
  store i8 10, i8* %34, align 1
  %35 = getelementptr inbounds i8, i8* %34, i64 1
  store i8 10, i8* %35, align 1
  %36 = getelementptr inbounds i8, i8* %35, i64 1
  store i8 10, i8* %36, align 1
  %37 = getelementptr inbounds i8, i8* %36, i64 1
  store i8 10, i8* %37, align 1
  %38 = getelementptr inbounds %struct.data_t, %struct.data_t* %3, i32 0, i32 0
  %39 = getelementptr inbounds [16 x i8], [16 x i8]* %38, i64 0, i64 0
  store i8 21, i8* %39, align 1
  %40 = getelementptr inbounds i8, i8* %39, i64 1
  store i8 22, i8* %40, align 1
  %41 = getelementptr inbounds i8, i8* %40, i64 1
  store i8 23, i8* %41, align 1
  %42 = getelementptr inbounds i8, i8* %41, i64 1
  store i8 24, i8* %42, align 1
  %43 = getelementptr inbounds i8, i8* %42, i64 1
  store i8 25, i8* %43, align 1
  %44 = getelementptr inbounds i8, i8* %43, i64 1
  store i8 20, i8* %44, align 1
  %45 = getelementptr inbounds i8, i8* %44, i64 1
  store i8 20, i8* %45, align 1
  %46 = getelementptr inbounds i8, i8* %45, i64 1
  store i8 20, i8* %46, align 1
  %47 = getelementptr inbounds i8, i8* %46, i64 1
  store i8 10, i8* %47, align 1
  %48 = getelementptr inbounds i8, i8* %47, i64 1
  store i8 20, i8* %48, align 1
  %49 = getelementptr inbounds i8, i8* %48, i64 1
  store i8 20, i8* %49, align 1
  %50 = getelementptr inbounds i8, i8* %49, i64 1
  store i8 20, i8* %50, align 1
  %51 = getelementptr inbounds i8, i8* %50, i64 1
  store i8 20, i8* %51, align 1
  %52 = getelementptr inbounds i8, i8* %51, i64 1
  store i8 20, i8* %52, align 1
  %53 = getelementptr inbounds i8, i8* %52, i64 1
  store i8 20, i8* %53, align 1
  %54 = getelementptr inbounds i8, i8* %53, i64 1
  %55 = getelementptr inbounds i8, i8* %39, i64 16
  br label %56

56:                                               ; preds = %56, %0
  %57 = phi i8* [ %54, %0 ], [ %58, %56 ]
  store i8 0, i8* %57, align 1
  %58 = getelementptr inbounds i8, i8* %57, i64 1
  %59 = icmp eq i8* %58, %55
  br i1 %59, label %60, label %56

60:                                               ; preds = %56
  %61 = bitcast %struct.data_t* %1 to { i64, i64 }*
  %62 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %61, i32 0, i32 0
  %63 = load i64, i64* %62, align 1
  %64 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %61, i32 0, i32 1
  %65 = load i64, i64* %64, align 1
  %66 = bitcast %struct.data_t* %2 to { i64, i64 }*
  %67 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %66, i32 0, i32 0
  %68 = load i64, i64* %67, align 1
  %69 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %66, i32 0, i32 1
  %70 = load i64, i64* %69, align 1
  %71 = bitcast %struct.data_t* %3 to { i64, i64 }*
  %72 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %71, i32 0, i32 0
  %73 = load i64, i64* %72, align 1
  %74 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %71, i32 0, i32 1
  %75 = load i64, i64* %74, align 1
  call void @process36data_tS_S_(i64 %63, i64 %65, i64 %68, i64 %70, i64 %73, i64 %75)
  ret void
}

define void @bad4() #0 {
; CHECK-LABEL: @bad4(
; CHECK-NEXT:    tail call void @process36data_tS_S_(i64 21542142465, i64 0, i64 723401749922909195, i64 723401728380766730, i64 1446803478303675925, i64 798285110420182026)
; CHECK-NEXT:    ret void
;
  %1 = alloca %struct.data_t, align 1
  %2 = alloca %struct.data_t, align 1
  %3 = alloca %struct.data_t, align 1
  %4 = getelementptr inbounds %struct.data_t, %struct.data_t* %1, i32 0, i32 0
  %5 = getelementptr inbounds [16 x i8], [16 x i8]* %4, i64 0, i64 0
  store i8 1, i8* %5, align 1
  %6 = getelementptr inbounds i8, i8* %5, i64 1
  store i8 2, i8* %6, align 1
  %7 = getelementptr inbounds i8, i8* %6, i64 1
  store i8 3, i8* %7, align 1
  %8 = getelementptr inbounds i8, i8* %7, i64 1
  store i8 4, i8* %8, align 1
  %9 = getelementptr inbounds i8, i8* %8, i64 1
  store i8 5, i8* %9, align 1
  %10 = getelementptr inbounds i8, i8* %9, i64 1
  store i8 0, i8* %10, align 1
  %11 = getelementptr inbounds i8, i8* %10, i64 1
  store i8 0, i8* %11, align 1
  %12 = getelementptr inbounds i8, i8* %11, i64 1
  store i8 0, i8* %12, align 1
  %13 = getelementptr inbounds i8, i8* %12, i64 1
  store i8 0, i8* %13, align 1
  %14 = getelementptr inbounds i8, i8* %13, i64 1
  store i8 0, i8* %14, align 1
  %15 = getelementptr inbounds i8, i8* %14, i64 1
  store i8 0, i8* %15, align 1
  %16 = getelementptr inbounds i8, i8* %15, i64 1
  store i8 0, i8* %16, align 1
  %17 = getelementptr inbounds i8, i8* %16, i64 1
  store i8 0, i8* %17, align 1
  %18 = getelementptr inbounds i8, i8* %17, i64 1
  store i8 0, i8* %18, align 1
  %19 = getelementptr inbounds i8, i8* %18, i64 1
  store i8 0, i8* %19, align 1
  %20 = getelementptr inbounds i8, i8* %19, i64 1
  store i8 0, i8* %20, align 1
  %21 = getelementptr inbounds %struct.data_t, %struct.data_t* %2, i32 0, i32 0
  %22 = getelementptr inbounds [16 x i8], [16 x i8]* %21, i64 0, i64 0
  store i8 11, i8* %22, align 1
  %23 = getelementptr inbounds i8, i8* %22, i64 1
  store i8 12, i8* %23, align 1
  %24 = getelementptr inbounds i8, i8* %23, i64 1
  store i8 13, i8* %24, align 1
  %25 = getelementptr inbounds i8, i8* %24, i64 1
  store i8 14, i8* %25, align 1
  %26 = getelementptr inbounds i8, i8* %25, i64 1
  store i8 15, i8* %26, align 1
  %27 = getelementptr inbounds i8, i8* %26, i64 1
  store i8 10, i8* %27, align 1
  %28 = getelementptr inbounds i8, i8* %27, i64 1
  store i8 10, i8* %28, align 1
  %29 = getelementptr inbounds i8, i8* %28, i64 1
  store i8 10, i8* %29, align 1
  %30 = getelementptr inbounds i8, i8* %29, i64 1
  store i8 10, i8* %30, align 1
  %31 = getelementptr inbounds i8, i8* %30, i64 1
  store i8 10, i8* %31, align 1
  %32 = getelementptr inbounds i8, i8* %31, i64 1
  store i8 10, i8* %32, align 1
  %33 = getelementptr inbounds i8, i8* %32, i64 1
  store i8 10, i8* %33, align 1
  %34 = getelementptr inbounds i8, i8* %33, i64 1
  store i8 10, i8* %34, align 1
  %35 = getelementptr inbounds i8, i8* %34, i64 1
  store i8 10, i8* %35, align 1
  %36 = getelementptr inbounds i8, i8* %35, i64 1
  store i8 10, i8* %36, align 1
  %37 = getelementptr inbounds i8, i8* %36, i64 1
  store i8 10, i8* %37, align 1
  %38 = getelementptr inbounds %struct.data_t, %struct.data_t* %3, i32 0, i32 0
  %39 = getelementptr inbounds [16 x i8], [16 x i8]* %38, i64 0, i64 0
  store i8 21, i8* %39, align 1
  %40 = getelementptr inbounds i8, i8* %39, i64 1
  store i8 22, i8* %40, align 1
  %41 = getelementptr inbounds i8, i8* %40, i64 1
  store i8 23, i8* %41, align 1
  %42 = getelementptr inbounds i8, i8* %41, i64 1
  store i8 24, i8* %42, align 1
  %43 = getelementptr inbounds i8, i8* %42, i64 1
  store i8 25, i8* %43, align 1
  %44 = getelementptr inbounds i8, i8* %43, i64 1
  store i8 20, i8* %44, align 1
  %45 = getelementptr inbounds i8, i8* %44, i64 1
  store i8 20, i8* %45, align 1
  %46 = getelementptr inbounds i8, i8* %45, i64 1
  store i8 20, i8* %46, align 1
  %47 = getelementptr inbounds i8, i8* %46, i64 1
  store i8 10, i8* %47, align 1
  %48 = getelementptr inbounds i8, i8* %47, i64 1
  store i8 20, i8* %48, align 1
  %49 = getelementptr inbounds i8, i8* %48, i64 1
  store i8 20, i8* %49, align 1
  %50 = getelementptr inbounds i8, i8* %49, i64 1
  store i8 20, i8* %50, align 1
  %51 = getelementptr inbounds i8, i8* %50, i64 1
  store i8 20, i8* %51, align 1
  %52 = getelementptr inbounds i8, i8* %51, i64 1
  store i8 20, i8* %52, align 1
  %53 = getelementptr inbounds i8, i8* %52, i64 1
  store i8 20, i8* %53, align 1
  %54 = getelementptr inbounds i8, i8* %53, i64 1
  store i8 11, i8* %54, align 1
  %55 = bitcast %struct.data_t* %1 to { i64, i64 }*
  %56 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %55, i32 0, i32 0
  %57 = load i64, i64* %56, align 1
  %58 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %55, i32 0, i32 1
  %59 = load i64, i64* %58, align 1
  %60 = bitcast %struct.data_t* %2 to { i64, i64 }*
  %61 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %60, i32 0, i32 0
  %62 = load i64, i64* %61, align 1
  %63 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %60, i32 0, i32 1
  %64 = load i64, i64* %63, align 1
  %65 = bitcast %struct.data_t* %3 to { i64, i64 }*
  %66 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %65, i32 0, i32 0
  %67 = load i64, i64* %66, align 1
  %68 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %65, i32 0, i32 1
  %69 = load i64, i64* %68, align 1
  call void @process36data_tS_S_(i64 %57, i64 %59, i64 %62, i64 %64, i64 %67, i64 %69)
  ret void
}
