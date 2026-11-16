# Contributor guide for the final web edition

## Active architecture

`dist/index.html` loads `app.js`. Mission rules live in `engine.js`; parameters and sources in `data.js`; exploration in `world.js`; drawing in `world-render.js`; outcomes in `assessment.js`; audio in `audio.js`. Paths resolve relative to `dist/`. Deleted root implementations are historical and must not be restored as the active game.

## Safe changes

Define the goal, affected screens and observable acceptance criteria first. Preserve the retro palette, typography, pixel-art proportions and existing composition. Reuse CSS components and avoid balance changes as a side effect of visual work.

For equipment or routes, review data.js and its engine.js, app.js and assessment.js consumers. For scenes, inspect map links, entry positions, collision rectangles and rendering. Keep scientific source URLs, explain how each source is used and preserve its limitations.

Saves use `beeyond-rpg13`; embedded mission records still use version 12. Preserve existing saves. Never change a key or discard data as an incidental refactor.

## Verification

Current story tests import modules from dist/. The legacy engine suite imports deleted root modules and requires substantive adaptation because the APIs differ. Report individual suites honestly.

For UI changes, exercise opening, exploration, station interactions, launch, incidents, report and return. Check focus, keyboard, touch, narrow screens, readable text and resource proportions. Static inspection is not a complete playthrough. See hackathon/VERIFICACION-PAGES.md for the actual published checks and their limits.

## Documentation and rights

README describes the current product; SUBMISSION.md contains reusable hackathon text; SOURCES.md records data provenance. REVIEW.md and V13_GDD_REVIEW.md distinguish historical context from current evidence. Original art/audio ownership and Apache 2.0 were confirmed by the team. Do not request those confirmations again. External research and trademarks retain their own terms. Keep public claims consistent with the active code and verification evidence.
