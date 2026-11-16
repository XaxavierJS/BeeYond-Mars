// Hand-built tile spaces. Furniture uses simple collision rectangles; no external art.
export const TILE=16;
export const MAPS={
home:{w:480,h:320,name:['La habitación de Lum','Lum’s room'],floor:'wood',spawn:[240,238],objects:[
{id:'bed',kind:'bed',x:64,y:68,w:64,h:64,label:['Cama','Bed']},
{id:'desk',kind:'desk',x:296,y:75,w:100,h:40,label:['Escritorio','Desk']},
{id:'box',kind:'box',x:128,y:208,w:28,h:28,label:['Caja sin cerrar','Unpacked box']},
{id:'plant',kind:'plant',x:400,y:190,w:24,h:24,label:['La última planta','The last plant']},
{id:'shelf',kind:'shelf',x:176,y:44,w:64,h:28,label:['Estante','Shelf']},
{id:'letter',kind:'letter',x:245,y:270,w:15,h:12,label:['Carta de Aurelia','Aurelia’s letter'],walk:true},
{id:'out',kind:'door',x:224,y:290,w:32,h:18,label:['Salir al pueblo','Go outside'],walk:true,to:'town',at:[125,162]}
]},
town:{w:832,h:576,name:['El jardín de las órbitas','The garden of orbits'],floor:'grass',spawn:[125,175],objects:[
{id:'home',kind:'house',x:64,y:48,w:128,h:88,label:['Volver a casa','Go home'],to:'home',at:[240,260]},
{id:'workshop',kind:'house',x:320,y:48,w:128,h:88,label:['Taller de Pip','Pip’s workshop'],to:'workshop',at:[240,260]},
{id:'garden',kind:'house',x:64,y:336,w:144,h:88,label:['Jardín de Nim','Nim’s garden'],to:'garden',at:[240,260]},
{id:'station',kind:'house',x:560,y:336,w:144,h:88,label:['Estación de Eko','Eko’s station'],to:'station',at:[240,260]},
{id:'lab',kind:'house',x:624,y:48,w:144,h:104,label:['Laboratorio Aurelia','Aurelia laboratory'],to:'lab',at:[240,270]},
{id:'bench',kind:'bench',x:344,y:275,w:60,h:18,label:['El banco de siempre','The old bench']},
{id:'tree1',kind:'tree',x:236,y:80,w:35,h:40,label:['Árbol','Tree']},
{id:'tree2',kind:'tree',x:480,y:148,w:35,h:40,label:['Árbol','Tree']},
{id:'tree3',kind:'tree',x:230,y:398,w:35,h:40,label:['Árbol','Tree']},
{id:'tree4',kind:'tree',x:740,y:280,w:35,h:40,label:['Árbol','Tree']},
{id:'pond',kind:'pond',x:365,y:382,w:116,h:75,label:['Estanque','Pond']}
]},
workshop:{w:480,h:320,name:['Taller · una cosa a la vez','Workshop · one thing at a time'],floor:'stone',spawn:[240,260],objects:[
{id:'Pip',kind:'npc',role:0,x:324,y:154,w:20,h:26,label:['Pip','Pip']},
{id:'switch',kind:'switch',x:88,y:128,w:24,h:24,label:['Interruptor de la radio','Radio switch']},
{id:'radio',kind:'radio',x:182,y:92,w:70,h:40,label:['Radio averiada','Broken radio']},
{id:'tools',kind:'shelf',x:340,y:55,w:72,h:35,label:['Herramientas','Tools']},
{id:'out',kind:'door',x:224,y:290,w:32,h:18,label:['Volver al pueblo','Go outside'],walk:true,to:'town',at:[384,166]}
]},
garden:{w:480,h:320,name:['Jardín · las cosas pequeñas','Garden · small things'],floor:'garden',spawn:[240,260],objects:[
{id:'Nim',kind:'npc',role:1,x:344,y:174,w:20,h:26,label:['Nim','Nim']},
{id:'flowers',kind:'flowers',x:88,y:84,w:100,h:45,label:['Semillero seco','Dry flower bed']},
{id:'hive',kind:'hive',x:275,y:80,w:44,h:40,label:['Observar abejorros','Watch the bumblebees']},
{id:'notes',kind:'desk',x:365,y:62,w:68,h:30,label:['Cuaderno de campo','Field notebook']},
{id:'out',kind:'door',x:224,y:290,w:32,h:18,label:['Volver al pueblo','Go outside'],walk:true,to:'town',at:[136,450]}
]},
station:{w:480,h:320,name:['Estación · alguien escucha','Station · someone is listening'],floor:'stone',spawn:[240,260],objects:[
{id:'Eko',kind:'npc',role:2,x:320,y:170,w:20,h:26,label:['Eko','Eko']},
{id:'message',kind:'console',x:182,y:75,w:96,h:45,label:['Mensaje a Aurelia','Message to Aurelia']},
{id:'window',kind:'window',x:64,y:64,w:64,h:32,label:['Mirar el cielo','Look at the sky']},
{id:'out',kind:'door',x:224,y:290,w:32,h:18,label:['Volver al pueblo','Go outside'],walk:true,to:'town',at:[632,450]}
]},
lab:{w:480,h:320,name:['Laboratorio · una mesa para cuatro','Laboratory · a table for four'],floor:'lab',spawn:[240,270],objects:[
{id:'bio',kind:'hive',x:64,y:80,w:64,h:45,label:['Cámara biológica','Biological chamber']},
{id:'engineering',kind:'desk',x:340,y:80,w:88,h:40,label:['Banco de ingeniería','Engineering bench']},
{id:'comms',kind:'console',x:64,y:200,w:72,h:35,label:['Instrumentos y enlace','Instruments and link']},
{id:'chart',kind:'chart',x:208,y:55,w:64,h:38,label:['Mapa de trayectorias','Trajectory map']},
{id:'review',kind:'table',x:208,y:160,w:64,h:32,label:['Reunir al equipo','Gather the team']},
{id:'launch',kind:'door',x:400,y:224,w:32,h:25,label:['Camino al cohete','Board the rocket'],walk:true},
{id:'out',kind:'door',x:224,y:290,w:32,h:18,label:['Volver al pueblo','Go outside'],walk:true,to:'town',at:[696,180]}
]},
ship:{w:480,h:320,name:['A bordo · lejos, pero juntos','On board · far, but together'],floor:'ship',spawn:[240,250],objects:[
{id:'helm',kind:'console',x:208,y:55,w:64,h:35,label:['Continuar el viaje','Continue the voyage']},
{id:'chamber',kind:'hive',x:72,y:128,w:64,h:40,label:['Cuidar la cámara','Check the chamber']},
{id:'repair',kind:'radio',x:360,y:128,w:64,h:35,label:['Sistemas de la nave','Ship systems']},
{id:'Pip',kind:'npc',role:0,x:338,y:190,w:20,h:26,label:['Pip','Pip']},
{id:'Nim',kind:'npc',role:1,x:128,y:214,w:20,h:26,label:['Nim','Nim']},
{id:'Eko',kind:'npc',role:2,x:286,y:124,w:20,h:26,label:['Eko','Eko']}
]},
mars:{w:480,h:320,name:['Invernadero · otro comienzo','Greenhouse · another beginning'],floor:'garden',spawn:[240,260],objects:[
{id:'habitat',kind:'hive',x:72,y:100,w:64,h:40,label:['Despertar con cuidado','Wake carefully']},
{id:'climate',kind:'console',x:350,y:90,w:64,h:36,label:['Preparar el ambiente','Prepare the habitat']},
{id:'seedbed',kind:'flowers',x:192,y:150,w:96,h:40,label:['Dar lugar a las flores','Make room for flowers']},
{id:'transmit',kind:'radio',x:350,y:220,w:64,h:30,label:['Compartir lo aprendido','Share what we learned']},
{id:'memory',kind:'table',x:66,y:230,w:60,h:24,label:['La carta que trajimos','The letter we carried']}
]}
};
export function visibleObjects(s){return MAPS[s.map].objects.filter(o=>o.id!=='letter'||s.flags.letterArrived&&!s.flags.grant);}
export function blocked(s,x,y){const m=MAPS[s.map];if(x<22||x>m.w-22||y<45||y>m.h-17)return true;return visibleObjects(s).some(o=>!o.walk&&x>o.x-7&&x<o.x+o.w+7&&y>o.y-3&&y<o.y+o.h+4);}
export function nearObject(s){return visibleObjects(s).map(o=>({o,d:Math.hypot(s.x-(o.x+o.w/2),s.y-(o.y+o.h+10))})).filter(p=>p.d<47).sort((a,b)=>a.d-b.d)[0]?.o;}
export function move(s,dx,dy,dt){const len=Math.hypot(dx,dy)||1;let nx=s.x+dx/len*82*dt,ny=s.y+dy/len*82*dt;if(!blocked(s,nx,s.y))s.x=nx;if(!blocked(s,s.x,ny))s.y=ny;}
export function enter(s,id,at){if(!MAPS[id])return;s.map=id;[s.x,s.y]=at||MAPS[id].spawn;}
export function newStory(mission){return {version:13,lang:'en',map:'home',x:240,y:238,mission,flags:{},memories:[],friends:[],carry:null,radioOn:true,radioFixed:false,careDay:-1,ending:0};}
export function remember(s,id){if(!s.memories.includes(id))s.memories.push(id);}
export function validStory(s,validateMission){return !!s&&s.version===13&&MAPS[s.map]&&Number.isFinite(s.x)&&Number.isFinite(s.y)&&s.x>=0&&s.y>=0&&['es','en'].includes(s.lang)&&s.flags&&Array.isArray(s.memories)&&Array.isArray(s.friends)&&validateMission(s.mission);}
