package static

/*
#cgo LDFLAGS: -lexamplestatic -L${SRCDIR}/../example/build -lcuda -lcudart -lm
#include <stdlib.h>
int add_wrapper(double *a, double *b, size_t len);
*/
import "C"

import (
	"fmt"
)

func cudaAdd(a, b []float64) error {
	if res := C.add_wrapper((*C.double)(&a[0]), (*C.double)(&b[0]), C.size_t(len(a))); res != 0 {
		return fmt.Errorf("got bad error code from C.add %d", int(res))
	}
	return nil
}
