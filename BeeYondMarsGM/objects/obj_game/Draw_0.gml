/// obj_game - Draw
/// All screens are drawn here (immediate-mode UI). Input is read where each control is drawn.

ui_begin();
anim += 1;
music_update();
if (keyboard_check_pressed(vk_f11) || keyboard_check_pressed(vk_f4)) window_set_fullscreen(!window_get_fullscreen());
if (toast_time > 0) toast_time -= 1;
var _g = global.G;
var _modal = (overlay != "");

ui_rect(0, 0, room_width, room_height, C_BG);

// ============================================================ TITLE
if (screen == "title")
{
    spr_cover(spr_hero, 0, 0, room_width, room_height);
    var _cx = 470, _cy = 170, _cw = 660, _ch = 560;
    ui_shade(_cx, _cy, _cw, _ch, 0.9);
    ui_panel(_cx, _cy, _cw, _ch, C_PANEL, C_SAGE);
    ui_text_c(800, _cy + 28, "A TINY LIFE * A HUGE JOURNEY", 2, C_MINT);
    spr_fit(spr_bees, 0, 720, _cy + 60, 160, 150, round(sin(anim / 25) * 5));
    ui_text_c(800, _cy + 220, "BEEYOND MARS", 6, C_GOLD);
    ui_text_wrap_c(800, _cy + 292, "Explore the lab, design a spacecraft and look after dormant bumblebee queens on an educational mission to Mars.", 560, 2, C_TEXT);
    if (!_modal)
    {
        if (ui_button(640, _cy + 380, 320, 52, "NEW MISSION", true, true)) { screen = "letter"; letter_t = 0; players_pick = 1; }
        if (ui_button(640, _cy + 446, 320, 44, "GUIDE AND SOURCES", true, false)) { overlay = "guide"; guide_page = 0; }
    }
    if (!_modal && ui_button(1380, 20, 200, 44, global.music_on ? "MUSIC: ON" : "MUSIC: OFF", true, false)) global.music_on = !global.music_on;
    ui_text_c(800, _cy + 510, "1-4 players on one device * NASA Space Apps 2026", 2, C_DIM);
    ui_text_c(800, _cy + 534, "Art: AI-assisted, marked AI * Fictional agency Aurelia * No NASA logos", 1, C_DIM);
    ai_badge(1556, 870);
}

// ============================================================ LETTER (funding)
if (screen == "letter")
{
    letter_t += 1;
    spr_cover(spr_bg_splash, 0, 0, room_width, room_height);
    ui_shade(0, 0, room_width, room_height, 0.55);
    // paper
    var _px = 110, _py = 50, _pw = 820, _ph = 800;
    ui_rect(_px + 10, _py + 12, _pw, _ph, C_INK);
    ui_panel(_px, _py, _pw, _ph, make_colour_rgb(246, 236, 212), make_colour_rgb(176, 150, 110));
    ui_text(_px + 40, _py + 34, "AURELIA SPACE AGENCY", 4, make_colour_rgb(120, 60, 30));
    ui_text(_px + 40, _py + 76, "Office of Pollinator Research * fictional space agency", 2, make_colour_rgb(120, 96, 70));
    ui_rect(_px + 40, _py + 104, _pw - 80, 3, make_colour_rgb(190, 140, 70));
    ui_text(_px + 40, _py + 120, "To: the BeeYond Mars team", 2, make_colour_rgb(56, 32, 26));
    ui_text(_px + 40, _py + 144, "Subject: research proposal FUNDED", 2, make_colour_rgb(56, 32, 26));
    var _n = min(string_length(LETTER), letter_t * 3);
    ui_text_wrap(_px + 40, _py + 186, string_copy(LETTER, 1, _n), _pw - 80, 2, make_colour_rgb(56, 32, 26));
    if (_n >= string_length(LETTER))
    {
        // FUNDED stamp
        var _sx = _px + _pw - 300, _sy = _py + _ph - 150;
        ui_rect(_sx, _sy, 240, 84, make_colour_rgb(200, 50, 40));
        ui_rect(_sx + 5, _sy + 5, 230, 74, make_colour_rgb(246, 236, 212));
        ui_text_c(_sx + 120, _sy + 18, "FUNDED", 5, make_colour_rgb(200, 50, 40));
        ui_text_c(_sx + 120, _sy + 62, string(global.CFG.budget) + " CREDITS", 1, make_colour_rgb(200, 50, 40));
    }
    // right panel
    ui_shade(970, 50, 600, 800, 0.85);
    ui_panel(970, 50, 600, 800, C_PANEL, C_SAGE);
    spr_fit(spr_bees, 3, 1170, 70, 200, 170, round(sin(anim / 20) * 5));
    ui_text_c(1270, 250, "YOU WON THE FUNDS!", 3, C_GOLD);
    ui_text_wrap_c(1270, 290, "The research grant is yours. Now build a spacecraft that can carry the queens.", 520, 2, C_TEXT);
    ui_panel(1000, 370, 540, 150, make_colour_rgb(30, 52, 50), C_SAGE);
    ui_text_wrap(1016, 384, "This mission is hypothetical. Diapause data come from studies on Earth. No one has shown that bumblebee queens survive an interplanetary trip; the game uses a simplified model to teach engineering decisions.", 510, 1, C_MINT);
    ui_text(1000, 540, "PEOPLE ON THIS DEVICE", 2, C_MINT);
    for (var i = 1; i <= 4; i++) if (ui_button(1000 + (i - 1) * 135, 568, 120, 48, string(i), true, players_pick == i)) players_pick = i;
    ui_text_wrap(1000, 632, (players_pick == 1) ? "1 player: you hold all four roles." : (string(players_pick) + " players take turns at the stations. Each role installs its own parts; the budget is shared."), 540, 2, C_DIM);
    if (_n < string_length(LETTER)) { if (ui_button(1000, 770, 250, 52, "READ ALL", true, false)) letter_t = 9999; }
    if (ui_button(1270, 770, 270, 52, "ACCEPT MISSION", true, true)) start_mission();
    ai_badge(1556, 870);
}

