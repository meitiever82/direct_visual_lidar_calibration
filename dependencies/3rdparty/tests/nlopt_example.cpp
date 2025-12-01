#include <iostream>
#include <nlopt.hpp>

// 目标函数
double myfunc(const std::vector<double> &x, std::vector<double> &grad, void *my_func_data) {
    if (!grad.empty()) {
        grad[0] = 0.0;
        grad[1] = 0.5 / sqrt(x[1]);
    }
    return sqrt(x[1]);
}

int main() {
    nlopt::opt opt(nlopt::LD_LBFGS, 2); // 使用L-BFGS算法进行优化，优化变量维度为2

    opt.set_min_objective(myfunc, NULL);

    std::vector<double> lb(2);
    lb[0] = -HUGE_VAL; lb[1] = 0;
    opt.set_lower_bounds(lb);

    double minf;
    std::vector<double> x(2, 1.234); // 初始猜测值

    nlopt::result result = opt.optimize(x, minf);

    if (result < 0) {
        std::cout << "NLopt failed with code: " << result << std::endl;
    } else {
        std::cout << "Found minimum at f(" << x[0] << "," << x[1] << ") = " << minf << std::endl;
    }

    return 0;
}