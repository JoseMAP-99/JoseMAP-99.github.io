/*
 * José María Amusquívar Poppe
 * Sólido de revolución
 * Creando interfaces de usuario
 */
 
//-----------Configuración de pantalla---------//
int sizeX, sizeY; //Dimensiones de la ventana

//----------Figuras creadas----------//
PShape solidoForm, group; //Shape sin relleno, y Shape que agrupa todas las figuras

//---------Objetos creados----------//
Points points; // Objeto que trata los puntos introducidos
Help help; // Objeto que se encarga de mostrar los textos

//-----------Variables de estado----------//
boolean printed; // Variable que señala si hay un sólido dibujado
boolean btnHelp; // Variable que señala si está activa la vista de ayuda

//-----------Variables de configuración----------//
int pos, sizePoint; // Número de puntos, y tamaño de puntos a dibujar
int maxScroll, minScroll, scrollMouse; // Valor máximo y mínimo para la rueda del ratón, y valor actual 
int nSep; // Variable que guarda la separación existente entre triángulos

//------------Variable para las pulsaciones de teclas---------//
boolean [] keys = new boolean[6]; // Variable que almacena las pulsaciones de teclas

void settings() {
  sizeX = 600; 
  sizeY = 600;
  size(sizeX, sizeY, P3D);    
}

void setup () { 
  //--------Variables de la figura------//
  pos = 0;
  sizePoint = 2;
  nSep = 20; 
  
  //-------Variables de estado-----//
  printed = false;
  btnHelp = true;
  
  //-------Variables relacionadas a la rueda del ratón-----//
  maxScroll = 5; 
  minScroll = -5; 
  scrollMouse = 0;
  
  //-------Objetos necesarios-------//
  help = new Help();  
  points = new Points();  
}

void drawBoard() {
  //------Se pinta el tablero y se dibuja la línea divisoria------//
  background(0);
  stroke(114, 116, 116);
  line(width/2, 0, width/2, height);
}

void drawPoints(int xs, int mult) {
  PVector aux;
  PVector last;
  for(int i = 0; i < pos; i++) {
    aux = points.getItem(i);    
        
    if (i == pos - 1){
      if (mouseX >= width/2){
        line(xs + mult*aux.x, aux.y, mouseX, mouseY);
      }
    }else{
      last = points.getItem(i+1);  
      line(xs + mult*last.x, last.y, xs + mult*aux.x, aux.y);
    }    
    circle(xs + mult*aux.x, aux.y, sizePoint);
  }
}

public PVector multVect(PVector pt, float theta) {
    PVector res = new PVector();
    res.x = (pt.x - width/2) * cos(theta) - pt.z * sin(theta);
    res.y = pt.y;
    res.z = (pt.x - width/2) * sin(theta) + pt.z * cos(theta);
    return res;
}

void drawSolid() {
  PVector pt;
  
  group = createShape(GROUP); // Grupo de PShape general
  
  solidoForm = createShape(); // Sólido sin relleno
  solidoForm.beginShape(LINES);
  stroke(255);
  solidoForm.strokeWeight(2);
  
  //-------Generación de las nuevas coordenadas-----------// 
  for (int i = 0; i < pos; i++) {
    for (int rad = 0; rad <= 360; rad+=nSep){
      pt = multVect(points.getItem(i), radians(rad));
      solidoForm.vertex(pt.x, pt.y, pt.z); 
    }    
  } 
  solidoForm.endShape(CLOSE); 
  
  //-------Variables locales para el cálculo del relleno------//
  PVector actual, actual1, last, last1;
  int nVerRad = 360/nSep;
  
  PShape triangle;
  
  //-------Creación de triángulos para el relleno-------//
  for (int i = nVerRad + 1; i < solidoForm.getVertexCount(); i++){
    actual = solidoForm.getVertex(i - 1);
    actual1 = solidoForm.getVertex(i);
    last = solidoForm.getVertex(i - nVerRad - 1);    
    last1 = solidoForm.getVertex(i - nVerRad); 
    
    triangle = createShape();
    triangle.beginShape(TRIANGLES);    
    triangle.vertex(actual.x, actual.y, actual.z);
    triangle.vertex(actual1.x, actual1.y, actual1.z);
    triangle.vertex(last.x, last.y, last.z);
    triangle.vertex(last1.x, last1.y, last1.z);
    triangle.endShape(CLOSE);  
    
    group.addChild(triangle); // Se adjunta cada triángulo en la figura final                              
  }
  group.addChild(solidoForm); // Se adjunta la figura sin relleno en la figura final
}

void draw () {
  //-------Se comprueba si la ayuda está activada-------/
  if (btnHelp){  
    help.drawTextHelp();
    help.drawSquareHelp();
    help.drawStartButton();
    return;
  }
  
  //---------Dibujado del tablero, textos y botón-------//
  drawBoard();  
  help.drawSquareHelp();
  help.drawSpaces();
 
 //--------Se comprueba si se dibuja el sólido o las líneas-------//
  if (printed){  
    translate(mouseX, mouseY - (points.getYs()[0] - ((points.getYs()[0] - points.getYs()[1])/2)));
    shape(group);   
    moveShape();
  }else{
    drawPoints(0, 1);
  }
}

void mouseWheel(MouseEvent event) {
  if (!printed) return;
  
  if (event.getCount() < 0 && scrollMouse > minScroll){
    group.scale(1.1);
    scrollMouse += event.getCount();
  }
  
  if (event.getCount() > 0 && scrollMouse < maxScroll){
    group.scale(0.9);
    scrollMouse += event.getCount();
  } 
  
  println(scrollMouse);
}

void mousePressed() {  
  if (mouseX > help.getXLeft('H') && mouseX < help.getXRight('H') && mouseY > help.getYUp('H') && mouseY < help.getYDown('H')) {
    btnHelp = !btnHelp;  
  }
  
  if (btnHelp) {
    if (mouseX > help.getXLeft('S') && mouseX < help.getXRight('S') && mouseY > help.getYUp('S') && mouseY < help.getYDown('S')) {
      btnHelp = false;  
    }
    return;
  }
  
  if (mouseButton == LEFT && !printed){
    if (mouseX >= width/2 && (mouseX < help.getXLeft('H') || mouseY > help.getYDown('H'))){
      points.appendItem(new PVector(mouseX, mouseY, 0));     
      System.out.println(points.getItem(pos).toString());
      pos++;    
    }else if (pos > 0 && mouseX < width/2){   
      drawSolid();
      printed = true;
    }
  } else if (mouseButton == RIGHT && pos > 0) {
    points.clearList();
    pos = 0;
    printed = false;
    scrollMouse = 0;
    nSep = 20;
    System.out.println("Lista vaciada");    
  }
}

void moveShape() {
  if (keys[0]) {
    group.rotateY(-0.1);
  } 
  
  if(keys[1]) {
    group.rotateY(0.1);
  }
  
  if(keys[2]) {
    group.rotateX(-0.1);
  }
  
  if(keys[3]){
    group.rotateX(0.1);
  } 
  
  if (keys[4] && nSep < 360){
    nSep++;
    drawSolid();
  } 
  
  if (keys[5] && nSep > 1){
    nSep--;
    drawSolid();
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
      case 'M':
      case 'm':
        keys[4] = b;
        break;
      case 'L':
      case 'l':
        keys[5] = b;
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
}
