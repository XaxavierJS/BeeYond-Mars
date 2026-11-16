# Sources, data provenance and scientific boundaries

This register describes the currently deployed v13 model. Runtime references are in `dist/data.js`; `dist/sources.json` and `dist/credits.html` provide companion reading. A citation does not mean the entire model is scientifically validated.

| Source | Use in BeeYond Mars | Boundary |
|---|---|---|
| [NASA Ames Trajectory Browser](https://trajbrowser.arc.nasa.gov/) | Attribution for team-transcribed standard and fast route scenarios: 288 days / 4.79 km/s and 272 days / 4.84 km/s. Duration affects voyage length; delta-v is compared against the game spacecraft model | Exact query/export remains unverified in this delivery. The game does not calculate an orbit or certify a trajectory |
| [NASA Mars Fact Sheet](https://nssdc.gsfc.nasa.gov/planetary/factsheet/marsfact.html) | Mars/Earth solar irradiance ratio about 0.431, shown as scientific context | Active generation multiplier is 0.85, an independent educational balance rule; it is not derived from 0.431 |
| [NASA: travel time to Mars](https://www.nasa.gov/directorates/smd/how-long-does-it-take-to-get-to-the-moon-mars-jupiter-we-asked-a-nasa-expert-episode-51/) | Roughly 7–10 months as journey context | Does not validate the exact scenario dates or the spacecraft |
| [ESA Mars Express: time delay](https://blogs.esa.int/mex/2012/08/05/time-delay-between-mars-and-earth/) | About 4–24 minutes one way motivates communications constraints and autonomy | Displayed interpolation is illustrative. The decision timer is gameplay, not instantaneous control from Earth |
| [JPL: Concept Maturity Levels](https://dataverse.jpl.nasa.gov/dataset.xhtml?persistentId=hdl:2014/44299) | Inspiration for staged design reviews | Funding amounts and approval criteria are fictional |
| [Bogo et al. (2017): diapause and colony initiation](https://cris.unibo.it/handle/11585/613718) | Terrestrial biological context for dormant bumblebee queens | Does not establish survival in space. Corrects a prior misattribution of DOI 10.1007/s13592-017-0529-z to Alford (1969) |
| [Smithsonian: STS-41-C bee enclosure](https://airandspace.si.edu/collection-objects/bee-enclosure-module-sts-41-c/nasm_A19880031000) | Historical context for honeybee experiments in orbit | Honeybees in low Earth orbit are not evidence for dormant bumblebee queens travelling to Mars |

## Supplied route reconstruction files

`data/BeeYond_Datos_Ruta_Estandar.json` and `data/BeeYond_Datos_Ruta_Rapida.json` preserve additional team-supplied route reconstructions. Their metadata identifies preliminary heliocentric propagation, interpolation and unresolved reference-frame/time assumptions. They are not consumed by the active runtime modules reviewed here. Their presence must not be presented as a validated live orbital simulation.

## Team-defined educational assumptions

The 2,000-credit starting budget, additional funding, component prices and masses, launcher/cruise-bus profiles, 0.85 generation factor, linear delta-v penalty, batteries, data storage, event timing, risk thresholds and outcome scores are game rules. The inherited 2.5 °C and 70% humidity targets are not a validated space protocol. Equipment and launch checks operate inside this model.

The hypothetical payload objective does not establish biological feasibility. Radiation dose-response, metabolism, real landing dynamics and human life support are not simulated. The sealed greenhouse and Nobel ending are explicitly imagined continuations. Risk, colony index and score must not be described as empirical survival probabilities or NASA judging scores.

## Credits and rights

The team confirms that the game's art, typography and audio are its own, with AI assistance disclosed in the game and submission materials. Original team content uses Apache License 2.0. Linked research and trademarks retain their own rights; citing a page does not relicense its figures, documents or imagery. Do not add third-party media to the demonstration without appropriate permission and attribution.
