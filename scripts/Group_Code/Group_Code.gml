function load_image() {
    var fn = get_open_filename("Image files|*.png|*.bmp", "");
    var image = sprite_add_crop(fn);
    if (!sprite_exists(image)) return [-1, undefined];
    return [image, fn];
};

function load_digit(button, index) {
    var data = load_image();
    var image = data[0];
    var fn = data[1];
    if (sprite_exists(image)) {
        sprite_set_offset(image, sprite_get_width(image) / 2, sprite_get_height(image) / 2);
        if (sprite_exists(button.sprite)) {
            if (sprite_exists(button.sprite)) sprite_delete(button.sprite);
        }
        obj_death.img_digits[@ index] = image;
        button.sprite = image;
        draw_label = false;
        
        var ext = filename_ext(fn);
        var base = filename_name(filename_change_ext(fn, ""));
        var path = filename_path(fn);
        if (string_digits(base) == string(index)) {
            for (var i = 0; i < 10; i++) {
                if (i == index) continue;
                var alt_image = sprite_add_crop(path + string(i) + ext);
                var alt_button = obj_death.button_digit[i];
                if (sprite_exists(alt_image)) {
                    sprite_set_offset(alt_image, sprite_get_width(alt_image) / 2, sprite_get_height(alt_image) / 2);
                    if (sprite_exists(alt_button.sprite)) {
                        if (sprite_exists(alt_button.sprite)) sprite_delete(alt_button.sprite);
                    }
                    obj_death.img_digits[@ i] = alt_image;
                    alt_button.sprite = alt_image;
                    alt_button.draw_label = false;
                }
            }
        }
    }
};

function sprite_add_crop(filename) {
    var base_image = sprite_add(filename, 0, false, false, 0, 0);
    if (!sprite_exists(base_image)) return base_image;
    var x1 = 0;
    var y1 = 0;
    var x2 = sprite_get_width(base_image);
    var y2 = sprite_get_height(base_image);
    var w = x2;
    var h = y2;
    
    gpu_set_blendmode(bm_add);
    
    var base_surface = surface_create(x2, y2);
    surface_set_target(base_surface);
    draw_clear_alpha(c_black, 0);
    draw_sprite(base_image, 0, 0, 0);
    surface_reset_target();
    var base_data = buffer_create(x2 * y2 * 4, buffer_fast, 1);
    buffer_get_surface(base_data, base_surface, 0);
    
    for (var j = 0; j < h; j++) {
        var done = false;
        for (var i = 0; i < w; i++) {
            if (buffer_peek(base_data, ((j * w) + i) * 4 + 3, buffer_u8) > 16) {
                var fy1 = j;
                done = true;
                break;
            }
        }
        if (done) break;
    }
    
    for (var j = h - 1; j >= 0; j--) {
        var done = false;
        for (var i = w - 1; i >= 0; i--) {
            if (buffer_peek(base_data, ((j * w) + i) * 4 + 3, buffer_u8) > 16) {
                var fy2 = j;
                done = true;
                break;
            }
        }
        if (done) break;
    }
    
    for (var i = 0; i < w; i++) {
        var done = false;
        for (var j = 0; j < h; j++) {
            if (buffer_peek(base_data, ((j * w) + i) * 4 + 3, buffer_u8) > 16) {
                var fx1 = i;
                done = true;
                break;
            }
        }
        if (done) break;
    }
    
    for (var i = w - 1; i >= 0; i--) {
        var done = false;
        for (var j = h - 1; j >= 0; j--) {
            if (buffer_peek(base_data, ((j * w) + i) * 4 + 3, buffer_u8) > 16) {
                var fx2 = i;
                done = true;
                break;
            }
        }
        if (done) break;
    }
    
    x1 = min(fx1, fx2);
    y1 = min(fy1, fy2);
    x2 = max(fx1, fx2);
    y2 = max(fy1, fy2);
    
    surface_resize(base_surface, x2 - x1, y2 - y1);
    surface_set_target(base_surface);
    draw_clear_alpha(c_black, 0);
    draw_sprite(base_image, 0, -x1, -y1);
    surface_reset_target();
    
    var cropped_image = sprite_create_from_surface(base_surface, 0, 0, x2 - x1, y2 - y1, false, false, (x2 - x1) / 2, (y2 - y1) / 2);
    surface_free(base_surface);
    sprite_delete(base_image);
    
    gpu_set_blendmode(bm_normal);
    
    return cropped_image;
};