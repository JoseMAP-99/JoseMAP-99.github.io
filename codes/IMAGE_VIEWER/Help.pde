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
      case 'P':
        res = 0;
        break;
      case 'N':
        res = (width/2);
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
      case 'P':
        res = (width/2) - 1;
        break;
      case 'N':
        res = width;
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
      case 'P':
      case 'N':
        res = ((height/2) + 380);     
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
      case 'P':
      case 'N':
        res = height;   
    }
    return res;  
  }

  void getActInfo() {
    fill(255);
    textSize(16);
    textAlign(CENTER, TOP);
    
    text("CURRENT IMAGE", 0, 60, width, 100);
    text(images.getName(0).trim(), 0, 100, width, 140);    
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
      
    text("PREVIOUS", 0, (height/2) + 385, width/2, height);
    text(images.getName(-1), 0, (height/2) + 425, width/2, height);
    
    text("NEXT", width/2, (height/2) + 385, width/2, height);
    text(images.getName(1), width/2, (height/2) + 425, width/2, height);
    
    textAlign(BASELINE);
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
    text("IMAGE VIEWER", 10, 20);
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

  void drawFilter (String filter) {
    fill(255);
    textSize(18);
    textAlign(CENTER);
    text(filter, width/2, ((height-heightI)/2) - 30);
    fill(0);
  }
      
  void drawTextHelp() {  
    background(0);
    fill(255);
    textSize(24);
    text("WELCOME", (width/2) - 40, (height/5) - 85);
    textSize(18);
    
    text("You can view your favourite images", (width/2) - 145, (height/5));      
    text("And apply the shader you want", (width/2) - 120, (height/5) + 50);
    
    textSize(24);
    text("CONTROLS", (width/2) - 45, (height/5) + 240);
    textSize(18); 

    text("Prev/Next image:", (width/2) - 200, (height/5) + 295);
    text("Press 'LEFT' - 'RIGHT' keys", (width/2) - 40, (height/5) + 280);
    text("Click 'PREV' - 'NEXT' button", (width/2) - 40, (height/5) + 310);

    text("Show/Hide HELP:", (width/2) - 200, (height/5) + 370);        
    text("Press 'H' key", (width/2) - 40, (height/5) + 355); 
    text("Click 'HELP' button", (width/2) - 40, (height/5) + 385);   

    text("SHADERS:", (width/2) - 200, (height/5) + 475);        
    text("Edge-detection: Press '1' key", (width/2) - 40, (height/5) + 430); 
    text("Pixels-movement: Press '2' key", (width/2) - 40, (height/5) + 460);      
    text("Inverted-colors: Press '3' key", (width/2) - 40, (height/5) + 490);      
    text("Circle-deform: Press '4' key", (width/2) - 40, (height/5) + 520);  
  }
}
