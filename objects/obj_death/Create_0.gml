randomize();

img_back = -1;
img_digits = array_create(10, -1);
bounds_lower = 0;
bounds_upper = 100;

container = new EmuCore(32, 32, 640, 640);

var button_back = new EmuButtonImage(32, EMU_AUTO, 256, 256, -1, 0, c_white, 1, true, function() {
    var image = load_image();
    if (sprite_exists(image)) {
        sprite_set_offset(image, sprite_get_width(image) / 2, sprite_get_height(image) / 2);
        if (sprite_exists(sprite)) {
            if (sprite_exists(sprite)) sprite_delete(sprite);
        }
        obj_death.img_back = image;
        sprite = image;
        draw_label = false;
    } else {
        draw_label = true;
    }
});
button_back.text = "Click to load background...";

container.AddContent([
    new EmuText(32, 32, 256, 32, "[c_blue]Base Image[/c]"),
    button_back,
    new EmuText(32, EMU_AUTO, 256, 32, "[c_blue]Digit Images[/c]"),
]);

var button_digit_0 = new EmuButtonImage(32, EMU_AUTO, 96, 64, -1, 0, c_white, 1, true, function() {
    load_digit(self, 0);
});
button_digit_0.text = "Digit: 0";

var button_digit_4 = new EmuButtonImage(32, EMU_AUTO, 96, 64, -1, 0, c_white, 1, true, function() {
    load_digit(self, 4);
});
button_digit_4.text = "Digit: 4";

var button_digit_8 = new EmuButtonImage(32, EMU_AUTO, 96, 64, -1, 0, c_white, 1, true, function() {
    load_digit(self, 8);
});
button_digit_8.text = "Digit: 8";

container.AddContent([button_digit_0, button_digit_4, button_digit_8]);

var button_digit_1 = new EmuButtonImage(160, button_digit_0.y, 96, 64, -1, 0, c_white, 1, true, function() {
    load_digit(self, 1);
});
button_digit_1.text = "Digit: 1";

var button_digit_5 = new EmuButtonImage(160, EMU_AUTO, 96, 64, -1, 0, c_white, 1, true, function() {
    load_digit(self, 5);
});
button_digit_5.text = "Digit: 5";

var button_digit_9 = new EmuButtonImage(160, EMU_AUTO, 96, 64, -1, 0, c_white, 1, true, function() {
    load_digit(self, 9);
});
button_digit_9.text = "Digit: 9";

container.AddContent([button_digit_1, button_digit_5, button_digit_9]);

var button_digit_2 = new EmuButtonImage(288, button_digit_0.y, 96, 64, -1, 0, c_white, 1, true, function() {
    load_digit(self, 2);
});
button_digit_2.text = "Digit: 2";

var button_digit_6 = new EmuButtonImage(288, EMU_AUTO, 96, 64, -1, 0, c_white, 1, true, function() {
    load_digit(self, 6);
});
button_digit_6.text = "Digit: 6";

container.AddContent([button_digit_2, button_digit_6]);

var button_digit_3 = new EmuButtonImage(416, button_digit_0.y, 96, 64, -1, 0, c_white, 1, true, function() {
    load_digit(self, 3);
});
button_digit_3.text = "Digit: 3";

var button_digit_7 = new EmuButtonImage(416, EMU_AUTO, 96, 64, -1, 0, c_white, 1, true, function() {
    load_digit(self, 7);
});
button_digit_7.text = "Digit: 7";

container.AddContent([button_digit_3, button_digit_7]);

var button_min = new EmuInput(window_get_width() / 2, 32, 288, 32, "Lower bound:", "0", "-9999...9999", 5, E_InputTypes.INT, function(value) {
    obj_death.bounds_lower = real(value);
});
button_min.SetRealNumberBounds(-9999, 9999);

var button_max = new EmuInput(window_get_width() / 2 + 320, 32, 288, 32, "Upper bound:", "0", "-9999...9999", 5, E_InputTypes.INT, function(value) {
    obj_death.bounds_upper = real(value);
});
button_max.SetRealNumberBounds(-9999, 9999);

button_min.SetNext(button_max);
button_min.SetPrevious(button_max);
button_max.SetNext(button_min);
button_max.SetPrevious(button_min);

var button_generate = new EmuButton(window_get_width() / 2, EMU_AUTO, 288, 32, "Generate Images", function() {
});

var preview_surface = new EmuRenderSurface(window_get_width() / 2, EMU_AUTO, 608, 400, function(mx, my) {
    var cx = floor(width / 2);
    var cy = floor(height / 2);
    drawCheckerbox(0, 0, width - 1, height - 1, 1, 1, c_white, 0.5);
    if (sprite_exists(obj_death.img_back)) {
        draw_sprite(obj_death.img_back, 0, cx, cy);
    } else {
        scribble_set_box_align(fa_center, fa_middle);
        scribble_set_wrap(width, height);
        scribble_draw(floor(cx), floor(cy), "Preivew will be shown here");
    }
    draw_rectangle_colour(1, 1, width - 1, height - 1, c_black, c_black, c_black, c_black, true);
}, emu_null, emu_null, emu_null);

container.AddContent([button_min, button_max, button_generate, preview_surface]);