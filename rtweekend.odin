package main

import "core:math"

pi :: math.PI
infinity :: math.INF_F64

degrees_to_radians :: proc(degrees: f64) -> f64 {
    return degrees * pi / 180.0
}