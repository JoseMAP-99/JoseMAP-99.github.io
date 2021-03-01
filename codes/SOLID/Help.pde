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
        res = ((width/2) - 50);        
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
        res = ((width/2) - 50) + btnWS;        
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
        res = (height - 35);        
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
        res = (height - 35) + btnH;        
    }
    return res;  
  }
  
  void drawSquareHelp() {
    fill(0);
    stroke(255);
    rect((width - 50), btnYH, btnWH, btnH);   
    fill(255);
    text("HELP", (width - 50)+5, btnYH+15);
    fill(0);
  }
  
  void drawSpaces() {
    fill(255);
    text("Spaces: " + nSep, 10, 20); 
    text("Points: " + pos, 10, 40);
    fill(0);
  }

  void drawStartButton() {
    fill(0);
    stroke(255);
    rect(((width/2) - 50), (height - 35), btnWS, btnH);   
    fill(255);
    text("CONTINUE", ((width/2) - 50)+14, (height - 35)+15);
    fill(0);
  }
  
  void drawOwner() {
    fill(255);
    textSize(12);
    text("© José María Amusquívar Poppe", 10, 20);
    fill(0);
  }

  void drawTextHelp() {  
    background(0);
    fill(255);
    textSize(18);
    text("WELCOME", (width/2) - 40, (height/5) - 85);
    textSize(14);
    
    stroke(255); noFill();
    text("Left click on the right side to draw rights points of the desired shape", (width/2) - 230, (height/5) - 50);    
    rect((width/2) - 90, (height/5) - 30, 180, 100);
    text("CLICK", (width/2) + 45, (height/5) + 65);
    stroke(114, 116, 116);
    line(width/2, (height/5) - 30, width/2, (height/5) - 30 + 100);
    stroke(255);
    circle((width/2) + 68, (height/5) - 6, 2);
    circle((width/2) + 33, (height/5) + 4, 2);
    circle((width/2) + 40, (height/5) + 25, 2);
    circle((width/2) + 15, (height/5) + 53, 2);  
    
    text("Left click on the left side to draw desired shape in 3D", (width/2) - 180, (height/5) + 110);
    rect((width/2) - 90, (height/5) + 130, 180, 100);
    text("CLICK", (width/2) - 85, (height/5) + 145);
    stroke(114, 116, 116);
    line(width/2, (height/5) + 130, width/2, (height/5) + 230); 
    
    stroke(255);    
    line((width/2) - 68, (height/5) + 130+26, (width/2) - 33, (height/5) + 130+34);
    line((width/2) - 33, (height/5) + 130+34, (width/2) - 40, (height/5) + 130+55);
    line((width/2) - 40, (height/5) + 130+55, (width/2) - 15, (height/5) + 130+83);
    line((width/2) - 15, (height/5) + 130+83, (width/2) + 15, (height/5) + 130+83);
    line((width/2) + 15, (height/5) + 130+83, (width/2) + 15, (height/5) + 130+83);
    line((width/2) + 15, (height/5) + 130+83, (width/2) + 40, (height/5) + 130+55);
    line((width/2) + 40, (height/5) + 130+55, (width/2) + 33, (height/5) + 130+34);
    line((width/2) + 33, (height/5) + 130+34, (width/2) + 68, (height/5) + 130+26);
    line((width/2) + 68, (height/5) + 130+26, (width/2) - 68, (height/5) + 130+26);
    
    textSize(18);
    text("CONTROLS", (width/2) - 45, (height/5) + 270);
    textSize(14);
    text("Show/Hide HELP: Press 'H' or click 'HELP' button", (width/2) - 155, (height/5) + 300);
    text("Horizontal rotation: 'A' - 'D' or 'Left' - 'Right'", (width/2) - 145, (height/5) + 325);
    text("Vertical rotation: 'W' - 'S' or 'Up' - 'Down'", (width/2) - 135, (height/5) + 350);
    text("Add/less triangles: 'M' - 'L'", (width/2) - 90, (height/5) + 375);
    text("Clear screen: Right click", (width/2) - 80, (height/5) + 400);    
    text("Zoom: Mouse scroll", (width/2) - 65, (height/5) + 425);
    drawOwner();
  }
}
