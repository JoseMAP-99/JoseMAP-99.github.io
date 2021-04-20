//José María Amusquívar Poppe
var g,r,s,pends=[];

function setup(){
  createCanvas(800,600, WEBGL); 
  g=0.5;r=12;s=8;init();  
}

function init(){for(var i=120; i<=500; i+=5) pends.push(new Pend(i-80,i*1.5,PI/4));}

function draw(){  
  background(230);lights();    
  translate(0,-2*height/5,0);
  strokeWeight(0.4);
  line(-width/2,0,width/2,0);
  stroke(0);  
  for(var i=0; i<76; i++) {    
    var p=pends[i];    
    if (i<= s) {    
      push();
      line(0,0,0,p.pos.x,p.pos.y,p.pos.z);translate(p.pos);fill(p.color);noStroke();sphere(r);
      pop();
    }    
    p.upd();    
  }
}

class Pend{   
  constructor(z,l,a){
    this.color=color(random(255));      
    this.lon=l;this.ang=a;
    this.vel=0;this.pos=createVector(0,0,z);
  }  
  upd(){
    this.vel+=(-(g*sin(this.ang))/this.lon);    
    this.ang+=this.vel; 
    this.pos.x=this.lon*sin(this.ang);this.pos.y=this.lon*cos(this.ang); 
  }
}

function mousePressed(){s++;}

function keyPressed(){
  if (key==='+')
    pends=[];s=14;init();
}
