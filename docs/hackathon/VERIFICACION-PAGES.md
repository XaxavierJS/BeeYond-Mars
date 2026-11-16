# Public Pages resource and mission verification

Checked 15 November 2026 at https://xaxavierjs.github.io/BeeYond-Mars/ . Game resource repair: commit 9389a7e.

## Repair

Copied the original bee atlas from assets/bees-v6.png to dist/assets/bees-v6.png and recovered dist/assets/aurelia-pixel.ttf from delivery commit fbbde3d. No new art was generated; sprites, CSS, proportions and mission rules were not changed.

## Observed evidence

- Isolated Chromium/Brave browser against the public URL, without a GitHub session.
- All 120 requested resources passed: bee atlas, pixel font and assets/gm files. Inspected static JS/CSS/HTML references resolved locally.
- Beginning a mission and opening the menu produced no observed JavaScript exceptions or HTTP errors.
- Layouts inspected at 1280×720 and 390×844. Proportions were retained; no horizontal overflow was observed on the mobile viewport.
- Prepared laboratory checkpoint: heavy launcher, Vanguard, antenna, toolkit and dosimeter. UI actions covered launch, skipped launch cutscene, voyage progression, communications realignment, mechanical repair, arrival/report at 300 days, four greenhouse care decisions, ending and redesign to the laboratory. Prepared save positions placed the character near objects between stages; this did not test every walking path or the whole opening from scratch.
- The engine loaded from Pages also completed a successful voyage, four care steps, a valid epilogue state and redesign→lab.
- npm run test:story passed four checks. The legacy engine suite was not repaired as part of the resource change.

Captures: [desktop opening](evidencia/inicio-escritorio.png), [mobile opening](evidencia/inicio-movil.png), [report](evidencia/informe-pages.png), [ending](evidencia/final-pages.png).

## Remaining limits

Opening and encounters without checkpoints; every failure branch; all accessibility settings; human listening review; physical touch devices; assistive technologies and other browsers. A successful recorded mission is not proof of every possible game state.
