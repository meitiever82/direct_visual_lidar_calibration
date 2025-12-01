#include <iostream>
#include <yaml-cpp/yaml.h>
#include <fstream>

int main() {
    // 创建一个YAML文档
    YAML::Node node;
    node["name"] = "Alice";
    node["age"] = 30;

    // 将YAML文档写入文件
    std::ofstream fout("data.yaml");
    fout << node;
    fout.close();

    // 从文件中读取YAML文档
    YAML::Node file_node = YAML::LoadFile("data.yaml");

    // 访问YAML节点的数据
    std::string name = file_node["name"].as<std::string>();
    int age = file_node["age"].as<int>();

    // 打印数据
    std::cout << "Name: " << name << std::endl;
    std::cout << "Age: " << age << std::endl;

    return 0;
}