// ============================================================ GAME SCREENS (HUD + world + dock)
_g = global.G;
if (screen != "title" && screen != "letter")
{
    var _t = g_stats(), _r = g_route();

    // ---------------- HUD
    ui_rect(0, 0, room_width, 60, C_PANEL);
    ui_rect(0, 58, room_width, 2, C_EDGE);
    ui_text(20, 14, "BEEYOND MARS", 3, C_GOLD);
    ui_text(242, 22, "/ AURELIA", 2, C_DIM);
    var _mx = 400;
    _mx += ui_metric(_mx, 13, 0, "FUNDS", string(_t.budget), C_GOLD) + 8;
    _mx += ui_metric(_mx, 13, 1, "MASS", fmt1(_t.kg) + "/250kg", (_t.kg <= 250) ? C_GOLD : C_RED) + 8;
    _mx += ui_metric(_mx, 13, 2, "POWER", string(_t.use) + "/" + string(_t.power) + "W", (_t.use <= _t.power) ? C_GOLD : C_RED) + 8;
    ui_metric(_mx, 13, 3, "DV", string_format(_t.dv, 1, 2) + "/" + string(_r.dv), (_t.dv >= _r.dv) ? C_GOLD : C_RED);
    if (!_modal && ui_button(1300, 10, 160, 40, "LOGBOOK", true, false)) { overlay = "journal"; paper_page = 0; }
    if (!_modal && ui_button(1470, 10, 110, 40, "MENU", true, false)) overlay = "menu";

    // ---------------- LAB
    if (screen == "lab")
    {
        var _k = LAB_K;
        ui_rect(LAB_X - 4, LAB_Y - 2, 640 * _k + 8, 352 * _k + 6, C_EDGE);
        draw_sprite_ext(spr_lab, 0, LAB_X, LAB_Y, 640 * _k / sprite_get_width(spr_lab), 352 * _k / sprite_get_height(spr_lab), 0, c_white, 1);

        // walking (keyboard)
        var _dx = 0, _dy = 0;
        if (!_modal)
        {
            _dx = (keyboard_check(vk_right) || keyboard_check(ord("D"))) - (keyboard_check(vk_left) || keyboard_check(ord("A")));
            _dy = (keyboard_check(vk_down) || keyboard_check(ord("S"))) - (keyboard_check(vk_up) || keyboard_check(ord("W")));
        }
        if (_dx != 0 || _dy != 0)
        {
            var _len = sqrt(_dx * _dx + _dy * _dy);
            var _nx = clamp(pos_x + _dx / _len * 2, 32, 608), _ny = clamp(pos_y + _dy / _len * 2, 128, 318);
            if (!lab_blocked(_nx, pos_y)) pos_x = _nx;
            if (!lab_blocked(pos_x, _ny)) pos_y = _ny;
            dir = (_dx < 0) ? 1 : ((_dx > 0) ? 2 : ((_dy < 0) ? 3 : 0));
            walk_frame = floor(anim / 8) mod 4;
        }
        else walk_frame = 0;

        // stations (crew member + label); click to open
        var _near = -1, _best = 9999;
        for (var i = 0; i < 4; i++)
        {
            var _s = stations[i];
            var _d = point_distance(_s.x, _s.y, pos_x, pos_y);
            if (_d < _best) { _best = _d; _near = i; }
        }
        for (var i = 0; i < 4; i++)
        {
            var _s = stations[i];
            var _sx = LAB_X + _s.x * _k, _sy = LAB_Y + _s.y * _k;
            draw_sprite_ext(spr_crew, 0, _sx + 40 * _k - 24 * _k, _sy - 42 * _k, 48 * _k / sprite_get_width(spr_crew), 48 * _k / sprite_get_height(spr_crew), 0, c_white, 1);
            var _hot = (i == _near && _best < 110);
            ui_rect(_sx - 9, _sy - 34, 18, 18, _hot ? C_GOLD : C_MINT);
            ui_rect(_sx - 76, _sy + 24, 152, 36, C_INK);
            ui_text_c(_sx, _sy + 33, _s.label, 2, _hot ? C_GOLD : make_colour_rgb(244, 231, 186));
            if (!_modal && mouse_check_button_pressed(mb_left) && !global.ui_click_used && point_distance(mouse_x, mouse_y, _sx, _sy) < 62 * _k)
            {
                global.ui_click_used = true;
                open_station(_s.role);
            }
        }
        if (!_modal && (keyboard_check_pressed(ord("E")) || keyboard_check_pressed(vk_enter)))
        {
            if (_best < 110) open_station(stations[_near].role);
            else toast("Walk up to a station or use the buttons below.");
        }
        // player
        draw_sprite_ext(spr_crew, dir * 4 + walk_frame, LAB_X + (pos_x - 24) * _k, LAB_Y + (pos_y - 42) * _k, 48 * _k / sprite_get_width(spr_crew), 48 * _k / sprite_get_height(spr_crew), 0, c_white, 1);
        ui_rect(LAB_X + (pos_x - 3) * _k, LAB_Y + (pos_y - 47) * _k, 6 * _k, 3 * _k, C_GOLD);

        // next step
        var _q = objective(), _hint = g_hints()[0];
        ui_shade(LAB_X + 12, LAB_Y + 12, 640, 150, 0.9);
        ui_rect(LAB_X + 12, LAB_Y + 12, 4, 150, C_HONEY);
        ui_eyebrow(LAB_X + 30, LAB_Y + 22, "YOUR NEXT STEP");
        ui_text(LAB_X + 30, LAB_Y + 46, _q[0], 2, C_GOLD);
        ui_text_wrap(LAB_X + 30, LAB_Y + 70, _q[1], 610, 1, C_TEXT);
        ui_text(LAB_X + 30, LAB_Y + 92, "TIP", 2, C_TEAL);
        ui_text_wrap(LAB_X + 80, LAB_Y + 94, _hint, 560, 1, C_TEXT);
        // queens monitor
        var _bx = LAB_X + 640 * _k - 236, _by = LAB_Y + 352 * _k - 236;
        ui_panel(_bx, _by, 224, 224, make_colour_rgb(24, 37, 56), C_SAGE);
        spr_fit(spr_bees, 1, _bx + 22, _by + 12, 180, 150, round(sin(anim / 30) * 4));
        ui_text_c(_bx + 112, _by + 170, "QUEENS RESTING", 2, C_TEXT);
        ui_text_c(_bx + 112, _by + 194, "Experimental cargo", 1, C_DIM);
        ai_badge(LAB_X + 640 * _k - 42, LAB_Y + 6);

        // dock
        ui_rect(0, 820, room_width, 80, C_PANEL);
        ui_rect(0, 820, room_width, 2, C_EDGE);
        var _names = ["BIOLOGY", "ENGINEERING", "COMMUNICATIONS", "MISSION LEAD"], _roles = [1, 0, 2, 3], _bxs = 20;
        for (var i = 0; i < 4; i++)
        {
            var _bw = string_length(_names[i]) * 12 + 40;
            if (!_modal && ui_button(_bxs, 836, _bw, 44, _names[i], true, false)) open_station(_roles[i]);
            _bxs += _bw + 12;
        }
        ui_text_r(1580, 838, "WASD / ARROWS: WALK * E: INTERACT", 2, C_DIM);
        ui_text_r(1580, 864, "Or click a station. " + ((_g.players > 1) ? string(_g.players) + " players: each role installs its own parts." : "1 player: you hold every role."), 1, C_DIM);
    }

    // ---------------- LIFTOFF
    if (screen == "liftoff")
    {
        liftoff_t += 1;
        if (liftoff_t == 41) sfx(snd_launch);
        // launch pad scene: 640x360 art scaled x2.5 (the rocket is a separate sprite so it can fly)
        var _ls = 2.5, _ly0 = 64 + (756 - 360 * _ls) / 2;
        gpu_set_scissor(0, 64, room_width, 756);
        draw_sprite_ext(spr_bg_launchpad, 0, 0, _ly0, _ls, _ls, 0, c_white, 1);
        var _rise = ease_io(max(0, liftoff_t - 60) / 150) * 900;
        var _shake = (liftoff_t > 40 && liftoff_t < 150) ? (irandom(4) - 2) : 0;
        var _rx = 270 * _ls + _shake, _ry = _ly0 + 105 * _ls - _rise;
        if (liftoff_t > 40)
        {
            var _fl = 40 + (floor(anim / 3) mod 3) * 14;
            draw_set_colour(make_colour_rgb(248, 174, 88)); draw_triangle(_rx + 95, _ry + 375, _rx + 205, _ry + 375, _rx + 150, _ry + 375 + _fl * 2, false);
            draw_set_colour(make_colour_rgb(255, 236, 160)); draw_triangle(_rx + 120, _ry + 375, _rx + 180, _ry + 375, _rx + 150, _ry + 375 + _fl, false);
            for (var i = 0; i < 5; i++) draw_sprite_ext(spr_fx_steam, (floor(anim / 5) + i) mod 6, 560 + i * 80, _ly0 + 250 * _ls - 40, 5, 5, 0, c_white, 0.85);
        }
        draw_sprite_ext(spr_rocket, 0, _rx, _ry, _ls, _ls, 0, c_white, 1);
        gpu_set_scissor(0, 0, room_width, room_height);
        ui_shade(560, 100, 480, 60, 0.85);
        ui_text_c(800, 118, (liftoff_t < 60) ? ("T-" + string(3 - floor(liftoff_t / 20))) : "LIFTOFF!", 3, C_GOLD);
        ai_badge(1556, 790);
        ui_rect(0, 820, room_width, 80, C_PANEL);
        ui_rect(0, 820, room_width, 2, C_EDGE);
        ui_text(20, 846, "Destination: Mars * " + _r.name + " * " + _r.depart + " -> " + _r.arrive, 2, C_TEXT);
        if (ui_button(1420, 834, 160, 48, "SKIP", true, false) || liftoff_t > 240) { screen = "voyage"; liftoff_t = 0; }
    }

    // ---------------- VOYAGE
    if (screen == "voyage")
    {
        var _f = _g.flight;
        spr_cover(spr_bg_transit, 0, 64, room_width, 756);
        ai_badge(1556, 790);
        var _p = _g.day / g_days();
        ui_shade(20, 80, 760, 110, 0.85);
        ui_eyebrow(40, 92, "TRANSIT TO MARS * " + string_upper(_r.name));
        ui_text(40, 118, "DAY " + string(_g.day) + " OF " + string(g_days()), 4, C_GOLD);
        ui_bar(40, 162, 720, 16, _p, C_HONEY);
        // ship on its way
        var _sx = lerp(180, 1420, _p), _sy = 300 - sin(_p * pi) * 90;
        draw_sprite_ext(spr_fx_signal, floor(anim / 6) mod 6, _sx - 64, _sy - 30, 4, 4, 0, c_white, 0.9);
        draw_sprite_ext(spr_equip, 6, _sx, _sy, 1.5, 1.5, -60, c_white, 1);

        // chamber window
        var _risky = _f.risk > 35;
        ui_panel(640, 330, 320, 300, make_colour_rgb(24, 37, 56), _risky ? C_RED : C_SAGE);
        spr_fit(spr_bees, _risky ? 2 : 1, 670, 345, 260, 190, round(sin(anim / 30) * 4));
        ui_text_c(800, 540, _risky ? "THEY NEED ATTENTION" : "CARGO RESTING", 2, _risky ? C_RED : C_TEXT);
        ui_text_c(800, 566, string_format(_f.temp, 1, 1) + " C * " + string(round(_f.humidity)) + "% RH", 2, C_GOLD);
        ui_text_c(800, 592, "Target 2.5 C * 70% RH", 1, C_DIM);

        // metrics
        var _y = 660, _x = 20;
        _x += ui_metric(_x, _y, 8, "RISK", string(round(_f.risk)) + "/100", _risky ? C_RED : C_GOLD) + 8;
        _x += ui_metric(_x, _y, 2, "BATTERY", string(round(_f.charge)) + "Wh", C_GOLD) + 8;
        _x += ui_metric(_x, _y, 18, "MEMORY", string(round(_f.stored)) + "/" + string(global.CFG.storage_mb) + "MB", C_GOLD) + 8;
        _x += ui_metric(_x, _y, 19, "RECEIVED", string(round(_f.sent)) + "MB", C_GOLD) + 8;
        _x += ui_metric(_x, _y, 11, "LOST", string(round(_f.lost)) + "MB", (_f.lost > 0) ? C_RED : C_GOLD) + 8;
        _x += ui_metric(_x, _y, 5, "SIGNAL", string(round(g_delay())) + "min", C_GOLD) + 8;
        ui_metric(_x, _y, 17, "SHIP", string(round(_f.integrity)) + "%", (_f.integrity < 60) ? C_RED : C_GOLD);
        ui_shade(20, 712, 1560, 96, 0.85);
        var _pend = (_f.pending != "");
        ui_text(40, 726, _pend ? "THE SPACECRAFT NEEDS A DECISION" : "WATCH, LEARN AND KEEP GOING", 2, C_GOLD);
        var _who = (_f.pending == "thermal") ? 1 : ((_f.pending == "comms") ? 2 : 0);
        ui_text_wrap(40, 752, _pend ? ("Time is paused until " + global.ROLES[_who] + " chooses a response.") : ("Sunlight now gives " + string(round(_f.last_gen)) + " W for " + string(_t.use) + " W of use. Ship integrity " + string(round(_f.integrity)) + "%, repair actions " + string(_f.repairs) + "."), 1500, 2, C_TEXT);
        ui_text(40, 780, "DID YOU KNOW?", 2, C_TEAL);
        ui_text(220, 780, global.FACTS[floor(_g.day / 30) mod array_length(global.FACTS)], 2, C_DIM);

        // dock
        ui_rect(0, 820, room_width, 80, C_PANEL);
        ui_rect(0, 820, room_width, 2, C_EDGE);
        ui_text(20, 846, "Every decision changes the result of this simulation.", 2, C_DIM);
        if (!_modal)
        {
            if (_pend) { if (ui_button(1190, 834, 390, 48, "RESOLVE INCIDENT", true, true)) overlay = "event"; }
            else if (ui_button(1190, 834, 390, 48, "ADVANCE " + string(min(30, g_days() - _g.day)) + " DAYS", true, true))
            {
                g_advance();
                if (_g.flight.pending != "") { overlay = "event"; sfx(snd_alert); }
            }
        }
        if (_g.phase == "report" && overlay == "") screen = "report";
    }

    // ---------------- REPORT
    if (screen == "report")
    {
        var _f = _g.flight, _rep = g_report();
        if (!report_sfx) { report_sfx = true; sfx((_rep.kind == "failure") ? snd_alert : snd_success); overlay = "journal"; paper_page = 3; }
        spr_cover(spr_bg_mars, 0, 64, room_width, 756);
        ai_badge(1556, 790);
        ui_shade(220, 80, 1160, 728, 0.9);
        ui_panel(220, 80, 1160, 728, C_PANEL, C_SAGE);
        ui_eyebrow(250, 100, "MISSION REPORT / ATTEMPT " + string(_g.attempt));
        spr_fit(spr_bees, (_rep.kind == "success") ? 3 : ((_rep.kind == "partial") ? 0 : 2), 1180, 96, 170, 150, round(sin(anim / 20) * 4));
        if (_rep.kind == "success") for (var i = 0; i < 5; i++) draw_sprite_ext(spr_fx_confetti, (floor(anim / 6) + i) mod 6, 1120 + i * 40, 110 + (i mod 2) * 30, 3, 3, 0, c_white, 1);
        var _title = (_rep.kind == "success") ? "MARS IN SIGHT!" : ((_rep.kind == "partial") ? "WE ARRIVED, WITH LESSONS" : "TIME TO REDESIGN");
        ui_text(250, 130, _title, 4, C_GOLD);
        if (_rep.science > 0 && _rep.arrived) ui_chip(760, 132, "+" + string(_rep.science) + " SCIENCE (DOSIMETER)", C_TEAL);
        var _why = "Your design balanced energy, climate and communication. Autonomy let the spacecraft respond far from Earth.";
        if (_rep.reason == "power") _why = "The spacecraft ran out of energy in two stages in a row. Reduce consumption or add generation.";
        if (_rep.reason == "climate") _why = "The chamber climate raised the risk to the cargo. Compare active cooling, backup sensors and an autonomous emergency response.";
        if (_rep.reason == "data") _why = "The spacecraft arrived, but observations were missing. Compare antenna throughput, memory and compression.";
        if (_rep.reason == "comms") _why = "Contact with Earth was lost for good: no high-gain antenna and no backup comms when the signal dropped. Telemetry froze and the mission failed early.";
        if (_rep.reason == "systems") _why = "A mechanical failure kept damaging the ship. A repair toolkit lets you fix it with one logbook action.";
        ui_text_wrap(250, 180, _why, 900, 2, C_TEXT);
        var _x = 250, _y = 250;
        _x += ui_metric(_x, _y, 4, "DAYS", string(_g.day) + "/" + string(g_days()), C_GOLD) + 8;
        _x += ui_metric(_x, _y, 14, "CARGO", _rep.status, (_rep.status == "GOOD") ? C_TEAL : C_RED) + 8;
        _x += ui_metric(_x, _y, 8, "RISK", string(round(_f.risk)) + "/100", C_GOLD) + 8;
        ui_metric(_x, _y, 16, "SCORE", string(_rep.score), C_GOLD);
        _x = 250; _y = 296;
        _x += ui_metric(_x, _y, 6, "CLIMATE", string_format(_f.temp, 1, 1) + "C " + string(round(_f.humidity)) + "%", C_GOLD) + 8;
        _x += ui_metric(_x, _y, 19, "DATA", string(round(_f.sent)) + "MB", C_GOLD) + 8;
        _x += ui_metric(_x, _y, 11, "LOST", string(round(_f.lost)) + "MB", C_GOLD) + 8;
        _x += ui_metric(_x, _y, 2, "ENERGY", string(round(_f.energy / 1000)) + "kWh", C_GOLD) + 8;
        ui_metric(_x, _y, 17, "SHIP", string(round(_f.integrity)) + "%", C_GOLD);

        ui_panel(250, 350, 1100, 300, make_colour_rgb(30, 45, 64), C_EDGE);
        ui_text(270, 364, "CONFIGURATION AND DECISIONS", 2, C_MINT);
        var _parts = "";
        for (var i = 0; i < array_length(_g.parts); i++) _parts += ((i > 0) ? ", " : "") + item(_g.parts[i]).name;
        // next phase (imagined, not simulated)
        ui_rect(1036, 388, 296, 240, C_SAGE);
        draw_sprite_ext(spr_bg_greenhouse, 0, 1040, 392, 0.6, 0.6, 0, c_white, 1);
        ui_rect(1040, 584, 288, 40, C_INK);
        ui_text_c(1184, 588, "NEXT PHASE: GREENHOUSE", 1, C_GOLD);
        ui_text_c(1184, 604, "hypothetical extension", 1, C_DIM);
        ai_badge(1294, 396);
        var _ly = 392;
        _ly += ui_text_wrap(270, _ly, "Spacecraft: " + _parts + " * " + fmt1(_t.kg) + " kg * " + string(_t.use) + "/" + string(_t.power) + " W * dv " + string_format(_t.dv, 1, 2) + " km/s", 750, 2, C_TEXT) + 6;
        _ly += ui_text_wrap(270, _ly, "Route: " + _r.name + " (" + _r.depart + " -> " + _r.arrive + ", " + string(_r.dv) + " km/s, NASA Trajectory Browser)", 750, 2, C_TEXT) + 6;
        _ly += ui_text_wrap(270, _ly, "Battery: " + string(global.CFG.battery_wh) + " -> " + string(round(_f.charge)) + " Wh", 750, 2, C_TEXT) + 6;
        for (var i = 0; i < array_length(_g.log); i++)
        {
            var _e = _g.log[i];
            if ((string_pos("Heat alarm", _e.text) == 1 || string_pos("Signal loss", _e.text) == 1 || string_pos("Minor impact", _e.text) == 1) && _ly < 620)
                _ly += ui_text_wrap(270, _ly, "Day " + string(_e.day) + ": " + string_copy(_e.text, 1, 110), 750, 1, C_GOLD) + 4;
        }
        ui_text_wrap(250, 664, "What would you change, and why? Redesign keeps your equipment and earned grants.", 1100, 2, C_TEXT);
        ui_text_wrap(250, 770, "Hypothetical educational model: it does not show real survival in space. Landing is not simulated; the greenhouse phase is a hypothetical extension.", 1100, 1, C_DIM);

        ui_rect(0, 820, room_width, 80, C_PANEL);
        ui_rect(0, 820, room_width, 2, C_EDGE);
        if (!_modal)
        {
            if (ui_button(20, 834, 330, 48, "PAPER AND FEEDBACK", true, false)) { overlay = "journal"; paper_page = 0; }
            if (ui_button(370, 834, 300, 48, "GUIDE AND SOURCES", true, false)) { overlay = "guide"; guide_page = 0; }
            var _gdone = is_struct(_g.green) && _g.green.done;
            if (ui_button(690, 834, 470, 48, _gdone ? "GREENHOUSE: DONE" : "NEXT PHASE: GREENHOUSE", g_green_can() && !_gdone, !_gdone))
            {
                if (!is_struct(_g.green)) g_green_start();
                screen = "greenhouse";
            }
            if (ui_button(1180, 834, 400, 48, "REDESIGN AND RETRY", true, false)) { g_redesign(); screen = "lab"; report_sfx = false; }
        }
    }
    // ---------------- GREENHOUSE (next phase, hypothetical extension)
    if (screen == "greenhouse")
    {
        var _gr = _g.green, _steps = g_green_steps();
        spr_cover(spr_bg_greenhouse, 0, 64, room_width, 756);
        ui_shade(0, 64, room_width, 756, 0.35);
        ai_badge(1556, 790);
        // bees flying in the dome: more bees when the colony is stronger
        var _nb = 1 + floor(_gr.colony / 25);
        for (var i = 0; i < _nb; i++)
            spr_fit(spr_bees, (_gr.colony >= 60) ? 3 : 0, 80 + i * 110 + round(sin(anim / 40 + i * 2) * 30), 120 + (i mod 2) * 70 + round(cos(anim / 30 + i) * 14), 90, 80, 0);
        // status panel
        ui_shade(20, 330, 600, 470, 0.9);
        ui_panel(20, 330, 600, 470, C_PANEL, C_SAGE);
        ui_eyebrow(40, 346, "NEXT PHASE * HYPOTHETICAL EXTENSION");
        ui_text(40, 372, "MARS GREENHOUSE", 4, C_GOLD);
        ui_text_wrap(40, 420, "Not part of the transit model. A sealed habitat with pressure, heat, water and plants. Can the queens wake up and start a colony?", 560, 2, C_TEXT);
        ui_text(40, 520, "COLONY INDEX", 2, C_MINT);
        ui_bar(40, 546, 560, 24, _gr.colony / 100, (_gr.colony >= 60) ? C_TEAL : ((_gr.colony >= 35) ? C_HONEY : C_RED));
        ui_text(40, 578, string(round(_gr.colony)) + "/100 * started at " + string(round(_gr.start)) + " (100 minus the trip risk)", 2, C_TEXT);
        ui_text(40, 620, "ENERGY CELLS", 2, C_MINT);
        for (var i = 0; i < 4; i++) ui_panel(40 + i * 56, 646, 46, 46, (i < _gr.cells) ? C_HONEY : make_colour_rgb(40, 52, 70), C_EDGE);
        ui_text_wrap(40, 706, "Cells come from your trip: 2, +1 if the battery ended at 800 Wh or more, +1 if the ship kept 80% integrity.", 560, 1, C_DIM);
        ui_text_wrap(40, 746, "Game index only: it is not a real chance of survival.", 560, 1, C_DIM);
        // decision or result
        ui_shade(650, 330, 930, 470, 0.9);
        ui_panel(650, 330, 930, 470, C_PANEL, C_SAGE);
        if (!_gr.done)
        {
            var _st = _steps[_gr.step];
            ui_eyebrow(670, 346, "STEP " + string(_gr.step + 1) + "/4 * DECISION FOR " + string_upper(global.ROLES[_st.role]));
            ui_text(670, 372, _st.title, 3, C_GOLD);
            ui_text_wrap(670, 410, _st.text, 890, 2, C_TEXT);
            ui_card(670, 470, 435, 230, false, false, _st.a_name);
            ui_text_wrap(686, 484, _st.a_name, 400, 2, C_GOLD);
            ui_text_wrap(686, 540, _st.a_desc, 400, 2, C_TEXT);
            if (ui_button(686, 640, 403, 46, (_gr.cells > 0) ? "CHOOSE (1 CELL)" : "NO CELLS LEFT", _gr.cells > 0 && !_modal, true)) { g_green_choose(true); sfx(snd_click); }
            ui_card(1125, 470, 435, 230, false, false, _st.b_name);
            ui_text_wrap(1141, 484, _st.b_name, 400, 2, C_GOLD);
            ui_text_wrap(1141, 540, _st.b_desc, 400, 2, C_TEXT);
            if (ui_button(1141, 640, 403, 46, "CHOOSE (FREE)", !_modal, false)) { g_green_choose(false); sfx(snd_click); }
            ui_text(670, 716, "DID YOU KNOW?", 2, C_TEAL);
            ui_text_wrap(670, 742, _st.fact, 890, 2, C_DIM);
        }
        else
        {
            var _res = g_green_result();
            ui_eyebrow(670, 346, "GREENHOUSE RESULT * HYPOTHETICAL");
            ui_text_wrap(670, 372, _res.title, 890, 3, C_GOLD);
            spr_fit(spr_bees, (_res.colony >= 60) ? 3 : ((_res.colony >= 35) ? 0 : 2), 1380, 420, 170, 150, round(sin(anim / 20) * 4));
            ui_text_wrap(670, 430, _res.text, 680, 2, C_TEXT);
            var _mx2 = 670;
            _mx2 += ui_metric(_mx2, 580, 14, "COLONY", string(_res.colony) + "/100", C_GOLD) + 8;
            _mx2 += ui_metric(_mx2, 580, 18, "SCIENCE", "+" + string(_res.science), C_GOLD) + 8;
            ui_metric(_mx2, 580, 12, "POLLINATION", _res.pollinated ? "YES" : "NO", _res.pollinated ? C_TEAL : C_RED);
            if (_res.pollinated) for (var i = 0; i < 6; i++) draw_sprite_ext(spr_fx_confetti, (floor(anim / 6) + i) mod 6, 700 + i * 120, 640 + (i mod 2) * 20, 3, 3, 0, c_white, 1);
            ui_text_wrap(670, 700, "This result is added to your paper as a follow-up experiment. It is a teaching model, not evidence that bumblebees can live on Mars.", 890, 1, C_DIM);
        }
        ui_rect(0, 820, room_width, 80, C_PANEL);
        ui_rect(0, 820, room_width, 2, C_EDGE);
        ui_text(20, 846, "Sealed greenhouse: nothing is released on Mars (planetary protection).", 2, C_DIM);
        if (!_modal && ui_button(1180, 834, 400, 48, _gr.done ? "ADD TO THE PAPER" : "BACK TO THE REPORT", true, _gr.done))
        {
            screen = "report";
            if (_gr.done) { overlay = "journal"; paper_page = 3; sfx(snd_success); }
        }
    }
    ui_text(20, 886, "Art: AI-assisted, marked AI * Fictional agency Aurelia * No NASA logos", 1, C_DIM);
}

