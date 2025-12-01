#include <metis.h>
#include <iostream>
#include <vector>

int main() {
    idx_t nVertices = 6;
    idx_t nEdges = 7;
    idx_t nWeights = 1;
    idx_t nParts = 2;
    idx_t objval;

    std::vector<idx_t> xadj = {0, 2, 5, 7, 10, 12, 14};
    std::vector<idx_t> adjncy = {1, 3, 0, 2, 4, 0, 1, 3, 5, 1, 4, 0, 3, 5, 2, 4};
    std::vector<idx_t> part(nVertices);

    // Perform graph partitioning
    METIS_PartGraphKway(&nVertices, &nWeights, xadj.data(), adjncy.data(), NULL, NULL, NULL, &nParts, NULL, NULL, NULL, &objval, part.data());

    // Print partitioning result
    for (idx_t i = 0; i < nVertices; i++) {
        std::cout << "Vertex " << i << " is in part " << part[i] << std::endl;
    }

    return 0;
}