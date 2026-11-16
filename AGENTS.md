# Contribution instructions

Read README.md and docs/AI_CONTRIBUTOR_GUIDE.md. The active application is served from dist/.

Preserve the final game, pixel art and resource proportions. Keep mission rules in engine.js, data in data.js and presentation in app.js/CSS. Do not restore an obsolete implementation to fix a test or stale import.

Preserve keyboard and touch controls, focus and reduced motion. Do not change save keys or versions without explicit compatibility handling. Distinguish scientific sources from team-defined educational rules. Document behavior changes and outstanding checks.

Run relevant tests and git diff --check. For visual changes, inspect affected screens on desktop and mobile. Never claim a platform was tested when it was not.
