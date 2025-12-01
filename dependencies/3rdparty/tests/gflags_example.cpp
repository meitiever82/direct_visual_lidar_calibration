#include <iostream>
#include <gflags/gflags.h>

DEFINE_string(name, "World", "The name to say hello to");

int main(int argc, char **argv) {
    gflags::ParseCommandLineFlags(&argc, &argv, true);

    std::cout << "Hello, " << FLAGS_name << "!" << std::endl;

    gflags::ShutDownCommandLineFlags();
    return 0;
}