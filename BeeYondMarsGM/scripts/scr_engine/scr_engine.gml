/// scr_engine
/// Rules of the simulation (no drawing here). Random events use a seeded generator,
/// so the same seed and the same decisions always give the same mission.
/// The game state lives in global.G.

function arr_has(_a, _v)
{
    for (var i = 0; i < array_length(_a); i++) if (_a[i] == _v) return true;
    return false;
}
function arr_without(_a, _v)
{
    var _o = [];
    for (var i = 0; i < array_length(_a); i++) if (_a[i] != _v) array_push(_o, _a[i]);
    return _o;
}
function fmt1(_x) { return string_format(_x, 1, 1); }

/// Seeded generator (same results in GameMaker and in the test simulator).
function rng_next()
{
    global.G.rng = (global.G.rng * 9301 + 49297) mod 233280;
    return global.G.rng / 233280;
}

function game_fresh(_players, _seed)
{
    return {
        phase: "lab", players: clamp(_players, 1, 4), role: 1,
        parts: [], route: "standard", grants: [], compared: [],
        day: 0, log: [], flight: undefined, green: undefined, attempt: 1, seed: _seed, rng: _seed
    };
}

function g_route() { return route_by_id(global.G.route); }
function g_has(_id) { return arr_has(global.G.parts, _id); }
function g_has_chamber() { return g_has("chamberA") || g_has("chamberB"); }

/// Totals for the current design.
function g_stats()
{
    var _g = global.G, C = global.CFG;
    var _cost = 0, _kg = 0, _use = 0, _power = C.rocket_w;
    for (var i = 0; i < array_length(_g.parts); i++)
    {
        var _it = item(_g.parts[i]);
        _cost += _it.cost; _kg += _it.kg; _use += _it.w; _power += _it.gen;
    }
    if (is_struct(_g.flight)) _use += _g.flight.extra_w;
    var _bud = C.budget - _cost;
    for (var j = 0; j < array_length(_g.grants); j++) _bud += C.grants[_g.grants[j]];
    return { cost: _cost, kg: _kg, use: _use, power: _power, arrival: _power * C.solar_arrival,
             dv: C.rocket_dv - _kg * C.dv_per_kg, budget: _bud };
}

function g_log(_txt) { array_push(global.G.log, { day: global.G.day, text: _txt }); }

/// Everything that blocks the launch.
function g_errors()
{
    var _t = g_stats(), _r = g_route(), _e = [];
    if (!g_has_chamber()) array_push(_e, "Install a biological chamber.");
    if (_t.kg > global.CFG.rocket_cap) array_push(_e, "Mass " + fmt1(_t.kg) + " kg exceeds the 250 kg rocket.");
    if (_t.use > _t.power) array_push(_e, "Use " + string(_t.use) + " W is over " + string(_t.power) + " W: install extra solar panels.");
    else if (_t.use > _t.arrival) array_push(_e, "Near Mars the panels make only " + string(round(_t.arrival)) + " W (orbit multiplier 0.85) and you use " + string(_t.use) + " W: add panels or remove instruments.");
    if (_t.dv < _r.dv) array_push(_e, "Delta-v " + string_format(_t.dv, 1, 2) + " km/s is below the " + string(_r.dv) + " km/s this route needs.");
    if (_t.budget < 0) array_push(_e, "Design exceeds available funding.");
    return _e;
}

