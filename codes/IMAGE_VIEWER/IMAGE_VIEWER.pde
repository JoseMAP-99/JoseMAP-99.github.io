
//------Variables para shaders------//
PShader edges, pixels, invert, circle;

//-----Variable para imagen actual y fondo------//
PImage actual, backG;

//------Variable de estado y pulsaciones------//
boolean btnHelp; 
boolean [] keys;

//------Dimensiones fijas de las imágenes, se aplica redimensión-----//
static final int widthI = 640, heightI = 427;

 //-------Objetos personales de ayuda-------//
Files files;
Images images;
Help help;

void setup() {
  //------Dimensión fija de la aplicación------//
  size(700, 900, P3D);

  //------Imagen de fondo de la aplicación------//
  backG = loadImage("background.jpg");

  //--------Asignación de los objetos personales-------//
  files = new Files("/images");
  help = new Help();
  images = new Images(files.getFiles());
  actual = images.getNextImage();

  //---------Carga de los distintos shaders------//
  edges = loadShader("shaders/Edges.glsl");
  pixels = loadShader("shaders/Pixels.glsl"); 
  invert = loadShader("shaders/Invert.glsl"); 
  circle = loadShader("shaders/Circle.glsl"); 

  //--------Inicialización de las variables de estado------//
  btnHelp = true;
  keys = new boolean[4];

  //-----Establece el centrado de las imágenes-------//
  imageMode(CENTER);
}

void draw() {
  //-------Se comprueba si la ayuda está activada-------//
  if (btnHelp){  
    help.drawTextHelp();    
    help.drawSquareHelp();
    help.drawStartButton();
    help.drawOwner();
    return;
  }  

  //------Comprobación del tamaño de pantalla y dibujado--------//
  if (width != backG.width || height != backG.height) {
    backG.resize(width, height);      
  }  
  resetShader(); 
  background(backG);  

  //-----Textos de ayuda------//
  help.getActInfo();
  help.getPrevNext();
  help.drawSquareHelp();
  help.drawSystem(); 

  //------Comprobación del tamaño de la imagen actual------//
  if (widthI != actual.width || heightI != actual.height) {
    actual.resize(widthI, heightI);      
  }   

  //-------Se aplica el filtro deseado, y se muestra la imagen------//
  updateFilters();
  image(actual, width/2, height/2); 
}

void mousePressed() {    
  if (mouseX > help.getXLeft('H') && mouseX < help.getXRight('H') && mouseY > help.getYUp('H') && mouseY < help.getYDown('H')) {
    btnHelp = !btnHelp; 
    return;
  }  
    
  if (btnHelp && (mouseX > help.getXLeft('S') && mouseX < help.getXRight('S') && mouseY > help.getYUp('S') && mouseY < help.getYDown('S'))) {
    btnHelp = false;  
    return;
  }
    
  if (btnHelp) return;
  
  if (mouseX > help.getXLeft('P') && mouseX < help.getXRight('P') && mouseY > help.getYUp('P') && mouseY < help.getYDown('P')) {
    getPrevNextImage(true); 
    return;
  }
  
  if (mouseX > help.getXLeft('N') && mouseX < help.getXRight('N') && mouseY > help.getYUp('N') && mouseY < help.getYDown('N')) {
    getPrevNextImage(false); 
    return;
  }
}

void getPrevNextImage(boolean prev) {      
  //----Obtención de la imagen según el booleano-----//
  actual = (prev)? images.getPrevImage() : images.getNextImage();
}

void updateFilters () {  

  if(keys[0]) {
    help.drawFilter("Edge-detection shader");
    shader(edges);       
  }
  
  if(keys[1]) {
    help.drawFilter("Pixels shader");
    pixels.set("pixels", 0.1 * mouseX, 0.1 * mouseY);
    shader(pixels); 
  }
  
  if(keys[2]){
    help.drawFilter("Inverted-colors shader");
    shader(invert); 
  } 
  
  if (keys[3]){
    help.drawFilter("Circle-deform shader");
    circle.set("radius", map(mouseX, 0, width, 0, 2));
    circle.set("radTwist", map(mouseY, 0, height, 1.0, 10));
    shader(circle); 
  } 
}

void setMovement (char k, boolean b) {
  switch (k) { 
      case '1':
        keys[0] = b;        
        break;
      case '2':
        keys[1] = b;
        break;
      case '3':
        keys[2] = b;
        break;
      case '4':
        keys[3] = b;
    }
}

void keyReleased() {
  setMovement(key, false);
}

void keyPressed() {
  setMovement(key, true);  
  if (!btnHelp) {
    if (key == CODED) {
      if(keyCode == LEFT){
        getPrevNextImage(true);
      }else if(keyCode == RIGHT){        
        getPrevNextImage(false);
      }
    }       
  }
  
  if (key == 'H' || key == 'h') {
    btnHelp = !btnHelp;  
  }
}
