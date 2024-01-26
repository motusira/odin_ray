package main

import "core:math"
import "core:fmt"

sphere :: struct {
    center: point3,
    radius: f64
}

hit_sphere :: proc(sphere: sphere, r: ^ray, rec: ^hit_record, ray_tmin: f64, ray_tmax: f64) -> bool {
    oc: vec3 = r.orig - sphere.center
    a := length_squared(&r.dir)
    half_b := dot(&oc, &r.dir)
    c := length_squared(&oc) - sphere.radius * sphere.radius
    discriminant := half_b*half_b - a*c
    if discriminant < 0 {
        return false
    }
    sqrtd := math.sqrt(discriminant)
    root := (-half_b - sqrtd) / a
    if (root <= ray_tmin || ray_tmax <= root) {
        root = (-half_b + sqrtd) / a
        if (root <= ray_tmin || ray_tmax <= root) {
            return false
        }
    }
    rec.t = root;
    rec.p = at(r, rec.t)
    outward_normal := (rec.p - sphere.center) / sphere.radius
    set_face_normal(rec, r, &outward_normal)
    return true
} 