/// Hints for the player (most useful first). NASA data is named where it applies.
function g_hints()
{
    var _t = g_stats(), _r = g_route(), _h = [];
    if (!g_has_chamber()) array_push(_h, "Start in Biology: the queens need a chamber. Economy is cheap but heavy; Vanguard holds the temperature.");
    if (_t.use > _t.power) array_push(_h, "Your systems use " + string(_t.use) + " W but the rocket gives 600 W. Engineering can add extra solar panels (+400 W).");
    if (_t.kg > global.CFG.rocket_cap) array_push(_h, "Too heavy: " + fmt1(_t.kg) + " of 250 kg. The antenna (60 kg) and panels (70 kg) are the heaviest extras.");
    if (_t.use <= _t.power && _t.arrival < _t.use) array_push(_h, "Near Mars, panels make less (NASA: Mars gets ~43% of Earth's sunlight; 85% in this game). You will make " + string(round(_t.arrival)) + " W but use " + string(_t.use) + " W: add panels or remove instruments.");
    if (_t.dv < _r.dv) array_push(_h, "NASA Trajectory Browser: " + _r.name + " needs " + string(_r.dv) + " km/s. Each kg costs 0.008 km/s; you have " + string_format(_t.dv, 1, 2) + ".");
    if (g_has_chamber() && !g_has("antenna") && !g_has("backup")) array_push(_h, "No antenna and no backup comms: if the signal is lost, the mission cannot talk to Earth and fails.");
    if (g_has("chamberA") && !g_has("thermal") && !g_has("toolkit")) array_push(_h, "The Economy chamber will raise heat alarms. A thermal sensor or a repair toolkit can save the queens.");
    if (g_has_chamber() && !g_has("toolkit")) array_push(_h, "Without a repair toolkit, a mechanical failure keeps damaging the ship.");
    if (_r.id == "venus") array_push(_h, "Route 3 needs 6.82 km/s: at 0.008 km/s per kg the whole ship must weigh 22 kg or less.");
    if (array_length(_h) == 0) array_push(_h, "Design looks solid. Compare routes at Mission Lead: the NASA data shows dates and delta-v.");
    return _h;
}

/// CML-inspired design level 1..4
function g_milestone()
{
    var _g = global.G;
    if (array_length(g_errors()) == 0 && array_length(_g.grants) == 2) return 4;
    if (arr_has(_g.grants, 1)) return 3;
    if (arr_has(_g.grants, 0)) return 2;
    return 1;
}

function g_claim(_i)
{
    var _g = global.G;
    if (_g.phase != "lab" || arr_has(_g.grants, _i)) return false;
    var _t = g_stats(), _ok;
    if (_i == 0) _ok = g_has_chamber() && _t.use <= _t.power && _t.kg <= global.CFG.rocket_cap;
    else _ok = arr_has(_g.grants, 0) && array_length(_g.compared) >= 2;
    if (!_ok) return false;
    array_push(_g.grants, _i);
    g_log("Design milestone CML " + string(_i + 2) + " approved: +" + string(global.CFG.grants[_i]) + " credits.");
    return true;
}

/// Install or remove a part. Returns "" when done, or the reason it was refused.
function g_toggle(_id)
{
    var _g = global.G, _p = item(_id);
    if (_g.phase != "lab") return "Not in the lab.";
    if (_g.players > 1 && _p.role != _g.role) return "Only " + global.ROLES[_p.role] + " can install this.";
    var _old = _g.parts;
    if (arr_has(_g.parts, _id)) _g.parts = arr_without(_g.parts, _id);
    else
    {
        var _n = [];
        for (var i = 0; i < array_length(_g.parts); i++)
            if (!(_p.kind == "chamber" && item(_g.parts[i]).kind == "chamber")) array_push(_n, _g.parts[i]);
        array_push(_n, _id);
        _g.parts = _n;
    }
    if (g_stats().budget < 0) { _g.parts = _old; return "Not enough funds. Remove equipment or pass a design review."; }
    return "";
}

function g_select_route(_id)
{
    var _g = global.G;
    _g.route = _id;
    if (!arr_has(_g.compared, _id)) array_push(_g.compared, _id);
}

/// Total trip length including delays.
function g_days() { return g_route().days + (is_struct(global.G.flight) ? global.G.flight.delay_days : 0); }

