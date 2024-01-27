package static

import (
	"fmt"
	"math/rand"
	"testing"
)

func BenchmarkCudaAdd(b *testing.B) {
	slizeSize := 1024 * 1024 * 400
	first := make([]float64, slizeSize)
	second := make([]float64, slizeSize)
	setToRandom(first)
	setToRandom(second)
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		if err := cudaAdd(first, second); err != nil {
			fmt.Println("got err: ", err)
			b.FailNow()
		}
	}
}

func setToRandom(floats []float64) {
	for i := 0; i < len(floats); i++ {
		floats[i] = rand.Float64()
	}
}
