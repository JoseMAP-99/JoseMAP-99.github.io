class Files {
  
  String [] paths;
  File dir;
  
  public Files(String path) {
    this.dir = new File(dataPath("") + path);
    
    println();
    
    init();
  }
  
  public String[] getFiles() {
    return this.paths;  
  }
  
  //-----Función que lista todos los ficheros de dicha ruta-----//
  private void init() {
    this.paths = dir.list();
    if (this.paths == null) {
      println("Ruta no encontrada");
      return;
    }
        
    for (String file : this.paths) {
      println (file);
    }  
    println("Se han encontrado " + this.paths.length + " imagenes"); 
  }
}