function g_launch()
{
    var _g = global.G, _r = g_route();
    if (array_length(g_errors()) > 0 || g_milestone() < 4) return false;
    _g.phase = "voyage"; _g.day = 0; _g.rng = _g.seed;
    // event schedule (seeded)
    var _ev = [];
    if (g_has("chamberA")) { array_push(_ev, { kind: "thermal", day: round(_r.days * 0.35) }); array_push(_ev, { kind: "thermal", day: round(_r.days * 0.7) }); }
    else array_push(_ev, { kind: "thermal", day: round(_r.days * 0.5) });
    array_push(_ev, { kind: "comms", day: round(_r.days * (0.45 + rng_next() * 0.2)) });
    array_push(_ev, { kind: "mech", day: round(_r.days * (0.2 + rng_next() * 0.6)) });
    _g.flight = { charge: global.CFG.battery_wh, temp: global.CFG.base_temp, humidity: global.CFG.base_humidity,
        risk: 0, stored: 0, sent: 0, lost: 0, generated: 0, energy: 0, outages: 0, pending: "", events: _ev, done: [],
        integrity: 100, damage_rate: 0, repairs: (g_has("toolkit") ? 2 : 0), extra_w: 0, delay_days: 0,
        low_telemetry: false, comms_lost: false, last_gen: g_stats().power, heat: 0, pending_i: -1, stages: [], choices: [], min_charge: global.CFG.battery_wh };
    g_log("Launch on " + _r.name + " (" + _r.depart + "). Payload " + fmt1(g_stats().kg) + " kg, delta-v " + string_format(g_stats().dv, 1, 2) + " km/s. Seed " + string(_g.seed) + ".");
    return true;
}

/// One-way signal delay in minutes (4 to 24).
function g_delay() { return 4 + 20 * min(1, global.G.day / g_route().days); }

/// Check the schedule: auto-resolve what the equipment handles, otherwise set a pending decision.
function g_check_events()
{
    var _g = global.G, _f = _g.flight;
    for (var i = 0; i < array_length(_f.events); i++)
    {
        var _e = _f.events[i];
        if (arr_has(_f.done, i) || _e.day > _g.day) continue;
        if (_e.kind == "thermal")
        {
            if (g_has("chamberB")) { array_push(_f.choices, "thermal:vanguard"); array_push(_f.done, i); _f.risk = clamp(_f.risk + 1, 0, 100); g_log("Heat alarm: the Vanguard chamber corrected it within minutes."); continue; }
            if (g_has("thermal")) { array_push(_f.choices, "thermal:sensor"); array_push(_f.done, i); _f.extra_w += 10; _f.risk = clamp(_f.risk + 3, 0, 100); g_log("Heat alarm caught in time by the redundant sensor. It self-regulates (+10 W)."); continue; }
        }
        if (_e.kind == "comms")
        {
            if (g_has("backup")) { array_push(_f.choices, "comms:backup"); array_push(_f.done, i); var _pen = _f.sent * 0.1; _f.sent -= _pen; _f.lost += _pen; g_log("Signal loss with the Deep Space Network: backup link took over. Minor data penalty (-" + string(round(_pen)) + " MB)."); continue; }
            if (!g_has("antenna")) { array_push(_f.choices, "comms:none"); array_push(_f.done, i); _f.comms_lost = true; g_log("Signal loss with the Deep Space Network. No antenna or backup: telemetry froze and contact was lost for good."); _g.phase = "report"; return; }
        }
        _f.pending = _e.kind; _f.pending_i = i;
        return;
    }
    if (_g.day >= g_days()) _g.phase = "report";
}

