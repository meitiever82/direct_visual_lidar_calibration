#include <gtest/gtest.h>

// 测试用例示例
TEST(MathTest, Addition) {
    EXPECT_EQ(2 + 2, 4);
}

int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}