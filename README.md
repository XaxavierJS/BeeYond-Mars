# BeeYond Mars · Mission Aurelia

An educational retro game for the NASA Space Apps Challenge. This browser edition follows GameMaker v11: players design a spacecraft for a hypothetical dormant bumblebee queen payload, manage a seeded interplanetary cruise, and review the outcome as a scientific paper. An optional sealed greenhouse is a clearly hypothetical follow-up.

The game is an educational model, not an aerospace simulation. Costs, spacecraft, route values, risk and biological outcomes are team-defined rules. Risk is not a survival probability. The game makes no claim that bumblebee queens can survive spaceflight.

## Run and verify

Requirements: Node.js with `node:test`, Python 3, and a modern browser.

```sh
npm start
```

Open <http://localhost:8080>. The static app is served from `dist/`; it uses no npm runtime dependencies or backend.

```sh
npm test
```

Tests cover the v11 catalog and calculations, arrival-power constraint, seeded incident schedule, thermal/comms/mechanical decisions, route limits, milestones, greenhouse outcomes and save validation.

## Mission flow

1. Start a mission for one to four local players and receive 900 fictional credits.
2. Design the spacecraft at Biology, Engineering and Communications. Pass CML-inspired reviews to earn 150 and 200 additional credits.
3. Compare the two direct Mars transfers and the Venus gravity-assist option. Current spacecraft cannot meet the Venus route's delta-v requirement.
4. Launch only when mass, delta-v, funds and arrival power satisfy the game rules. The cruise advances in 30-day stages and includes thermal, communications and mechanical incidents.
5. Read the five-page paper and peer review. Redesigning retains equipment and earned grants.
6. If the mission arrives with cargo status below compromised, run the optional sealed-greenhouse model. Its colony and pollination outcomes are fictional game results.

## v11 model

The mission starts with a 250 kg, 7.0 km/s, 600 W launcher. Delta-v is `7.0 − 0.008 × payload_kg`; launch power checks whether total generation × 0.85 covers the equipment load. The battery is 1600 Wh and the telemetry buffer is 128 MB. Routes are 288 days / 4.79 km/s, 272 days / 4.84 km/s and the Venus assist at 352 days / 6.82 km/s.

The equipment catalog, game parameters and source notes are in [`dist/game-balance.json`](dist/game-balance.json) and [`dist/sources.json`](dist/sources.json). Exact route values and model parameters are team-supplied assumptions, not a trajectory calculation.

## Architecture and saves

- `dist/engine.js`: serializable mission state, constraints, seeded events, reporting and greenhouse rules.
- `dist/app.js`: responsive interface, local cooperation, paper, controls and export.
- `dist/data.js`: components, routes, model parameters and source notes.
- `dist/audio.js` and `dist/assets/`: original chiptune and GameMaker audio/visual resources.

The browser autosaves v11 missions as `beeyond-v11`. Previous v5/v6 save data is left untouched; starting a mission creates a new v11 save. The game supports keyboard and touch controls, fullscreen, JSON report download and local pass-and-play roles.

## Guidance for AI contributors

Read [`AGENTS.md`](AGENTS.md) before changing the project, then use the [AI contributor guide](docs/AI_CONTRIBUTOR_GUIDE.md) for architecture, visual rules, scientific context, extension recipes and the UX/UI backlog. Keep that guide and the in-game references aligned when an approved change affects them.

## Credits and scientific limits

Concept, story, mechanics and game values: BeeYond Mars team. Art is original and AI-assisted. Music and sound are original project assets. Aurelia is fictional; no NASA logos or official affiliation are implied. Source context and its limits are available in the in-game guide and `dist/sources.json`.
