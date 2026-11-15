// Original chiptune: two melodic phrases, arpeggiated harmony and triangle bass.
export class ChipAudio {
 constructor(){this.ctx=null;this.timer=null;this.step=0;this.music=.25;this.sfx=.4;try{const s=JSON.parse(localStorage.getItem('beeyond-audio'));if(s){this.music=s.music;this.sfx=s.sfx;}}catch{} }
 async start(){this.ctx??=new AudioContext();await this.ctx.resume();if(!this.timer){this.next=this.ctx.currentTime+.06;this.timer=setInterval(()=>this.schedule(),80);}}
 note(midi,time,len,volume,type='square'){if(!this.ctx||volume<=0)return;const o=this.ctx.createOscillator(),g=this.ctx.createGain();o.type=type;o.frequency.value=440*2**((midi-69)/12);g.gain.setValueAtTime(0,time);g.gain.linearRampToValueAtTime(volume,time+.008);g.gain.exponentialRampToValueAtTime(.0001,time+len);o.connect(g);g.connect(this.ctx.destination);o.start(time);o.stop(time+len+.02);}
 schedule(){if(this.ctx.state!=='running')return;const melody=[72,0,76,79,0,76,74,0,72,0,67,0,69,72,0,0,74,0,77,81,0,79,77,0,76,0,74,72,0,67,0,0];while(this.next<this.ctx.currentTime+.2){const i=this.step%32,bass=[48,45,53,55][Math.floor(i/8)];if(melody[i])this.note(melody[i],this.next,.24,this.music*.085);this.note(bass+[12,19,24,19][i%4],this.next,.13,this.music*.035,'triangle');if(i%4===0)this.note(bass,this.next,.5,this.music*.16,'triangle');this.next+=.205;this.step++;}}
 effect(kind='click'){if(!this.ctx)return;const notes={click:[76],equip:[72,79],error:[48,46],advance:[60,67,72],success:[72,76,79,84]}[kind]||[76];notes.forEach((n,i)=>this.note(n,this.ctx.currentTime+i*.075,.12,this.sfx*.12));}
 set(k,v){this[k]=Number(v);try{localStorage.setItem('beeyond-audio',JSON.stringify({music:this.music,sfx:this.sfx}));}catch{}}
 pause(){if(this.ctx)this.ctx.suspend();}resume(){if(this.ctx){this.next=this.ctx.currentTime+.06;this.ctx.resume();}}
}
