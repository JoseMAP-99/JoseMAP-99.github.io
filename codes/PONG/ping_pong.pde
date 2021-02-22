/* Juego Pong
 * Desarollado por José María Amusquívar Poppe
 * 15/02/2021
 */
 
import processing.sound.*;
import javax.swing.*;

//---------Especiales--------//
SoundFile pingPong, knockBall, gameOver; //Variables para la reproducción de sonidos
GifMaker gifFile; //Variable para la creación del GIF

//---------Configuración de pantalla----------//
int sizeX = 400; int sizeY = 500; //Dimensión de la ventana

//---------Palas------//
int supXPala, supYPala, infXPala, infYPala; //Posiciones X e Y de ambas palas
int jump, sizePala; //Valocidad de movimiento de las palas, y longitud de ellas

//---------Pelota--------//
int cx, cy, radius; //Posición X e Y de la pelota, y radio de la misma
int incY, incX, fastBall; //Incremento y velocidad de la pelota

//------Configuración del campo de juego-------//
int tableX, tableY, border; //Dimensiones de la zona de juego, tiene un borde que lo rodea
      
//-------Variables de estado-------//
boolean running; //Variable que señala si se está o no ejecutando el juego
boolean pauseGame = true; //Variable que señala si el juego ha sido pausado o no
boolean upWin; //Variable que señala qué jugador ha ganado el punto

//---------Variables de pintado del puntaje----------//
int middleX = (sizeX/2) + (sizeX/2)/2; //Variable de posición X común para el centrado del marcador    
int middleYSup = (sizeY/2) - (sizeY/2)/2; //Variable de posición Y para el centrado del marcador superior   
int middleYInf = (sizeY/2) + (sizeY/2)/2;  //Variable de posición Y para el centrado del marcador inferior

//----------Variables especiales-------//
int scoreSup, scoreInf; //Variables que almacenan el puntaje de los jugadores
int randDir = -1; //Variable que alterna los saques de la pelota
int rounds; //Variable que guarda el número de rondas elegido  

void settings() {
  size(sizeX, sizeY);
}

void setup(){ 
  //------Variables del campo de juego--------//
  border = 20;
  tableX = sizeX - (2*border);
  tableY = sizeY - (2*border);
  
  //--------Carga de sonidos-------//
  pingPong = new SoundFile(this, "sounds/ping-pong.mp3"); 
  gameOver = new SoundFile(this, "sounds/game-over.mp3"); 
  knockBall = new SoundFile(this, "sounds/knock-ball.mp3"); 
  
  //--------Configuración del capturador de GIF--------//
  gifFile = new GifMaker(this, "ping_pong.gif");
  gifFile.setRepeat(0);
}

void resetScore() {  
  scoreSup = 0;
  scoreInf = 0;
}

void selectPlayer () {
  //-----Posición aleatoria de la pelola------// 
  cx = (int) random(border + radius, sizeX - border - radius);
  
  //-----Selección del siguiente saque-----//
  if (!upWin){
    cy = infYPala - radius;  
    incY = -fastBall;      
  }else{
    cy = supYPala + 10 + radius;
    incY = fastBall;     
  }
  
  //-------Cambio de orientación de la pelota----//
  incX =  randDir*fastBall; 
  randDir = -1 * randDir;
}

void resetGame(){  
  //Palas
  sizePala = 80;
  supXPala = (sizeX/2) - (sizePala/2);
  supYPala = border;
  infXPala = (sizeX/2) - (sizePala/2);
  infYPala = tableY + 10;
  jump = 5; //Velocidad de palas  
  
  radius = 10;
  fastBall = 3;
  for (int i = 0; i < pressed.length; i++) pressed[i] = false;
  selectPlayer();  
}  

void drawBoard(){
  background(223, 184, 125); //Fondo de juego (bordes). Tono marrón
  
  //-----Texto de ayuda superior-----//
  textSize(12);
  text("Presione R para reiniciar, P para pausar o iniciar", (sizeX/2) - 130, border/2 + 5); //Texto de ayuda
  
  //-------Dibujado del tablero de juego-------//
  fill(125, 171, 223); //Fondo de mesa. Tono azul
  rect(border, border, tableX, tableY); //Forma de mesa rectangular
  
  //------Dibujado de las divisiones del tablero----//
  stroke(255); //Color de trazado de mesa (líneas). Blanco
  line(sizeX/2, border, sizeX/2, sizeY-20); //Trazado de mesa
  
  //---------Dibujado del separador central----------//
  fill(125, 223, 125); //Color de trazado de separación de mesa. Tono verde
  rect(border, (sizeY/2)-5, tableX, 10); //Trazado de separación de mesa
}

void drawPala() {
  fill(255, 0, 0); //Color de pala. Rojo
  rect(supXPala, supYPala, sizePala, 10); //Dibujado de la pala superior
  rect(infXPala, infYPala, sizePala, 10); //Dibujado de la pala inferior
}

void drawBall() {
  fill(255); //Color blanco
  circle(cx, cy, radius*2); //Dibujado de la pelota según el diámetro=2*radius
}

void drawScore(){
  fill(255); //Color blanco
  textSize(60); //Tamaño de las letras
  
  //------Dibujado del nombre y puntaje del jugador superior--------//
  text("P1", (sizeX - middleX) - 30, middleYSup + 30);
  text(scoreSup, middleX - 30, middleYSup + 30); 
  
  //------Dibujado del nombre y puntaje del jugador inferior--------//
  text("P2", (sizeX - middleX) - 30, middleYInf + 30); 
  text(scoreInf, middleX - 30, middleYInf + 30); 
}

