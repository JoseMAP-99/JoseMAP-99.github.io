/* José María Amusquívar Poppe
 * Creando Interfaces de Usuario
 * Planetario -- mintiendo en medidas para mejor ajuste
 */

//--------Objetos personalizados----------//
Points points; // Colección de planetas introducidos por el usuario
Points sats; // Colección de satélites generados para el Sistema solar
Points solar; // Colección de planetas correspondiente al Sistema solar
Planet center; // Estrella central por defecto en modo creación
Help help; // Objeto para mostras mensajes de ayuda

//-------Variables para el fondo del planetario--------//
PImage backG;
int sizeX, sizeY;

//--------Variables para controlar el zoom aplicado---------//
float zoom, countZoom, minScroll, maxScroll;

//-------Variables para controlar el radio de los planetas creados--------//
int radius, minRadius, maxRadius;

//-------Variable que controla la roación vertical-------//
float rotateX;

//--------Contadores de planetas para ambos modos---------------//
int pos, posIni;

//--------Variables de estado----------//
boolean btnHelp, newDraw;

//-------Vector para controlar las pulsaciones---------//
boolean [] keys = new boolean[5];

//-------Listas de valores para el Sistema solar-----------//
float [] radiusP, distP; // Radios y distancias al Sol
String [] paths; // Rutas de texturas de cada planeta

void setup() {
  fullScreen(P3D); // Obliga a usar pantalla completa
  
  //------Carga de fondo y dimensiones de la imagen-----//
  backG = loadImage("media/space.jpg");  
  sizeX = backG.width;
  sizeY = backG.height;
  
  initPlanets(); // Se inicializan los valores el Sistema solar
  
  rotateX = 0; //Rotación vertical
  
  //------Radio de los planetas en modo creación------//
  radius = 30;
  minRadius = 20;
  maxRadius = 200;
  
  //------Zoom aplicado a ambas vistas--------//
  minScroll = -5;
  maxScroll = 10;
  zoom = 1;
  countZoom = 0;
  
  //------Número de planetas de ambas vistas-------//
  pos = 1; // Vista de creación
  posIni = radiusP.length; // Vista de visualización
  
  //-----Variables de estado-----//
  btnHelp = true; // Ayuda activada
  newDraw = false; // Modo creación o visualización
  
  //-------Se crean los planetas del Sistema solar------//
  solar = new Points();
  sats = new Points();
  loadSolar();  
  
  //------Se crea la estrella central del modo creación-----//
  points = new Points();
  center = new Planet(50, 0, 0); //Radio, distancia al centro, ángulo de inicio
  points.appendItem(center);
  
  help = new Help(); // Objeto de ayuda
}

void initPlanets() {
  radiusP = new float[]{80, 8, 12, 12, 18, 35, 30, 23, 22, 5};
  distP = new float[]{0, 100, 140, 170, 250, 325, 425, 500, 575, 625};
  paths = new String[]{"media/sol.png", "media/mercurio.png", 
                       "media/venus.png", "media/tierra.jpg", 
                       "media/marte.jpg", "media/jupiter.jpg",
                       "media/saturno.jpg", "media/urano.jpg",
                       "media/urano.jpg", "media/pluton_casi_planeta.jpg"}; 
}

void draw() {
  //-------Se comprueba si la ayuda está activada-------//
  if (btnHelp){  
    help.drawTextHelp();
    help.drawSquareHelp();
    help.drawStartButton();
    return;
  }
  
  //------Comprobación del tamaño de pantalla y dibujado--------//
  if (width != sizeX || height != sizeY) {
    backG.resize(width, height);      
  }
  
  background(backG);   
  help.drawSquareHelp();
  help.drawNewPlanets();
  
  //------Modo creación o modo visualización-------//    
  if (newDraw){    
    help.drawInfo();
    drawPlanets(false);    
  }else{
    help.drawSystem();
    drawPlanets(true);
    if (!newDraw) drawSats();
  }
  moveShape();
}

