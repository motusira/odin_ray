package main

import "core:math"

vec3 :: [3]f64
point3 :: vec3

Vec3 :: proc() -> vec3 {
    return vec3{0, 0, 0}
}

length_squared :: proc(v: ^vec3) -> f64 {
    return v[0]*v[0] + v[1]*v[1] + v[2]*v[2]
}

length :: proc(v: ^vec3) -> f64 {
    return math.sqrt_f64(length_squared(v))
}

dot :: proc(v, u: ^vec3) -> f64 {
    return v[0]*u[0] \
        + v[1]*u[1] \
        + v[2]*u[2] 
}

cross :: proc(v, u: ^vec3) -> vec3 {
    return vec3{v[1] * u[2] - v[2] * u[1], \
        v[2] * u[0] - v[0] * u[2], \
        v[0] * u[1] - v[1] * u[0]}
}

unit :: proc(v: ^vec3) -> vec3 {
    return v^ / length(v)
}
