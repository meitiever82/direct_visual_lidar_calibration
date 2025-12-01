#include <opencv2/opencv.hpp>

int main() {
    // 创建一个黑色图像
    cv::Mat image = cv::Mat::zeros(400, 400, CV_8UC3);

    // 画一条直线
    cv::line(image, cv::Point(50, 50), cv::Point(350, 350), cv::Scalar(255, 255, 255), 2);

    // 显示图像
    cv::imshow("OpenCV Example", image);
    cv::waitKey(0);

    return 0;
}