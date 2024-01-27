package static

import (
	"cuda-example/common"
	"fmt"
	"testing"
)

func BenchmarkCudaAdd(b *testing.B) {
	first, second := common.GetTestSlices()
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		if err := cudaAdd(first, second); err != nil {
			fmt.Println("got err: ", err)
			b.FailNow()
		}
	}
}