/// Advance one stage (up to 30 days).
function g_advance()
{
    var _g = global.G, _f = _g.flight, _t = g_stats(), C = global.CFG;
    if (_g.phase != "voyage" || _f.pending != "") return;
    var _total = g_days();
    var _days = min(C.stage_days, _total - _g.day);
    _g.day += _days;
    var _ratio = min(1, _g.day / g_route().days);
    var _sun = 1 - (1 - C.solar_arrival) * _ratio;
    if (_g.route == "venus") _sun *= 1 + 0.3 * sin(min(1, _ratio * 2) * pi);
    var _gen = _t.power * _sun, _hours = _days * 24;
    _f.last_gen = _gen;
    _f.energy += _t.use * _hours;
    var _raw = _f.charge + (_gen - _t.use) * _hours;
    _f.charge = clamp(_raw, 0, C.battery_wh);
    _f.min_charge = min(_f.min_charge, _f.charge);
    var _out = _raw < 0;
    _f.outages = _out ? _f.outages + 1 : 0;

    var _vg = g_has("chamberB"), _sensor = g_has("thermal");
    var _drift = _vg ? 0.05 : (_sensor ? 0.16 : 0.4);
    _f.temp = C.base_temp + (_f.temp - C.base_temp) * (_vg ? 0.18 : 0.65) + _drift + (_out ? 5 : 0) + _f.heat;
    _f.humidity = clamp(C.base_humidity + (_f.humidity - C.base_humidity) * 0.65 - _drift * 2 - (_out ? 10 : 0) - _f.heat * 2, 0, 100);
    var _exp = max(0, _f.temp - 4) * 5 + max(0, 60 - _f.humidity) * 0.5 + (_vg ? 0 : 1.5);
    _f.risk = clamp(_f.risk + _exp * _days / 30, 0, 100);
    _f.integrity = clamp(_f.integrity - (_out ? 30 : 0) - _f.damage_rate, 0, 100);

    var _prod = (g_has("dosimeter") ? 32 : 24) * (_f.low_telemetry ? 0.5 : 1) * _days / 30;
    _f.generated += _prod;
    var _avail = _f.stored + _prod;
    var _link = g_has("antenna") ? 64 : (g_has("backup") ? 16 : 0);
    var _sent = _out ? 0 : min(_avail, _link * _days / 30);
    _f.sent += _sent;
    _f.lost += max(0, _avail - _sent - C.storage_mb);
    _f.stored = min(C.storage_mb, _avail - _sent);

    array_push(_f.stages, { day: _g.day, gen: round(_gen), use: _t.use, charge: round(_f.charge), temp: _f.temp, hum: round(_f.humidity), risk: round(_f.risk), sent: round(_f.sent), integ: round(_f.integrity) });
    g_log(string(_days) + " days: " + string(round(_gen)) + " W made, " + string(_t.use) + " W used; battery " + string(round(_f.charge)) + " Wh; chamber " + fmt1(_f.temp) + " C, " + string(round(_f.humidity)) + "% RH; risk " + string(round(_f.risk)) + "; +" + string(round(_sent)) + " MB received.");

    if (_f.outages >= 2 || _f.risk >= C.critical_risk || _f.integrity <= 0) { _g.phase = "report"; return; }
    g_check_events();
}

/// Options for the pending incident: id, name, desc, ok
function g_options()
{
    var _f = global.G.flight;
    if (!is_struct(_f)) return [];
    if (_f.pending == "thermal")
        return [
            { id: "repair", name: "Repair with the toolkit", desc: "Use one repair action (" + string(_f.repairs) + " left). The chamber is back in range.", ok: _f.repairs > 0 },
            { id: "battery", name: "Emergency cooling", desc: "Spend 600 Wh of battery on a cooling pulse. Some stress remains (+12 risk).", ok: _f.charge >= 600 },
            { id: "wait", name: "Ride it out", desc: "Do nothing. The hive overheats: +6 C and +35 risk.", ok: true }
        ];
    if (_f.pending == "comms")
    {
        var _wd = g_has("dosimeter") ? 6 : 12;
        return [
            { id: "realign", name: "Wait for the antenna to realign", desc: "Keep all data, but the trip takes " + string(_wd) + " more days (more energy and exposure)." + (g_has("dosimeter") ? " The dosimeter warned early." : ""), ok: true },
            { id: "essentials", name: "Send essentials only", desc: "No delay. Stored data (" + string(round(_f.stored)) + " MB) is lost and future science is halved.", ok: true }
        ];
    }
    if (_f.pending == "mech")
        return [
            { id: "fix", name: "Repair (logbook action)", desc: "Use the toolkit (" + string(_f.repairs) + " actions left). The trip continues normally.", ok: _f.repairs > 0 },
            { id: "power", name: "Divert power to life support", desc: "Spend 500 Wh to keep systems up. The ship loses 20% integrity.", ok: _f.charge >= 500 },
            { id: "continue", name: "Keep going", desc: "Ignore it. Damage grows every stage (-10% integrity each 30 days).", ok: true }
        ];
    return [];
}

