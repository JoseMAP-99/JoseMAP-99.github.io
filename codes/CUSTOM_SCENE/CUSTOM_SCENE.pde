/* José María Amusquívar Poppe
 * Creando Interfaces de Usuario
 * Escena personalizada
 */

//--------Objetos personalizados----------//
Help help; // Objeto para mostrar mensajes de ayuda
Person mario; // Objeto encargado del personaje de la aplicación
Structure [] structs; // Colección de estructuras

//--------Variables de estado----------//
boolean btnHelp, fpView, controlsMario;

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

void setup() {
  fullScreen(P3D); // Obliga a usar pantalla completa
  
  //------Carga de fondo y dimensiones de la imagen-----//
  backG = loadImage("media/background.jpg");
  sizeX = backG.width;
  sizeY = backG.height;
  
  //-----Variables de estado-----//
  btnHelp = true; // Ayuda activada
  fpView = false; // Modo primera o tercera persona
  controlsMario = false; // Tipo de controles a mostrar
  
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
    controlsMario = !controlsMario; 
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
  if (keys[0]) {
    mario.updatePos(1);
  }  
  if (keys[1]) {
    mario.updatePos(-1);
  }
  if (keys[2]) {
    mario.updateAngle(-1);
  }  
  if (keys[3]) {
    mario.updateAngle(1);
  }
  if (keys[9]) {
    mario.updateAngleY(-100);
  }  
  if (keys[10]) {
    mario.updateAngleY(100);
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
