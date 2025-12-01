#include <glog/logging.h>

int main(int argc, char* argv[]) {
    // 初始化 Google 日志库
    google::InitGoogleLogging(argv[0]);

    // 设置日志级别
    FLAGS_logtostderr = true; // 输出到控制台
    FLAGS_minloglevel = google::INFO; // 设置最低输出级别为 INFO

    // 写日志
    LOG(INFO) << "这是一个 INFO 级别的日志信息";
    LOG(WARNING) << "这是一个 WARNING 级别的日志信息";
    LOG(ERROR) << "这是一个 ERROR 级别的日志信息";

    // 关闭 Google 日志库
    google::ShutdownGoogleLogging();

    return 0;
}