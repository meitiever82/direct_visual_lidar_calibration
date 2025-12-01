#include <iostream>
#include <GeographicLib/Geodesic.hpp>

int main() {
    // 创建Geodesic对象
    GeographicLib::Geodesic geod = GeographicLib::Geodesic::WGS84();

    // 输入两个地点的经纬度坐标
    double lat1 = 37.7749;  // 纬度
    double lon1 = -122.4194;  // 经度
    double lat2 = 34.0522;  // 纬度
    double lon2 = -118.2437;  // 经度

    // 计算两个地点之间的距离
    double s12;
    geod.Inverse(lat1, lon1, lat2, lon2, s12);

    std::cout << "Distance between the two points is: " << s12 << " meters" << std::endl;

    return 0;
}