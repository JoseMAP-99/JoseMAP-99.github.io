/* José María Amusquívar Poppe
 * Creando Interfaces de Usuario
 * Planetario -- mintiendo en medidas para mejor ajuste
 */

Points points;
Points solar;
Planet center;
Help help;

PImage backG;

float zoom, countZoom, minScroll, maxScroll;

int radius, minRadius, maxRadius;
int pos, posIni;

boolean btnHelp, newDraw;
boolean [] keys = new boolean[7];

float x, y, z, dist;

float [] radiusP, distP;
String [] paths;

void setup() {
  fullScreen(P3D);
  
  backG = loadImage("media/space.jpg");
  
  initPlanets();
  
  radius = 30;
  minRadius = 20;
  maxRadius = 200;
  
  minScroll = -5;
  maxScroll = 5;
  zoom = 1;
  countZoom = 0;
  
  pos = 1;
  posIni = radiusP.length;
  
  btnHelp = true;
  newDraw = false;
  
  solar = new Points();
  loadSolar();
  
  points = new Points();
  center = new Planet(50, 0, 0); //Radio, distancia al centro, ángulo de inicio
  points.appendItem(center);
  help = new Help();
}

void initPlanets() {
  radiusP = new float[]{80, 8, 12, 12, 18, 35, 30, 23, 22, 5};
  distP = new float[]{0, 100, 140, 170, 250, 325, 400, 475, 550, 600};
  paths = new String[]{"media/sol.png", "media/mercurio.png", 
                       "media/venus.png", "media/tierra.jpg", 
                       "media/marte.jpg", "media/jupiter.jpg",
                       "media/saturno.jpg", "media/urano.jpg",
                       "media/urano.jpg", "media/pluton_casi_planeta.jpg"}; 
}

void draw() {
  //-------Se comprueba si la ayuda está activada-------/
  if (btnHelp){  
    help.drawTextHelp();
    help.drawSquareHelp();
    help.drawStartButton();
    return;
  }
  
  background(backG); 
  
  help.drawSquareHelp();
  help.drawNewPlanets();
    
  if (newDraw){    
    help.drawInfo();
    drawPlanets(false);    
  }else{
    help.drawSystem();
    drawPlanets(true);
  }
  moveShape();
}

void loadSolar() {
  for (int i = 0; i < posIni; i++) {
    solar.appendItem(new Planet(radiusP[i], distP[i], random(0, 360)));
    solar.getItem(i).setTexture(loadImage(paths[i]));
  }
}

void drawPlanets(boolean isSolar) {
  int aux = isSolar ? posIni : pos;
  for (int i = 0; i < aux; i++){
    Planet planet = isSolar ? solar.getItem(i) : points.getItem(i);
    
    pushMatrix();
    translate(width/2, height/2, -150);
    rotateX((PI/2.66)+rotateX);
    rotateY(rotateY);
    scale(zoom);
    ellipse(0, 0, 2*planet.dist, (2*planet.dist));
    popMatrix();
    
    pushMatrix();   
    translate(width/2, height/2, -150);
    noFill(); 
    rotateX((-PI/8)+rotateX);
    rotateY(rotateY);
    scale(zoom);
    translate(planet.x, planet.y, planet.z);    
    rotateX((-PI/8)+rotateX);
    rotateY(rotateY);
    scale(zoom);
    planet.runPlanet();
    popMatrix();
    planet.updateAngle();
    planet.updateCoords();    
  }
}


void mouseWheel(MouseEvent event) {  
  if (event.getCount() < 0 && countZoom > minScroll){    
    zoom -= 0.1;
    countZoom += event.getCount();
  }
  
  if (event.getCount() > 0 && countZoom < maxScroll){
    zoom += 0.1;
    countZoom += event.getCount();
  } 
  
  println(radius);
}

