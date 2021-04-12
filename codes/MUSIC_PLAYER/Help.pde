class Help {
  private int btnH; //Altura de botones
  private int btnYH, btnWH; //Posición y ancho botón de ayuda
  private int btnWS; //Posición y ancho botón de inicio
  private AudioMetaData meta;
  private int ys, yi;
  private int y;
  private int x1, y1, x2, y2, x3, y3;
  
  public Help() {
    init();  
  }
  
  private void init() {
    this.btnH = 20;
    
    this.btnYH = 10;
    this.btnWH = 40;    
    
    this.btnWS = 100;
    
    this.ys = 100;
    this.yi = 25;
    
    x1 = (width/2) - 40;
    y1 = (height/2) + 340; 
    x2 = (width/2) - 40;
    y2 = (height/2) + 370; 
    x3 = (width/2) - 10;
    y3 = (height/2) + 355; 
  }
  
  private int getXLeft(char button){
    int res = 0;
    switch (button) {
      case 'H':
        res = (width - 50);
        break;
      case 'S':
        res = ((width/2) - 25);   
        break;
      case 'M':
        res = ((width/2) + 140);
        break;
      case 'P':
        res = 0;
        break;
      case 'N':
        res = (width/2);
        break;
      case 'R':
        res = ((width/2) + 10);
        break;
      case 'D':
        res = ((width/2) - 40);
        break;
      case 'd':
        res = ((width/2) - 24);
    }
    return res;  
  }
  
  private int getXRight(char button){
    int res = 0;
    switch (button) {
      case 'H':
        res = (width - 50) + btnWH;
        break;
      case 'S':
        res = ((width/2) - 25) + btnWS;    
        break;
      case 'M':
        res = ((width/2) + 140) + btnWS;  
        break;
      case 'P':
        res = (width/2) - 1;
        break;
      case 'N':
        res = width;
        break;
      case 'R':
        res = ((width/2) + 40);
        break;
      case 'D':
        res = ((width/2) - 26);
        break;
      case 'd':
        res = ((width/2) - 10);
    }
    return res;  
  }
  
  private int getYUp(char button){
    int res = 0;
    switch (button) {
      case 'H':
        res = this.btnYH;
        break;
      case 'S':
        res = (height/5 + 620);  
        break;
      case 'M':
        res = ((height/5) + 250);
        break;
      case 'R':
        res = ((height/2) + 340);
        break;
      case 'P':
      case 'N':
        res = ((height/2) + 380);      
        break;
      case 'D':
      case 'd':
        res = ((height/2) + 340);
    }
    return res;  
  }
  
  private int getYDown(char button){
    int res = 0;
    switch (button) {
      case 'H':
        res = this.btnYH + btnH;
        break;
      case 'S':
        res = (height/5 + 620) + btnH; 
        break;
      case 'M':
        res = ((height/5) + 250) + btnH;
        break;
      case 'R':
        res = ((height/2) + 370);
        break;
      case 'P':
      case 'N':
        res = height;   
        break;
      case 'D':
      case 'd':
        res = ((height/2) + 370);
    }
    return res;  
  }
    
  void getInfoSong() {
    fill(255);
    textSize(16);
    textAlign(CENTER, TOP);
    
    meta = song.getMetaData(); 
    y = ys;
    text("CURRENT SONG", 0, y - 40, width, y);
    text("File Name: " + meta.fileName().split("/")[1].trim(), 0, y, width, y + 40);    
    text("Title: " + meta.title().trim(), 0, y+=yi, width, y+yi);
    text("Album: " + meta.album().trim(), 0, y+=yi, width, y+yi);
    text("Author: " + meta.author().trim(), 0, y+=yi, width, y+yi);    
    text("Duration: " + milisToTime(song.length()), 0, y+=yi, width, y+yi);
    text("Date: " + meta.date().trim(), 0, y+=yi, width, y+yi);
    text("Genre: " + meta.genre().trim(), 0, y+=yi, width, y+yi);
    fill(0);
    textAlign(BASELINE);
  }
  
  void getPrevNext() {
    stroke(255);   
    noFill();
    rect(-1, (height/2) + 380, width/2, height);
    rect(width/2, (height/2) + 380, width, height);
  
    fill(255);
    textSize(14);    
    textAlign(CENTER, TOP);
    
    meta = songs.getPrevSong().getMetaData();    
    text("PREVIOUS", 0, (height/2) + 385, width/2, height);
    text(meta.fileName().split("/")[1], 0, (height/2) + 425, width/2, height);
    
    songs.setCurrent(1);
    meta = songs.getNextSong().getMetaData();
    songs.setCurrent(-1);
    text("NEXT", width/2, (height/2) + 385, width/2, height);
    text(meta.fileName().split("/")[1], width/2, (height/2) + 425, width/2, height);
    
    textAlign(BASELINE);
  }
  
  float side(float x1, float y1, float x2, float y2, float mX, float mY) {
    return (y2 - y1) * (mX - x1) + (x1 - x2) * (mY - y1);
  }
  
  boolean checkPointOnTriangle(float mX, float mY) {
    boolean side1 = side(x1, y1, x2, y2, mX, mY) >= 0; 
    boolean side2 = side(x2, y2, x3, y3, mX, mY) >= 0;
    boolean side3 = side(x3, y3, x1, y1, mX, mY) >= 0; 
    
    return side1 && side2 && side3;
  }
  
  void drawPanel() {
    noFill();
    stroke(255);
    rect((width/2) - 50, (height/2) + 330, 100, 50);
    line((width/2), (height/2) + 330, (width/2), (height/2) + 380);
    
    fill(255);
    rect((width/2) + 10, (height/2) + 340, 30, 30);  
    
    if (song.isPlaying()) {
      rect((width/2) - 40, (height/2) + 340, 13, 30); 
      rect((width/2) - 23, (height/2) + 340, 13, 30); 
    } else {
      triangle(x1, y1, x2, y2, x3, y3); 
    }
    fill(0);
  }
  
  void drawSquareHelp() {
    fill(0);
    stroke(255);
    rect((width - 50), btnYH, btnWH, btnH);   
    fill(255);
    textSize(14);
    text("HELP", (width - 50)+4, btnYH+15);
    fill(0);
  }
      
  void drawSystem() {
    fill(255);
    textSize(18);
    text("MUSIC PLAYER", 10, 20);
    fill(0);
  }
  
  void drawVolume() {    
    fill(255);
    text("VOLUME: " + nf(volume, 0, 2), 10, 40);
    fill(0);
  }
  
  void drawMute() {    
    fill(255);
    String muting = (muted) ? "ON" : "OFF";
    text("MUTED: " + muting, 10, 60);
    fill(0);
  }
  
  void drawCurrent() {
    fill(255);
    textSize(18);
    text("", 10, 20); 
    fill(0);
  }

  void drawStartButton() {
    fill(0);
    stroke(255);
    rect(((width/2) - 25), (height/5 + 620), btnWS, btnH);   
    fill(255);
    textSize(14);
    text("CONTINUE", ((width/2) - 25) + 14, (height/5 + 620) + 15);
    fill(0);
  }
  
  void drawOwner() {
    fill(255);
    textSize(14);
    text("© José María Amusquívar Poppe", 10, 20);
    fill(0);
  }
  
  void drawControls() {
    fill(0);
    stroke(255);
    rect((width/2) + 140, (height/5) + 250, btnWS, btnH);   
    fill(255);
    textSize(14);
    if (controlsCustom) {
      text("MOUSE", ((width/2) + 140) + 25, ((height/5) + 250) + 15);
    }else{
      text("KEYBOARD", ((width/2) + 140) + 14, ((height/5) + 250) + 15);
    }
    fill(0);
  }
      
  void drawTextHelp() {  
    background(0);
    fill(255);
    textSize(24);
    text("WELCOME", (width/2) - 40, (height/5) - 85);
    textSize(18);
    
    text("You can listen to your favourite songs", (width/2) - 145, (height/5));      
    text("Or just any audio you want", (width/2) - 100, (height/5) + 50);
    text("The timeline moves based on song", (width/2) - 130, (height/5) + 100);
    text("Control your songs as you want", (width/2) - 130, (height/5) + 150);
    
    textSize(24);
    text("CONTROLS", (width/2) - 45, (height/5) + 270);
    textSize(18); 
    if (!controlsCustom) {            
      text("Prev/Next song: Press 'LEFT' - 'RIGHT' keys", (width/2) - 160, (height/5) + 345); 
      text("More/Less volume: Press '+' - '-' keys", (width/2) - 140, (height/5) + 385);
      text("Play/Pause song: Press 'SpaceBar' key", (width/2) - 135, (height/5) + 425);
      text("Stop or Reset song: Press 'R' key", (width/2) - 115, (height/5) + 465);             
      text("Mute/Unmute song: Press 'M' key", (width/2) - 120, (height/5) + 505);      
      text("Show/Hide HELP: Press 'H' key", (width/2) - 110, (height/5) + 545); 
    }else{
      text("Skip Backward/Forward song: Click on the song's timeline", (width/2) - 230, (height/5) + 365);
      text("Prev/Next song: Click 'PREV' - 'NEXT' button", (width/2) - 160, (height/5) + 405);      
      text("Stop or Reset song: Click 'STOP' button", (width/2) - 140, (height/5) + 445);    
      text("Play/Pause song: Click 'PLAY' button", (width/2) - 135, (height/5) + 485);
      text("Show/Hide HELP: Click 'HELP' button", (width/2) - 135, (height/5) + 525); 
    }
  }
}
