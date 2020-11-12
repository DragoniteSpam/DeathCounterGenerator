randomize();

img_back = -1;
img_digits = array_create(10, -1);
bounds_lower = 0;
bounds_upper = 100;
draw_grid = true;
snap_grid = true;
grid_size = 16;
numbers_location = { x: 0, y: 0 };

container = new EmuCore(32, 32, 640, 640);

var button_back = new EmuButtonImage(32, EMU_AUTO, 256, 256, -1, 0, c_white, 1, true, function() {
    var image = load_image()[0];
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

button_digit = array_create(10, undefined);

button_digit[0] = new EmuButtonImage(32, EMU_AUTO, 96, 64, -1, 0, c_white, 1, true, function() {
    load_digit(self, 0);
});
button_digit[0].text = "Digit: 0";

button_digit[4] = new EmuButtonImage(32, EMU_AUTO, 96, 64, -1, 0, c_white, 1, true, function() {
    load_digit(self, 4);
});
button_digit[4].text = "Digit: 4";

button_digit[8] = new EmuButtonImage(32, EMU_AUTO, 96, 64, -1, 0, c_white, 1, true, function() {
    load_digit(self, 8);
});
button_digit[8].text = "Digit: 8";

container.AddContent([button_digit[0], button_digit[4], button_digit[8]]);

button_digit[1] = new EmuButtonImage(160, button_digit[0].y, 96, 64, -1, 0, c_white, 1, true, function() {
    load_digit(self, 1);
});
button_digit[1].text = "Digit: 1";

button_digit[5] = new EmuButtonImage(160, EMU_AUTO, 96, 64, -1, 0, c_white, 1, true, function() {
    load_digit(self, 5);
});
button_digit[5].text = "Digit: 5";

button_digit[9] = new EmuButtonImage(160, EMU_AUTO, 96, 64, -1, 0, c_white, 1, true, function() {
    load_digit(self, 9);
});
button_digit[9].text = "Digit: 9";

container.AddContent([button_digit[1], button_digit[5], button_digit[9]]);

button_digit[2] = new EmuButtonImage(288, button_digit[0].y, 96, 64, -1, 0, c_white, 1, true, function() {
    load_digit(self, 2);
});
button_digit[2].text = "Digit: 2";

button_digit[6] = new EmuButtonImage(288, EMU_AUTO, 96, 64, -1, 0, c_white, 1, true, function() {
    load_digit(self, 6);
});
button_digit[6].text = "Digit: 6";

container.AddContent([button_digit[2], button_digit[6]]);

button_digit[3] = new EmuButtonImage(416, button_digit[0].y, 96, 64, -1, 0, c_white, 1, true, function() {
    load_digit(self, 3);
});
button_digit[3].text = "Digit: 3";

button_digit[7] = new EmuButtonImage(416, EMU_AUTO, 96, 64, -1, 0, c_white, 1, true, function() {
    load_digit(self, 7);
});
button_digit[7].text = "Digit: 7";

container.AddContent([button_digit[3], button_digit[7]]);

input_min = new EmuInput(window_get_width() / 2, 32, 288, 32, "Lower bound:", string(bounds_lower), "-9999...9999", 5, E_InputTypes.INT, function() {
    obj_death.bounds_lower = real(value);
});
input_min.SetRealNumberBounds(-9999, 9999);

input_max = new EmuInput(window_get_width() / 2 + 320, 32, 288, 32, "Upper bound:", string(bounds_upper), "-9999...9999", 5, E_InputTypes.INT, function() {
    obj_death.bounds_upper = real(value);
});
input_max.SetRealNumberBounds(-9999, 9999);

input_min.SetNext(input_max);
input_min.SetPrevious(input_max);
input_max.SetNext(input_min);
input_max.SetPrevious(input_min);

container.AddContent([input_min, input_max]);

var button_draw_grid = new EmuCheckbox(window_get_width() / 2, EMU_AUTO, 288, 32, "Draw Grid", draw_grid, function() {
    obj_death.draw_grid = value;
    obj_death.input_grid_size.interactive = obj_death.snap_grid || obj_death.draw_grid;
});

container.AddContent([button_draw_grid]);

var button_snap_grid = new EmuCheckbox(window_get_width() / 2 + 320, button_draw_grid.y, 288, 32, "Snap to Grid", snap_grid, function() {
    obj_death.snap_grid = value;
    obj_death.input_grid_size.interactive = obj_death.snap_grid || obj_death.draw_grid;
});

container.AddContent([button_snap_grid]);

input_grid_size = new EmuInput(window_get_width() / 2, EMU_AUTO, 288, 32, "Grid size:", string(grid_size), "1...100", 3, E_InputTypes.INT, function() {
    obj_death.grid_size = real(value);
});
input_grid_size.SetRealNumberBounds(4, 100);

container.AddContent([input_grid_size]);

var preview_surface = new EmuRenderSurface(window_get_width() / 2, EMU_AUTO, 608, 400, function(mx, my) {
    var cx = floor(width / 2);
    var cy = floor(height / 2);
    static number = irandom_range(10, 99);
    
    if (obj_death.snap_grid) {
        mx = round(mx / obj_death.grid_size) * obj_death.grid_size;
        my = round(my / obj_death.grid_size) * obj_death.grid_size;
    }
    if (mx > 0 && mx < width - 1 && my > 0 && my < height - 1 && mouse_check_button(mb_left)) {
        obj_death.numbers_location.x = mx - cx;
        obj_death.numbers_location.y = my - cy;
    }
    
    drawCheckerbox(0, 0, width - 1, height - 1, 1, 1, c_white, 0.5);
    draw_card(number, obj_death.draw_grid, width, height);
    
    if (mouse_check_button_pressed(mb_right)) {
        number = irandom_range(10, 99);
    }
    if (!sprite_exists(obj_death.img_back)) {
        scribble_set_box_align(fa_center, fa_middle);
        scribble_set_wrap(width, height);
        scribble_draw(floor(cx), floor(cy), "Preivew will be shown here");
    }
    draw_rectangle_colour(1, 1, width - 1, height - 1, c_black, c_black, c_black, c_black, true);
}, emu_null, emu_null, emu_null);

var button_generate = new EmuButton(window_get_width() / 2, EMU_AUTO, 288, 32, "Generate Images", function() {
    
});

container.AddContent([preview_surface, button_generate]);