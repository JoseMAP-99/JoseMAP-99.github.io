class Planet {
  private float radius;
  private float dist;
  private float angle;
  private float fast;
  private int orientation;
  private int [] orient = new int[] {-1, 1}; 
  
  private float x;
  private float y;
  private float z;
  
  private final float minFast = 0.1;
  private final float maxFast = 1.1;
  PShape sphere;
  
  public Planet(float radius, float dist, float angle) {
    this.radius = radius; // Radio de la esfera
    this.dist = dist; // Distancia al centro de dibujado
    this.angle = angle; // Ángulo de rotación y traslación
    this.fast = random(minFast, maxFast); // Velocidad de rotación
    this.orientation = orient[(int) random(0, 2)]; // -1 = LEFT, 1 = RIGHT
    
    this.x = this.dist;
    this.y = 0;
    this.z = 0;
    
    noStroke();
    if (newDraw) fill(random(10, 255), random(10, 255), random(10, 255));
    sphere = createShape(SPHERE, this.radius);    
  }
  
  public void setTexture(PImage newImg){
    sphere.setTexture(newImg); 
  }
  
  public void setRadius(float newRadius) {
    this.radius = newRadius;
  }
  
  public void updateRadius(float radius) {
    this.radius += radius;
  }
  
  public void setAngle(float newAngle) {
    this.angle = newAngle;  
  }
  
  public void setFast(float newFast) {
    this.fast = newFast;  
  }
  
  public void setOrientation(int newOrientation) {
    this.orientation = newOrientation;  
  }
  
  public void setDist(float newDist) {
    this.dist = newDist;  
  }
  
  public void runPlanet() {
    rotateY(radians(angle)); 
    lights();
    shape(sphere);
  } 
  
  public void updateAngle() {
    this.angle += this.orientation * this.fast;
    if (abs(angle) > 360) this.angle = 0;
  }
  
  public void updateCoords() {
    this.x = this.dist * sin(radians(this.angle));
    this.z = this.dist * cos(radians(this.angle)); 
  }
}
