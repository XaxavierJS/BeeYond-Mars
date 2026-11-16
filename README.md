# BeeYond Mars

**A small life. A distant world. A second chance at science.**

[Play the game](https://xaxavierjs.github.io/BeeYond-Mars/) · [Submission text](docs/SUBMISSION.md) · [Sources and scientific limits](docs/SOURCES.md) · [Verification](docs/hackathon/VERIFICACION-PAGES.md)

BeeYond Mars is a browser-based educational adventure created for the NASA Space Apps **Space Mission Design Game** challenge. Players help Lum reunite with Pip, Nim and Eko, then design a spacecraft for a hypothetical study of dormant bumblebee queens travelling to Mars. Exploration and conversations give the engineering decisions a human context: protecting a small payload means balancing a whole mission.

## What players do

Explore the village, reconnect with the team, choose a biological chamber and instruments, compare launcher/cruise-bus packages and two Mars route scenarios, and pass design reviews. Before launch, check mass, power, budget, communications and delta-v. During the voyage, respond to incidents with the equipment and energy available. Read the result, identify the bottleneck and redesign. An optional sealed greenhouse and later award are fictional story continuations.

The game supports one to four local players sharing a device, with Engineering, Biology, Communications and Mission Lead responsibilities. It does not provide online multiplayer. Move with WASD or arrows and interact with E/space; pointer navigation and on-screen movement buttons are also available. English is the initial language; Spanish can be selected in the pause menu. Audio volumes and decision timing are adjustable.

## Educational purpose

Players practise comparing alternatives, budgeting limited resources, interpreting constraints and explaining outcomes. A lighter component can consume more power; an additional instrument uses mass and money; a faster route can require more delta-v. The mission report makes the consequences available for another attempt. These are intended learning outcomes, not results of a completed educational effectiveness study.

## NASA and other research

NASA Ames Trajectory Browser is the attributed source for the team's route scenarios; their exact query/export provenance remains unverified in this delivery. Route days and delta-v affect the game's checks and travel. NASA Mars Fact Sheet, NASA travel-time information, JPL design-maturity concepts, ESA communications context, terrestrial bumblebee research and the Smithsonian's historical bee enclosure provide scientific context. See [the source register](docs/SOURCES.md) for links, use and limitations.

The 0.431 Mars/Earth irradiance ratio is scientific context. The active 0.85 generation factor is an independent simplified game rule. Budgets, launcher profiles, mass penalty, incidents and risk scores are team models. This game does not predict biological survival, calculate a physical orbit, validate a space diapause protocol or model human life support. Aurelia and the ending are fictional; no agency endorsement is implied.

## Run locally

Requires Python 3; no installation of npm dependencies is needed.

```sh
python3 -m http.server 8080 --bind 127.0.0.1 --directory dist
```

Open http://localhost:8080. With npm installed, `npm start` runs the same server. Serve `dist/` as the web root; modules may not load when opening HTML directly as a file.

## Project structure

| Path | Responsibility |
|---|---|
| `dist/index.html`, `app.js` | Entry point, screens, story interactions, menus and persistence |
| `dist/engine.js`, `data.js` | Mission rules/state; parameters, equipment, routes and sources |
| `dist/world.js`, `world-render.js` | Maps, movement, collisions and pixel-world rendering |
| `dist/assessment.js` | Outcome assessment and ending classification |
| `dist/audio.js` | Procedural audio |
| `dist/style.css`, `rpg.css`, `assets/` | Presentation and deployed resources |
| `assets/`, `data/`, `tools/` | Additional supplied art, route reconstructions and authoring tools |
| `docs/`, `tests/` | Documentation and automated checks |

## Saves and verification

Exploration saves use browser local storage key `beeyond-rpg13`; the embedded mission format still uses version 12. Preserve both when changing the game. Reloading a save currently selects English. Gameplay has no account system or analytics in the game code; hosting may have its own access logs.

`npm run test:story` passes four checks for maps, collisions, invalid saves and assessment. `npm test` currently also loads a legacy engine suite that imports deleted root modules and fails; it is not a passing full regression suite. The published mission was exercised from prepared checkpoints through launch, incidents, arrival, report, greenhouse, ending and redesign, with no observed JavaScript errors. Desktop and mobile layouts and 120 resource URLs were checked. A complete introduction without checkpoints, physical touch devices, all failure variants and assistive technologies remain pending. See [verification evidence](docs/hackathon/VERIFICACION-PAGES.md).

## Credits, AI and reuse

Concept, story direction, mechanics, art, typography, music and sound: BeeYond Mars team. The team confirms authorship of its art and audio. Development, adaptation, narrative text and procedural audio used AI assistance; artwork is identified as AI-assisted in the game. Confirm the exact tool names in the submission form. Referenced games inspired general narrative/design ideas; their characters, music and assets were not supplied as part of this implementation.

The team approved Apache License 2.0 for its original content; see [LICENSE](LICENSE). Scientific references remain subject to their own terms. Agency names and trademarks do not imply endorsement.

Read [AGENTS.md](AGENTS.md) and [the contributor guide](docs/AI_CONTRIBUTOR_GUIDE.md) before extending the game. See [the closure plan](docs/hackathon/PLAN-CIERRE.md) for outstanding delivery work.
