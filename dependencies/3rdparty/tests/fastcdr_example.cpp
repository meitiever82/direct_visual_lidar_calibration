#include <iostream>
#include <fastcdr/FastBuffer.h>
#include <fastcdr/Cdr.h>

int main() {
    // 创建FastBuffer对象
    eprosima::fastcdr::FastBuffer buffer;

    // 创建一个Cdr对象，将数据序列化到FastBuffer中
    eprosima::fastcdr::Cdr cdr(buffer);
    int32_t number = 42;
    cdr << number;

    // 从FastBuffer中反序列化数据
    eprosima::fastcdr::Cdr deser(buffer);
    int32_t deserialized_number;
    deser >> deserialized_number;

    // 打印反序列化后的数据
    std::cout << "Deserialized number: " << deserialized_number << std::endl;

    return 0;
}