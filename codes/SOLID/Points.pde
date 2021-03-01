import java.util.ArrayList;

class Points {
  
  private ArrayList<PVector> points;
  
  public Points(){
    this.points = new ArrayList<PVector>();
  }   
  
  public boolean appendItem(PVector pt) {
     return this.points.add(pt);
  }
  
  public PVector getItem(int index){   
    if (index >= 0 && index < this.points.size()){
      return this.points.get(index);
    }
    System.out.println("Indice erróneo");
    return null;
  }
  
  public void clearList(){
    this.points.clear(); 
  }  
  
  public float[] getYs() {
    float infY = 0;
    float supY = height;
    for(PVector pt : this.points) {
      if (pt.y > infY) {
        infY = pt.y;  
      }
      
      if (pt.y < supY) {
        supY = pt.y;  
      }
    }
    return new float[] {supY, infY};
  }
  
}
