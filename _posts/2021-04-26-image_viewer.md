# Filtros para imágenes

`Autor: José María Amusquívar Poppe`

Para el desarrollo de esta práctica se ha solicitado la realización de una aplicación que incorpore distintas manipulaciones de *shaders*, empleando para ello el lenguaje de alto nivel *OpenGL Shading Language*[^1], el cual proporciona mayor versatilidad para el desarrollo de renderizados. La aplicación implementada constituye una interfaz de usuario que permite al usuario visualizar imágenes de su disco duro y aplicarles una serie de filtros predefinidos en la aplicación (Figura 1).

![](/images/image_viewer/vPrincipal.PNG "Fig. 1: Interfaz de usuario de la aplicación")

<br/>

1. TOC
{:toc}

<br/>

## Introducción

El proyecto a realizar tiene como objetivo practicar las distintas maneras de ,manipular *shaders* aplicados, en este caso, sobre imágenes proporcionados por el usuario. Para este cometido se emplea el lenguaje *GLSL*, cuya sintaxis es similar a la de *C*[^2], generando un fichero independiente en formato *.glsl*, el cual es cargado con la función *loadShader()* en el entorno de *Processing*[^3]. Así pues, la aplicación carga por defecto todas las imágenes contenidas en la carpeta "data/images/", por lo que será necesario disponer de dicha carpeta con algún fichero de imagen, en formato *.jpg* o *.png*, para que la aplicación funcione adecuadamente. Todas las imágenes son cargadas en el proyecto y puestas a disposición del usuario mediante acciones de "Next" y "Previous", además de las respectivas teclas que aplican los filtros a las imágenes.

<br/>
<br/>

## Propuesta de diseño

El diseño elegido para este proyecto está constituido por dos vistas, una de ayuda y la otra se corresponde con la vista principal de la aplicación. Esta última está constituida por un fondo de pantalla que decora la interfaz final, además de disponer tres botones presentes en pantalla, cada uno con una función específica como cambiar de imagen y el botón de ayuda. Dentro de esta vista también se proporciona textos que representan el nombre de las imágenes, extraídos de su ruta (Figura 2). El aspecto más importante de esta vista es la capacidad de poder aplicar los filtros a la imagen actual, estos filtros se pueden enumerar en cuatro: detección de bordes, alteración de píxeles, inversión de los colores y un filtro que deforma la imagen en círculos.

| Vista principal |
| - |
| ![](/images/image_viewer/vVisualizacion.PNG "Fig. 2: Vista general de la aplicación") |

La segunda vista es la de ayuda, accesible desde el botón *HELP* o pulsando la tecla 'H' cuando se necesite. En esta vista se explica de forma general cómo funciona la aplicación mostrando los controles disponibles (Figura 3).

| Vista de ayuda |
| - |
| ![](/images/image_viewer/vAyuda.PNG "Fig. 3: Manual de uso y ayuda de la aplicación") |

#### Controles

Los controles están disponibles desde la vista de ayuda de la aplicación (Figura 3). Los distintos controles disponibles permiten al usuario manipular las imágenes, así como aplicarles filtros, saltarlos, y, obviamente, disfrutar de las imágenes.

**TECLADO**

* **Tecla 'H':** Abre la vista de ayuda.

* **Tecla 'LEFT' - 'RIGHT':** Cambia a la imagen siguiente o anterior.

**RATÓN**

* **Click sobre 'HELP':** Abre la vista de ayuda.

* **Click izquierdo sobre 'PREV' - 'NEXT':** Cambia al sonido siguiente o anterior.

**FILTROS**

* **Tecla '1':** Detección de bordes.

* **Tecla '2':** Alteración de píxeles.

* **Tecla '3':** Inversión de colores.

* **Tecla '4':** Deformación circular.

<br/>
<br/>

## Recursos empleados

Para la realización de esta práctica se ha empleado *Processing*[^3], que se define como un lenguaje de programación y entorno de desarrollo integrado de código abierto basado en Java. 

Se ha empleado el languaje *GLSL*[^1], que se define como un lenguaje de alto nivel de sombreado con una sintaxis basada en el lenguaje de programación C.

