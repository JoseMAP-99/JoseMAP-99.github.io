class Person {
  private float x;
  private float y;
  private float z;
  private float angle;
  private float angleY;
  
  private float focusX;
  private float focusZ;
  
  private int speed;  
    
  private PShape obj;
    
  Person() {
    this.obj = loadShape("media/personaje/mario-sculpture.obj");
    
    this.speed = 5;
    this.angle = 0;
    this.angleY = -7000;
    
    this.focusX = 0;
    this.focusZ = 0;
    
    this.x = 0;
    this.y = 1435;
    this.z = 600;
    
    scale(0.35);
  }
  
  public void runPerson() {
    pushMatrix();    
    translate(this.x, this.y, this.z);    
    rotateY(-(PI + (radians(this.angle))));
    rotateZ(PI);
    shape(this.obj);
    popMatrix();
  }  
  
  void updateAngle(float newAngle) {
    this.angle += newAngle*(this.speed-2);
    
    if (this.angle >= 360 || this.angle <= -360){
      this.angle = 0;  
    }
  }
  
  void updateAngleY(float newAngle) {
    if (this.angleY >= 80000 && newAngle > 0) return;
    if (this.angleY <= -1500000 && newAngle < 0) return;
    
    this.angleY += newAngle*(this.speed*20);    
  }
    
  void updatePos(int bf) {      
    this.x += sin(radians(this.angle))*(bf*this.speed*5);
    this.z += cos(radians(this.angle))*(-bf*this.speed*5); 
  }
  
  void setSpeed(int newSpeed) {
    this.speed = newSpeed;  
  }  
  
  //------Cálculo del punto lejano para camera()---------//
  float[] getFarFocus() {
    // Width*1000 -> Fondo en infinito y menos infinito
    this.focusX = sin(radians(this.angle))*(width*1000);
    this.focusZ = cos(radians(this.angle))*(-width*1000);
    
    return new float[]{focusX, focusZ};
  }
  
  //------Cálculo del punto cercano en tercera persona para camera()---------//
  float[] getCloseFocus() {
    // 300 -> Fondo en personaje en tercera persona
    float xpos = this.x + sin(radians(this.angle))*(-300);
    float zpos = this.z + cos(radians(this.angle))*(300);
    
    return new float[]{xpos, zpos};
  }
    
  void resetCoords() {
    this.angle = 0;
    this.angleY = 0;
    
    this.focusX = 0;
    this.focusZ = 0;
    
    this.x = 0;
    this.y = 1435;
    this.z = 600;
  }
}
