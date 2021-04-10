# Reproductor de sonidos

`Autor: José María Amusquívar Poppe`

Para el desarrollo de esta práctica se ha solicitado la realización de una aplicación que incorpore distintos tratamientos de sonido, pudiendo emplear para ello librerías adicionales como *Minim*[^1], o *SoundCipher*[^2], aparte de la librería nativa de *Processing*[^3] denominada *Sound*. La aplicación implementada constituye una interfaz de usuario que permite al usuario escuchar canciones y controlar algunos parámetros de ésta, además de permitir visualizar en una línea de tiempo las distintas frecuencias de la canción (Figura 1).

![](/images/music_player/vPrincipal.PNG "Fig. 1: Interfaz de usuario de la aplicación")

<br/>

1. TOC
{:toc}

<br/>

## Introducción

El proyecto a realizar tiene como objetivo practicar las distintas opciones de manipulación de sonidos, ya sea modificando su amplitud, frecuencia, ganancia, entre otros aspectos. Para este cometido se ha utilizado la librería *Minim*[^1], la cual, gracias a la clase *AudioPlayer*, proporciona una gran versatilidad para controlar cualquier archivo de sonido. Así pues, la aplicación carga por defecto todas las canciones contenidas en la carpeta "data/music/", por lo que será necesario disponer de dicha carpeta con algín fichero de sonido dentro de ella para que la aplicación funcione adecuadamente. Todas estas canciones son cargadas en el proyecto y puestas a disposición del usuario mediante acciones de "Next" y "Previous", además de dos botones para reproducir/pausar y detener el sonido, además de otras acciones como silenciar el sonido, aumentar/reducir volumen o adelantar/atrasar el sonido.

Finalmente, se ha habilitado dos tipos de controles para un mayor alcance respecto al usuario final, proporcionado los controles mediante el teclado o mediante el ratón del ordenador.

<br/>
<br/>

## Propuesta de diseño

El diseño elegido para este proyecto está constituido por dos vistas, una de ayuda y la otra se corresponde con la vista principal de la aplicación. Esta última está constituida por un fondo de pantalla que decora la interfaz final, además de disponer cinco botones presentes en pantalla, cada uno con una función específica, tales como cambiar de canción, pausar, el botón de ayuda, entre otros. Dentro de esta vista también se proporcionan algunos textos que representan la infromación de las canciones, extraídos de los metadatos de la canción gracias al estándar *ID3*[^4]. El aspecto más importante de esta vista es la representación de las distintas frecuencias del sonido mediante una línea de tiempo, tal como se puede apreciar en la figura 2.

| Vista principal |
| - |
| ![](/images/music_player/vVisualizacion.PNG "Fig. 2: Vista general de la aplicación") |

La segunda vista, ya mencionada anteriormente, es la de ayuda, accesible desde el botón *HELP* o pulsando la tecla 'H' cuando se necesite. En esta vista se explica de forma general cómo funciona la aplicación mostrando los controles disponibles, tanto para el manejo mediante el teclado (figura 3), como para el manejo mediante el ratón del ordenador (figura 4), el cambio entre estas dos ayudas se realiza pulsando sobre el botón *KEYBOARD* o *MOUSE*.

| Vista de ayuda |
| - |
| ![](/images/music_player/vAyuda1.PNG "Fig. 3: Manual de uso y ayuda de la aplicación (TECLADO)") |
| - |
| ![](/images/music_player/vAyuda2.PNG "Fig. 4: Manual de uso y ayuda de la aplicación (RATÓN)") |

#### Controles

Los controles están disponibles desde la vista de ayuda de la aplicación (figura 3 y 4). Los distintos controles disponibles permiten al usuario manipular los sonidos, así como reproducirlos, saltarlos, y, obviamente, disfrutar de la música.

**TECLADO**

* **Tecla 'H':** Abre la vista de ayuda.

* **Tecla 'LEFT' - 'RIGHT':** Cambia al sonido siguiente o anterior.

* **Tecla 'Espacio':** Pausa o reproduce el contenido actual.

* **Tecla '+' - '-':** Aumenta o disminuye el volumen general.

* **Tecla 'M':** Silencia o quita el silencio del sonido actual.

* **Tecla 'R':** Detiene/reinicia el sonido actual.

**RATÓN**

* **Click izquierdo sobre la línea de tiempo:** Adelanta o retrasa el sonido actual.

* **Click izquierdo sobre 'PREV' - 'NEXT':** Cambia al sonido siguiente o anterior.

* **Click izquierdo sobre 'PLAY' - 'PAUSE':** Pausa o reproduce el contenido actual.

* **Click izquierdo sobre 'STOP':** Detiene/reinicia el sonido actual.