void loadSolar() {
  Planet pt; 
  Planet sat; 
  for (int i = 0; i < posIni; i++) {
    //----Se crea cada planeta y se asigna su textura----//
    pt = new Planet(radiusP[i], distP[i], random(0, 360));
    solar.appendItem(pt);
    pt.setTexture(loadImage(paths[i]));
    
    //-----Se crea un satélite para cada planeta-----//
    pushMatrix();
    translate(pt.x, pt.y, pt.z);
    sat = new Planet(5, pt.radius + 5, random(0, 360));    
    sats.appendItem(sat);  
    popMatrix();
  }
}

void drawSats() {
  //-----Se dibuja la Luna-----//  
  Planet planet = sats.getItem(3);        
  pushMatrix();   
  translate(width/2, height/2, -150);
  noFill(); 
  rotateX((-PI/8)+rotateX);
  scale(zoom);
  translate(solar.getItem(3).x, solar.getItem(3).y, solar.getItem(3).z);   
  translate(planet.x, planet.y, planet.z);        
  planet.runPlanet();    
  popMatrix();
  
  //-----Actualización de ángulos y coordenadas------//
  planet.updateAngle();
  planet.updateCoords(); 
    
  //------Se dibujan los anillos de Saturno-----//
  planet = sats.getItem(6);   
  pushMatrix();   
  translate(width/2, height/2, -150);
  rotateX((-PI/8)+rotateX);      
  scale(zoom);
  translate(solar.getItem(6).x, solar.getItem(6).y, solar.getItem(6).z);        
  rotateX((PI/2.66)+rotateX);
  
  //----Los anillos están compuestos por varias figuras 'ellipse()'
  stroke(195, 150, 74);
  for (int j = 0; j <= 24; j+=2){        
    ellipse(0, 0, 2*planet.dist+j, (2*planet.dist)+j);
  }
  
  noStroke();
  popMatrix(); 
  
  //-----Actualización de ángulos y coordenadas------//
  planet.updateAngle();
  planet.updateCoords(); 
}

void drawPlanets(boolean isSolar) {
  //-----Se comprueba el modo en el que se encuentra-----//
  int aux = isSolar ? posIni : pos;
  for (int i = 0; i < aux; i++){
    
    //----Según el modo, se obtiene un planeta de las colecciones-----//
    Planet planet = isSolar ? solar.getItem(i) : points.getItem(i);
    
    //------Trazado de la óribta--------//
    pushMatrix();
    translate(width/2, height/2, -150);
    rotateX((PI/2.66)+rotateX);
    scale(zoom);
    ellipse(0, 0, 2*planet.dist, (2*planet.dist));
    popMatrix();
    
    //--------Dibujado del planeta actual--------//
    pushMatrix();   
    translate(width/2, height/2, -150);
    noFill(); 
    rotateX((-PI/8)+rotateX);
    scale(zoom);
    translate(planet.x, planet.y, planet.z);    
    planet.runPlanet();    
    popMatrix();
    
    //--------Actualización de ángulos y coordenadas----------//
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
    radius = 30;
    zoom = 1;
    countZoom = 0;
    points.clearList();
    points.appendItem(center);
  }
}

void moveShape() {  
  if(keys[0]) {
    rotateX -= 0.1;
  }
  
  if(keys[1]){
    rotateX += 0.1;
  } 
  
  if (keys[4]) {
    points.removeLast();
    pos--;
    keys[4] = false;
  }
  
  if(keys[2] && radius < maxRadius) {
    radius++;
  } 
  
  if(keys[3] && radius > minRadius){
    radius--;
  } 
}

void setMovement(int k, boolean b) {
  switch (k) {      
      case 'W':
      case 'w':
        keys[0] = b;
        break;
      case 'S':
      case 's':
        keys[1] = b;
        break;
      case '+':
        keys[2] = b;
        break;
      case '-':
        keys[3] = b;
        break;
      case CODED:
        if(keyCode == UP){
          keys[0] = b;
        }else if(keyCode == DOWN){
          keys[1] = b;
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
  
  if ((key == 'X' || key == 'x') && pos > 1 && newDraw){
    keys[4] = true;  
  } 
}
