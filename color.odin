package main

import "core:fmt"

color :: vec3

write_color :: proc(pixel_color: color) {
    fmt.print(
        int(255.999 * pixel_color[0]), ' ',
        int(255.999 * pixel_color[1]), ' ',
        int(255.999 * pixel_color[2]), '\n'
    )
}