function g_resolve(_id)
{
    var _g = global.G, _f = _g.flight, _ops = g_options(), _o = undefined;
    for (var i = 0; i < array_length(_ops); i++) if (_ops[i].id == _id) _o = _ops[i];
    if (_o == undefined || !_o.ok) return false;
    var _k = _f.pending;
    array_push(_f.choices, _k + ":" + _id);
    if (_k == "thermal")
    {
        if (_id == "repair") { _f.repairs -= 1; _f.risk = clamp(_f.risk + 3, 0, 100); }
        if (_id == "battery") { _f.charge -= 600; _f.energy += 600; _f.risk = clamp(_f.risk + 12, 0, 100); }
        if (_id == "wait") { _f.temp += 6; _f.humidity -= 12; _f.risk = clamp(_f.risk + 35, 0, 100); _f.heat = 1; }
    }
    if (_k == "comms")
    {
        if (_id == "realign") _f.delay_days += g_has("dosimeter") ? 6 : 12;
        else { _f.lost += _f.stored; _f.stored = 0; _f.low_telemetry = true; }
    }
    if (_k == "mech")
    {
        if (_id == "fix") _f.repairs -= 1;
        if (_id == "power") { _f.charge -= 500; _f.integrity = clamp(_f.integrity - 20, 0, 100); }
        if (_id == "continue") { _f.integrity = clamp(_f.integrity - 15, 0, 100); _f.damage_rate = 10; }
    }
    var _names = { thermal: "Heat alarm", comms: "Signal loss", mech: "Minor impact" };
    g_log(variable_struct_get(_names, _k) + ": " + _o.name + ". " + _o.desc);
    array_push(_f.done, _f.pending_i);
    _f.pending = "";
    if (_f.risk >= global.CFG.critical_risk || _f.integrity <= 0) { _g.phase = "report"; return true; }
    g_check_events();
    return true;
}

/// Final report.
function g_report()
{
    var _g = global.G, _f = _g.flight, C = global.CFG;
    var _arr = _g.day >= g_days() && _f.outages < 2 && _f.integrity > 0 && !_f.comms_lost;
    var _kind = (!_arr || _f.risk >= C.critical_risk) ? "failure" : ((_f.risk > 35 || _f.sent < 100 || _f.lost > 64 || _f.integrity < 50) ? "partial" : "success");
    var _reason = "balanced";
    if (_f.comms_lost) _reason = "comms";
    else if (_f.integrity <= 0) _reason = "systems";
    else if (_f.outages >= 2) _reason = "power";
    else if (_f.risk > 35) _reason = "climate";
    else if (_f.sent < 100 || _f.lost > 64) _reason = "data";
    else if (_f.integrity < 50) _reason = "systems";
    var _sci = g_has("dosimeter") ? ((_g.route == "venus") ? 100 : 50) : 0;
    var _score = max(0, round((_arr ? 100 : 0) + (100 - _f.risk) + _f.sent / 4 - _f.lost / 4 + (_arr ? _sci : 0)));
    var _status = _f.risk >= C.critical_risk ? "COMPROMISED" : (_f.risk > 35 ? "AT RISK" : "GOOD");
    return { kind: _kind, arrived: _arr, reason: _reason, score: _score, status: _status, science: _sci };
}

function g_redesign()
{
    var _g = global.G;
    _g.phase = "lab"; _g.day = 0; _g.flight = undefined; _g.green = undefined; _g.attempt += 1; _g.log = [];
    _g.seed = (_g.seed * 7 + 13) mod 9973;
    g_log("New design attempt. Equipment and earned grants kept.");
}

