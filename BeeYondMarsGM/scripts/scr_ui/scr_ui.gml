/// scr_ui
/// Immediate-mode pixel UI in the look of the v6 web version (navy panels, sage borders, honey buttons).
/// Text uses a bitmap font built from spr_font (5x7 glyphs in a 6x9 cell). Scale 2 = body, 3 = headings.

#macro C_BG      make_colour_rgb(17, 23, 38)
#macro C_PANEL   make_colour_rgb(24, 37, 56)
#macro C_CARD    make_colour_rgb(34, 54, 74)
#macro C_CARD_HI make_colour_rgb(46, 74, 96)
#macro C_EDGE    make_colour_rgb(75, 101, 117)
#macro C_SAGE    make_colour_rgb(145, 175, 155)
#macro C_MINT    make_colour_rgb(182, 216, 189)
#macro C_TEXT    make_colour_rgb(246, 239, 219)
#macro C_DIM     make_colour_rgb(170, 184, 190)
#macro C_HONEY   make_colour_rgb(240, 196, 90)
#macro C_GOLD    make_colour_rgb(255, 224, 151)
#macro C_INK     make_colour_rgb(20, 26, 40)
#macro C_RED     make_colour_rgb(255, 138, 122)
#macro C_TEAL    make_colour_rgb(127, 208, 196)
#macro C_PINK    make_colour_rgb(242, 179, 192)
#macro C_BROWN   make_colour_rgb(56, 32, 26)

#macro TXT_LINE 11

global.ui_click_used = false;
global.fnt_px = -1;

function ui_init_font()
{
    if (global.fnt_px != -1) return;
    var _chars = "";
    for (var c = 32; c < 127; c++) _chars += chr(c);
    global.fnt_px = font_add_sprite_ext(spr_font, _chars, false, 0);
}

