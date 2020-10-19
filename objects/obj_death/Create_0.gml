randomize();

img_back = -1;
img_digits = array_create(10, -1);

container = new EmuCore(32, 32, 640, 640);

container.AddContent([
    new EmuText(32, 32, 256, 32, "[c_blue]Base Image[/c]"),
    new EmuButton(32, EMU_AUTO, 256, 256, "Background", function() {
    }),
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