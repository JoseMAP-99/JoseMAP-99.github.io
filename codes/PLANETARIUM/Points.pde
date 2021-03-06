import java.util.ArrayList;

class Points {
  
  private ArrayList<Planet> points;
  
  public Points(){
    this.points = new ArrayList<Planet>();
  }   
  
  public boolean appendItem(Planet pt) {
     return this.points.add(pt);
  }
  
  public Planet getItem(int index){   
    if (index >= 0 && index < this.points.size()){
      return this.points.get(index);
    }
    System.out.println("Indice erróneo");
    return null;
  }
  
  public void clearList(){
    this.points.clear(); 
  }  
  
  public void removeLast() {
    this.points.remove(pos - 1);
  }
}