/// Lab furniture collisions (640x352 lab canvas coordinates).
function lab_blocked(_x, _y)
{
    return (_x > 48 && _x < 208 && _y > 208 && _y < 280) || (_x > 416 && _x < 592 && _y > 208 && _y < 280) || (_x > 300 && _x < 344 && _y > 244 && _y < 284);
}


/// Paper conclusions and peer review: different for every mission, built from what the team did.
function g_conclusions()
{
    var _g = global.G, _f = _g.flight, _t = g_stats(), _r = g_route(), _rep = g_report();
    var _find = [], _good = [], _fix = [];
    var _ch = arr_has(_f.choices, "thermal:repair") || arr_has(_f.choices, "thermal:battery") || arr_has(_f.choices, "thermal:wait");

    // 1. the biological cargo
    if (_rep.status == "GOOD") array_push(_find, "The chamber kept the queens in good condition (risk index " + string(round(_f.risk)) + "/100, final " + fmt1(_f.temp) + " C and " + string(round(_f.humidity)) + "% RH, close to the 2.5 C / 70% target).");
    else if (_rep.status == "AT RISK") array_push(_find, "The queens reached a risky state (risk index " + string(round(_f.risk)) + "/100). The chamber drifted away from 2.5 C / 70% RH.");
    else array_push(_find, "The biological cargo was compromised (risk index " + string(round(_f.risk)) + "/100). The hypothesis could not be tested.");
    if (g_has("chamberB")) array_push(_good, "Choosing the Vanguard chamber removed the heat alarms: active control paid off.");
    else if (arr_has(_f.choices, "thermal:sensor")) array_push(_good, "The redundant thermal sensor caught the heat alarms in time.");
    if (arr_has(_f.choices, "thermal:wait")) array_push(_fix, "Riding out a heat alarm cost +35 risk. A thermal sensor (150 cr, 0.3 kg) or a toolkit would have prevented it.");
    else if (arr_has(_f.choices, "thermal:repair")) array_push(_good, "The toolkit fixed the heat alarm on board, without waiting for Earth.");
    else if (arr_has(_f.choices, "thermal:battery")) array_push(_fix, "Emergency cooling used 600 Wh of battery. A sensor would have cost only 10 W.");

    // 2. trajectory and mass (NASA data)
    var _margin = _t.dv - _r.dv;
    array_push(_find, "On " + _r.name + " (NASA Ames Trajectory Browser) the ship had " + string_format(_t.dv, 1, 2) + " km/s for " + string(_r.dv) + " km/s needed: a margin of " + string_format(_margin, 1, 2) + " km/s with " + fmt1(_t.kg) + " kg.");
    if (_margin < 0.3) array_push(_fix, "The delta-v margin was thin. Every kg costs 0.008 km/s: drop heavy extras to gain safety.");
    else if (_t.kg < 180) array_push(_good, "A light ship (" + fmt1(_t.kg) + " kg) left a comfortable delta-v margin.");

    // 3. energy
    if (_f.outages > 0) array_push(_find, "Power ran out during the trip: near Mars the panels made about " + string(round(_t.arrival)) + " W for " + string(_t.use) + " W of use (NASA: Mars gets ~43% of Earth's sunlight).");
    else array_push(_find, "Energy stayed positive. The lowest battery level was " + string(round(_f.min_charge)) + " Wh of " + string(global.CFG.battery_wh) + ".");
    if (_t.arrival < _t.use) array_push(_fix, "Plan power for the arrival, not the launch: panels make less near Mars.");
    else if (_f.outages == 0) array_push(_good, "Power was planned for the whole trip, including the weaker sunlight near Mars.");

    // 4. communications and science
    if (_f.comms_lost) array_push(_find, "Contact with NASA's Deep Space Network was lost for good: the experiment has no data to report.");
    else array_push(_find, string(round(_f.sent)) + " MB of science reached Earth and " + string(round(_f.lost)) + " MB were lost.");
    if (arr_has(_f.choices, "comms:backup")) array_push(_good, "The backup comms system saved the link during the solar storm.");
    if (arr_has(_f.choices, "comms:none")) array_push(_fix, "Without an antenna or a backup link, one signal loss ends the mission. Communications are not optional.");
    if (arr_has(_f.choices, "comms:realign")) array_push(_good, "Waiting for the antenna to realign protected all the data.");
    if (arr_has(_f.choices, "comms:essentials")) array_push(_fix, "Sending only essentials lost the stored observations and halved later science.");
    if (g_has("dosimeter") && _rep.arrived) array_push(_good, "The dosimeter added radiation measurements (+" + string(_rep.science) + " science).");
    else if (!g_has("dosimeter")) array_push(_fix, "A dosimeter (50 cr, 0.3 kg) would add radiation data and warn of solar storms.");

    // 5. mechanical failure
    if (arr_has(_f.choices, "mech:fix")) array_push(_good, "The repair toolkit fixed the impact damage with one logbook action.");
    if (arr_has(_f.choices, "mech:continue")) array_push(_fix, "Ignoring the impact let damage grow every stage (ship integrity " + string(round(_f.integrity)) + "%).");
    if (arr_has(_f.choices, "mech:power")) array_push(_fix, "Diverting power kept life support up but cost 20% integrity. A toolkit (150 cr) avoids it.");

    // follow-up experiment in the greenhouse (hypothetical extension)
    if (is_struct(_g.green) && _g.green.done)
    {
        var _gg = g_green_result();
        array_push(_find, "Follow-up in the sealed Mars greenhouse (hypothetical): " + string_lower(_gg.title) + ", colony index " + string(_gg.colony) + "/100, +" + string(_gg.science) + " science" + (_gg.pollinated ? ", tomato flowers pollinated." : "."));
        if (_gg.pollinated) array_push(_good, "The greenhouse experiment reached pollination: the goal of the whole mission.");
        else if (_gg.colony < 60) array_push(_fix, "In the greenhouse, spend energy cells on the wake-up and the climate first: the colony comes before the data.");
    }

    // budget
    if (_t.budget >= 200) array_push(_good, "The team kept " + string(_t.budget) + " credits in reserve.");

    var _verdict = "ACCEPTED", _vtext = "The reviewers recommend publication. The mission reached Mars with the cargo in good condition and useful data.";
    if (_rep.kind == "partial") { _verdict = "MAJOR REVISIONS"; _vtext = "The mission arrived, but the results are incomplete. Revise the design and fly again before publication."; }
    if (_rep.kind == "failure") { _verdict = "REJECTED"; _vtext = "The experiment could not be completed. Use the comments below, redesign and resubmit."; }
    if (array_length(_good) == 0) array_push(_good, "The team completed a full design cycle and documented every decision.");
    if (array_length(_fix) == 0) array_push(_fix, "Try another NASA route or a lighter design and compare the results.");
    return { verdict: _verdict, vtext: _vtext, findings: _find, good: _good, fix: _fix };
}