function ui_begin()
{
    global.ui_click_used = false;
    draw_set_alpha(1);
    draw_set_font(global.fnt_px);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

function ui_rect(_x, _y, _w, _h, _col)
{
    draw_set_colour(_col);
    draw_rectangle(_x, _y, _x + _w - 1, _y + _h - 1, false);
}

/// Panel with a 2 px border (v6 style).
function ui_panel(_x, _y, _w, _h, _fill, _edge)
{
    ui_rect(_x, _y, _w, _h, _edge);
    ui_rect(_x + 2, _y + 2, _w - 4, _h - 4, _fill);
}

/// Translucent dark layer.
function ui_shade(_x, _y, _w, _h, _alpha)
{
    draw_set_alpha(_alpha);
    ui_rect(_x, _y, _w, _h, C_INK);
    draw_set_alpha(1);
}

function ui_text(_x, _y, _str, _scale, _col)
{
    draw_set_font(global.fnt_px);
    draw_set_colour(_col);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_text_transformed(_x, _y, _str, _scale, _scale, 0);
}

function ui_text_c(_x, _y, _str, _scale, _col)
{
    draw_set_font(global.fnt_px);
    draw_set_colour(_col);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_text_transformed(_x, _y, _str, _scale, _scale, 0);
    draw_set_halign(fa_left);
}

function ui_text_r(_x, _y, _str, _scale, _col)
{
    draw_set_font(global.fnt_px);
    draw_set_colour(_col);
    draw_set_halign(fa_right);
    draw_set_valign(fa_top);
    draw_text_transformed(_x, _y, _str, _scale, _scale, 0);
    draw_set_halign(fa_left);
}

/// Wrapped text. Returns the height used.
function ui_text_wrap(_x, _y, _str, _w, _scale, _col)
{
    draw_set_font(global.fnt_px);
    draw_set_colour(_col);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_text_ext_transformed(_x, _y, _str, TXT_LINE, _w / _scale, _scale, _scale, 0);
    return string_height_ext(_str, TXT_LINE, _w / _scale) * _scale;
}

function ui_text_wrap_c(_x, _y, _str, _w, _scale, _col)
{
    draw_set_font(global.fnt_px);
    draw_set_colour(_col);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_text_ext_transformed(_x, _y, _str, TXT_LINE, _w / _scale, _scale, _scale, 0);
    draw_set_halign(fa_left);
    return string_height_ext(_str, TXT_LINE, _w / _scale) * _scale;
}

function ui_text_height(_str, _w, _scale)
{
    draw_set_font(global.fnt_px);
    return string_height_ext(_str, TXT_LINE, _w / _scale) * _scale;
}

/// Button. _selected = primary (honey). Returns true on the frame it is clicked.
function ui_button(_x, _y, _w, _h, _label, _enabled, _selected)
{
    var _hover = point_in_rectangle(mouse_x, mouse_y, _x, _y, _x + _w, _y + _h);
    var _fill = make_colour_rgb(38, 58, 75), _ink = C_TEXT, _edge = make_colour_rgb(129, 150, 142);
    if (_selected) { _fill = C_HONEY; _ink = C_INK; _edge = C_GOLD; }
    if (_hover && _enabled) _fill = merge_colour(_fill, c_white, 0.15);
    if (!_enabled) { _fill = make_colour_rgb(30, 40, 54); _ink = make_colour_rgb(110, 124, 132); _edge = C_EDGE; }
    var _dy = (_hover && _enabled) ? 2 : 0;
    ui_rect(_x + 3, _y + 4, _w, _h, C_INK);
    ui_panel(_x, _y + _dy, _w, _h, _fill, _edge);
    draw_set_font(global.fnt_px);
    draw_set_colour(_ink);
    // centred by hand (does not depend on the font's own vertical alignment)
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    var _th = string_height_ext(_label, TXT_LINE, (_w - 20) / 2) * 2 - 4;
    draw_text_ext_transformed(_x + _w / 2, _y + _dy + round((_h - _th) / 2), _label, TXT_LINE, (_w - 20) / 2, 2, 2, 0);
    draw_set_halign(fa_left);
    if (_enabled && _hover && mouse_check_button_pressed(mb_left) && !global.ui_click_used)
    {
        global.ui_click_used = true;
        return true;
    }
    return false;
}

/// Clickable card. Returns 0 idle, 1 hover, 2 clicked.
function ui_card(_x, _y, _w, _h, _selected, _enabled, _label)
{
    var _hover = _enabled && point_in_rectangle(mouse_x, mouse_y, _x, _y, _x + _w, _y + _h);
    ui_panel(_x, _y, _w, _h, _selected ? C_CARD_HI : C_CARD, _selected ? C_HONEY : (_hover ? C_SAGE : C_EDGE));
    if (_hover && mouse_check_button_pressed(mb_left) && !global.ui_click_used)
    {
        global.ui_click_used = true;
        return 2;
    }
    return _hover ? 1 : 0;
}

/// Metric chip: [icon LABEL value]. Returns its width.
function ui_metric(_x, _y, _icon, _label, _value, _vcol)
{
    var _w = 40 + (string_length(_label) + string_length(_value) + 1) * 12;
    ui_rect(_x, _y, _w, 34, make_colour_rgb(32, 46, 64));
    ui_rect(_x, _y + 32, _w, 2, make_colour_rgb(82, 111, 121));
    if (_icon >= 0) draw_sprite_ext(spr_ui, _icon, _x + 8, _y + 9, 1, 1, 0, c_white, 1);
    ui_text(_x + 30, _y + 9, _label, 2, C_DIM);
    ui_text(_x + 30 + (string_length(_label) + 1) * 12, _y + 9, _value, 2, _vcol);
    return _w;
}

/// Small label chip. Returns its width.
function ui_chip(_x, _y, _label, _col)
{
    var _w = string_length(_label) * 12 + 14;
    ui_rect(_x, _y, _w, 24, _col);
    ui_rect(_x + 2, _y + 2, _w - 4, 20, C_PANEL);
    ui_text(_x + 7, _y + 3, _label, 2, _col);
    return _w;
}

function ui_bar(_x, _y, _w, _h, _value, _col)
{
    var _v = clamp(_value, 0, 1);
    ui_rect(_x, _y, _w, _h, C_INK);
    ui_rect(_x + 2, _y + 2, _w - 4, _h - 4, make_colour_rgb(40, 52, 70));
    ui_rect(_x + 2, _y + 2, round((_w - 4) * _v), _h - 4, _col);
}

/// Draw a sprite scaled to fit inside a box, centred. _bob = vertical offset.
function spr_fit(_spr, _frame, _x, _y, _w, _h, _bob)
{
    var _sw = sprite_get_width(_spr), _sh = sprite_get_height(_spr);
    var _s = min(_w / _sw, _h / _sh);
    draw_sprite_ext(_spr, _frame, _x + (_w - _sw * _s) / 2, _y + (_h - _sh * _s) / 2 + _bob, _s, _s, 0, c_white, 1);
}

/// Draw a background sprite to cover the box (crop by scaling up).
function spr_cover(_spr, _x, _y, _w, _h)
{
    var _sw = sprite_get_width(_spr), _sh = sprite_get_height(_spr);
    var _s = max(_w / _sw, _h / _sh);
    gpu_set_scissor(_x, _y, _w, _h);
    draw_sprite_ext(_spr, 0, _x + (_w - _sw * _s) / 2, _y + (_h - _sh * _s) / 2, _s, _s, 0, c_white, 1);
    gpu_set_scissor(0, 0, room_width, room_height);
}

/// Small "AI" badge (visible watermark for AI-assisted art).
function ai_badge(_x, _y)
{
    ui_rect(_x, _y, 34, 22, C_BROWN);
    ui_text(_x + 5, _y + 3, "AI", 2, make_colour_rgb(255, 244, 220));
}

/// Eyebrow label (small caps style).
function ui_eyebrow(_x, _y, _str) { ui_text(_x, _y, _str, 2, C_MINT); }

function tag_colour(_tag)
{
    switch (_tag)
    {
        case "VERIFIED": return C_TEAL;
        case "OPEN": return C_PINK;
        case "TEAM": return C_HONEY;
    }
    return C_SAGE;
}

function ease_io(_t)
{
    var _c = clamp(_t, 0, 1);
    return _c * _c * (3 - 2 * _c);
}