boolean checkNewPlanet(float mouseXPos) {
   float leftPos = 0;
   float rightPos = 0;
   
   if (mouseXPos > width/2) {
      leftPos = mouseXPos - width/2 - radius;
      rightPos = mouseXPos - width/2 + radius;
   }else{
      leftPos = width/2 - mouseXPos - radius;
      rightPos = width/2 - mouseXPos + radius;
   }
   
   print("pos " + leftPos + " " + rightPos + "\n");
   
   for(int i = 0; i < pos; i++) {
     Planet pt = points.getItem(i);
     print((pt.x - pt.radius) + " " + (pt.x + pt.radius) + "\n");
     if (rightPos <= pt.x + pt.radius && rightPos >= pt.x - pt.radius || 
         leftPos >= pt.x - pt.radius && leftPos <= pt.x + pt.radius || 
         rightPos <= -(pt.x + pt.radius) && rightPos >= -(pt.x - pt.radius) ||
         leftPos >= - (pt.x - pt.radius) && leftPos <= -(pt.x + pt.radius)) return false;
   }
   print("------------\n");
   return true;
}

void mousePressed() {    
  if (mouseX > help.getXLeft('H') && mouseX < help.getXRight('H') && mouseY > help.getYUp('H') && mouseY < help.getYDown('H')) {
    btnHelp = !btnHelp; 
    return;
  }
  
  if (mouseX > help.getXLeft('N') && mouseX < help.getXRight('N') && mouseY > help.getYUp('N') && mouseY < help.getYDown('N')) {
    newDraw = !newDraw; 
    rotateX = 0;
    rotateY = 0;
    zoom = 1;
    countZoom = 0;
    return;
  }
  
  if (btnHelp) {
    if (mouseX > help.getXLeft('S') && mouseX < help.getXRight('S') && mouseY > help.getYUp('S') && mouseY < help.getYDown('S')) {
      btnHelp = false;  
    }
    return;
  }
  if (mouseButton == LEFT && newDraw){
    if (!checkNewPlanet(mouseX)) return;
    print("Pintado \n");
    float r = 0;
    float gl = 0;
    if (mouseX > width/2) {
      r = mouseX - width/2;
      gl = 90;
    }else if (mouseX < width/2){
      r = width/2 - mouseX;
      gl = -90;
    }
    points.appendItem(new Planet(radius, r, gl));
    pos++;
  } else if (mouseButton == RIGHT && pos > 1 && newDraw){
    pos = 1;  
    radius = 30;
    rotateX = 0;
    rotateY = 0;
    radius = 30;
    zoom = 1;
    countZoom = 0;
    points.clearList();
    points.appendItem(center);
  }
}

float rotateX = 0;
float rotateY = 0;
void moveShape() {
  if (keys[0]) {
    rotateY -= 0.1;
  } 
  
  if(keys[1]) {
    rotateY += 0.1;
  }
  
  if(keys[2]) {
    rotateX -= 0.1;
  }
  
  if(keys[3]){
    rotateX += 0.1;
  } 
  
  if (keys[4]) {
    points.removeLast();
    pos--;
    keys[4] = false;
  }
  
  if(keys[5] && radius < maxRadius) {
    radius++;
  }else 
  if(keys[6] && radius > minRadius){
    radius--;
  } 
}

void setMovement(int k, boolean b) {
  switch (k) {      
      case 'A':
      case 'a':
        keys[0] = b;
        break;
      case 'D':
      case 'd':
        keys[1] = b;
        break;
      case 'W':
      case 'w':
        keys[2] = b;
        break;
      case 'S':
      case 's':
        keys[3] = b;
        break;
      case '+':
        keys[5] = b;
        break;
      case '-':
        keys[6] = b;
        break;
      case CODED:
        if (keyCode == LEFT){
          keys[0] = b;
        }else if(keyCode == RIGHT){
          keys[1] = b;
        }else if(keyCode == UP){
          keys[2] = b;
        }else if(keyCode == DOWN){
          keys[3] = b;
        }
    }
}

void keyReleased() {
  setMovement(key, false);
}

void keyPressed() {  
  setMovement(key, true);
  
  if (key == 'H' || key == 'h'){
    btnHelp = !btnHelp;  
  }  
  
  if ((key == 'X' || key == 'x') && pos > 1){
    keys[4] = true;  
  } 
}