// ============================================================ OVERLAYS
_g = global.G;
if (overlay != "")
{
    ui_shade(0, 0, room_width, room_height, 0.7);
    var _wx = 210, _wy = 90, _ww = 1180, _wh = 700;
    ui_panel(_wx, _wy, _ww, _wh, C_PANEL, C_SAGE);
    if (overlay == "journal") ui_text(240, 92, "MISSION LOGBOOK", 1, C_MINT);
}

if (overlay == "station")
{
    var _role = station, _t = g_stats();
    ui_eyebrow(240, 116, "STATION " + string_upper(global.ROLES[_role]) + ((_g.players > 1) ? " * YOUR TURN" : ""));
    var _heads = ["BUILD YOUR SPACECRAFT", "LOOK AFTER YOUR BEES", "LISTEN FROM EARTH", "PREPARE THE LAUNCH"];
    ui_text(240, 142, _heads[_role], 4, C_GOLD);
    if (_role != 3)
    {
        var _intro = ["Power, sensors and repairs. Every kg costs 0.008 km/s of delta-v.", "Your passengers travel dormant. Pick one chamber: it is the heart of the mission.", "Talk to Earth through NASA's Deep Space Network and measure radiation."];
        ui_text_wrap(240, 194, _intro[_role], 1110, 2, C_TEXT);
        var _mine = [];
        for (var i = 0; i < array_length(global.ITEMS); i++) if (global.ITEMS[i].role == _role) array_push(_mine, global.ITEMS[i]);
        var _nc = array_length(_mine), _cw = floor((1120 - (_nc - 1) * 20) / _nc);
        for (var i = 0; i < _nc; i++)
        {
            var _it = _mine[i], _cx = 240 + i * (_cw + 20), _cy = 236, _own = g_has(_it.id);
            ui_card(_cx, _cy, _cw, 400, _own, false, _it.name);
            spr_fit(spr_equip, _it.icon, _cx + 16, _cy + 16, 80, 80, 0);
            ui_text_wrap(_cx + 110, _cy + 22, string_upper(_it.name), _cw - 126, 2, _own ? C_GOLD : C_TEXT);
            if (_own) ui_chip(_cx + 110, _cy + 72, "INSTALLED", C_TEAL);
            ui_text_wrap(_cx + 18, _cy + 112, _it.desc, _cw - 36, 2, C_TEXT);
            ui_text(_cx + 18, _cy + 270, string(_it.cost) + " credits", 2, C_GOLD);
            ui_text(_cx + 18, _cy + 294, fmt1(_it.kg) + " kg * " + ((_it.gen > 0) ? ("+" + string(_it.gen)) : ("-" + string(_it.w))) + " W", 2, C_GOLD);
            ui_text(_cx + 18, _cy + 318, "dv -" + string_format(_it.kg * global.CFG.dv_per_kg, 1, 2) + " km/s", 2, C_DIM);
            if (ui_button(_cx + 18, _cy + 338, _cw - 36, 46, _own ? "REMOVE" : "INSTALL", true, !_own))
            {
                var _msg = g_toggle(_it.id);
                if (_msg != "") toast(_msg); else sfx(snd_click);
            }
        }
        ui_text(240, 652, "Funds: " + string(g_stats().budget) + " credits * Mass " + fmt1(_t.kg) + "/250 kg * Power " + string(_t.use) + "/" + string(_t.power) + " W", 2, C_DIM);
    }
    else
    {
        if (ui_button(240, 190, 540, 42, arr_has(_g.grants, 0) ? "DONE: CML 2 FIRST REVIEW" : "+150 * CML 2 * REVIEW DESIGN", !arr_has(_g.grants, 0), false))
        {
            if (g_claim(0)) { toast("Research funds received!"); sfx(snd_coin); } else toast("Install a chamber with enough power and under 250 kg.");
        }
        if (ui_button(800, 190, 560, 42, arr_has(_g.grants, 1) ? "DONE: CML 3 ROUTES COMPARED" : "+200 * CML 3 * COMPARE ROUTES", !arr_has(_g.grants, 1), false))
        {
            if (g_claim(1)) { toast("Research funds received!"); sfx(snd_coin); } else toast("Pass the first review and examine two routes.");
        }
        ui_text(240, 244, "NASA AMES TRAJECTORY BROWSER * Rocket: Medium Lift 250 kg, 7.0 km/s, 600 W", 2, C_MINT);
        for (var i = 0; i < array_length(global.ROUTES); i++)
        {
            var _ro = global.ROUTES[i], _cx = 240 + i * 380, _cy = 272, _sel = (_g.route == _ro.id);
            ui_card(_cx, _cy, 360, 232, _sel, false, _ro.name);
            ui_text_wrap(_cx + 16, _cy + 14, string_upper(_ro.name), 330, 2, _sel ? C_GOLD : C_TEXT);
            ui_text(_cx + 16, _cy + 62, _ro.depart + " ->", 2, C_TEXT);
            ui_text(_cx + 16, _cy + 84, _ro.arrive + " * " + string(_ro.days) + " d", 2, C_TEXT);
            ui_text(_cx + 16, _cy + 110, string(_ro.inj) + " + " + string(_ro.post) + " = " + string(_ro.dv) + " km/s", 2, C_GOLD);
            ui_text(_cx + 16, _cy + 134, "yours: " + string_format(_t.dv, 1, 2) + " km/s", 2, (_t.dv >= _ro.dv) ? C_TEAL : C_RED);
            ui_text_wrap(_cx + 16, _cy + 158, _ro.note, 330, 1, C_DIM);
            if (ui_button(_cx + 16, _cy + 178, 328, 40, (arr_has(_g.compared, _ro.id) ? "EXAMINED * " : "") + "CHOOSE", true, false)) g_select_route(_ro.id);
        }
        // hints
        var _h = g_hints();
        ui_panel(240, 520, 1120, 76, make_colour_rgb(30, 45, 64), C_TEAL);
        ui_text(256, 530, "TIP", 2, C_TEAL);
        ui_text_wrap(310, 530, _h[0], 1030, 2, C_TEXT);
        // checks
        var _errs = g_errors();
        var _msg = "";
        if (array_length(_errs) == 0) _msg = "OK: chamber, mass, power, delta-v and funds are compatible.";
        else for (var i = 0; i < min(2, array_length(_errs)); i++) _msg += _errs[i] + " ";
        ui_panel(240, 606, 1120, 98, (array_length(_errs) > 0) ? make_colour_rgb(70, 36, 40) : make_colour_rgb(30, 52, 50), (array_length(_errs) > 0) ? C_RED : C_SAGE);
        ui_text_wrap(256, 618, _msg, 1090, 2, C_TEXT);
        ui_text(256, 676, "Energy rule: power x 0.85 near Mars = " + string(round(_t.arrival)) + " W must cover " + string(_t.use) + " W of use.", 1, (_t.arrival < _t.use) ? C_RED : C_DIM);
        if (ui_button(240, 724, 380, 48, "LAUNCH TO MARS", g_milestone() >= 4, true))
        {
            if (g_launch()) { overlay = ""; screen = "liftoff"; liftoff_t = 0; }
        }
        ui_text(640, 740, "CML " + string(g_milestone()) + "/4", 2, C_DIM);
    }
}