// ================================================================ NEXT PHASE: MARS GREENHOUSE
// Hypothetical extension (not part of the transit MVP). A sealed greenhouse: nothing is released on Mars.
// The team has a few energy cells; each careful option uses one. Deterministic.

function g_green_can()
{
    var _g = global.G;
    if (!is_struct(_g.flight) || _g.phase != "report") return false;
    var _rep = g_report();
    return _rep.arrived && _rep.status != "COMPROMISED";
}

function g_green_start()
{
    var _g = global.G, _f = _g.flight;
    _g.green = { step: 0, cells: 2 + ((_f.charge >= 800) ? 1 : 0) + ((_f.integrity >= 80) ? 1 : 0),
                 colony: clamp(100 - _f.risk, 0, 100), start: clamp(100 - _f.risk, 0, 100),
                 lights: false, science: 0, picks: [], done: false };
    g_log("Greenhouse phase started (hypothetical extension). Queen condition " + string(round(_g.green.colony)) + "/100, " + string(_g.green.cells) + " energy cells.");
}

function g_green_steps()
{
    return [
        { role: 1, title: "WAKE THE QUEENS", text: "The queens have been dormant for the whole trip. Diapause must end gently.",
          a_name: "Warm up slowly (7 days)", a_desc: "Uses 1 energy cell. Gentle wake-up: colony +15.",
          b_name: "Warm up fast (1 day)", b_desc: "Free. A sudden change stresses the queens: colony -15.",
          fact: "On Earth, queens leave diapause when spring slowly warms the soil." },
        { role: 0, title: "GREENHOUSE CLIMATE", text: "Mars nights are far below freezing. The sealed greenhouse needs heating to stay near 22-25 C.",
          a_name: "Hold a steady climate", a_desc: "Uses 1 energy cell. Stable nest: colony +15.",
          b_name: "Let it swing at night", b_desc: "Free. Cold nights slow the brood: colony -20.",
          fact: "Planetary protection: the greenhouse is closed. No insect is ever released on Mars." },
        { role: 3, title: "TOMATO FLOWERS", text: "A colony needs flowers for pollen and nectar. With ~43% of Earth's sunlight, plants need help.",
          a_name: "Turn on grow lights", a_desc: "Uses 1 energy cell. Many flowers: food for the colony (+10) and a pollination test.",
          b_name: "Natural light only", b_desc: "Free. Few flowers: colony -10 and no pollination test.",
          fact: "Bumblebees shake tomato flowers to release pollen: this is called buzz pollination." },
        { role: 2, title: "REPORT TO EARTH", text: "The results travel through NASA's Deep Space Network, with a delay of up to 24 minutes.",
          a_name: "Send the full dataset", a_desc: "Uses 1 energy cell. +50 science for the paper.",
          b_name: "Send a short summary", b_desc: "Free. +10 science.",
          fact: "A result only counts in science when others can check the data." }
    ];
}

