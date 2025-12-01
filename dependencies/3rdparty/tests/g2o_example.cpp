#include <iostream>
#include <Eigen/Core>
#include <g2o/core/base_vertex.h>
#include <g2o/core/base_unary_edge.h>
#include <g2o/core/block_solver.h>
#include <g2o/core/optimization_algorithm_levenberg.h>
#include <g2o/solvers/dense/linear_solver_dense.h>

using namespace std;
using namespace Eigen;

// 定义顶点类
class VertexExample : public g2o::BaseVertex<1, double> {
public:
    EIGEN_MAKE_ALIGNED_OPERATOR_NEW

    virtual void setToOriginImpl() {
        _estimate = 0.0;
    }

    virtual void oplusImpl(const double* update) {
        _estimate += *update;
    }

    virtual bool read(istream& /*is*/) { return false; }
    virtual bool write(ostream& /*os*/) const { return false; }
};

// 定义边类
class EdgeExample : public g2o::BaseUnaryEdge<1, double, VertexExample> {
public:
    EIGEN_MAKE_ALIGNED_OPERATOR_NEW

    EdgeExample() {}

    void computeError() {
        const VertexExample* v = static_cast<VertexExample*>(_vertices[0]);
        _error(0) = _measurement - v->estimate();
    }

    virtual bool read(istream& /*is*/) { return false; }
    virtual bool write(ostream& /*os*/) const { return false; }
};

int main() {
    typedef g2o::BlockSolver<g2o::BlockSolverTraits<1, 1>> BlockSolverType;
    typedef g2o::LinearSolverDense<BlockSolverType::PoseMatrixType> LinearSolverType;

    // 创建图优化器
    g2o::SparseOptimizer optimizer;
    BlockSolverType* solver = new BlockSolverType(std::unique_ptr<LinearSolverType>(new LinearSolverType));
    g2o::OptimizationAlgorithmLevenberg* algorithm = new g2o::OptimizationAlgorithmLevenberg(std::unique_ptr<BlockSolverType>(solver));
    optimizer.setAlgorithm(algorithm);

    // 添加顶点
    VertexExample* v = new VertexExample();
    v->setId(0);
    v->setEstimate(0.0);
    optimizer.addVertex(v);

    // 添加边
    EdgeExample* e = new EdgeExample();
    e->setVertex(0, v);
    e->setMeasurement(2.0);
    e->setInformation(Matrix<double, 1, 1>::Identity());
    optimizer.addEdge(e);

    // 执行优化
    optimizer.initializeOptimization();
    optimizer.optimize(10);

    // 输出优化结果
    cout << "Optimized value: " << v->estimate() << endl;

    return 0;
}