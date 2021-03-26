/* José María Amusquívar Poppe
 * Creando Interfaces de Usuario
 * Escena personalizada empleando la cámara
 */
 
import oscP5.*;

//--------Objetos personalizados----------//
Help help; // Objeto para mostrar mensajes de ayuda
Person mario; // Objeto encargado del personaje de la aplicación
Structure [] structs; // Colección de estructuras

//--------Variables de estado----------//
boolean btnHelp, fpView;

int controls;

//-------Vector para controlar las pulsaciones---------//
boolean [] keys = new boolean[11];

//----------Vector de rutas a objetos------------//
String [] paths = new String[] {
  "media/brasil/cristo-redentorstl.obj",
  "media/egipto/pyramid.obj",
  "media/mexico/chichen-itza.obj",
  "media/paris/eiffel-tower.obj",
  "media/roma/coliseum.obj"
  };
  
//------Variables de iluminación---------//
String mode = "NORMAL LIGHTS"; // Variable que especifica el modo de iluminación
int indexFilter = 5; // Variable para controlar las iluminaciones

//----------Variables del espacio expositor-----------//
int widthBox, heightBox, depthBox;

//-------Variables para el fondo del planetario--------//
PImage backG;
int sizeX, sizeY;

//--------Variables que almacenan el color actual--------//
float red, green, blue;

//---------Varibales especiales----------------//
OscP5 oscP5; // Objeto especial de oscP5 en conjunto con FaceOSC
int found; // Indica si se ha encotrado una cara

//----------Variables de datos--------------//
PVector posePosition = new PVector(); // Almacena la posición del rostro
PVector lastPosePosition = new PVector(); // Posición del rostro para comparar
float [] eyebrows; // Almacena los valores de las cejas
float [] lastEyebrows; // Valores de las cejas para comparar
float mouthHeight; // Almacena los valores de la altura de la boca

//----------Variables de control------------//
float tolerance = 1.0; // Nivel de tolerancia entre comparaciones
boolean closed; // Variable de estado para la boca
boolean movement; // Variable de estado para el desplazamiento hacia adelante

//----------Rotaciones del personaje------------//
int rotateMario; // Rotación horizontal
int rotateMarioY; // ROtación vertical

//-----------Variables para representación en vivo----------//
float[] rawArray; // Almacena todos los puntos en crudo del rostro

void setup() {
  //fullScreen(P3D); // Obliga a usar pantalla completa
  size(1000, 1000, P3D);     
  
  rawArray = new float[132]; // Array para valores crudos de FaceOSC
  
  //---------Inicialización del *listener* y sus propiedad--------------//
  oscP5 = new OscP5(this, 8338);
  oscP5.plug(this, "found", "/found");
  oscP5.plug(this, "posePosition", "/pose/position");
  oscP5.plug(this, "poseOrientation", "/pose/orientation");
  oscP5.plug(this, "eyebrowLeftReceived", "/gesture/eyebrow/left");
  oscP5.plug(this, "eyebrowRightReceived", "/gesture/eyebrow/right");
  oscP5.plug(this, "mouthHeightReceived", "/gesture/mouth/height");
  oscP5.plug(this, "rawData", "/raw");
  
  //------Variables de datos-------//
  eyebrows = new float[2];
  lastEyebrows = new float[2];  
  rotateMario = 0;
  rotateMarioY = 0;
  
  //------Variables de estado-------//
  closed = true;
  movement = false;
  
  //------Carga de fondo y dimensiones de la imagen-----//
  backG = loadImage("media/background.jpg");
  sizeX = backG.width;
  sizeY = backG.height;
  
  //-----Variables de estado-----//
  btnHelp = true; // Ayuda activada
  fpView = false; // Modo primera o tercera persona
  controls = 0;
  
  //-----Inicialización de variables principales---------//
  help = new Help();
  mario = new Person();
  structs = new Structure[5];
  
  generateColor(); // Se generan colores iniciales para la iluminación
  initStructs(); // Se crean las estructuras
    
  keys[4] = true; // Luces normales por defecto
  
  //------Medidas del espacio expositor---------//
  widthBox = 20000;
  heightBox = 3000;
  depthBox = 20000;
}

