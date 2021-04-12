/* José María Amusquívar Poppe
 * Creando Interfaces de Usuario
 * Práctica de manipulación de sonido
 */
 
import ddf.minim.*;
import java.util.concurrent.TimeUnit;

//------Variable principal Minim---------//
Minim minim;

//-------Objetos personales de ayuda-------//
Files files;
Songs songs;
Help help;

//-------Variable que almacena la canción actual------//
AudioPlayer song;

//---------Variables de estado-----------//
boolean controlsCustom, btnHelp, muted;

//-----Variables para controlar el volumen-----//
float volume = 0;
int i = -7;
final float minVol = -20.0;
final float maxVol = 6.0;

//-----Variables temporizadores para textos-------//
float timerVol = -1;
float timerMute = -1;

//------Variable para el fondo de pantalla-----//
PImage backG;

//-------Variables para controlar la auto-reproducción------//
float position = 0;
boolean paused = false;

//-------Variable de ayuda para adelantar y retrasar sonidos-----//
float posx;

void setup() {  
  //------Dimensión fija de la aplicación------//
  size(700, 900);  
  
  //------Imagen de fondo de la aplicación------//
  backG = loadImage("background.png");
  
  //-------Instancia de la clase Minim-------//
  minim = new Minim(this);
  
  //--------Asignación de los objetos personales-------//
  files = new Files("/music");  
  songs = new Songs(files.getFiles()); 
  help = new Help();
  
  //-------Obtención de la primera canción--------//
  song = songs.getNextSong();
  
  //-------Inicialización de las variables de estado--------//
  controlsCustom = false; // Monitoriza los controles en la vista de ayuda
  btnHelp = true; // Monitoriza si la vista de ayuda está activa
  muted = false; // Monitoriza si el sonido está silenciado o no
}

void draw () { 
   //-------Se comprueba si la ayuda está activada-------//
  if (btnHelp){  
    help.drawTextHelp();    
    help.drawSquareHelp();
    help.drawStartButton();
    help.drawOwner();
    help.drawControls();
    return;
  }  
  
  //-----Fondo de pantalla y textos de ayuda------//
  background(backG);   
  help.getInfoSong();
  help.getPrevNext();
  help.drawPanel();
  help.drawSquareHelp();
  help.drawSystem();    
  
  //------Muestra volumen en pantalla durante un momento-----//
  if (timerVol > -1 && timerVol < 80) {
    help.drawVolume();
    timerVol++;
  }
  
  //------Muestra *mute* en pantalla durante un momento-----//
  if (timerMute > -1 && timerMute < 80) {
    help.drawMute();
    timerMute++;
  }
   
  //-----Si la canción termina sola, avanza a la siguiente automáticamente-------//
  if (!paused && !song.isPlaying() && position > 0) {
    getPrevNextSong(false);
    song.play();
    paused = false;
  }
  
  //-----Almacena la posición actual de la canción-------//
  position = song.position();
    
  //-------Genera las vibraciones del sonido en pantalla (lineal y circular)------//  
  for(int i = 0; i < song.bufferSize() - 1; i++) {
    float x1 = map(i, 0, song.bufferSize(), 0, width);
    float x2 = map(i + 1, 0, song.bufferSize(), 0, width);
    
    stroke(255);
    line(x1, (height/2) - song.left.get(i) * 70, x2, (height/2) + song.left.get(i+1) * 70);
    
    stroke(255, 0, 255, 20);
    line(width/2 - song.left.get(i)*180, (3*height/4) + song.right.get(i+1)*180, width/2, 3*height/4);
    line(width/2 + song.left.get(i)*180, (3*height/4) + song.right.get(i+1)*180, width/2, 3*height/4);
  }
    
  //-------Genera una línea roja que indica la posición actual de la canción------//
  stroke(255, 0, 0);
  posx = map(song.position(), 0, song.length(), 0, width);  
  line(posx, (height/2) - 110, posx, (height/2) + 110);   
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
  
  if (btnHelp && (mouseX > help.getXLeft('M') && mouseX < help.getXRight('M') && mouseY > help.getYUp('M') && mouseY < help.getYDown('M'))) {
    controlsCustom = !controlsCustom; 
    return;
  }
  
  if (btnHelp) return;
  
  if (mouseX > help.getXLeft('P') && mouseX < help.getXRight('P') && mouseY > help.getYUp('P') && mouseY < help.getYDown('P')) {
    getPrevNextSong(true); 
    return;
  }
  
  if (mouseX > help.getXLeft('N') && mouseX < help.getXRight('N') && mouseY > help.getYUp('N') && mouseY < help.getYDown('N')) {
    getPrevNextSong(false); 
    return;
  }
    
  if (mouseX > help.getXLeft('R') && mouseX < help.getXRight('R') && mouseY > help.getYUp('R') && mouseY < help.getYDown('R')) {
    stopSong();  
    position = 0;
    paused = true;
    return;
  }
  
  if (!song.isPlaying() && help.checkPointOnTriangle(mouseX, mouseY)) {
    song.play();  
    paused = false;
    return;
  }
  
  if ((mouseX > help.getXLeft('D') && mouseX < help.getXRight('D') && mouseY > help.getYUp('D') && mouseY < help.getYDown('D')) ||
      (mouseX > help.getXLeft('d') && mouseX < help.getXRight('d') && mouseY > help.getYUp('d') && mouseY < help.getYDown('d'))) {
    song.pause();
    paused = true; 
    return;
  }
  if (mouseButton == LEFT && mouseY >= (height/2) - 110 && mouseY <= (height/2) + 110) {
    skipBF();
  }
}

