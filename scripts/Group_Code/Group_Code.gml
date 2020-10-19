function load_image() {
    var fn = get_open_filename("Image files|*.png|*.bmp", "");
    var image = sprite_add(fn, 0, false, false, 0, 0);
    if (!sprite_exists(image)) return -1;
    return image;
};

function load_digit(button, index) {
    var image = load_image();
    if (sprite_exists(image)) {
        if (sprite_exists(button.sprite)) {
            if (sprite_exists(button.sprite)) sprite_delete(button.sprite);
        }
        obj_death.img_digits[@ index] = image;
        button.sprite = image;
    }
};