void initStructs() {
  this.structs[0] = new Structure(this.paths[0], new float[]{0, 425, -3000}, 20, "The Christ Redeemer", new float[]{-950, -1500, 0});
  this.structs[1] = new Structure(this.paths[1], new float[]{-4000, 1235, -4000}, 400, "Pyramid of Giza", new float[]{-500, -700, 0});
  this.structs[2] = new Structure(this.paths[2], new float[]{-6000, 1730, 0}, 500, "Chichen Itza", new float[]{-600, -2500, 0});
  this.structs[3] = new Structure(this.paths[3], new float[]{0, 1610, 6000}, 6, "The Eiffel Tower", new float[]{-850, -2800, 0});
  this.structs[4] = new Structure(this.paths[4], new float[]{6000, 1500, 0}, 3000, "Roman Colosseum", new float[]{-800, -1500, 0});
}

void draw() { 
  //-------Se comprueba si la ayuda está activada-------//
  if (btnHelp){  
    camera(); 
    help.drawTextHelp();
    help.drawSquareHelp(0);
    help.drawStartButton();
    help.drawOwner();
    help.drawControls();
    return;
  }  
  
  //------Comprobación del tamaño de pantalla y dibujado--------//
  if (width != sizeX || height != sizeY) {
    backG.resize(width, height);      
  }  
  background(backG); 
  
  //------Dibujado del rostro con puntos y aristas-------//
  camera();
  translate(width/11, height/7, 0);
  scale(3);
  drawFacePoints(); 
  drawFacePolygons();
  
  //-------Se ejecuta cuando encuentra un rostro--------//    
  if(found > 0) {    
    
    //-------Comprueba el desplazamiento hacia adelante-------//
    if (eyebrows[0] > (lastEyebrows[0] + tolerance) && eyebrows[1] > (lastEyebrows[1] + tolerance)) {
      movement = true;
    }else{
      movement = false;  
    }
    
    //-------Comprueba la rotación horizontal---------//
    if (posePosition.x > (lastPosePosition.x + 15*tolerance)) {
      rotateMario = -1;
    }else if (posePosition.x < (lastPosePosition.x - 15*tolerance)){
      rotateMario = 1;  
    }else{
      rotateMario = 0;  
    }
    
    //-------Comprueba la rotación vertical----------//
    if (posePosition.y > (lastPosePosition.y + 15*tolerance)) {
      rotateMarioY = -1;
    }else if (posePosition.y < (lastPosePosition.y - 15*tolerance)){
      rotateMarioY = 1;  
    }else{
      rotateMarioY = 0;  
    }
    
    //--------Cammbia la iluminación con la boca-------//
    if (mouthHeight > 4 && !closed){
      if (indexFilter > 4) keys[indexFilter-1] = false;
      if (indexFilter == 4) keys[8] = false;
      keys[indexFilter] = true;
      
      indexFilter++;
      if (indexFilter >= 9) indexFilter = 4;
      closed = true;
    }    
  }
  
  //------Comprobación del modo de cámara--------//
  if (fpView) { // Primera persona
    camera(mario.x, mario.y, mario.z,
           mario.getFarFocus()[0], mario.angleY, mario.getFarFocus()[1],
           0.0, 1.0, 0.0); // upX, upY, upZ
           
  }else{ // Tercera persona
    camera(mario.getCloseFocus()[0], mario.y - 100, mario.getCloseFocus()[1],
          mario.getFarFocus()[0], mario.angleY, mario.getFarFocus()[1],
          0.0, 1.0, 0.0);      
    
  }
   
  //-------Dibujado del espacio y mensajes-------//
  drawPlane();  
  pushMatrix();
  camera();  
  help.drawSquareHelp(0);
  help.drawSystem();
  popMatrix(); 
    
  //-------Selección de iluminación--------//
  if (keys[4]) {
    lights();
    mode = "NORMAL LIGHT";
  }
  if (keys[5]) {
    pointLight((int)255*red, (int)255*green, (int)255*blue, mouseX, mouseY, 400);
    lightSpecular(100, 100, 100);
    directionalLight(0.8, 0.8, 0.8, 0, 0, -1);
    mode = "SPECULAR LIGHT";
  }
  if (keys[6]) {
    float val = (float) mouseX/(float) width * (float) 255;
    ambientLight( (int) val*red, 255*green, 255*blue);
    directionalLight(50, 200, 50, -1, 0, 0);
    pointLight(204, 153, 0, mouseX, mouseY, 400);
    mode = "SPOT LIGHT";
  }
  if (keys[7]) {
    float val = (float) mouseX/(float) width * (float) 255;
    ambientLight( (int) val*red, 255*green, 255*blue);
    directionalLight(50, 200, 50, -1, 0, 0);
    spotLight(204, 153, 100, mouseX, mouseY, 500, 0, 0, -1, PI/2, 600);
    mode = "POINT LIGHT";
  } 
  
  if(keys[8]) {    
    ambientLight(20, 20, 20);
    mode = "POINT LIGHT (DARK) --> LEFT CLICK FOR LIGHTS";
    if (mousePressed && mouseButton == LEFT) {
      pointLight(255*red, 255*green, 255*blue, mouseX, mouseY, 400);
      directionalLight(0.8, 0.8, 0.8, 0, 0, -1);
    }    
  }
    
  //------Visualización y actualización de movimiento---------/
  showStructs();  
  mario.runPerson();  
  moveShape();
}

