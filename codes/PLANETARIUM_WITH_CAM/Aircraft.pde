class Aircraft {
  private float x;
  private float y;
  private float z;
    
  private float speed;
  
  PShape nave; 
    
  Aircraft() {
    this.x = 50;
    this.y = height/2;
    this.z = 0;
    
    nave = loadShape("media/nave/space-shuttle-orbiter.obj");
    
    this.speed = 5;
  }
  
  void runAircraft() {
     pushMatrix();
     translate(this.x, this.y, this.z);
     scale(0.03*zoom);
     rotateX(PI);
     rotateY(-PI/2);
     shape(nave);
     popMatrix();
  }
    
  void updateX(float newX) {
    this.x += newX*this.speed;
  }
  
  void updateY(float newY) {
    this.y += newY*this.speed;
  }
  
  void updateZ(float newZ) {
    this.z += newZ*this.speed;
  }
  
  void setSpeed(float newSpeed) {
    this.speed = newSpeed;  
  }  
  
  void resetCoords() {
    this.x = 50;
    this.y = height/2;
    this.z = 0; 
  }
}
