function load_image() {
    var fn = get_open_filename("Image files|*.png|*.bmp", "");
    var image = sprite_add(fn, 0, false, false, 0, 0);
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
                var alt_image = sprite_add(path + string(i) + ext, 0, false, false, 0, 0);
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