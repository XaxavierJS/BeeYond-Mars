// Provisional gameplay balance. Values are not spacecraft specifications.
export const CFG={version:11,budget:900,grants:[150,200],rocketCap:250,rocketDv:7,rocketPower:600,batteryWh:1600,storageMB:128,solarArrival:.85,dvPerKg:.008,stageDays:30,baseTemp:2.5,baseHumidity:70,criticalRisk:80};
export const ROLES=[['Engineering','Engineering'],['Biology','Biology'],['Communications','Communications'],['Mission lead','Mission lead']];
export const PEOPLE=['Pip','Nim','Eko','Lum'];
export const AVATARS=['engineering','biology','communications','management'];
export const ITEMS=[
{id:'chamberA',name:['Chamber A - Economy','Chamber A - Economy'],role:1,cost:150,kg:135,w:200,gen:0,kind:'chamber',icon:1,desc:['Fits the 600 W base. Heavy, and its temperature is harder to hold: expect at least two heat alarms.','Fits the 600 W base. Heavy, and its temperature is harder to hold: expect at least two heat alarms.']},
{id:'chamberB',name:['Chamber B - Vanguard','Chamber B - Vanguard'],role:1,cost:300,kg:90,w:500,gen:0,kind:'chamber',icon:0,desc:['Active, precise climate control. No heat trouble, but 500 W leaves little power for instruments.','Active, precise climate control. No heat trouble, but 500 W leaves little power for instruments.']},
{id:'panels',name:['Extra solar panels','Extra solar panels'],role:0,cost:400,kg:70,w:0,gen:400,kind:'power',icon:2,desc:['+400 W. Required if use goes over 600 W. Very expensive and heavy.','+400 W. Required if use goes over 600 W. Very expensive and heavy.']},
{id:'thermal',name:['Redundant thermal sensor','Redundant thermal sensor'],role:0,cost:150,kg:.3,w:20,gen:0,kind:'sensor',icon:3,desc:['Catches heat alarms in time and self-regulates (+10 W while it works).','Catches heat alarms in time and self-regulates (+10 W while it works).']},
{id:'toolkit',name:['Repair toolkit','Repair toolkit'],role:0,cost:150,kg:20,w:5,gen:0,kind:'tools',icon:8,desc:['Two repair actions for mechanical failures or heat alarms.','Two repair actions for mechanical failures or heat alarms.']},
{id:'antenna',name:['High-gain antenna','High-gain antenna'],role:2,cost:300,kg:60,w:80,gen:0,kind:'comms',icon:4,desc:['Keeps contact with Earth and sends 64 MB per stage. Uses a big share of the payload.','Keeps contact with Earth and sends 64 MB per stage. Uses a big share of the payload.']},
{id:'backup',name:['Backup comms system','Backup comms system'],role:2,cost:150,kg:25,w:40,gen:0,kind:'comms',icon:9,desc:['Takes over if the main link fails, so telemetry is not lost.','Takes over if the main link fails, so telemetry is not lost.']},
{id:'dosimeter',name:['Radiation dosimeter','Radiation dosimeter'],role:2,cost:50,kg:.3,w:10,gen:0,kind:'science',icon:5,desc:['Measures cosmic radiation (+8 MB science per stage) and warns of solar storms. No shielding.','Measures cosmic radiation (+8 MB science per stage) and warns of solar storms. No shielding.']}
];
export const LAUNCHERS=[{id:'medium',name:'Aurelia Medium Lift',cost:0,cap:250,dv:7,power:600,mars:true}];
export const ROUTES=[{id:'standard',name:['Route 1: Standard transfer','Route 1: Standard transfer'],days:288,dv:4.79,depart:'Dec 21, 2030',arrive:'Oct 5, 2031',inj:3.68,post:1.11,note:'Earth-Mars. Longest margin, easiest manoeuvre.'},{id:'fast',name:['Route 2: Fast transfer','Route 2: Fast transfer'],days:272,dv:4.84,depart:'Dec 21, 2030',arrive:'Sep 19, 2031',inj:3.71,post:1.13,note:'Earth-Mars. 16 days shorter, a bit more delta-v.'},{id:'venus',name:['Route 3: Venus gravity assist','Route 3: Venus gravity assist'],days:352,dv:6.82,depart:'Feb 20, 2030',arrive:'Feb 7, 2031',inj:4.81,post:2.01,note:'Earth-Venus-Mars. Needs a very light ship and the dosimeter.'}];
export const GUIDE=[
['POWER (W)','What the ship makes and uses right now. The game assumes panels make 85% of their output on arrival; this is a simplified team rule.'],
['ENERGY (Wh)','The battery reserve. It drains when use beats generation.'],
['DELTA-V (km/s)','The game launcher has 7.0 km/s minus 0.008 per kg. Each route has a minimum from the linked NASA Ames query; this is a simplified game comparison, not a real vehicle analysis.'],
['DATA (MB)','Science received on Earth. You need an antenna (or backup) to send it.'],
['DIAPAUSE','Queens sleep through winter for about 6–9 months, with a very slow metabolism.'],
['RISK (0–100)','A game index from chamber conditions. Not a real chance of survival.']
];
export const SOURCES=[
{label:'VERIFIED',nasa:true,title:'NASA Ames Trajectory Browser — Earth to Mars rendezvous',url:'https://trajbrowser.arc.nasa.gov/traj_browser.php?DTunit=yrs&LD1=2029&LD2=2040&chk_target_list=on&maxDT=1.5&maxDV=7.0&maxMag=25&maxOCC=4&min=DT&mission_class=oneway&mission_type=rendezvous&submit=Search&target_list=Mars&wdw_width=-1',use:'NASA Ames query for one-way Earth-Mars rendezvous. The selected 2030 standard, fast and Venus-assist rows reproduce the game dates, durations and delta-v. Browser delta-v is from 200 km LEO; the game uses these route requirements in its simplified team-defined launcher model.'},
{label:'VERIFIED',nasa:true,title:'NASA: Earth to Mars takes about 7–10 months',url:'https://www.nasa.gov/directorates/smd/how-long-does-it-take-to-get-to-the-moon-mars-jupiter-we-asked-a-nasa-expert-episode-51/',use:'Trip length drives energy use, climate exposure and the chance of failures.'},
{label:'VERIFIED',nasa:true,title:'NASA Mars Fact Sheet: sunlight ~43% of Earth',url:'https://nssdc.gsfc.nasa.gov/planetary/factsheet/marsfact.html',use:'NASA reports Mars sunlight at about 43% of Earth. Separately, the game applies an 85% arrival-power factor as a simplified team rule; it is not converted from the NASA figure.'},
{label:'VERIFIED',nasa:true,title:'NASA Deep Space Network',url:'https://www.nasa.gov/communicating-with-missions/dsn/',use:'Antennas on Earth that talk to spacecraft. The signal-loss event uses it as context.'},
{label:'VERIFIED',nasa:false,title:'ESA Mars Express: signal delay 4–24 min one way',url:'https://blogs.esa.int/mex/2012/08/05/time-delay-between-mars-and-earth/',use:'Why the spacecraft often has to fix problems on its own.'},
{label:'ADAPTED',nasa:true,title:'JPL Concept Maturity Levels',url:'https://dataverse.jpl.nasa.gov/dataset.xhtml?persistentId=hdl:2014/44299',use:'Design milestones are CML-inspired. The grants are fictional.'},
{label:'VERIFIED',nasa:false,title:'Alford 1969 (Apidologie): diapause 6–9 months',url:'https://link.springer.com/article/10.1007%2Fs13592-017-0529-z',use:'Background for a dormant cargo. Earth conditions only.'},
{label:'SINGLE STUDY',nasa:false,title:'Yoon et al. 2010: 2.5 C and 70% humidity',url:'https://koreascience.kr/article/JAKO201028542317554.pdf',use:'Chamber targets. One lab study, not a space standard.'},
{label:'CONTEXT',nasa:false,title:'Beekman et al. 1998: lab diapause survival',url:'https://conservationevidencejournal.com/individual-study/1690',use:'Longer diapause lowers survival on Earth. Never used as a probability.'},
{label:'VERIFIED',nasa:false,title:'Smithsonian: STS-41-C bees in space (1984)',url:'https://airandspace.si.edu/collection-objects/bee-enclosure-module-sts-41-c/nasm_A19880031000',use:'3,300 honeybees built comb in orbit. Inspiration, not proof for bumblebees.'},
{label:'TEAM',nasa:false,title:'Team table: equipment, rocket, events',url:null,use:'Masses, power, 0.008 km/s per kg, costs, events and the 250 kg / 7.0 km/s / 600 W rocket are team values.'},
{label:'OPEN',nasa:false,title:'Open question: dormant queens in space',url:null,use:'Nobody has flown dormant bumblebee queens to Mars. Risk is a game index, not a survival chance.'}
];
