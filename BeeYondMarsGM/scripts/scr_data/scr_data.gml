/// scr_data
/// Every number of the game lives here, with its label (see SOURCES).
/// Equipment, events and routes follow the team's "Listado de decisiones" (updated inventory table).
/// Cost categories: Low = 50, Medium = 150, High = 300, Very high = 400 credits.

function data_init()
{
    global.CFG = {
        budget: 900,            // TEAM: starting grant from the fictional Aurelia
        grants: [150, 200],     // CML-inspired milestone grants (fictional)
        rocket_cap: 250,        // TEAM: Medium Lift rocket, 250 kg
        rocket_dv: 7.0,         // TEAM: 7.0 km/s
        rocket_w: 600,          // TEAM: 600 W base generation
        dv_per_kg: 0.008,       // TEAM: delta-v penalty per kg (90 kg -> -0.72 km/s)
        battery_wh: 1600,       // SIMPLIFIED
        storage_mb: 128,        // SIMPLIFIED
        solar_arrival: 0.85,    // SIMPLIFIED (real ~0.43, NASA Mars Fact Sheet)
        stage_days: 30,
        base_temp: 2.5,         // SINGLE STUDY: Yoon et al. 2010
        base_humidity: 70,      // SINGLE STUDY: Yoon et al. 2010
        critical_risk: 80
    };

    // role: 0 Engineering, 1 Biology, 2 Communications, 3 Mission Lead. icon = frame in spr_equip
    global.ITEMS = [
        { id: "chamberA", name: "Chamber A - Economy", role: 1, cost: 150, kg: 135, w: 200, gen: 0, kind: "chamber", icon: 1,
          desc: "Fits the 600 W base. Heavy, and its temperature is harder to hold: expect at least two heat alarms." },
        { id: "chamberB", name: "Chamber B - Vanguard", role: 1, cost: 300, kg: 90, w: 500, gen: 0, kind: "chamber", icon: 0,
          desc: "Active, precise climate control. No heat trouble, but 500 W leaves little power for instruments." },
        { id: "panels", name: "Extra solar panels", role: 0, cost: 400, kg: 70, w: 0, gen: 400, kind: "power", icon: 2,
          desc: "+400 W. Required if use goes over 600 W. Very expensive and heavy." },
        { id: "thermal", name: "Redundant thermal sensor", role: 0, cost: 150, kg: 0.3, w: 20, gen: 0, kind: "sensor", icon: 3,
          desc: "Catches heat alarms in time and self-regulates (+10 W while it works)." },
        { id: "toolkit", name: "Repair toolkit", role: 0, cost: 150, kg: 20, w: 5, gen: 0, kind: "tools", icon: 8,
          desc: "Two repair actions for mechanical failures or heat alarms." },
        { id: "antenna", name: "High-gain antenna", role: 2, cost: 300, kg: 60, w: 80, gen: 0, kind: "comms", icon: 4,
          desc: "Keeps contact with Earth and sends 64 MB per stage. Uses a big share of the payload." },
        { id: "backup", name: "Backup comms system", role: 2, cost: 150, kg: 25, w: 40, gen: 0, kind: "comms", icon: 9,
          desc: "Takes over if the main link fails, so telemetry is not lost." },
        { id: "dosimeter", name: "Radiation dosimeter", role: 2, cost: 50, kg: 0.3, w: 10, gen: 0, kind: "science", icon: 5,
          desc: "Measures cosmic radiation (+8 MB science per stage) and warns of solar storms. No shielding." }
    ];

    // VERIFIED: team query of the NASA Ames Trajectory Browser.
    global.ROUTES = [
        { id: "standard", name: "Route 1: Standard transfer", days: 288, dv: 4.79, depart: "Dec 21, 2030", arrive: "Oct 5, 2031", inj: 3.68, post: 1.11,
          note: "Earth-Mars. Longest margin, easiest manoeuvre." },
        { id: "fast", name: "Route 2: Fast transfer", days: 272, dv: 4.84, depart: "Dec 21, 2030", arrive: "Sep 19, 2031", inj: 3.71, post: 1.13,
          note: "Earth-Mars. 16 days shorter, a bit more delta-v." },
        { id: "venus", name: "Route 3: Venus gravity assist", days: 352, dv: 6.82, depart: "Feb 20, 2030", arrive: "Feb 7, 2031", inj: 4.81, post: 2.01,
          note: "Earth-Venus-Mars. Needs a very light ship and the dosimeter." }
    ];

    global.ROLES = ["Engineering", "Biology", "Communications", "Mission Lead"];

    global.SOURCES = [
        { kind: "VERIFIED", nasa: true, title: "NASA Ames Trajectory Browser", url: "https://trajbrowser.arc.nasa.gov/",
          use: "Central NASA data: the three routes (dates, days, delta-v). Launch is blocked unless your delta-v covers the route." },
        { kind: "VERIFIED", nasa: true, title: "NASA: Earth to Mars takes about 7-10 months", url: "https://www.nasa.gov/directorates/smd/how-long-does-it-take-to-get-to-the-moon-mars-jupiter-we-asked-a-nasa-expert-episode-51/",
          use: "Trip length drives energy use, climate exposure and the chance of failures." },
        { kind: "VERIFIED", nasa: true, title: "NASA Mars Fact Sheet: sunlight ~43% of Earth", url: "https://nssdc.gsfc.nasa.gov/planetary/factsheet/marsfact.html",
          use: "Why panels make less near Mars. SIMPLIFIED: output falls to 85%, not 43%." },
        { kind: "VERIFIED", nasa: true, title: "NASA Deep Space Network", url: "https://www.nasa.gov/communicating-with-missions/dsn/",
          use: "Antennas on Earth that talk to spacecraft. The signal-loss event uses it as context." },
        { kind: "VERIFIED", nasa: false, title: "ESA Mars Express: signal delay 4-24 min one way", url: "https://blogs.esa.int/mex/2012/08/05/time-delay-between-mars-and-earth/",
          use: "Why the spacecraft often has to fix problems on its own." },
        { kind: "ADAPTED", nasa: true, title: "JPL Concept Maturity Levels", url: "https://dataverse.jpl.nasa.gov/dataset.xhtml?persistentId=hdl:2014/44299",
          use: "Design milestones are CML-inspired. The grants are fictional." },
        { kind: "VERIFIED", nasa: false, title: "Alford 1969 (Apidologie): diapause 6-9 months", url: "https://link.springer.com/article/10.1007%2Fs13592-017-0529-z",
          use: "Background for a dormant cargo. Earth conditions only." },
        { kind: "SINGLE STUDY", nasa: false, title: "Yoon et al. 2010: 2.5 C and 70% humidity", url: "https://koreascience.kr/article/JAKO201028542317554.pdf",
          use: "Chamber targets. One lab study, not a space standard." },
        { kind: "CONTEXT", nasa: false, title: "Beekman et al. 1998: lab diapause survival", url: "https://conservationevidencejournal.com/individual-study/1690",
          use: "Longer diapause lowers survival on Earth. Never used as a probability." },
        { kind: "VERIFIED", nasa: false, title: "Smithsonian: STS-41-C bees in space (1984)", url: "https://airandspace.si.edu/collection-objects/bee-enclosure-module-sts-41-c/nasm_A19880031000",
          use: "3,300 honeybees built comb in orbit. Inspiration, not proof for bumblebees." },
        { kind: "TEAM", nasa: false, title: "Team table: equipment, rocket, events", url: "",
          use: "Masses, power, 0.008 km/s per kg, costs, events and the 250 kg / 7.0 km/s / 600 W rocket are team values." },
        { kind: "OPEN", nasa: false, title: "Open question: dormant queens in space", url: "",
          use: "Nobody has flown dormant bumblebee queens to Mars. Risk is a game index, not a survival chance." }
    ];

    // NASA facts shown during the trip (one per stage)
    global.FACTS = [
        "NASA: a trip to Mars takes about 7 to 10 months.",
        "NASA Trajectory Browser: your route was computed for real planet positions.",
        "NASA Mars Fact Sheet: Mars gets about 43% of the sunlight Earth gets.",
        "ESA: a radio signal takes 4 to 24 minutes to reach Mars.",
        "NASA Deep Space Network: three sites on Earth listen to deep-space missions.",
        "Smithsonian: in 1984, 3,300 honeybees flew on the Space Shuttle (STS-41-C).",
        "Bumblebee queens sleep (diapause) through winter for about 6 to 9 months.",
        "Earth and Mars line up for a launch window about every 26 months."
    ];

    global.GUIDE = [
        ["POWER (W)", "What the ship makes and uses right now. Near Mars, panels make less."],
        ["ENERGY (Wh)", "The battery reserve. It drains when use beats generation."],
        ["DELTA-V (km/s)", "7.0 km/s minus 0.008 for every kg. Each NASA route needs a minimum."],
        ["DATA (MB)", "Science received on Earth. You need an antenna (or backup) to send it."],
        ["DIAPAUSE", "Queens sleep through winter for about 6-9 months, with a very slow metabolism."],
        ["RISK (0-100)", "A game index from chamber conditions. Not a real chance of survival."]
    ];
}

function item(_id)
{
    for (var i = 0; i < array_length(global.ITEMS); i++) if (global.ITEMS[i].id == _id) return global.ITEMS[i];
    return undefined;
}
function route_by_id(_id)
{
    for (var i = 0; i < array_length(global.ROUTES); i++) if (global.ROUTES[i].id == _id) return global.ROUTES[i];
    return global.ROUTES[0];
}
