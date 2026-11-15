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

The equipment catalog, game parameters and source notes are in [`dist/game-balance.json`](dist/game-balance.json) and [`dist/sources.json`](dist/sources.json). Route dates, durations and delta-v are linked to the NASA Ames Trajectory Browser query in the source list. The launcher capacity, mass penalty, power rules and biological risk model are simplified team-defined game values, not spacecraft specifications or survival predictions.

`dist/data.js` is the runtime source of truth for those reference files. After changing its catalog, rules or sources, run `npm run sync:data` to refresh the JSON copies.

## Architecture and saves

- `dist/engine.js`: serializable mission state, constraints, seeded events, reporting and greenhouse rules.
- `dist/app.js`: responsive interface, local cooperation, paper, controls and export.
- `dist/data.js`: components, routes, model parameters and source notes.
- `dist/audio.js` and `dist/assets/`: original chiptune and GameMaker audio/visual resources.

The browser autosaves v11 missions as `beeyond-v11`. Previous v5/v6 save data is left untouched; starting a mission creates a new v11 save. The game supports keyboard and touch controls, fullscreen, JSON report download and local pass-and-play roles.

## Guidance for AI contributors

Read [`AGENTS.md`](AGENTS.md) before changing the project, then use the [AI contributor guide](docs/AI_CONTRIBUTOR_GUIDE.md) for architecture, visual rules, scientific context, extension recipes and the UX/UI backlog. Keep that guide and the in-game references aligned when an approved change affects them.

## NASA Space Apps audit

The [2026 challenge compliance audit](docs/hackathon/auditoria-cumplimiento.md), [gap priorities](docs/hackathon/brechas-y-prioridades.md) and [submission checklist](docs/hackathon/checklist-entrega.md) separate official requirements from team proposals and mark items that need confirmation in the team account.
Use the [plan to close remaining items and prepare future changes](docs/hackathon/plan-cierre-pendientes.md) to sequence evidence gathering, rights review, final playthrough and UX/UI improvements.
The [resource and rights inventory](docs/hackathon/recursos-y-licencias.md) tracks which asset origins are only team-declared and what must be confirmed before publication.
The [NASA route evidence](docs/hackathon/evidencia-rutas-nasa.md) records the reproducible query and the selected values used by the game.
The [modular demo script](docs/hackathon/guion-demo.md) connects the NASA data to the gameplay and flags the details the team must fill in before publishing.
The [GitHub Pages publishing guide](docs/hackathon/publicacion-github-pages.md) describes the manual-only workflow prepared for the public web build.

## Credits and scientific limits

Concept, story, mechanics, art, music and sound: BeeYond Mars team. The team created art and audio with AI assistance; AI-assisted art carries a visible mark. Aurelia is fictional; no NASA logos or official affiliation are implied. Source context and its limits are available in the in-game guide and `dist/sources.json`.

Original project content is released under the [Apache License 2.0](LICENSE). Third-party references and materials remain subject to their own terms. The GameMaker logo placeholders in `BeeYondMarsGM/options/` are excluded from that license; the team confirms authorized use, subject to the GameMaker brand guidelines recorded in [NOTICE](NOTICE).
