#include <iostream>
#include <nlohmann/json.hpp>

using json = nlohmann::json;

int main() {
    // 创建一个 JSON 对象
    json j = {
            {"key1", "value1"},
            {"key2", 2},
            {"key3", {3, 4, 5}}
    };

    // 将 JSON 对象输出到控制台
    std::cout << j.dump(4) << std::endl;

    return 0;
}