if (overlay == "event")
{
    var _f = _g.flight, _k = _f.pending;
    var _who = (_k == "thermal") ? 1 : ((_k == "comms") ? 2 : 0);
    ui_eyebrow(240, 116, "DECISION FOR * " + string_upper(global.ROLES[_who]) + " * DAY " + string(_g.day));
    var _title = "ALERT! HIVE TEMPERATURE OUT OF RANGE";
    var _txt = "The Economy chamber is losing control of the temperature. Without a thermal sensor it was not caught in time. How do you fix it?";
    if (_k == "comms") { _title = "SIGNAL LOST WITH NASA'S DEEP SPACE NETWORK"; _txt = "A solar storm cut the link. Science data cannot be sent to Earth. The high-gain antenna can try to realign."; }
    if (_k == "mech") { _title = "MINOR IMPACT DETECTED!"; _txt = "Something hit the ship. If the damage is not repaired, life support starts to fail stage after stage."; }
    ui_text(240, 142, _title, 3, C_GOLD);
    draw_sprite_ext(spr_fx_warning, floor(anim / 6) mod 6, 1300, 112, 4, 4, 0, c_white, 1);
    ui_text_wrap(240, 186, _txt, 1110, 2, C_TEXT);
    var _ops = g_options(), _n = array_length(_ops), _cw = floor((1120 - (_n - 1) * 20) / _n);
    for (var i = 0; i < _n; i++)
    {
        var _o = _ops[i], _cx = 240 + i * (_cw + 20);
        ui_card(_cx, 256, _cw, 420, false, false, _o.name);
        ui_text_wrap(_cx + 20, 276, _o.name, _cw - 40, 3, _o.ok ? C_GOLD : C_DIM);
        ui_text_wrap(_cx + 20, 390, _o.desc, _cw - 40, 2, C_TEXT);
        if (!_o.ok) ui_text(_cx + 20, 560, (_o.id == "repair" || _o.id == "fix") ? "Needs the repair toolkit." : "Not enough battery.", 2, C_RED);
        if (ui_button(_cx + 20, 604, _cw - 40, 48, "CHOOSE RESPONSE", _o.ok, true))
        {
            g_resolve(_o.id);
            overlay = "";
            toast("Decision written in the logbook.");
            if (_g.flight.pending != "") { overlay = "event"; sfx(snd_alert); }
        }
    }
}

