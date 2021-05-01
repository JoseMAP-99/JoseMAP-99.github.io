class Images {
  
  private ArrayList images;
  private int nImages;
  private ArrayList paths;
  private int current;
    
  public Images(String[] paths) {
    this.images = new ArrayList<PImage>(); 
    this.paths = new ArrayList<String>();   
    this.nImages = paths.length;
    this.current = -1;    
    init(paths);
  }
  
  //-----Función que carga sólo aquellos fichero ".jpg" o ".png"------//
  private void init (String [] paths) { 
    for (String path : paths) {
      if (!path.endsWith(".jpg") && !path.endsWith(".png")) {
        this.nImages--;
        continue;
      }
      this.paths.add(path);
      this.images.add(loadImage("images/" + path));
    }
  }
  
  //-----Función que obtiene la imagen anterior, cambiando el índice al adecuado (circular)-----//
  public PImage getPrevImage() {
    this.current--;
    if (this.current < 0) this.current = this.nImages - 1;
        
    return (PImage) this.images.get(this.current);
  }
  
  public PImage getNextImage() {
    this.current++;
    if (this.current >= this.nImages) this.current = 0;
    
    return (PImage) this.images.get(this.current);
  }

  public String getName (int added) {   
    int aux = this.current + added;     
    if (aux < 0) {
      aux = this.nImages - 1;
    } else if (aux >= this.nImages) {
      aux = 0;
    }
    return (String) this.paths.get(aux);
  }
  
  public int getCount () {
    return this.nImages;  
  }  
}