<br/>
<br/>

## Recursos empleados

Para la realización de esta práctica se ha empleado *Processing*[^1], que se define como un lenguaje de programación y entorno de desarrollo integrado de código abierto basado en Java. 

Se ha empleado la librería *Minim*[^1] para realizar todas las manipulaciones de sonidos correspondiente. Y, también, se ha empleado la librería *TimeUnit*[^5], para poder realizar la conversión de milisegundos a una cadena de texto en formato "MM:SS min", la cual se más entendible para el usuario final.

Para obtener el GIF del videojuego se optó por la librería *gifAnimation*, sin embargo, debido a problemas de lentitud en la captura de *frames*, se optó por obtener el GIF grabando la pantalla y pasándolo a dicho formato final.

<br/>
<br/>

## Desarrollo del código

El código de esta práctica se estructura en cuatro clases: la clase principal, la clase de ayuda, la clase de ficheros y la clase de canciones. La primera alberga los métodos importantes del proyecto, la segunda se trata de un objeto que se encarga de mostrar los textos de la aplicación, la tercera se encarga de leer las rutas de los sonidos de la carpeta "data/music/", y la cuarta clase se encarga de cargar estos sonidos en la aplicación, así como proporcionar distintos mecanismos para los sonidos.

A continuación se procederá a explicar el código realizado en *Processing*, empezando con la clase principal:

#### Variables empleadas

Para conseguir que la aplicación funcione adecuadamente, se ha empleado una serie de variables con determinadas funciones, tal y como se puede apreciar en el siguiente fragmento de código:

    //------Variable principal Minim---------//
    Minim minim;

    //-------Objetos personales de ayuda-------//
    Files files;
    Songs songs;
    Help help;

    //-------Variable que almacena la canción actual------//
    AudioPlayer song;

    //---------Variables de estado-----------//
    boolean controlsCustom, btnHelp, muted;

    //-----Variables para controlar el volumen-----//
    float volume = 0;
    int i = -7;
    final float minVol = -20.0;
    final float maxVol = 6.0;

    //-----Variables temporizadores para textos-------//
    float timerVol = -1;
    float timerMute = -1;

    //------Variable para el fondo de pantalla-----//
    PImage backG;

    //-------Variables para controlar la auto-reproducción------//
    float position = 0;
    boolean paused = false;

    //-------Variable de ayuda para adelantar y retrasar sonidos-----//
    float posx;
    
<br/>

#### Función *setup()*

En esta función se han inicializado las distintas variables existentes, la imagen de fondo, los distintos objetos personales, así como la obtención del primer sonido a reproducir.

    void setup() {  
      //------Dimensión fija de la aplicación------//
      size(700, 900);  

      //------Imagen de fondo de la aplicación------//
      backG = loadImage("background.png");

      //-------Instancia de la clase Minim-------//
      minim = new Minim(this);

      //--------Asignación de los objetos personales-------//
      files = new Files("/music");  
      songs = new Songs(files.getFiles()); 
      help = new Help();

      //-------Obtención de la primera canción--------//
      song = songs.getNextSong();

      //-------Inicialización de las variables de estado--------//
      controlsCustom = false; // Monitoriza los controles en la vista de ayuda
      btnHelp = true; // Monitoriza si la vista de ayuda está activa
      muted = false; // Monitoriza si el sonido está silenciado o no
    }

<br/>

#### Función de obtención de sonidos *getPrevNextSong(boolean b)*

En esta función se obtiene el sonido siguiente o anterior según el valor del booleando pasado como parámetro, además de reiniciar las distintas variables y mantener la opción de *mute* y la del volumen.

    void getPrevNextSong(boolean prev) {  
      /* Si la canción actual está silenciada, se le quita el
       * silencio por si se vuelve a reproducir.
       */
      if (song.isMuted()) {
        muted = true;
        song.unmute();
      }

      /* Se detiene la canción en su posición actual, o se reinicia si 
       * ésta ha conluido "stopSong()"
       */
      if (!song.isPlaying() && position > 0) {
        stopSong();
      } else {
        song.pause();
      }

      //----Obtención de la canción según el booleano-----//
      song = (prev)? songs.getPrevSong() : songs.getNextSong();

      //-----Si el silenciado está activado, se silencia el nuevo sonido-----//
      if (muted) song.mute();

      //-----Se establece el volumen general y se reinician variables-------//
      song.setGain(i); 
      position = 0;
      paused = true;
    }
    
<br/>

#### Función de obtención de duración *milisToTime(long milis)*

