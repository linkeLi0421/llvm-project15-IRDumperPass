//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// <regex>

// template <class BidirectionalIterator> class sub_match;

// constexpr sub_match();

#include <regex>
#include <cassert>
#include "test_macros.h"

int main(int, char**)
{
    {
        typedef char CharT;
        typedef std::sub_match<const CharT*> SM;
        SM sm;
        assert(sm.matched == false);
    }
#ifndef TEST_HAS_NO_WIDE_CHARACTERS
    {
        typedef wchar_t CharT;
        typedef std::sub_match<const CharT*> SM;
        SM sm;
        assert(sm.matched == false);
    }
#endif

  return 0;
}
