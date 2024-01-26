package main

import "core:fmt"
import "core:log"
import "core:math"
import ".."

ray_color :: proc(r: ^ray, world: ^hittable_list) -> color {
    rec: hit_record
    if world->hit(r, &rec, 0.0, infinity) {
        return 0.5 * (rec.normal + color{1, 1, 1})
    }
    unit_direction := unit(&vec3{r.dir[0], r.dir[1], r.dir[2]})
    a := 0.5 * (unit_direction[1] + 1.0)
    res := (1.0-a)*color{1.0, 1.0, 1.0} + a*color{0.5, 0.7, 1.0}
    //fmt.println(r.dir[0], r.dir[1], r.dir[2])
    return res
}

gen_image :: proc() {
    aspect_ratio: f64 = 16.0 / 9.0
    image_width := 400

    image_height := int(f64(image_width) / aspect_ratio)
    image_height = (image_height < 1) ? 1 : image_height

    objcts: [dynamic]Objects
    defer delete(objcts)
    append(&objcts, sphere{point3{0, 0, -1}, 0.5})
    append(&objcts, sphere{point3{0, -100.5, -1}, 100})
    world := hittable_list {
        objcts,
        hit
    }

    focal_lenght: f64 = 1.0
    viewport_height: f64 = 2.0
    viewport_width := viewport_height * (f64(image_width)/f64((image_height))) 
    camera_center := point3{0, 0, 0}

    viewport_u := vec3{viewport_width, 0, 0}
    viewport_v := vec3{0, -viewport_height, 0}

    pixel_delta_u := viewport_u / f64(image_width)
    pixel_delta_v := viewport_v / f64(image_height)

    viewport_upper_left := camera_center - vec3{0, 0, focal_lenght} - viewport_u/2 - viewport_v/2
    pixel00_loc := viewport_upper_left + 0.5 * (pixel_delta_u + pixel_delta_v)

    fmt.print("P3\n", image_width, ' ', image_height, "\n255\n")

    for j := 0; j < image_height; j += 1 {
        //log.debug("\rScanlines remaining: ", (image_height - j), '\n')
        for i := 0; i < image_width; i += 1 {
            pixel_center := pixel00_loc + (f64(i) * pixel_delta_u) + (f64(j) * pixel_delta_v)
            ray_direction := pixel_center - camera_center
            r := ray{camera_center, ray_direction}
            pixel_color := ray_color(&r, &world)
            write_color(pixel_color)
        }
    }
}

main :: proc() {
    gen_image()
}