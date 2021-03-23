class Structure {
    
  PShape struct;
  private String title; 
  private color colorS;
  
  private float scale;  
  private float translate[]; //TranslateX, TranslateY, TranslateZ
  private float titlePos[]; //TitleX, TitleY, TitleZ
    
  Structure(String path, float translate[], float scale, String title, float [] titlePos) {
    this.struct = loadShape(path);
    
    this.title = title;
    this.titlePos = titlePos;
    
    this.translate = translate;
    this.scale = scale;    
    
    this.struct.scale(this.scale);
    this.struct.setStroke(false);
    
    getColor();    
  }
  
  public void getColor() {
    this.colorS = color(random(255), random(255), random(255));
  }
  
  public void runShape() {
    pushMatrix();  
    translate(this.translate[0], this.translate[1], this.translate[2]); 
    
    this.struct.setFill(this.colorS);
    
    drawTitle();
     
    rotateZ(PI);    
            
    shape(this.struct);
    popMatrix();
  }
  
  //--------Función que imprime y rota el nombre según el personaje-----------//
  void drawTitle() {
    pushMatrix();
    rotateY(-radians(mario.angle));
    fill(255);
    textSize(200);    
    text(this.title, titlePos[0], titlePos[1], titlePos[2]);
    popMatrix();
  }  
}
