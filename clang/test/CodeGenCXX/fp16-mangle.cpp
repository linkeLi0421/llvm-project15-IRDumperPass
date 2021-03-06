// RUN: %clang_cc1 -no-opaque-pointers -emit-llvm -o - -triple arm-none-linux-gnueabi %s | FileCheck %s

// CHECK: @_ZN1SIDhDhE1iE ={{.*}} global i32 3
template <typename T, typename U> struct S { static int i; };
template <> int S<__fp16, __fp16>::i = 3;

// CHECK-LABEL: define{{.*}} void @_Z1fPDh(half* noundef %x)
void f (__fp16 *x) { }

// CHECK-LABEL: define{{.*}} void @_Z1gPDhS_(half* noundef %x, half* noundef %y)
void g (__fp16 *x, __fp16 *y) { }

