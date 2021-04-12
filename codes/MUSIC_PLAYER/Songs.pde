class Songs {
  
  private ArrayList songs;
  private int nSongs;
  private String [] paths;
  private int current;
  
  private final float reduceVol = -7.0;
  
  public Songs(String[] paths) {
    this.songs = new ArrayList<AudioPlayer>();    
    this.nSongs = paths.length;
    this.paths = paths;
    this.current = -1;    
    init();
  }
  
  //-----Función que carga sólo aquellos fichero ".mp3" o ".wav"------//
  private void init () {
    for (String path : this.paths) {
      if (!path.endsWith(".mp3") && !path.endsWith(".wav")) {
        this.nSongs--;
        continue;
      }
      this.songs.add(minim.loadFile("music/" + path));
    }
  }
  
  //-----Función que obtiene la canción anterior, cambiando el índice al adecuado (circular)-----//
  public AudioPlayer getPrevSong() {
    this.current--;
    if (this.current < 0) this.current = this.nSongs - 1;
        
    AudioPlayer s = (AudioPlayer) this.songs.get(this.current);
    s.setGain(this.reduceVol);
    return s; 
  }
  
  public AudioPlayer getNextSong() {
    this.current++;
    if (this.current >= this.nSongs) this.current = 0;
    
    AudioPlayer s = (AudioPlayer) this.songs.get(this.current);
    s.setGain(this.reduceVol);
    return s;  
  }
  
  public int getCount () {
    return this.nSongs;  
  }
  
  public void setCurrent (int added) {
    if (added > 0) {
      this.current++;
      if (this.current >= this.nSongs) this.current = 0;
    } else {
      this.current--;
      if (this.current < 0) this.current = this.nSongs - 1;
    }
  }
}