void skipBF() {
  //-----Obtiene la posición del ratón-----//
  float pos = mouseX;    
  
  //-----Obtiene la duración del sonido-----//
  float duration = song.length();
     
  //-----Realiza un mapeo de "pos" de rango "0-width" al rango "0-duration"-----// 
  int timeToSkip = (int) map(pos, 0, width, 0, duration);    
  
  //-----Comprueba si es un avance o retroceso del sonido------//
  if (pos > posx) {      
    timeToSkip -= position;
  } else {
    timeToSkip = -((int) position - timeToSkip);
  }
  
  //------Salta a dicha posición------//
  song.skip((int) timeToSkip);
}

void stopSong() {
  song.rewind(); song.pause();
}

void getPrevNextSong(boolean prev) {  
  /* Si la canción actual está silenciada, se le quita el
   * silencio por si se vuelve a reproducir.
   */
  if (song.isMuted()) {
    muted = true;
    song.unmute();
  }
  
  /* Se detiene la canción en su posición actual, o se reinicia si 
   * ésta ha conluido "stopSong()"
   */
  if (!song.isPlaying() && position > 0) {
    stopSong();
  } else {
    song.pause();
  }
  
  //----Obtención de la canción según el booleano-----//
  song = (prev)? songs.getPrevSong() : songs.getNextSong();
  
  //-----Si el silenciado está activado, se silencia el nuevo sonido-----//
  if (muted) song.mute();
  
  //-----Se establece el volumen general y se reinician variables-------//
  song.setGain(i); 
  position = 0;
  paused = true;
}

String milisToTime(long millis) {
  return String.format("%02d:%02d min", 
          TimeUnit.MILLISECONDS.toMinutes(millis),
          TimeUnit.MILLISECONDS.toSeconds(millis) - 
          TimeUnit.MINUTES.toSeconds(TimeUnit.MILLISECONDS.toMinutes(millis))
        );
}

void keyPressed() {  
  if (!btnHelp) {
    if (key == CODED) {
      if(keyCode == LEFT){
        getPrevNextSong(true);
      }else if(keyCode == RIGHT){        
        getPrevNextSong(false);
      }
    }
    
    if (key == ' ') {
      if (song.isPlaying()) {
        song.pause();
        paused = true;
      } else {
        song.play();  
        paused = false;
      }
    }
    
    if (key == 'R' || key == 'r') {      
      stopSong();  
      position = 0;
      paused = true;
    }
    
    if (key == '-') {     
      if (i > minVol) i--;
      song.setGain(i);    
      volume = map(i, minVol, maxVol, -10, 10);
      timerVol = 0;
    }
    
    if (key == '+') {  
      if (i < maxVol) i++;
      song.setGain(i);  
      volume = map(i, minVol, maxVol, -10, 10);    
      timerVol = 0;
    }
    
    if (key == 'M' || key == 'm') {
      if (song.isMuted()) {
        song.unmute();
        muted = false;
      } else {
        song.mute();
        muted = true;
      }    
      timerMute = 0;
    }
  }
  
  if (key == 'H' || key == 'h') {
    btnHelp = !btnHelp;  
  }
}
