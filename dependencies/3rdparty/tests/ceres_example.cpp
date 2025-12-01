#include <ceres/ceres.h>
#include <iostream>

// Define the cost function
struct CostFunction {
    template <typename T>
    bool operator()(const T* const x, T* residual) const {
        residual[0] = x[0] - T(5.0);
        return true;
    }
};

int main() {
    // Initialize the parameter
    double x = 0.0;

    // Create the problem
    ceres::Problem problem;

    // Set up the cost function
    ceres::CostFunction* cost_function = new ceres::AutoDiffCostFunction<CostFunction, 1, 1>(new CostFunction);
    problem.AddResidualBlock(cost_function, nullptr, &x);

    // Configure the solver
    ceres::Solver::Options options;
    options.linear_solver_type = ceres::DENSE_QR;
    options.minimizer_progress_to_stdout = true;
    ceres::Solver::Summary summary;

    // Solve the problem
    ceres::Solve(options, &problem, &summary);

    std::cout << "Initial x: 0.0" << std::endl;
    std::cout << "Final x: " << x << std::endl;

    return 0;
}