Junto al proyecto se adjuntan imágenes de prueba libres de derechos de autor, todas ellas extraídas de la página *Pixabay*[^4].

Para obtener el GIF del videojuego se optó por la librería *gifAnimation*, sin embargo, debido a problemas de lentitud en la captura de *frames*, se optó por obtener el GIF grabando la pantalla y pasándolo a dicho formato final.

<br/>
<br/>

## Desarrollo del código

El código de esta práctica se estructura en cuatro clases: la clase principal, la clase de ayuda, la clase de ficheros y la clase de imágenes. La primera alberga los métodos importantes del proyecto, la segunda se trata de un objeto que se encarga de mostrar los textos de la aplicación, la tercera se encarga de leer las rutas de las imágenes de la carpeta "data/images/", y la cuarta clase se encarga de cargar estas imágenes en la aplicación como *PImage*, así como proporcionar distintos mecanismos de interacción.

A continuación se procederá a explicar el código realizado en *Processing*, empezando con la clase principal:

#### Variables empleadas

Para conseguir que la aplicación funcione adecuadamente, se ha empleado una serie de variables con determinadas funciones, tal y como se puede apreciar en el siguiente fragmento de código:

    //------Variables para shaders------//
    PShader edges, pixels, invert, circle;

    //-----Variable para imagen actual y fondo------//
    PImage actual, backG;

    //------Variable de estado y pulsaciones------//
    boolean btnHelp; 
    boolean [] keys;

    //------Dimensiones fijas de las imágenes, se aplica redimensión-----//
    static final int widthI = 640, heightI = 427;

     //-------Objetos personales de ayuda-------//
    Files files;
    Images images;
    Help help;

<br/>

#### Función *setup()*

En esta función se han inicializado las distintas variables existentes, la imagen de fondo, los distintos *shaders* y objetos personales, así como la obtención de la primera imagen a mostrar.

    void setup() {
      //------Dimensión fija de la aplicación------//
      size(700, 900, P3D);

      //------Imagen de fondo de la aplicación------//
      backG = loadImage("background.jpg");

      //--------Asignación de los objetos personales-------//
      files = new Files("/images");
      help = new Help();
      images = new Images(files.getFiles());
      actual = images.getNextImage();

      //---------Carga de los distintos shaders------//
      edges = loadShader("shaders/Edges.glsl");
      pixels = loadShader("shaders/Pixels.glsl"); 
      invert = loadShader("shaders/Invert.glsl"); 
      circle = loadShader("shaders/Circle.glsl"); 

      //--------Inicialización de las variables de estado------//
      btnHelp = true;
      keys = new boolean[4];

      //-----Establece el centrado de las imágenes-------//
      imageMode(CENTER);
    }

<br/>

#### Función de obtención de imágenes *getPrevNextImage(boolean b)*

En esta función se obtiene la imagen siguiente o anterior según el valor del booleando pasado como parámetro.

    void getPrevNextImage(boolean prev) {      
      //----Obtención de la imagen según el booleano-----//
      actual = (prev)? images.getPrevImage() : images.getNextImage();
    }
    
<br/>

#### Función de dibujado general *draw()*

Esta función es la que se ocupa de mantener el tablero actualizado, y está constituida en cuatro secciones: la primera se encarga de comprobar si se ha activado el mensaje de ayuda; la segunda se encarga de comprobar el tamaño del fondo de pantalla y redimensionarlo si fuese necesario; la tercera se encarga de mostrar los textos informativos en la vista principal; la cuarta sección se encarga de comprobar las dimensiones de la imagen actual, y redimensionarla si fuese necesario, para después aplicarle el filtro adecuado y mostar dicha imagen procesada por pantalla.

    void draw() {
      //-------Se comprueba si la ayuda está activada-------//
      if (btnHelp){  
        help.drawTextHelp();    
        help.drawSquareHelp();
        help.drawStartButton();
        help.drawOwner();
        return;
      }  

      //------Comprobación del tamaño de pantalla y dibujado--------//
      if (width != backG.width || height != backG.height) {
        backG.resize(width, height);      
      }  
      resetShader(); 
      background(backG);  

      //-----Textos de ayuda------//
      help.getActInfo();
      help.getPrevNext();
      help.drawSquareHelp();
      help.drawSystem(); 

      //------Comprobación del tamaño de la imagen actual------//
      if (widthI != actual.width || heightI != actual.height) {
        actual.resize(widthI, heightI);      
      }   

      //-------Se aplica el filtro deseado, y se muestra la imagen------//
      updateFilters();
      image(actual, width/2, height/2); 
    }