if (overlay == "journal")
{
    // ---- mission logbook written like a scientific paper
    var _ink = make_colour_rgb(56, 32, 26), _red = make_colour_rgb(140, 50, 30), _soft = make_colour_rgb(110, 90, 70);
    ui_panel(230, 104, 1140, 676, make_colour_rgb(246, 236, 212), make_colour_rgb(176, 150, 110));
    var _f = _g.flight, _t = g_stats(), _r = g_route(), _flown = is_struct(_f);
    var _rep = _flown ? g_report() : undefined;
    var _parts = "";
    for (var i = 0; i < array_length(_g.parts); i++) _parts += ((i > 0) ? ", " : "") + item(_g.parts[i]).name;
    if (_parts == "") _parts = "(no equipment yet)";
    var _x0 = 270, _w = 1060, _y = 124;
    if (paper_page == 0)
    {
        _y += ui_text_wrap(_x0, _y, "Transport of dormant Bombus terrestris queens to Mars: a spacecraft design study", _w, 3, _ink) + 6;
        _y += ui_text_wrap(_x0, _y, "BeeYond Mars team (" + string(_g.players) + " player" + ((_g.players > 1) ? "s" : "") + ") * Aurelia Space Agency, Office of Pollinator Research (fictional) * Attempt " + string(_g.attempt) + " * Seed " + string(_g.seed), _w, 1, _soft) + 14;
        ui_text(_x0, _y, "ABSTRACT", 2, _red); _y += 24;
        var _abs = "We designed a spacecraft to carry dormant bumblebee queens to Mars on a fixed budget. Design in progress: " + _parts + ", " + fmt1(_t.kg) + " kg, " + string(_t.use) + "/" + string(_t.power) + " W, delta-v " + string_format(_t.dv, 1, 2) + " km/s.";
        if (_flown && _g.phase == "report") _abs = "We flew " + _parts + " (" + fmt1(_t.kg) + " kg) on " + _r.name + ", a NASA Trajectory Browser transfer of " + string(_r.days) + " days. Result: " + string_upper(_rep.kind) + ". Cargo status " + _rep.status + " (risk index " + string(round(_f.risk)) + "/100), " + string(round(_f.sent)) + " MB of science received, ship integrity " + string(round(_f.integrity)) + "%.";
        else if (_flown) _abs = "Mission in flight on " + _r.name + " (day " + string(_g.day) + " of " + string(g_days()) + "). Payload: " + _parts + ".";
        _y += ui_text_wrap(_x0, _y, _abs, _w, 2, _ink) + 8;
        ui_text(_x0, _y, "Keywords: diapause, life support, delta-v, NASA Trajectory Browser, Deep Space Network", 1, _soft); _y += 24;
        ui_text(_x0, _y, "1. INTRODUCTION", 2, _red); _y += 24;
        _y += ui_text_wrap(_x0, _y, "Our team wants to publish the first study on flying dormant bumblebee queens to Mars. Pollinators are key for food production. Future greenhouses on Mars may need them. Bumblebee queens survive winter in diapause for about 6-9 months (Alford 1969). Hypothesis: a chamber near 2.5 C and 70% humidity (Yoon et al. 2010) can keep them dormant during a 9-12 month transfer. This has never been tested in space (open question).", _w, 2, _ink) + 8;
    }
    if (paper_page == 1)
    {
        ui_text(_x0, _y, "2. METHODS", 2, _red); _y += 24;
        _y += ui_text_wrap(_x0, _y, "Spacecraft: " + _parts + ". Total mass " + fmt1(_t.kg) + " kg (limit 250 kg). Power use " + string(_t.use) + " W for " + string(_t.power) + " W generated. Delta-v = 7.0 - 0.008 x " + fmt1(_t.kg) + " = " + string_format(_t.dv, 1, 2) + " km/s.", _w, 2, _ink) + 6;
        _y += ui_text_wrap(_x0, _y, "Trajectory: " + _r.name + ", " + _r.depart + " to " + _r.arrive + " (" + string(_r.days) + " days), injection " + string(_r.inj) + " + post-injection " + string(_r.post) + " = " + string(_r.dv) + " km/s, from the NASA Ames Trajectory Browser. Solar power falls to 85% near Mars (simplified from ~43%, NASA Mars Fact Sheet).", _w, 2, _ink) + 10;
        ui_text(_x0, _y, "3. RESULTS", 2, _red); _y += 24;
        if (!_flown) ui_text_wrap(_x0, _y, "No data yet: results appear here, stage by stage, after launch.", _w, 2, _soft);
        else
        {
            var _cols = [0, 110, 260, 420, 560, 680, 800, 940];
            var _hd = ["DAY", "POWER W", "BATTERY Wh", "TEMP C", "RH %", "RISK", "DATA MB", "SHIP %"];
            for (var c = 0; c < 8; c++) ui_text(_x0 + _cols[c], _y, _hd[c], 1, _red);
            _y += 16; ui_rect(_x0, _y, _w, 2, _soft); _y += 6;
            var _st = _f.stages, _from = max(0, array_length(_st) - 12);
            for (var k = _from; k < array_length(_st); k++)
            {
                var _e = _st[k];
                var _v = [string(_e.day), string(_e.gen) + "/" + string(_e.use), string(_e.charge), fmt1(_e.temp), string(_e.hum), string(_e.risk), string(_e.sent), string(_e.integ)];
                for (var c = 0; c < 8; c++) ui_text(_x0 + _cols[c], _y, _v[c], 2, _ink);
                _y += 24;
            }
            ui_text(_x0, _y + 4, "Table 1. Measurements at the end of each 30-day stage.", 1, _soft);
        }
    }
    if (paper_page == 2)
    {
        ui_text(_x0, _y, "3.1 EVENTS AND DECISIONS", 2, _red); _y += 24;
        var _any = false;
        for (var i = 0; i < array_length(_g.log); i++)
        {
            var _e = _g.log[i];
            if (string_pos("Heat alarm", _e.text) == 1 || string_pos("Signal loss", _e.text) == 1 || string_pos("Minor impact", _e.text) == 1 || string_pos("Design milestone", _e.text) == 1 || string_pos("Launch", _e.text) == 1)
            {
                _any = true;
                if (_y < 470) _y += ui_text_wrap(_x0, _y, "Day " + string(_e.day) + ". " + _e.text, _w, 1, _ink) + 4;
            }
        }
        if (!_any) { ui_text(_x0, _y, "No events yet.", 2, _soft); _y += 24; }
        _y += 8;
        ui_text(_x0, _y, "4. DISCUSSION", 2, _red); _y += 24;
        var _disc = "Pending: the discussion is written when the mission ends.";
        if (_flown && _g.phase == "report")
        {
            _disc = "The design balanced energy, climate and communication.";
            if (_rep.reason == "climate") _disc = "Chamber climate was the main problem. Active control (Vanguard), a thermal sensor or a toolkit reduce the risk.";
            if (_rep.reason == "power") _disc = "Power was short for two stages in a row. Use fewer watts or add panels.";
            if (_rep.reason == "comms") _disc = "Contact with Earth was lost. A high-gain antenna or a backup link is essential.";
            if (_rep.reason == "systems") _disc = "Unrepaired damage grew every stage. A repair toolkit would have stopped it.";
            if (_rep.reason == "data") _disc = "We arrived but lost observations. Transmission and memory limited the science.";
            _disc += " This is a hypothetical educational model: it does not prove that queens survive a trip to Mars.";
        }
        _y += ui_text_wrap(_x0, _y, _disc, _w, 2, _ink) + 10;
        ui_text(_x0, _y, "REFERENCES", 2, _red); _y += 22;
        for (var i = 0; i < array_length(global.SOURCES); i++)
        {
            if (global.SOURCES[i].url == "" || _y > 700) continue;
            ui_text(_x0, _y, "[" + string(i + 1) + "] " + global.SOURCES[i].title, 1, _ink);
            _y += 14;
        }
    }
    if (paper_page >= 3)
    {
        if (!(_flown && _g.phase == "report"))
        {
            ui_text(_x0, _y, (paper_page == 3) ? "5. CONCLUSIONS" : "PEER REVIEW", 2, _red); _y += 28;
            ui_text_wrap(_x0, _y, "Not written yet. Fly the mission: the conclusions and the reviewers' feedback appear here when it ends.", _w, 2, _soft);
        }
        else
        {
            var _cc = g_conclusions();
            var _vc = (_cc.verdict == "ACCEPTED") ? make_colour_rgb(40, 120, 70) : ((_cc.verdict == "REJECTED") ? make_colour_rgb(200, 50, 40) : make_colour_rgb(190, 120, 30));
            // verdict stamp (both pages)
            ui_rect(1050, 124, 290, 96, _vc);
            ui_rect(1055, 129, 280, 86, make_colour_rgb(246, 236, 212));
            ui_text_c(1195, 140, _cc.verdict, (string_length(_cc.verdict) > 9) ? 3 : 4, _vc);
            ui_text_c(1195, 192, "Journal of Pollinator Spaceflight", 1, _vc);
            if (paper_page == 3)
            {
                ui_text(_x0, _y, "5. CONCLUSIONS", 3, _red); _y += 40;
                for (var i = 0; i < array_length(_cc.findings); i++) if (_y < 660) _y += ui_text_wrap(_x0, _y, "- " + _cc.findings[i], (_y < 230) ? 760 : _w, 2, _ink) + 10;
                ui_text(_x0, 690, "Next page: the reviewers' feedback for your team  >", 2, _red);
            }
            else
            {
                ui_text(_x0, _y, "PEER REVIEW", 3, _red); _y += 36;
                _y += ui_text_wrap(_x0, _y, _cc.vtext, 760, 2, _ink) + 16;
                ui_text(_x0, _y, "WHAT WORKED", 2, make_colour_rgb(40, 110, 70)); _y += 26;
                for (var i = 0; i < min(3, array_length(_cc.good)); i++) _y += ui_text_wrap(_x0 + 10, _y, "+ " + _cc.good[i], _w - 10, 2, _ink) + 6;
                _y += 10;
                ui_text(_x0, _y, "WHAT TO IMPROVE", 2, _red); _y += 26;
                for (var i = 0; i < min(3, array_length(_cc.fix)); i++) if (_y < 680) _y += ui_text_wrap(_x0 + 10, _y, "> " + _cc.fix[i], _w - 10, 2, _ink) + 6;
            }
        }
    }
    ui_text(260, 742, "PAGE " + string(paper_page + 1) + "/5", 2, _soft);
    if (ui_button(420, 724, 110, 48, "<", paper_page > 0, false)) paper_page -= 1;
    if (ui_button(545, 724, 110, 48, ">", paper_page < 4, false)) paper_page += 1;
}

