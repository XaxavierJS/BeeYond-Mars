import {CFG,ITEMS,LAUNCHERS,ROUTES} from './data.js';
const copy=s=>structuredClone(s); const clamp=(n,a=0,b=100)=>Math.max(a,Math.min(b,n));
export const item=id=>ITEMS.find(i=>i.id===id);
export const route=s=>ROUTES.find(r=>r.id===s.route);
export const launcher=s=>LAUNCHERS.find(r=>r.id===s.launcher);
export function fresh(players=1){return {version:CFG.version,phase:'lab',players:clamp(players,1,4),role:1,parts:[],route:'standard',launcher:'medium',grants:[],compared:[],day:0,log:[],flight:null,attempt:1};}
export function stats(s){const p=s.parts.map(item),l=launcher(s);const cost=p.reduce((a,i)=>a+i.cost,0)+l.cost;const kg=p.reduce((a,i)=>a+i.kg,0);const power=l.power+p.reduce((a,i)=>a+i.gen,0);return {cost,kg,use:p.reduce((a,i)=>a+i.w,0),power,arrivalPower:power*CFG.solarArrival,dv:l.dv-kg*CFG.dvPerKg,budget:CFG.budget+s.grants.reduce((a,i)=>a+CFG.grants[i],0)-cost};}
export function log(s,en,es=en){s.log.push({day:s.day,en,es});}
export function errors(s){const t=stats(s),l=launcher(s),r=route(s),e=[];
if(!s.parts.some(k=>item(k).kind==='chamber'))e.push(['Install a biological chamber.','Instala una cámara biológica.']);
if(t.kg>l.cap)e.push([`Mass ${t.kg} kg exceeds ${l.cap} kg.`,`La masa ${t.kg} kg supera ${l.cap} kg.`]);
if(t.use>t.power)e.push(['Insufficient departure power. Install solar wings.','Falta potencia de salida. Instala paneles.']);
if(t.dv<r.dv)e.push(['Insufficient delta-v for this transfer.','Falta delta-v para esta transferencia.']);
if(!l.mars)e.push(['This launcher only reaches Earth orbit.','Este lanzador solo alcanza la órbita terrestre.']);
if(t.budget<0)e.push(['Design exceeds available funding.','El diseño supera los fondos.']);
if(r.days<210||r.days>300)e.push(['Transfer outside the direct 7–10 month MVP.','Transferencia fuera del MVP de 7–10 meses.']);return e;}
export function milestone(s){if(errors(s).length===0&&s.grants.length===2)return 4;if(s.grants.includes(1))return 3;if(s.grants.includes(0))return 2;return 1;}
export function claim(s0,i){const s=copy(s0);if(s.phase!=='lab'||s.grants.includes(i))return s;
const t=stats(s);const ok=i===0?s.parts.some(k=>item(k).kind==='chamber')&&t.use<=t.power&&t.kg<=launcher(s).cap:s.grants.includes(0)&&s.compared.length>=2;
if(ok){s.grants.push(i);log(s,`Design milestone ${i+2}: +${CFG.grants[i]} credits.`,`Hito de diseño ${i+2}: +${CFG.grants[i]} créditos.`);}return s;}
export function toggle(s0,id){const s=copy(s0),p=item(id);if(!p||s.phase!=='lab'||(s.players>1&&p.role!==s.role))return s;
if(s.parts.includes(id))s.parts=s.parts.filter(k=>k!==id);else {if(p.kind==='chamber')s.parts=s.parts.filter(k=>item(k).kind!=='chamber');s.parts.push(id);}if(stats(s).budget<0)return s0;return s;}
export function chooseLauncher(s0,id){if(!LAUNCHERS.some(l=>l.id===id)||!['lab','launch'].includes(s0.phase))return s0;const s=copy(s0);s.launcher=id;if(stats(s).budget<0)return s0;return s;}
export function selectRoute(s0,id){if(!ROUTES.some(r=>r.id===id)||!['lab','launch'].includes(s0.phase))return s0;const s=copy(s0);s.route=id;if(!s.compared.includes(id))s.compared.push(id);return s;}
export function launch(s0){if(errors(s0).length||milestone(s0)<4||s0.phase!=='launch')return s0;const s=copy(s0);s.phase='voyage';s.day=0;s.flight={charge:CFG.batteryWh,temp:CFG.baseTemp,humidity:CFG.baseHumidity,risk:0,stored:0,sent:0,lost:0,generated:0,energy:0,outages:0,pending:null,resolved:[],coolingFault:false,blackout:0,lowTelemetry:false,integrity:100};log(s,`Launch. ${route(s).days}-day transfer; ${stats(s).kg} kg payload.`,`Despegue. Tránsito de ${route(s).days} días; carga de ${stats(s).kg} kg.`);return s;}
export const delay=s=>4+20*(s.day/route(s).days);
export function advance(s0){if(s0.phase!=='voyage'||s0.flight.pending)return s0;const s=copy(s0),f=s.flight,t=stats(s);const days=Math.min(CFG.stageDays,route(s).days-s.day);s.day+=days;const ratio=s.day/route(s).days;const gen=t.power*(1-(1-CFG.solarArrival)*ratio),hours=days*24;f.energy+=t.use*hours;
const raw=f.charge+(gen-t.use)*hours;f.charge=clamp(raw,0,CFG.batteryWh);const out=raw<0;f.outages=out?f.outages+1:0;
const active=s.parts.includes('chamberA'),sensor=s.parts.includes('thermal');const drift=active?0.05:(sensor?0.16:0.48);
f.temp=CFG.baseTemp+(f.temp-CFG.baseTemp)*(active?0.18:0.65)+drift+(out?5:0)+(f.coolingFault?3:0);
f.humidity=clamp(CFG.baseHumidity+(f.humidity-CFG.baseHumidity)*0.65-drift*2-(out?10:0)-(f.coolingFault?6:0));
const exposure=Math.max(0,f.temp-4)*5+Math.max(0,60-f.humidity)*0.5+(active?0:1.5);f.risk=clamp(f.risk+exposure*days/30);f.integrity=clamp(f.integrity-(out?30:0));
const produced=(s.parts.includes('dosimeter')?32:24)*(f.lowTelemetry?0.5:1)*days/30;f.generated+=produced;const available=f.stored+produced;const throughput=(s.parts.includes('antenna')?64:16)*days/30;const sent=(f.blackout>0||out)?0:Math.min(available,throughput);f.sent+=sent;f.lost+=Math.max(0,available-sent-CFG.storageMB);f.stored=Math.min(CFG.storageMB,available-sent);if(f.blackout>0)f.blackout--;
log(s,`${days} days: ${Math.round(gen)} W / ${t.use} W; ${f.charge.toFixed(0)} Wh; risk ${f.risk.toFixed(0)}; +${sent.toFixed(0)} MB received.`,`${days} días: ${Math.round(gen)} W / ${t.use} W; ${f.charge.toFixed(0)} Wh; riesgo ${f.risk.toFixed(0)}; +${sent.toFixed(0)} MB recibidos.`);
if(f.outages>=2||f.risk>=CFG.criticalRisk||f.integrity<=0){s.phase='report';return s;}
if(s.day>=90&&!f.resolved.includes('thermal'))f.pending='thermal';else if(s.day>=180&&!f.resolved.includes('comms'))f.pending='comms';else if(s.day>=route(s).days)s.phase='report';return s;}
export function options(s){const f=s.flight;if(f?.pending==='thermal')return [
{id:'autonomy',name:['Let onboard control reroute power','Activar control autónomo'],desc:['Pause this stage’s downlink. Stabilize climate; lose up to 16 MB received.','Pausa la transmisión de esta etapa. Estabiliza el clima; hasta −16 MB recibidos.'],disabled:false},
{id:'reserve',name:['Use emergency battery','Usar batería de emergencia'],desc:['Spend 600 Wh on the cooling pulse; keep data.','Gasta 600 Wh en refrigeración; conserva los datos.'],disabled:f.charge<600},
{id:'earth',name:['Wait for Earth instructions','Esperar instrucciones terrestres'],desc:[`Round trip: ${Math.round(delay(s)*2)} min. Deadline: 20 min. If late: +6 °C, −18% RH, +25 risk and continuing heat leak.`,`Ida y vuelta: ${Math.round(delay(s)*2)} min. Plazo: 20 min. Si llega tarde: +6 °C, −18% HR, +25 riesgo y fuga térmica persistente.`],disabled:false}];
if(f?.pending==='comms')return [
{id:'compress',name:['Prioritize essential telemetry','Priorizar telemetría esencial'],desc:['Transmit stored data now; halve future science generation.','Transmite los datos guardados; reduce a la mitad la ciencia futura.'],disabled:false},
{id:'buffer',name:['Keep full observations','Mantener observaciones completas'],desc:[`No downlink for 60 days. Buffer ${Math.round(f.stored)}/${CFG.storageMB} MB; overflow is lost.`,`Sin transmisión durante 60 días. Memoria ${Math.round(f.stored)}/${CFG.storageMB} MB; el exceso se pierde.`],disabled:false}];return [];}
export function resolve(s0,id){const o=options(s0).find(o=>o.id===id);if(!o||o.disabled)return s0;const s=copy(s0),f=s.flight;
if(f.pending==='thermal'){if(id==='reserve'){f.charge-=600;f.energy+=600;}if(id==='autonomy'){const lost=Math.min(16,f.sent);f.sent-=lost;f.lost+=lost;}if(id==='earth'&&delay(s)*2>20){f.temp+=6;f.humidity-=18;f.risk=clamp(f.risk+25);f.coolingFault=true;}}
if(f.pending==='comms'){if(id==='compress'){f.sent+=f.stored;f.stored=0;f.lowTelemetry=true;}else f.blackout=2;}
log(s,`${f.pending}: ${o.name[0]}. ${o.desc[0]}`,`${f.pending}: ${o.name[1]}. ${o.desc[1]}`);f.resolved.push(f.pending);f.pending=null;if(s.day>=route(s).days||f.risk>=CFG.criticalRisk)s.phase='report';return s;}
export function report(s){const f=s.flight,arrived=s.day>=route(s).days&&f.outages<2&&f.integrity>0;const kind=!arrived||f.risk>=CFG.criticalRisk?'failure':f.risk>35||f.sent<100||f.lost>64?'partial':'success';return {kind,arrived,score:Math.max(0,Math.round((arrived?100:0)+(100-f.risk)+f.sent/4-f.lost/4)),reason:!arrived?(f.outages>=2?'power':'climate'):f.risk>35?'climate':f.sent<100||f.lost>64?'data':'balanced'};}
export function redesign(s0){const s=copy(s0);s.phase='lab';s.day=0;s.flight=null;s.attempt++;s.log=[];log(s,'New design attempt. Equipment and earned grants retained.','Nuevo intento. Se conservan las piezas y los hitos obtenidos.');return s;}
export function validSave(s){return !!s&&s.version===CFG.version&&['lab','launch','voyage','report'].includes(s.phase)&&Number.isInteger(s.players)&&s.players>=1&&s.players<=4&&Array.isArray(s.parts)&&s.parts.every(k=>item(k))&&new Set(s.parts).size===s.parts.length&&s.parts.filter(k=>item(k).kind==='chamber').length<=1&&ROUTES.some(r=>r.id===s.route)&&LAUNCHERS.some(l=>l.id===s.launcher)&&Array.isArray(s.grants)&&s.grants.every(i=>i===0||i===1)&&new Set(s.grants).size===s.grants.length&&Array.isArray(s.compared)&&Array.isArray(s.log)&&Number.isInteger(s.role)&&s.role>=0&&s.role<=3&&Number.isFinite(s.day)&&s.day>=0&&s.day<=route(s).days&&stats(s).budget>=0&&(!['voyage','report'].includes(s.phase)||(s.flight&&['charge','temp','humidity','risk','stored','sent','lost','energy','integrity','generated','outages'].every(k=>Number.isFinite(s.flight[k]))&&Array.isArray(s.flight.resolved)&&[null,'thermal','comms'].includes(s.flight.pending)));}
