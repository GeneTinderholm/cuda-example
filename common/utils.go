package common

import "math/rand"

func GetTestSlices() ([]float64, []float64) {
	slizeSize := 1024 * 1024
	first := make([]float64, slizeSize)
	second := make([]float64, slizeSize)
	randomize(first)
	randomize(second)
	return first, second
}

func randomize(floats []float64) {
	for i := 0; i < len(floats); i++ {
		floats[i] = rand.Float64()
	}
}