boolean corn = false;
boolean [] pressed = new boolean[4];

void draw () {   
  if (pauseGame){ 
    //------Dibujado del juego-------//
    drawBoard();
    drawPala();
    drawBall(); 
    drawScore();
    
    //------Mensaje señelando la pausa-----//
    textSize(40);
    fill(255, 0, 0);
    text("PAUSA", (sizeX/2) - 64, (sizeY/2) + 14);
    
    //------Mensaje que indican los controles del juego-------//
    textSize(15);
    text("Pulse P para iniciar", (sizeX / 2) - 64, (sizeY / 2) - 40);
    text("CONTROLES", (sizeX / 2) - 44, (sizeY / 2) + 40);
    text("Pala superior: A y D", (sizeX / 2) - 64, (sizeY / 2) + 60);
    text("Pala inferior: Izq. y Der.", (sizeX / 2) - 70, (sizeY / 2) + 80);
    return;
  }
  
  if (!running){
    //-------Solicitud del número de rondas--------//
    String roundsNumber = JOptionPane.showInputDialog(null, "¿Cuántas rondas?", "Rondas", JOptionPane.QUESTION_MESSAGE); 
    
    //----Comprobación de errores y conversión a entero-----//
    if (roundsNumber == null) System.exit(0);
    if (roundsNumber != null && !roundsNumber.matches("\\d+")) return; 
    rounds = Integer.parseInt(roundsNumber);
    if (rounds <= 0) return;
    
    //--------Reinicio del juego y señal de activación------//
    resetGame(); 
    resetScore();
    running = true;    
  }
 
 if (running){
   //-------Dibujado del videojuego-------//
   drawBoard();
   drawPala();
   drawBall(); 
   drawScore();
   movePala();
   
   //-------Actualización normal de la pelota--------//
   cy += incY; 
   cx += incX;
         
   //-------Comprobación del choque de la pelota contra las esquinas de las palas--------//
   if (!corn && (supXPala - cx > 0 && supXPala - cx <= radius && cy - radius <= supYPala + 10 ||
              cx - (supXPala + sizePala) > 0 && cx - (supXPala + sizePala) <= radius && cy - radius <= supYPala + 10 ||
              infXPala - cx > 0 && infXPala - cx <= radius && cy + radius >= infYPala ||
              cx - (infXPala + sizePala) > 0 && cx - (infXPala + sizePala) <= radius && cy + radius >= infYPala)) {
       incX =- incX;
       incY =- incY;
       pingPong.play(); 
       corn = true;
   
   //-------Comprobación del choque de la pelota contra las paredes laterales---------//
   } else if (cx + radius >= sizeX-border || cx - radius <= border) {
       incX =- incX;     
       knockBall.play();
       corn = false;
       
   //-------Comprobación del choque de la pelota contra las palas--------// 
   } else if (!corn && (cy - radius <= supYPala + 10 && cx >= supXPala && cx <= supXPala + sizePala ||
       cy + radius >= infYPala && cx >= infXPala && cx <= infXPala + sizePala)) {    
        incY =- incY;     
        pingPong.play();
       
   //----------Comprobación si la posición de la pelota está fuera del área de juego----------//
   } else if(cy < border || cy > sizeY-border){  
     
     //--------Actualización del puntaje según la posición Y de la pelota-------//
     if (cy < border) {
       scoreInf++;
       upWin = true;
     }else{
       scoreSup++;
       upWin = false;
     }
       gameOver.play(); //Sonido reproducido al perder el punto
       
       //------Comprobación si se ha alcanzado el número de rondas deseado-------//
       if (scoreSup == rounds || scoreInf == rounds){
         String message;
         if (scoreSup == rounds) {
           message = "Ha ganado el jugador 1";
         }else{
           message = "Ha ganado el jugador 2";
         }  
         
         //-------Presentación del anuncio del ganador correspondiente-------//
          JOptionPane.showMessageDialog(null, message, "Ganador", JOptionPane.INFORMATION_MESSAGE);           
          running = false; //Cambio de estado, el juego ya no se ejecuta
          return;
       }   
       
       //-------Reinicio del tablero para cada punto-------//
       resetGame();  
       drawBoard();
       drawPala();
       drawBall(); 
       drawScore();
       pauseGame = true; //Se certifica que cada punto empiece pulsando "P"
   }
 }  
 gifFile.addFrame();
}

void mousePressed () {
  gifFile.finish(); 
}

void setMovement(int k, boolean b) {
  if (!pauseGame){
    switch (k) {
      case 'a':
        pressed[0] = b;
        break;
      case 'A':
        pressed[0] = b;
        break;
      case 'd':
        pressed[1] = b;
        break;
      case 'D':
        pressed[1] = b;
        break;
      case CODED:
        if (keyCode == LEFT){
          pressed[2] = b;
        }else if (keyCode == RIGHT){
          pressed[3] = b;
        }       
    }
  }
}

void movePala() {
  if (pressed[0]) {
    if (supXPala > border) supXPala -= jump;
  }else
  
  if (pressed[1]){
    if (supXPala + sizePala < sizeX-border) supXPala += jump;
  }
  
  if (pressed[2]){
    if (infXPala > border) infXPala -= jump;
  }
  
  if (pressed[3]){
    if (infXPala + sizePala < sizeX-border) infXPala += jump;
  }
}

void keyPressed() {
  setMovement(key, true);
  
  if (key == 'R' || key == 'r'){
    pauseGame = false;
    resetGame(); 
  }else if (key == 'P' || key == 'p'){
    pauseGame = !pauseGame;
  }  
}

void keyReleased() {
  setMovement(key, false);
}