<br/>

#### Funciones restantes

Las funciones restantes se corresponden con aquellas encargadas de recoger las pulsaciones de las teclas como *keyPressed()*, además de funciones para capturar las pulsaciones del ratón como *mousePressed()*.

<br/>

#### Clase *Help*

Esta clase es la encargada de mostrar y generar todos los textos de la aplicación, así como los diversos botones existentes, tales como los que se presentan a continuación:

    //------Función que dibuja la información de la imagen actual-----//
    void getActInfo() {
      fill(255);
      textSize(16);
      textAlign(CENTER, TOP);

      text("CURRENT IMAGE", 0, 60, width, 100);
      text(images.getName(0).trim(), 0, 100, width, 140);    
      fill(0);
      textAlign(BASELINE);
    }

    //-----Función que dibuja los botones de siguiente y anterior imagen------//
    void getPrevNext() {
      stroke(255);   
      noFill();
      rect(-1, (height/2) + 380, width/2, height);
      rect(width/2, (height/2) + 380, width, height);

      fill(255);
      textSize(14);    
      textAlign(CENTER, TOP);

      text("PREVIOUS", 0, (height/2) + 385, width/2, height);
      text(images.getName(-1), 0, (height/2) + 425, width/2, height);

      text("NEXT", width/2, (height/2) + 385, width/2, height);
      text(images.getName(1), width/2, (height/2) + 425, width/2, height);

      textAlign(BASELINE);
    }
    
#### Clase *Files*

Esta clase se encarga de leer las rutas de todas las imágenes situadas en la ruta "data/images/", para que, posteriormente, esta información sea transferida a la clase *Images* y pueda cargar todas las imágenes en variables *PImage*.

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
    
<br/>

#### Clase *Images*

Esta clase se encarga de cargar todas las imágenes leídas en la clase *Files*, y almacenarlas en un *ArrayList<PImage>*. Dentro de esta clase existe una variable que sirve de índice para la obtención del sonido correspondiente del *ArrayList*. Además, únicamente se cargan aquellos ficheros cuya extensión sea *.jpg* o *.png*, con el objetivo de evitar cualquier error. 
Dentro de esta clase existen varios métodos que proporcionan la imagen siguiente o anterior. Los métodos para obtener la imagen anterior o siguiente son similares con la excepción del índice.

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

    //-----Función que obtiene la canción anterior, cambiando el índice al adecuado (circular)-----//
    public PImage getPrevImage() {
      this.current--;
      if (this.current < 0) this.current = this.nImages - 1;

      return (PImage) this.images.get(this.current);
    }

Para consultar el código fuente de la aplicación, puede dirigirse al siguiente enlace:

[Consultar código fuente](https://github.com/JoseMAP-99/JoseMAP-99.github.io/tree/master/codes/IMAGE_VIEWER)

<br/>
<br/>

## Resultados obtenidos

A continuación se muestra la ejecución de la aplicación en *Processing* en formato de GIF (Figura 4).

![](/images/image_viewer/funcionamiento.gif "Fig. 4: Funcionamiento de la aplicación")

<br/>
<br/>

## Descarga del código fuente

Si desea descargar el código fuente, puede hacerlo desde el siguiente enlace:

[Descarga del código fuente](https://downgit.github.io/#/home?url=https://github.com/JoseMAP-99/JoseMAP-99.github.io/tree/master/codes/IMAGE_VIEWER)

<br/>
<br/>

## Referencias

[^1]: [Página de consulta sobre *GLSL*](https://www.khronos.org/opengl/wiki/Core_Language_(GLSL))
[^2]: [Página de consulta en *C*](https://es.wikipedia.org/wiki/C_(lenguaje_de_programaci%C3%B3n))
[^3]: [Página de consulta sobre *Processing*](https://processing.org/)
[^4]: [Página de consulta sobre *Pixabay*](https://pixabay.com/es/)