En esta función se transforma los milisegundos pasado como parámetro a una cadena de texto entendible para el ser humano siguiendo el formato "MM:SS min", para esto se ha empleado la librería *TimeUnit*.

    String milisToTime(long millis) {
      return String.format("%02d:%02d min", 
              TimeUnit.MILLISECONDS.toMinutes(millis),
              TimeUnit.MILLISECONDS.toSeconds(millis) - 
              TimeUnit.MINUTES.toSeconds(TimeUnit.MILLISECONDS.toMinutes(millis))
            );
    }
    
<br/>

#### Función de avance/retroceso *skipBF()*

Esta función sólo se activa cuando el usuario hace *click* izquierdo en la línea de tiempo del sonido con el objetivo de adelantar o retrasarlo. Para conseguir esto, se mapea la posición del ratón cuyo rango es "0-width" a "0-duration", donde *width* es el ancho de la aplicación, y *duration* es la duración del sonido en millisegundos.

    void skipBF() {
      //-----Obtiene la posición del ratón-----//
      float pos = mouseX;    

      //-----Obtiene la duración del sonido-----//
      float duration = song.length();

      //-----Realiza un mapeo de "pos" de rango "0-width" al rango "0-duration"-----// 
      int timeToSkip = (int) map(pos, 0, width, 0, duration);    

      //-----Comprueba si es un avance o retroceso del sonido------//
      if (pos > posx) {      
        timeToSkip -= position;
      } else {
        timeToSkip = -((int) position - timeToSkip);
      }

      //------Salta a dicha posición------//
      song.skip((int) timeToSkip);
    } 
    
<br/>

#### Función de dibujado general *draw()*

Esta función es la que se ocupa de mantener el tablero actualizado, y está constituida en cinco secciones: la primera se encarga de comprobar si se ha activado el mensaje de ayuda; la segunda se encarga de mostrar los textos informativos en la vista principal; la tercera sección se encarga de mostrar temporalmente un texto informativo respecto al volumen y *mute*, los cuales desaparecene en pocos segundos, a fin de evitar cargar la interfaz de usuario con mucho texto; la cuarta sección se encarga de trazar la línea de tiempo con frecuencias del sonido, tanto la horizontal como la circular; la última sección se encarga dibujar una línea vertial roja, que representa la posición actual del sonido.

    void draw () { 
       //-------Se comprueba si la ayuda está activada-------//
      if (btnHelp){  
        help.drawTextHelp();    
        help.drawSquareHelp();
        help.drawStartButton();
        help.drawOwner();
        help.drawControls();
        return;
      }  

      //-----Fondo de pantalla y textos de ayuda------//
      background(backG);   
      help.getInfoSong();
      help.getPrevNext();
      help.drawPanel();
      help.drawSquareHelp();
      help.drawSystem();    

      //------Muestra volumen en pantalla durante un momento-----//
      if (timerVol > -1 && timerVol < 80) {
        help.drawVolume();
        timerVol++;
      }

      //------Muestra *mute* en pantalla durante un momento-----//
      if (timerMute > -1 && timerMute < 80) {
        help.drawMute();
        timerMute++;
      }

      //-----Si la canción termina sola, avanza a la siguiente automáticamente-------//
      if (!paused && !song.isPlaying() && position > 0) {
        getPrevNextSong(false);
        song.play();
        paused = false;
      }

      //-----Almacena la posición actual de la canción-------//
      position = song.position();

      //-------Genera las vibraciones del sonido en pantalla (lineal y circular)------//  
      for(int i = 0; i < song.bufferSize() - 1; i++) {
        float x1 = map(i, 0, song.bufferSize(), 0, width);
        float x2 = map(i + 1, 0, song.bufferSize(), 0, width);

        stroke(255);
        line(x1, (height/2) - song.left.get(i) * 70, x2, (height/2) + song.left.get(i+1) * 70);

        stroke(255, 0, 255, 20);
        line(width/2 - song.left.get(i)*180, (3*height/4) + song.right.get(i+1)*180, width/2, 3*height/4);
        line(width/2 + song.left.get(i)*180, (3*height/4) + song.right.get(i+1)*180, width/2, 3*height/4);
      }

      //-------Genera una línea roja que indica la posición actual de la canción------//
      stroke(255, 0, 0);
      posx = map(song.position(), 0, song.length(), 0, width);  
      line(posx, (height/2) - 110, posx, (height/2) + 110);   
    }
    
<br/>

#### Funciones restantes

Las funciones restantes se corresponden con aquellas encargadas de recoger las pulsaciones de las teclas como *keyPressed()*, además de funciones para capturar las pulsaciones del ratón como *mousePressed()*, y una función corta para detener el sonido actual.

<br/>

#### Clase *Help*

