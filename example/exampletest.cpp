#include "library.cuh"
#include <gtest/gtest.h>

TEST(TestAddArr, add_arr_should_add_arrays) {
    double a[4] = {1, 2, 3, 4};
    double b[4] = {5, 6, 7, 8};
    int err = add_arr(a, b, 4);
    ASSERT_EQ(err, 0);
    ASSERT_EQ(a[0], 6);
    ASSERT_EQ(a[1], 8);
    ASSERT_EQ(a[2], 10);
    ASSERT_EQ(a[3], 12);
}