if (overlay == "guide")
{
    var _pages = 1 + ceil(array_length(global.SOURCES) / 4);
    if (guide_page == 0)
    {
        ui_text(240, 120, "LITTLE MISSION GUIDE", 4, C_GOLD);
        for (var i = 0; i < array_length(global.GUIDE); i++)
        {
            var _cx = 240 + (i mod 2) * 565, _cy = 180 + floor(i / 2) * 150;
            ui_panel(_cx, _cy, 545, 136, C_CARD, C_EDGE);
            ui_text(_cx + 18, _cy + 16, global.GUIDE[i][0], 2, C_GOLD);
            ui_text_wrap(_cx + 18, _cy + 46, global.GUIDE[i][1], 510, 2, C_TEXT);
        }
        ui_text_wrap(240, 640, "Hypothetical educational model. The MVP ends on arrival; it does not simulate landing or pollination. Labels: VERIFIED = cited source, ADAPTED = inspiration, SINGLE STUDY / CONTEXT = use with care, TEAM = team choice, OPEN = unknown to science.", 780, 1, C_DIM);
    }
    else
    {
        ui_text(240, 120, "SOURCES AND LABELS", 4, C_GOLD);
        for (var k = 0; k < 4; k++)
        {
            var i = (guide_page - 1) * 4 + k;
            if (i >= array_length(global.SOURCES)) break;
            var _s = global.SOURCES[i], _cx = 240 + (k mod 2) * 565, _cy = 180 + floor(k / 2) * 230;
            ui_panel(_cx, _cy, 545, 216, C_CARD, C_EDGE);
            var _cwid = ui_chip(_cx + 16, _cy + 14, _s.kind, tag_colour(_s.kind));
            if (_s.nasa) ui_chip(_cx + 26 + _cwid, _cy + 14, "NASA", C_GOLD);
            var _hy = _cy + 50;
            _hy += ui_text_wrap(_cx + 16, _hy, _s.title, 510, 2, C_GOLD) + 6;
            _hy += ui_text_wrap(_cx + 16, _hy, _s.use, 510, 2, C_TEXT) + 4;
            if (_s.url != "") { var _host = string_delete(_s.url, 1, 8); _host = string_copy(_host, 1, string_pos("/", _host) - 1); ui_text(_cx + 16, _cy + 186, "Link: " + _host, 2, C_TEAL); }
        }
    }
    ui_text(240, 742, "PAGE " + string(guide_page + 1) + "/" + string(_pages), 2, C_DIM);
    if (ui_button(420, 724, 110, 48, "<", guide_page > 0, false)) guide_page -= 1;
    if (ui_button(545, 724, 110, 48, ">", guide_page < _pages - 1, false)) guide_page += 1;
}