Esta clase es la encargada de mostrar y generar todos los textos de la aplicación, así como los diversos botones existentes, tales como los que se presentan a continuación:

    //-----Función que dibuja el botón de ayuda-----//
    void drawSquareHelp() {
      fill(0);
      stroke(255);
      rect((width - 50), btnYH, btnWH, btnH);   
      fill(255);
      textSize(14);
      text("HELP", (width - 50)+4, btnYH+15);
      fill(0);
    }
    
    //------Función que dibuja la información del sonido actual-----//
    void getInfoSong() {
      fill(255);
      textSize(16);
      textAlign(CENTER, TOP);

      meta = song.getMetaData(); // Obtención de los metadatos del sonido
      y = ys;
      text("CURRENT SONG", 0, y - 40, width, y);
      text("File Name: " + meta.fileName().split("/")[1].trim(), 0, y, width, y + 40);    
      text("Title: " + meta.title().trim(), 0, y+=yi, width, y+yi);
      text("Album: " + meta.album().trim(), 0, y+=yi, width, y+yi);
      text("Author: " + meta.author().trim(), 0, y+=yi, width, y+yi);    
      text("Duration: " + milisToTime(song.length()), 0, y+=yi, width, y+yi);
      text("Date: " + meta.date().trim(), 0, y+=yi, width, y+yi);
      text("Genre: " + meta.genre().trim(), 0, y+=yi, width, y+yi);
      fill(0);
      textAlign(BASELINE);
    }
      
    //------Función que dibuja el botón de play/pause y stop-----//
    void drawPanel() {
      noFill();
      stroke(255);
      rect((width/2) - 50, (height/2) + 330, 100, 50);
      line((width/2), (height/2) + 330, (width/2), (height/2) + 380);

      fill(255);
      rect((width/2) + 10, (height/2) + 340, 30, 30);  

      if (song.isPlaying()) {
        rect((width/2) - 40, (height/2) + 340, 13, 30); 
        rect((width/2) - 23, (height/2) + 340, 13, 30); 
      } else {
        triangle(x1, y1, x2, y2, x3, y3); 
      }
      fill(0);
    }
    
<br/>

#### Clase *Files*

Esta clase se encarga de leer las rutas de todos los sonidos situados en la ruta "data/music/", para que, posteriormente, esta informaicón sea transferida a la clase *Songs* y pueda cargar todos los sonidos.

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
      println("Se han encontrado " + this.paths.length + " canciones"); 
    }    
    
<br/>

#### Clase *Songs*

Esta clase se encarga de cargar todos los sonidos leídos en la clase *Files*, y almacenarlos en un *ArrayList<AudioPlayer>*. Dentro de esta clase existe una variable que sirve de índice para la obtención del sonido correspondiente del *ArrayList*. Además, únicamente se cargan aquellos ficheros cuya extensión sea *.mp3* o *.wav*, con el objetivo de evitar cualquier error. 
Dentro de esta clase existen varios métodos que proporcionan la canción siguiente o anterior, además de establecer el índice a un deseado para obtener cualquier sonido requerido. Los métodos para obtener el sonido anterior o siguientes son similares con la excepción del índice.

    //-----Función que carga sólo aquellos fichero ".mp3" o ".wav"------//
    private void init () {
      for (String path : this.paths) {
        //-------Se emplea la función "endsWith()" para tal cometido------//
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

Para consultar el código fuente de la aplicación, puede dirigirse al siguiente enlace:

[Consultar código fuente](https://github.com/JoseMAP-99/JoseMAP-99.github.io/tree/master/codes/MUSIC_PLAYER)

<br/>
<br/>

## Resultados obtenidos

A continuación se muestra la ejecución de la aplicación en *Processing* en formato de GIF (figura 5).

![](/images/music_player/funcionamiento.gif "Fig. 5: Funcionamiento de la aplicación")

<br/>
<br/>

## Descarga del código fuente

Si desea descargar el código fuente, puede hacerlo desde el siguiente enlace:

[Descarga del código fuente](https://downgit.github.io/#/home?url=https://github.com/JoseMAP-99/JoseMAP-99.github.io/tree/master/codes/MUSIC_PLAYER)

<br/>
<br/>

[^1]: [Página de consulta sobre *Minim*](http://code.compartmental.net/tools/minim/)
[^2]: [Página de consulta en *SoundCipher*](http://explodingart.com/soundcipher/)
[^3]: [Página de consulta sobre *Processing*](https://processing.org/)
[^4]: [Página de consulta sobre *ID3*](https://id3.org/)
[^5]: [Página de consulta sobre *TimeUnit*](https://docs.oracle.com/javase/7/docs/api/java/util/concurrent/TimeUnit.html)

