package main

ray :: struct {
    orig: point3,
    dir: vec3,
}

at :: proc(r: ^ray, t: f64) -> point3 {
    return r.orig + t * r.dir
}