public void rawData(float[] raw) {
  rawArray = raw; // stash data in array
}

//--------------------------------------------
void drawFacePoints() {
  int nData = rawArray.length;
  for (int val=0; val<nData; val+=2) {
    fill(100);
    ellipse(rawArray[val], rawArray[val+1], 0.5, 0.5);
  }
}

//--------------------------------------------
void drawFacePolygons() {
  noFill(); 
  stroke(255); 
 
  // Face outline
  beginShape();
  for (int i=0; i<34; i+=2) {
    vertex(rawArray[i], rawArray[i+1]);
  }
  for (int i=52; i>32; i-=2) {
    vertex(rawArray[i], rawArray[i+1]);
  }
  endShape(CLOSE);
  
  // Eyes
  beginShape();
  for (int i=72; i<84; i+=2) {
    vertex(rawArray[i], rawArray[i+1]);
  }
  endShape(CLOSE);
  beginShape();
  for (int i=84; i<96; i+=2) {
    vertex(rawArray[i], rawArray[i+1]);
  }
  endShape(CLOSE);
  
  // Upper lip
  beginShape();
  for (int i=96; i<110; i+=2) {
    vertex(rawArray[i], rawArray[i+1]);
  }
  for (int i=124; i>118; i-=2) {
    vertex(rawArray[i], rawArray[i+1]);
  }
  endShape(CLOSE);
  
  // Lower lip
  beginShape();
  for (int i=108; i<120; i+=2) {
    vertex(rawArray[i], rawArray[i+1]);
  }
  vertex(rawArray[96], rawArray[97]);
  for (int i=130; i>124; i-=2) {
    vertex(rawArray[i], rawArray[i+1]);
  }
  endShape(CLOSE);
  
  // Nose bridge
  beginShape();
  for (int i=54; i<62; i+=2) {
    vertex(rawArray[i], rawArray[i+1]);
  }
  endShape();
  
  // Nose bottom
  beginShape();
  for (int i=62; i<72; i+=2) {
    vertex(rawArray[i], rawArray[i+1]);
  }
  endShape();
}
 
public void posePosition(float x, float y) {
  if (lastPosePosition.x == 0 || lastPosePosition.y == 0) {
    lastPosePosition.set(x, y, 0);
  }
  posePosition.set(x, y, 0);
}

public void found (int i) {
  found = i;
}

//------Altura de la boca---------//
public void mouthHeightReceived(float h) {
  if (mouthHeight <= 4) closed = false;
  mouthHeight = h;
}

//-------Ceja izquierda--------//
public void eyebrowLeftReceived(float f) {
  if (lastEyebrows[0] == 0) {
    lastEyebrows[0] = f;
  }
  if (f > lastEyebrows[0] + tolerance*3 || f < lastEyebrows[0] - tolerance*3) {
    lastEyebrows[0] = f;   
  }
  if (eyebrows[0] < lastEyebrows[0]) {
    lastEyebrows[0] = eyebrows[0];
  }
  eyebrows[0] = f;  
}

//--------Ceja derecha---------//
public void eyebrowRightReceived(float f) {
  if (lastEyebrows[1] == 0) {
    lastEyebrows[1] = f;
  }
  if (f > lastEyebrows[1] + tolerance*3 || f < lastEyebrows[1] - tolerance*3) {
    lastEyebrows[1] = f;   
  }
  if (eyebrows[1] < lastEyebrows[1]) {
    lastEyebrows[1] = eyebrows[1];
  }
  eyebrows[1] = f; 
}

