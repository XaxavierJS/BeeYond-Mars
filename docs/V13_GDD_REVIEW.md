# v13 design review and boundaries

## Product scope

BeeYond Mars combines exploration with mission design. Lum reconnects with Pip, Nim and Eko before configuring a hypothetical dormant-bumblebee mission. Players manage equipment, resources, reviews, route scenarios and flight incidents, then inspect a report and redesign. A sealed habitat and imagined award provide fictional continuations.

The world is rendered at 480×270 with pixel scaling, a controlled palette and hand-built spaces. Crew silhouettes use accessories to distinguish characters. The original supplied bee atlas and pixel font were restored for Pages without changing the artwork or layout. The game initially selects English and offers Spanish in the pause menu. Technical log entries may remain English.

Procedural audio varies by scene and emergency state; music/effects have controls. Dialogue reveals progressively. Launch has a countdown, smoke, rocket motion and a skip option. These implementation features do not substitute for human audio review or accessibility testing.

## Numerical and scientific clarifications

- A 0.3 kg component has a 0.0024 km/s penalty under the rule 0.008 km/s per kg.
- The linear mass penalty is a game model, not a rocket-equation derivation.
- Vanguard consumes 500 W. Additional equipment and arrival margin determine whether generation is adequate; a blanket claim that it always needs panels would be inaccurate.
- Active generation uses 0.85 as an explicit simplification. NASA's approximately 0.431 irradiance ratio is separate context.
- Two active route scenarios use 272/288 days and 4.84/4.79 km/s. They are team-transcribed values attributed to NASA Ames; their exact query/export remains unverified in this delivery.
- Thermal targets are not a validated space protocol. Risk and colony values are simulated indices, not empirical probabilities.
- Real orbital propagation, landing dynamics, biological metabolism, radiation dose-response and human life support are outside the implemented model.

## Verification status

Four current story checks pass. The complete test command fails on a legacy suite that imports deleted root modules. Public Pages checks covered 120 resources, desktop/mobile layouts and a checkpoint-assisted mission through launch, incidents, arrival, report, greenhouse, ending and redesign without observed JavaScript exceptions. See hackathon/VERIFICACION-PAGES.md for captures and scope.

The complete opening without prepared checkpoints, real mobile touch, screen readers, other browsers, all endings and external learner testing remain pending. The game is publicly hosted at https://xaxavierjs.github.io/BeeYond-Mars/ . Public availability does not establish registration, acceptance or submission for judging.