if (overlay == "menu")
{
    ui_text(240, 120, "MISSION PAUSED", 4, C_GOLD);
    ui_text_wrap(240, 180, "Credits: concept, story and mechanics by the BeeYond Mars team. Bee sprites, scene art and some other sprites are AI-assisted and carry a visible AI mark. Code and the original chiptune music were made with AI assistance (OpenAI Codex, Claude) and reviewed by the team. No NASA logos; Aurelia is fictional.", 1110, 2, C_DIM);
    if (ui_button(240, 330, 360, 52, "LOGBOOK (PAPER)", true, false)) { overlay = "journal"; paper_page = 0; }
    if (ui_button(620, 330, 360, 52, global.music_on ? "MUSIC: ON" : "MUSIC: OFF", true, false)) global.music_on = !global.music_on;
    if (ui_button(620, 400, 360, 52, global.sfx_on ? "SOUND FX: ON" : "SOUND FX: OFF", true, false)) global.sfx_on = !global.sfx_on;
    ui_text_c(800, 486, "VOLUME " + string(round(global.volume * 100)) + "%", 2, C_TEXT);
    if (ui_button(620, 470, 80, 52, "-", global.volume > 0.05, false)) { global.volume = max(0, global.volume - 0.1); audio_master_gain(global.volume); }
    if (ui_button(900, 470, 80, 52, "+", global.volume < 0.95, false)) { global.volume = min(1, global.volume + 0.1); audio_master_gain(global.volume); }
    if (ui_button(240, 400, 360, 52, "GUIDE AND SOURCES", true, false)) { overlay = "guide"; guide_page = 0; }
    if (ui_button(240, 470, 360, 52, "FULL SCREEN (F11)", true, false)) window_set_fullscreen(!window_get_fullscreen());
    if (ui_button(240, 540, 360, 52, "BACK TO TITLE", true, false)) { overlay = ""; screen = "title"; }
}

// close button (drawn last so it stays on top of the paper)
if (overlay != "" && overlay != "event")
{
    if (ui_button(1060, 724, 300, 48, "BACK TO THE GAME", true, false) || keyboard_check_pressed(vk_escape)) overlay = "";
}

// ============================================================ TOAST
if (toast_time > 0)
{
    var _tw = string_length(toast_text) * 12 + 40;
    ui_rect(800 - _tw / 2 + 4, 70, _tw, 44, C_INK);
    ui_panel(800 - _tw / 2, 66, _tw, 44, C_GOLD, C_HONEY);
    ui_text_c(800, 79, toast_text, 2, C_INK);
}
