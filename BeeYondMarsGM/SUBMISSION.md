# BeeYond Mars – text for the Space Apps submission form (draft, edit freely)

## High-level summary
BeeYond Mars is an educational retro game for 1–4 players on one device. A fictional space agency, Aurelia, funds a team that wants to study the hypothetical transport of dormant bumblebee queens (*Bombus terrestris*) to Mars. Players build a spacecraft from parts with mass, power and cost, pass design reviews that release funds, compare Earth–Mars route values from a reproducible NASA Ames Trajectory Browser query, and handle heat alarms, signal loss and impacts during the trip. The mission logbook is written as a scientific paper: its conclusions and the reviewers' feedback change with every decision, so players learn why the mission worked or failed and can redesign and fly again.

## Detailed project description
BeeYond Mars turns mission design into a playable set of trade-offs. Players install a biological chamber and spacecraft equipment, then compare three Earth-to-Mars route options while watching mass, delta-v, power, energy, communications, data and budget. Design reviews reward testing the design and comparing routes. Once the launch constraints are met, players advance a seeded voyage in stages and choose how to respond to on-board incidents using the resources they installed. A mission report and five-page paper summarize the decisions, measurements and outcome; players can redesign and try again. One device supports one to four local players, who share or take turns across Engineering, Biology, Communications and Mission Lead roles.

The educational purpose is to make engineering trade-offs visible: lighter equipment may use more power, added capability costs mass and credits, and a shorter route can require more delta-v. NASA Ames route data anchor the trajectory comparison, while the launcher, equipment catalog, grant amounts, event outcomes and biological risk index are simplified game rules. The game is not an aerospace design tool and does not claim that dormant bumblebee queens can survive interplanetary travel. The optional sealed greenhouse is a hypothetical extension, not evidence of survival or a proposed release of organisms on Mars.

The browser edition is a static HTML/CSS/JavaScript game migrated from the team's GameMaker v11 project. It has no runtime backend. The code and art/audio AI disclosures below reflect the team's current declaration and should be checked against the final published build and demo.

The team's original project content is released under the Apache License 2.0; third-party sources are cited and remain subject to their own terms.

## Submission links to fill in
- Public web build: **[ADD URL; verify it opens without login]**
- Demo video/slides: **[ADD PUBLIC URL; confirm the event's current length and format]**
- Source repository: **https://github.com/XaxavierJS/BeeYond-Mars** (public; confirm this is the repository the team wants to submit)

## How it addresses the challenge
- Full mission cycle: objective, spacecraft design, instruments, launcher and trajectory check, constraint management, simulation and evaluation.
- Visible resources: mass, power, energy, budget, data, communications and time.
- Collaborative mode for up to 4 people with roles (Engineering, Biology, Communications, Mission Lead), local and turn-based.
- Feedback that explains the outcome, plus redesign and retry.

## NASA data and resources
- NASA Ames Trajectory Browser: linked one-way Earth–Mars rendezvous query reproduces the selected route dates, durations and delta-v. The game stores those route records and blocks launch unless spacecraft delta-v covers the selected value. The launcher model itself is a simplified team-defined rule.
- NASA: Earth–Mars travel time of about 7–10 months.
- NASA Mars Fact Sheet: sunlight at Mars is about 43% of Earth's. Separately, the game applies an 85% arrival-power factor as a simplified team rule; it is not a conversion of that NASA figure.
- NASA Deep Space Network: context for the signal-loss event.
- JPL Concept Maturity Levels: design milestones (grants are fictional).

## Other references
ESA Mars Express blog (signal delay); Alford 1969 cited in Apidologie (diapause); Yoon et al. 2010 (2.5 °C, 70% RH); Beekman et al. 1998 (diapause survival, context only); Velthuis & van Doorn 2006 (*Bombus terrestris*); Smithsonian NASM (STS-41-C bee module). Full links are in the game under Guide and Sources.

## Use of AI
- The idea, story, mechanics and values were defined by the team.
- Code was developed with AI assistance (OpenAI Codex, Claude) and reviewed by the team.
- The team created the scene art, bee and character sprites with AI assistance; AI-assisted artwork carries a visible "AI" mark.
- The team created the music and sound effects with code written with AI assistance; no third-party music or sounds are used.
- No NASA logos, flags or mission identifiers appear in any AI-generated asset. The agency "Aurelia" is fictional.

## Scientific limits
The mission is hypothetical. Risk is a game index, not a survival probability. Whether dormant bumblebee queens can survive an interplanetary trip is an open question. The greenhouse phase is a clearly labelled hypothetical extension in a sealed habitat.
