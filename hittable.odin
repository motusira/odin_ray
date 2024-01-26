package main

set_face_normal :: proc(rec: ^hit_record, r: ^ray, outward_normal: ^vec3) {
    rec.front_face = dot(&r.dir, outward_normal) < 0;
    rec.normal = rec.front_face ? outward_normal^ : -1 * outward_normal^
}

hit_record :: struct {
    p: point3,
    normal: vec3,
    t: f64,
    front_face: bool
}

hittable :: struct {
    hit: proc(r: ^ray, rec: ^hit_record, ray_tmin: f64, ray_tmax: f64) -> bool
}