void drawPlane() {
  pushMatrix();
  fill(0);
  beginShape();    
  vertex(-(widthBox), heightBox/2, depthBox);
  vertex(-(widthBox), heightBox/2, -depthBox);
  vertex((widthBox), heightBox/2, -depthBox);
  vertex((widthBox), heightBox/2, depthBox);
  endShape(CLOSE);  
  popMatrix();
  
}

void showStructs() {
  for (Structure struct : this.structs) {
    struct.runShape();  
  }
}

void generateColor() {
  red = random(1);
  green = random(1);
  blue = random(1);
}

void mouseWheel(MouseEvent event) {  
  if (event.getCount() < 0 && (red > 0 && green > 0 && blue > 0)){    
    red -= 0.1;
    green -= 0.1;
    blue -= 0.1;
  }
  
  if (event.getCount() > 0 && (red < 1 && green < 1 && blue < 1)){
    red += 0.1;
    green += 0.1;
    blue += 0.1;
  }   
}

void mousePressed() {    
  if (mouseX > help.getXLeft('H') && mouseX < help.getXRight('H') && mouseY > help.getYUp('H') && mouseY < help.getYDown('H')) {
    btnHelp = !btnHelp; 
    return;
  }  
    
  if (mouseX > help.getXLeft('S') && mouseX < help.getXRight('S') && mouseY > help.getYUp('S') && mouseY < help.getYDown('S')) {
    btnHelp = false;  
    return;
  }
  
  if (mouseX > help.getXLeft('M') && mouseX < help.getXRight('M') && mouseY > help.getYUp('M') && mouseY < help.getYDown('M')) {
    controls++;
    if (controls >= 3) controls = 0;
    return;
  }
  
  if (mouseButton == RIGHT) {
    if (mode == "NORMAL LIGHT") {
      for (Structure struct : this.structs) {
        struct.getColor();
      }
    }else{
      generateColor();  
    }
  }
}

void moveShape() {  
  if (keys[0] || movement) {
    mario.updatePos(1);
  }  
  if (keys[1]) {
    mario.updatePos(-1);
  }
  if (keys[2] || rotateMario == -1) {
    mario.updateAngle(-1);
  }  
  if (keys[3] || rotateMario == 1) {
    mario.updateAngle(1);
  }
  if (keys[9] || rotateMarioY == 1) {
    mario.updateAngleY(-50);
  }  
  if (keys[10] || rotateMarioY == -1) {
    mario.updateAngleY(50);
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
      case 'A':
      case 'a':
        keys[2] = b;
        break;
      case 'D':
      case 'd':
        keys[3] = b;
        break;
      case 'Q':
      case 'q':
        keys[9] = b;
        break;
      case 'E':
      case 'e':
        keys[10] = b;
        break;
      case CODED:
        if(keyCode == UP){
          keys[0] = b;
        }else if(keyCode == DOWN){
          keys[1] = b;
        }else if(keyCode == LEFT){
          keys[2] = b;
        }else if(keyCode == RIGHT){
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
  
  if (key == 'C' || key == 'c'){
    fpView = !fpView;  
  } 
  
  if (key == 'R' || key == 'r'){
    mario.resetCoords(); 
    eyebrows = new float[2];
    lastEyebrows = new float[2];
    lastPosePosition.set(0, 0, 0);
    posePosition.set(0, 0, 0);
  } 
  
  if (key == ' '){
    if (indexFilter > 4) keys[indexFilter-1] = false;
    if (indexFilter == 4) keys[8] = false;
    keys[indexFilter] = true;
    
    indexFilter++;
    if (indexFilter >= 9) indexFilter = 4;
  }
  
  if (key == '0'){
    indexFilter = 5;
    keys[4] = true; 
    keys[5] = false;
    keys[6] = false;
    keys[7] = false;
    keys[10] = false;
  } 
  
  if (key == '1'){
    indexFilter = 6;
    keys[4] = false;
    keys[5] = true; 
    keys[6] = false;
    keys[7] = false;
    keys[8] = false;
  } 
  
  if (key == '2'){
    indexFilter = 7;
    keys[4] = false;
    keys[5] = false;
    keys[6] = true; 
    keys[7] = false;
    keys[8] = false;
  } 
  
  if (key == '3'){
    indexFilter = 8;
    keys[4] = false;
    keys[5] = false;
    keys[6] = false; 
    keys[7] = true; 
    keys[8] = false;
  } 
  
  if (key == '4'){
    indexFilter = 4;
    keys[4] = false;
    keys[5] = false;
    keys[6] = false; 
    keys[7] = false; 
    keys[8] = true;
  } 
}  
