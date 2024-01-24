#include "library.cuh"

__global__ void add(double *a, double *b, size_t len) {
    size_t i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i < len) {
        a[i] = a[i] + b[i];
    }
}

extern "C" {
int add_arr(double *a, double *b, size_t len) {
    double *dev_a, *dev_b;
    size_t arr_size_bytes = len * sizeof(double),
            block_size = 1024,
            num_blocks = (size_t) std::ceil(((double) len) / ((double) block_size));
    cudaError_t err = cudaMalloc((void **) &dev_a, arr_size_bytes);
    if (err != cudaSuccess) {
        goto cleanup;
    }

    err = cudaMalloc((void **) &dev_b, arr_size_bytes);
    if (err != cudaSuccess) {
        goto cleanup;
    }

    err = cudaMemcpy(dev_a, a, arr_size_bytes, cudaMemcpyHostToDevice);
    if (err != cudaSuccess) {
        goto cleanup;
    }

    err = cudaMemcpy(dev_b, b, arr_size_bytes, cudaMemcpyHostToDevice);
    if (err != cudaSuccess) {
        goto cleanup;
    }

    add<<<num_blocks, block_size>>>(dev_a, dev_b, len);

    err = cudaMemcpy(a, dev_a, arr_size_bytes, cudaMemcpyDeviceToHost);

    cleanup:
    cudaError_t cleanup_err = cudaSuccess;
    if (dev_a != nullptr) {
        cleanup_err = cudaFree(dev_a);
    }
    if (dev_b != nullptr) {
        cudaError_t err_b = cudaFree(dev_b);
        if (cleanup_err == cudaSuccess) {
            cleanup_err = err_b;
        }
    }
    if (err == cudaSuccess) {
        err = cleanup_err;
    }
    return err;
}
}