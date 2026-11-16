// v11 equipment port. Launcher profiles, grant, timings and risk are fictional game balance.
export const CFG={version:12,budget:2000,grants:[150,200],batteryWh:1600,storageMB:128,solarArrival:.85,dvPerKg:.008,stageDays:30,baseTemp:2.5,baseHumidity:70,criticalRisk:80};
export const ROLES=['Engineering','Biology','Communications','Mission lead'];
export const PEOPLE=['Pip','Nim','Eko','Lum'];
export const ITEMS=[
{id:'chamberA',name:'Economy chamber',role:1,cost:150,kg:135,w:200,gen:0,kind:'chamber',icon:1,desc:'Passive cooling. Two heat alarms need a sensor or a careful response.'},
{id:'chamberB',name:'Vanguard chamber',role:1,cost:300,kg:90,w:500,gen:0,kind:'chamber',icon:0,desc:'Active climate control. 500 W, not 800 W. Does not guarantee biological survival.'},
{id:'panels',name:'Solar wings',role:0,cost:400,kg:70,w:0,gen:400,icon:2,desc:'Adds 400 W at departure, 340 W under the simplified arrival factor. Heavy but useful.'},
{id:'thermal',name:'Thermal sensor',role:0,cost:150,kg:.3,w:20,gen:0,icon:3,desc:'Detects heat alarms; controller responds automatically, using 10 W extra per alarm.'},
{id:'toolkit',name:'Repair toolkit',role:0,cost:150,kg:20,w:5,gen:0,icon:8,desc:'Two autonomous repair actions for heat or mechanical incidents.'},
{id:'antenna',name:'High-gain antenna',role:2,cost:300,kg:60,w:80,gen:0,icon:4,desc:'Sends up to 64 MB per 30 days. Does not change the speed of light.'},
{id:'backup',name:'Backup link',role:2,cost:150,kg:25,w:40,gen:0,icon:9,desc:'Sends 16 MB per 30 days. Automatically handles a signal incident.'},
{id:'dosimeter',name:'Radiation dosimeter',role:2,cost:50,kg:.3,w:10,gen:0,icon:5,desc:'Adds 8 MB of observations per 30 days. Measures radiation; provides no shielding.'}
];
export const LAUNCHERS=[
{id:'scout',name:'Scout',cost:0,cap:190,dv:6.8,power:450,overhead:10,desc:'Low-cost biological survey. Small payload; best with the Economy chamber.'},
{id:'medium',name:'Aurelia',cost:200,cap:250,dv:7,power:600,overhead:0,desc:'Balanced payload and bus. Vanguard needs solar wings and careful instruments.'},
{id:'heavy',name:'Atlaswing',cost:600,cap:400,dv:9.2,power:1000,overhead:50,desc:'Higher capacity and manoeuvre margin; expensive, with higher bus consumption.'}
];
export const ROUTES=[{id:'standard',name:'The patient path',days:288,dv:4.79,depart:'2030-12-21',arrive:'2031-10-05',desc:'Standard transfer · lower manoeuvre requirement.'},{id:'fast',name:'A little sooner',days:272,dv:4.84,depart:'2030-12-21',arrive:'2031-09-19',desc:'Fast transfer · 16 fewer days of exposure.'},];
export const SOURCES=[
{title:'NASA Mars Fact Sheet',url:'https://nssdc.gsfc.nasa.gov/planetary/factsheet/marsfact.html',kind:'Verified context; simplified in game',use:'Mars/Earth solar irradiance ratio is 0.431. The game uses an explicitly simplified 0.85 cruise generation factor for balance. This is not an orbital or surface power model.'},
{title:'NASA Ames Trajectory Browser',url:'https://trajbrowser.arc.nasa.gov/',kind:'Team-transcribed scenarios',use:'The v11 file attributes 272/288-day routes and delta-v to this browser. Exact query/export was not supplied: these scenario values remain unverified, not certified trajectories.'},
{title:'NASA · travel time to Mars',url:'https://www.nasa.gov/directorates/smd/how-long-does-it-take-to-get-to-the-moon-mars-jupiter-we-asked-a-nasa-expert-episode-51/',kind:'Scientific context',use:'Typical travel takes roughly 7–10 months.'},
{title:'ESA Mars Express · signal delay',url:'https://blogs.esa.int/mex/2012/08/05/time-delay-between-mars-and-earth/',kind:'Scientific context',use:'About 4–24 minutes one way. The displayed linear interpolation is illustrative. Timed decisions represent onboard autonomy, not instant commands from Earth.'},
{title:'Bogo et al. (2017) · diapause and colony initiation',url:'https://cris.unibo.it/handle/11585/613718',kind:'Terrestrial study',use:'Mating status and pre-diapause weight affected outcomes in terrestrial rearing. Corrects the v11 misattribution of DOI 10.1007/s13592-017-0529-z to Alford (1969). Does not validate space transport.'},
{title:'Smithsonian · STS-41-C bee enclosure',url:'https://airandspace.si.edu/collection-objects/bee-enclosure-module-sts-41-c/nasm_A19880031000',kind:'Historical context',use:'Honeybees were studied in orbit; this is not evidence for dormant bumblebee queens on a Mars voyage.'},
{title:'JPL · Concept Maturity Levels',url:'https://dataverse.jpl.nasa.gov/dataset.xhtml?persistentId=hdl:2014/44299',kind:'Design inspiration',use:'Design reviews are inspired by maturity levels. Grants and approval criteria are fictional.'},
{title:'Model assumptions and art credits',url:'credits.html',kind:'Game design',use:'All credit prices, payload limits, launcher bus power, linear delta-v penalty, events and risk thresholds are fictional. 2.5 °C and 70% RH are inherited design targets, not a validated space protocol. Human travel, greenhouse and Nobel ending are imagined fiction.'}
];
export const SEALS=[['letter','A second chance'],['Pip','A repaired compass'],['Nim','A packet of seeds'],['Eko','A voice in the dark'],['design','A funded question'],['routes','Two possible skies'],['launch','Leaving home'],['data','A signal received'],['repair','Learning from trouble'],['arrival','A distant horizon'],['garden','A living question'],['paper','Shared knowledge']];
