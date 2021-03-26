class Help {
  private int btnH; //Altura de botones
  private int btnYH, btnWH; //Posición y ancho botón de ayuda
  private int btnWS; //Posición y ancho botón de inicio
  
  public Help() {
    init();  
  }
  
  private void init() {
    this.btnH = 20;
    
    this.btnYH = 10;
    this.btnWH = 40;    
    
    this.btnWS = 100;
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
        res = (height/5 + 680);  
        break;
      case 'M':
        res = ((height/5) + 280);
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
        res = (height/5 + 680) + btnH; 
        break;
      case 'M':
        res = ((height/5) + 280) + btnH;
    }
    return res;  
  }
  
  void drawSquareHelp(int filled) {
    fill(filled);
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
    text(mode, 10, 20); 
    text("R to restart!", 10, 60);
    fill(0);
  }

  void drawStartButton() {
    fill(0);
    stroke(255);
    rect(((width/2) - 25), (height/5 + 680), btnWS, btnH);   
    fill(255);
    textSize(14);
    text("CONTINUE", ((width/2) - 25) + 14, (height/5 + 680) + 15);
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
    rect((width/2) + 140, (height/5) + 280, btnWS, btnH);   
    fill(255);
    textSize(14);
    if (controls == 1) {
      text("MARIO", ((width/2) + 140) + 25, ((height/5) + 280) + 15);
    }else if (controls == 2){
      text("FACIAL", ((width/2) + 140) + 25, ((height/5) + 280) + 15);
    }else{
      text("GENERAL", ((width/2) + 140) + 16, ((height/5) + 280) + 15);
    }
    fill(0);
  }
      
  void drawTextHelp() {  
    background(0);
    fill(255);
    textSize(24);
    text("WELCOME", (width/2) - 40, (height/5) - 85);
    textSize(18);
    
    text("You will see wonderful structures from the world today", (width/2) - 220, (height/5));      
    text("You can navigate around all the structures", (width/2) - 160, (height/5) + 50);
    text("Mario Bros. will be your guide on this tour", (width/2) - 160, (height/5) + 100);
    text("Enjoy switching the lights mode", (width/2) - 120, (height/5) + 150);
    
    textSize(24);
    text("CONTROLS", (width/2) - 45, (height/5) + 300);
    textSize(18); 
    if (controls == 2) {          
      text("Horizontal rotation: Move your head left or right", (width/2) - 180, (height/5) + 375);
      text("Vertical rotation: Move your head up or down", (width/2) - 170, (height/5) + 415);
      text("Change lights: Open your mouth", (width/2) - 120, (height/5) + 455); 
      text("Forward: Rise your eyebrows", (width/2) - 100, (height/5) + 495);
    }else if (controls == 1){
      text("Forward and Backward: 'W' - 'S' or 'UP' - 'Down'", (width/2) - 170, (height/5) + 375);
      text("Horizontal rotation: 'A' - 'D' or 'LEFT' - 'RIGHT'", (width/2) - 170, (height/5) + 415);
      text("Vertical rotation: 'Q' - 'E' keys", (width/2) - 100, (height/5) + 455);
      text("Change point of view: 'C' key", (width/2) - 100, (height/5) + 495); 
      text("Reset position: Press 'R' key", (width/2) - 95, (height/5) + 535); 
    }else{
      text("Show/Hide HELP: Press 'H' or click 'HELP' button", (width/2) - 175, (height/5) + 375);      
      text("Change lights (Manual): Press '0' - '1' - '2' - '3' - '4'", (width/2) - 185, (height/5) + 415);   
      text("Change lights (Auto): Press 'SpaceBar'", (width/2) - 125, (height/5) + 455);
      text("Generate new colors: Right click", (width/2) - 105, (height/5) + 495);             
      text("More or less color: Mouse scroll", (width/2) - 105, (height/5) + 535);
    }
  }
}