/// _careful = true for option A (needs one cell). Returns false if it cannot be chosen.
function g_green_choose(_careful)
{
    var _gr = global.G.green, _st = g_green_steps();
    if (_gr.done) return false;
    if (_careful && _gr.cells <= 0) return false;
    if (_careful) _gr.cells -= 1;
    switch (_gr.step)
    {
        case 0: _gr.colony += _careful ? 15 : -15; break;
        case 1: _gr.colony += _careful ? 15 : -20; break;
        case 2: _gr.colony += _careful ? 10 : -10; _gr.lights = _careful; break;
        case 3: _gr.science += _careful ? 50 : 10; break;
    }
    _gr.colony = clamp(_gr.colony, 0, 100);
    array_push(_gr.picks, _careful);
    g_log("Greenhouse - " + _st[_gr.step].title + ": " + (_careful ? _st[_gr.step].a_name : _st[_gr.step].b_name) + ".");
    _gr.step += 1;
    if (_gr.step >= 4) { _gr.done = true; g_log("Greenhouse result: " + g_green_result().title + "."); }
    return true;
}

function g_green_result()
{
    var _gr = global.G.green;
    var _title = "QUEENS DID NOT RECOVER", _text = "In this model the queens did not recover from diapause. A calmer trip (lower risk) and a gentle wake-up give them a better start.";
    var _poll = false;
    var _c = round(_gr.colony);
    if (_c >= 60)
    {
        _title = "COLONY FOUNDED (IN THE MODEL)";
        _text = "The queens woke up, built a nest and raised the first workers inside the sealed greenhouse.";
        if (_gr.lights) { _poll = true; _text += " The workers buzz-pollinated the tomato flowers: the first fruit is growing."; }
        else _text += " With few flowers there was no pollination test: grow lights would allow it.";
    }
    else if (_c >= 35)
    {
        _title = "QUEENS AWAKE, NO COLONY YET";
        _text = "The queens woke up but were too weak to start a colony. A steadier climate and more flowers would help.";
    }
    return { title: _title, text: _text, pollinated: _poll, colony: round(_gr.colony), science: _gr.science };
}
