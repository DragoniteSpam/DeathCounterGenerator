draw_clear(c_white);
container.Render();
EmuOverlay.Render();

if (generating) {
    if (++gen_index > gen_final) {
        generating = false;
        EnableAll();
    }
}