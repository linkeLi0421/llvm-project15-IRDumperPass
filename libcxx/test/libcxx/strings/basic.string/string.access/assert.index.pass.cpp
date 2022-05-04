//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// <string>

// Index string out of bounds.

// UNSUPPORTED: c++03, windows
// XFAIL: use_system_cxx_lib && target={{.+}}-apple-macosx{{10.9|10.10|10.11|10.12|10.13|10.14|10.15|11.0|12.0}}
// ADDITIONAL_COMPILE_FLAGS: -D_LIBCPP_ENABLE_ASSERTIONS=1

#include <string>
#include <cassert>

#include "check_assertion.h"
#include "min_allocator.h"

int main(int, char**) {
  {
    typedef std::string S;
    S s;
    assert(s[0] == 0);
    TEST_LIBCPP_ASSERT_FAILURE(s[1], "string index out of bounds");
  }

  {
    typedef std::basic_string<char, std::char_traits<char>, min_allocator<char> > S;
    S s;
    assert(s[0] == 0);
    TEST_LIBCPP_ASSERT_FAILURE(s[1], "string index out of bounds");
  }

  return 0;
}