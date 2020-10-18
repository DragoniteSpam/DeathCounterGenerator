randomize();

img_back = undefined;
img_digits = array_create(10, -1);

container = new EmuCore(32, 32, 640, 640);

container.AddContent([
    new EmuText(32, 32, 256, 32, "[c_blue]Base Image[/c]"),
    new EmuButton(32, EMU_AUTO, 256, 256, "Background", function() {
    }),
    new EmuText(32, EMU_AUTO, 256, 32, "[c_blue]Digit Images[/c]"),
]);

var button_digit_0 = new EmuButton(32, EMU_AUTO, 96, 64, "Digit: 0", function() {
});

var button_digit_4 = new EmuButton(32, EMU_AUTO, 96, 64, "Digit: 4", function() {
});

var button_digit_8 = new EmuButton(32, EMU_AUTO, 96, 64, "Digit: 8", function() {
});

container.AddContent([button_digit_0, button_digit_4, button_digit_8]);

var button_digit_1 = new EmuButton(160, button_digit_0.y, 96, 64, "Digit: 1", function() {
});

var button_digit_5 = new EmuButton(160, EMU_AUTO, 96, 64, "Digit: 5", function() {
});

var button_digit_9 = new EmuButton(160, EMU_AUTO, 96, 64, "Digit: 9", function() {
});

container.AddContent([button_digit_1, button_digit_5, button_digit_9]);

var button_digit_2 = new EmuButton(288, button_digit_0.y, 96, 64, "Digit: 2", function() {
});

var button_digit_6 = new EmuButton(288, EMU_AUTO, 96, 64, "Digit: 6", function() {
});

container.AddContent([button_digit_2, button_digit_6]);

var button_digit_3 = new EmuButton(416, button_digit_0.y, 96, 64, "Digit: 3", function() {
});

var button_digit_7 = new EmuButton(416, EMU_AUTO, 96, 64, "Digit: 7", function() {
});

container.AddContent([button_digit_3, button_digit_7]);