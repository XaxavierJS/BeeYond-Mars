/// obj_game - Create
/// BeeYond Mars · Mission Aurelia (GameMaker v8)
/// Screens: title -> letter (funding) -> lab (walkable, 4 stations) -> liftoff -> voyage (30-day stages) -> report.
/// Rules are in scr_engine, numbers and sources in scr_data. Everything is drawn in the Draw event.

ui_init_font();
data_init();
gpu_set_texfilter(false);
randomize();   // a different mission seed each time the game is opened

// Fit the window to small screens (the game is designed at 1600x900).
if (os_browser == browser_not_a_browser)
{
    var _dw = display_get_width(), _dh = display_get_height();
    if (_dw < 1700 || _dh < 1000)
    {
        var _fit = min(_dw * 0.92 / 1600, _dh * 0.84 / 900);
        window_set_size(round(1600 * _fit), round(900 * _fit));
        alarm[0] = 1;
    }
}

screen = "title";       // title, letter, lab, liftoff, voyage, report
overlay = "";           // "", station, event, journal, guide, menu
station = 0;
guide_page = 0;
paper_page = 0;
players_pick = 1;
letter_t = 0;
global.G = undefined;

anim = 0;
toast_text = "";
toast_time = 0;
liftoff_t = 0;
report_sfx = false;

// audio (original chiptune made for this project)
global.music_on = true;
global.sfx_on = true;
music_cur = -1;
global.volume = 0.5;          // master volume (0 to 1), changed in MENU
audio_master_gain(global.volume);

// lab walking (coordinates in the 640x352 lab canvas of the v6 version)
LAB_X = 112; LAB_Y = 64; LAB_K = 1375 / 640;
pos_x = 310; pos_y = 180; dir = 0; walk_frame = 0;
stations = [
    { x: 130, y: 294, role: 0, label: "WORKSHOP" },
    { x: 145, y: 145, role: 1, label: "BIOLOGY" },
    { x: 512, y: 145, role: 2, label: "COMMS" },
    { x: 510, y: 293, role: 3, label: "LEAD" }
];

/// Short message above the dock for about 3 seconds.
toast = function(_s) { toast_text = _s; toast_time = 180; };

/// Sound effect helper.
sfx = function(_snd) { if (global.sfx_on) audio_play_sound(_snd, 2, false); };

/// Background music: the right loop for the current screen.
music_update = function()
{
    var _want = (screen == "voyage" || screen == "liftoff") ? snd_voyage : snd_music;
    if (!global.music_on) _want = -1;
    if (_want != music_cur)
    {
        if (music_cur != -1) audio_stop_sound(music_cur);
        music_cur = _want;
        if (_want != -1) audio_play_sound(_want, 1, true);
    }
};

/// Next step shown in the lab.
objective = function()
{
    var _g = global.G;
    if (!g_has_chamber()) return ["Meet your tiny passengers", "Open Biology and choose a chamber to protect them."];
    if (!arr_has(_g.grants, 0)) return ["Check your first design", "At Mission Lead, review chamber, power and mass: +150 credits."];
    if (!arr_has(_g.grants, 1)) return ["Compare paths to Mars", "At Mission Lead, examine two NASA routes: +200 credits."];
    if (array_length(g_errors()) > 0) return ["Adjust your spacecraft", "Mission Lead lists what is missing before launch."];
    return ["All set for a big adventure", "Improve your instruments or launch from Mission Lead."];
};

open_station = function(_r)
{
    global.G.role = _r;
    station = _r;
    overlay = "station";
};

start_mission = function()
{
    global.G = game_fresh(players_pick, irandom_range(1000, 9972));
    g_log("Funding letter received: " + string(global.CFG.budget) + " credits from Aurelia. Mission accepted.");
    screen = "lab";
    overlay = "";
    pos_x = 310; pos_y = 180;
    sfx(snd_coin);
};

LETTER = "Dear team,\n\nWe are happy to tell you that your research proposal \"BeeYond Mars: dormant bumblebee queens for future Martian greenhouses\" has been FUNDED.\n\nYou receive " + string(global.CFG.budget) + " credits to design the spacecraft. Passing the design reviews (CML 2 and 3) unlocks 350 more.\n\nYour mission: fly fertilized, dormant Bombus terrestris queens to Mars and keep them in good condition until arrival. Use the real NASA trajectory data and record everything in your mission logbook. When you arrive, your results become a scientific paper: the reviewers will decide if it gets published.\n\nGood luck!\nDr. Pollen, Director";
