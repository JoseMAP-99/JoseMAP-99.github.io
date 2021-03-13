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
      case 'A':
        res = ((width/2) + 140);
        break;
      case 'N':
        res = ((width/2) - 30);
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
      case 'A':
        res = ((width/2) + 140) + btnWS;
        break;
      case 'N':
        res = ((width/2) - 30) + btnWH + 30;
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
      case 'A':
        res = ((height/5) + 280);
        break;
      case 'N':
        res = this.btnYH;
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
      case 'A':
        res = ((height/5) + 280) + btnH;
        break;
      case 'N':
        res = this.btnYH + btnH;
    }
    return res;  
  }
  
  void drawSquareHelp() {
    fill(0);
    stroke(255);
    rect((width - 50), btnYH, btnWH, btnH);   
    fill(255);
    textSize(14);
    text("HELP", (width - 50)+5, btnYH+15);
    fill(0);
  }
  
  void drawNewPlanets() {
    fill(0);
    stroke(255);
    rect((width/2 - 30), btnYH, btnWH + 30, btnH);   
    fill(255);
    textSize(14);
    text("CHANGE", (width/2 - 30)+5, btnYH+15);
    fill(0);
  }
  
  void drawInfo() {
    fill(255);
    textSize(18);
    text("Radius: " + radius, 10, 20); 
    text("Planets: " + pos, 10, 40);
    fill(0);
  }
  
  void drawSystem() {
    fill(255);
    textSize(18);
    text("PLANETARIUM", 10, 20); 
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
    if (controlsNave) {
      text("AIRCRAFT", ((width/2) + 140) + 14, ((height/5) + 280) + 15);
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
    
    text("First view represents Solar System, so just enjoy", (width/2) - 180, (height/5));      
    text("You can switch to creation mode by pressing CHANGE button", (width/2) - 230, (height/5) + 50);
    text("You can zoom or rotate vertically Solar System and your creations", (width/2) - 250, (height/5) + 100);
    text("Switch the control information by pressing GENERAL button", (width/2) - 230, (height/5) + 150);
    text("PLUTO is not a PLANET, but I like it", (width/2) - 125, (height/5) + 200);    
    
    textSize(24);
    text("CONTROLS", (width/2) - 45, (height/5) + 300);
    if (!controlsNave) {
      textSize(18);    
      text("Show/Hide HELP: Press 'H' or click 'HELP' button", (width/2) - 175, (height/5) + 375);
      text("Draw a new planet: Left click (Creation mode)", (width/2) - 165, (height/5) + 415);
      text("More/Less radius: '+' - '-' (Creation mode)", (width/2) - 155, (height/5) + 455);
      text("Vertical rotation: 'W' - 'S' or 'Up' - 'Down'", (width/2) - 150, (height/5) + 495);
      text("Clear screen: Right click (Creation mode)", (width/2) - 150, (height/5) + 535); 
      text("Remove last planet: 'X' (Creation mode)", (width/2) - 145, (height/5) + 575);             
      text("Zoom: Mouse scroll", (width/2) - 65, (height/5) + 615);
    } else {
      textSize(18);  
      text("Back and forward: 'M' - 'L' (First person view)", (width/2) - 175, (height/5) + 415);      
      text("Horizontal movement: '4' - '6' keys", (width/2) - 135, (height/5) + 455); 
      text("Vertical movement: '8' - '2' keys", (width/2) - 120, (height/5) + 495);      
      text("Reset aircraft position: 'R' key", (width/2) - 115, (height/5) + 535); 
      text("Change point of view: 'C' key", (width/2) - 110, (height/5) + 575);
    }
  }
}
