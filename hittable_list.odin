package main

Objects :: union {
    sphere
}

hittable_list :: struct {
    objects: [dynamic]Objects,
    //add: proc(h: ^hittable_list, o: ^hittable),
    //clear: proc(h: ^hittable_list),
    hit: proc(h: ^hittable_list, r: ^ray, rec: ^hit_record, ray_tmin: f64, ray_tmax: f64) -> bool
}

hit :: proc(h: ^hittable_list, r: ^ray, rec: ^hit_record, ray_tmin: f64, ray_tmax: f64) -> bool {
    temp_rec: hit_record
    hit_anything: bool = false
    closest_so_far := ray_tmax
    #reverse for obj in h.objects {
        if  obj_hit(obj, r, &temp_rec, ray_tmin, ray_tmax) {
            hit_anything = true
            closest_so_far = temp_rec.t
            rec^ = temp_rec
        }
    }

    return hit_anything
}

obj_hit :: proc(obj: Objects, r: ^ray, rec: ^hit_record, ray_tmin: f64, ray_tmax: f64) -> bool{
    switch v in obj {
        case sphere :
            return hit_sphere(v, r, rec, ray_tmin, ray_tmax)
        case:
            return false
    }
}