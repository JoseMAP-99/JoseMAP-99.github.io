# Escena personalizada

`Autor: José María Amusquívar Poppe`

Para el desarrollo de esta práctica se ha solicitado la realización de una escena que incluya diversas herramientas de *Processing*[^1], tales como luces, movimiento de cámara, texturas y todos los extras que se deseen. Por tanto, la escena implementada constituye un gran espacio sobre el cual se presentan diversas estructuras del mundo real, tales como la Torre Eiffel, El Cristo Redentor, entre otras (Figura 1).

![](/images/custom_scene/vPrincipal.PNG "Fig. 1: Interfaz de usuario de la aplicación")

<br/>

1. TOC
{:toc}

<br/>

## Introducción

La práctica a realizar tiene como objetivo abarcar todos los contenidos vistos hasta ahora, haciendo enfásis en las luces, movimientos de cámara o formas tridimensionales. Así pues, se ha decidido montar un expositor de asombrosas estructuras del mundo actual, ya sean consideradas una de las maravillas del mundo o simplemente sea una imponente estructura diseñada por el ser humano. Entre las estructuras presentadas en este expositor se encuentran: El Cristo Redentor (Río de Janeiro, Brasil), La gran pirámide de Guiza (Guiza, Egipto), Chichen Itzá (Yucatán, México), la torre Eiffel (París, Francia) y una similitud al Coliseo (Roma, Italia).

Para poder montar el expositor, se han obtenido todos los modelos de las estructuras mencionadas anteriormente en la página *Clara.io*[^2], aplicándoles una debida rotación y un reescalado. Además, se ha añadido un personaje que será el que controle el usuario a través del espacio presentado, este personaje se corresponde con el hábil fontanero de los videojuegos, *Marios Bros.*[^3], cuyo modelo *.obj* también ha sido extraído de *Clara.io*, conjuntamente con su textura característica.

Finalmente, se ha incorporado 2 vistas, en una se presenta el menú de ayuda o manual de uso disponible en todo momento, y la otra se corresponde con la vista principal, en la que se presentan las distintas estructuras junto a *Mario Bros.*. En esta última vista el usuario puede controlar al personaje a través de todo el expositor, pudiendo cambiar el vista de la cámara a primera o tercera persona, tal como se requiera.

<br/>
<br/>

## Propuesta de diseño

El diseño elegido para este proyecto está constituido por un gran espacio sobre el que se sitúan las diversas estructuras, con un fondo para decorar la aplicación.

La primera vista a explicar es la vista principal sobre la que se encuentran todas las estructuras, cada una con un color distinto y con su respectivo nombre sobre sí mismas. Estas estructuras están situadas en coordenadas fijas del espacio y distantes entre ellas. Al iniciar esta vista, el usuario se enontrará con el personaje de *Mario Bros.* en tercera persona y de fondo la estructura de *El Cristo Redentor*. Este personaje puede ser desplazado hacia adelante y hacias atrás, además de poder rotar sobre su propio eje para poder desplazarse hacia la derecha o izquierda, y también puede rotar verticalmente la cámara para simular la mirada del personaje, modificando en todo momento los parámetros de la función *camera()*. En todo momento, el usuario podrá cambiar el tipo de iluminación de la escena, al igual que los colores de ésta, y el tipo de cámara deseado (Figura 2).

| Vista principal |
| - |
| ![](/images/custom_scene/vVisualizacion.PNG "Fig. 2: Vista del expositor (Primera persona)") |

La tercera vista, ya mencionada anteriormente, es la de ayuda, accesible desde el botón *HELP* o pulsando la tecla 'H' cuando se necesite. En esta vista se explica de forma general cómo funciona la aplicación mostrando los controles disponibles, tanto para el manejo general (figura 3), como para el manejo del personaje (figura 4), el cambio entre estas dos ayudas se realiza pulsando sobre el botón *GENERAL* o *MARIO*.

| Vista de ayuda |
| - |
| ![](/images/custom_scene/vAyuda1.PNG "Fig. 3: Manual de uso y ayuda de la aplicación (GENERAL)") |
| - |
| ![](/images/custom_scene/vAyuda2.PNG "Fig. 4: Manual de uso y ayuda de la aplicación (MARIO BROS)") |

Tal como se comentó anteriormente, para el desarrollo de *Mario Bros.* se ha usado un objeto *.obj* ya definido, encontrado en *Clara.io*. Este modelo[^4] fue cargado a *Processing* empleando la función *loadShape()*, y reescalado a las dimensiones correspondientes, tal como se ve en las imágenes de funcionamiento.

#### Controles

Los controles están disponibles desde la vista de ayuda de la aplicación (figura 3 y 4). Los distintos controles disponibles permiten interactuar al usuario con la escena, las ilumniación o el personaje, entre estas interacciones está presente la acción de desplazarse, rotar o cambiar la iluminación de la escena, etre otros.

**GENERAL**

* **Tecla 'H':** Abre la vista de ayuda.

* **Teclas '0'...'4' (Manual):** Cambia la iluminación manualmente.

* **Tecla 'Espacio' (Automático):** Cambia la iluminación automáticamente.

* **Click derecho:** Genera nuevos colores de iluminación o para las estructuras.

* **Rueda del ratón:** Altera los colores actuales.

**PERSONAJE**

* **Tecla 'W' - 'S' o 'UP' - 'DOWN':** Desplaza el personaje hacia adelante o atrás.

* **Tecla 'A' - 'D' 'LEFT' - 'RIGHT':** Rota la posición del personaje para un mejor desplazamiento.

* **Tecla 'E' - 'Q':** Rota verticalmente la cámara.

* **Tecla 'C':** Cambia la vista de la cámara (Primera o tercera persona).

* **Tecla 'R':** Reinicia la posición del personaje.

<br/>
<br/>

## Recursos empleados

Para la realización de esta práctica se ha empleado *Processing*[^1], que se define como un lenguaje de programación y entorno de desarrollo integrado de código abierto basado en Java. Además, se ha empleado un modelo *.obj* ya definido, encontrado en la página *Clara.io*[^2], desde ahí se puede consultar los detalles de todas las figuras presentadas.

Para obtener el GIF del videojuego se optó por la librería *gifAnimation*, sin embargo, debido a problemas de lentitud en la captura de *frames*, se optó por obtener el GIF grabando la pantalla y pasándolo a dicho formato final.

<br/>
<br/>

## Desarrollo del código


El código de esta práctica se estructura en cuatro clases: la clase principal, la clase de ayuda, la clase de personaje y la clase estructura. La primera alberga los métodos importantes del proyecto, la segunda se trata de un objeto que se encarga de mostrar los textos de la aplicación, la tercera se encarga de generar y controlar todo lo relacionado al personaje de la aplicación, y la última es un objeto que se conrresponde con el tipo de todas las estructuras mostradas sobre el expositor. 

A continuación se procederá a explicar el código realizado en *Processing*, empezando con la clase principal:

#### Variables empleadas

Para conseguir que la aplicación funcione adecuadamente, se ha empleado una serie de variables con determinadas funciones, tal y como se puede apreciar en el siguiente fragmento de código:

    //--------Objetos personalizados----------//
    Help help; // Objeto para mostrar mensajes de ayuda
    Person mario; // Objeto encargado del personaje de la aplicación
    Structure [] structs; // Colección de estructuras

    //--------Variables de estado----------//
    boolean btnHelp, fpView, controlsMario;

    //-------Vector para controlar las pulsaciones---------//
    boolean [] keys = new boolean[11];

    //----------Vector de rutas a objetos------------//
    String [] paths = new String[] {
      "media/brasil/cristo-redentorstl.obj",
      "media/egipto/pyramid.obj",
      "media/mexico/chichen-itza.obj",
      "media/paris/eiffel-tower.obj",
      "media/roma/coliseum.obj"
      };
  
    //------Variables de iluminación---------//
    String mode = "NORMAL LIGHTS"; // Variable que especifica el modo de iluminación
    int indexFilter = 5; // Variable para controlar las iluminaciones

    //----------Variables del espacio expositor-----------//
    int widthBox, heightBox, depthBox;

    //-------Variables para el fondo del planetario--------//
    PImage backG;
    int sizeX, sizeY;
    
    //--------Variables que almacenan el color actual--------//
    float red, green, blue;
    
<br/>

#### Función *setup()*

En esta función se han inicializado las distintas variables existentes, la imagen de fondo, los valores de las distintas estructuras, las variables de control, entre otros. Además, se ha forzado la pantalla completa con *fullScreen(P3D)* para una mejor visualización.

    void setup() {
      //size(1920, 1080, P3D);
      fullScreen(P3D); // Obliga a usar pantalla completa

      //------Carga de fondo y dimensiones de la imagen-----//
      backG = loadImage("media/background.jpg");
      sizeX = backG.width;
      sizeY = backG.height;

      //-----Variables de estado-----//
      btnHelp = true; // Ayuda activada
      fpView = false; // Modo primera o tercera persona
      controlsMario = false; // Tipo de controles a mostrar

      //-----Inicialización de variables principales---------//
      help = new Help();
      mario = new Person();
      structs = new Structure[5];

      generateColor(); // Se generan colores iniciales para la iluminación
      initStructs(); // Se crean las estructuras

      keys[4] = true; // Luces normales por defecto

      //------Medidas del espacio expositor---------//
      widthBox = 20000;
      heightBox = 3000;
      depthBox = 20000;
    }
    
<br/>

#### Función de inicialización *initStructs()*

En esta función se inicializan todas las estructuras del espacio, asignándoles su posición, nombre, rotación, reescalado, entre otros.

    void initStructs() {
      this.structs[0] = new Structure(this.paths[0], new float[]{0, 425, -3000}, 20, "The Christ Redeemer", new float[]{-950, -1500, 0});
      this.structs[1] = new Structure(this.paths[1], new float[]{-4000, 1235, -4000}, 400, "Pyramid of Giza", new float[]{-500, -700, 0});
      this.structs[2] = new Structure(this.paths[2], new float[]{-6000, 1730, 0}, 500, "Chichen Itza", new float[]{-600, -2500, 0});
      this.structs[3] = new Structure(this.paths[3], new float[]{0, 1610, 6000}, 6, "The Eiffel Tower", new float[]{-850, -2800, 0});
      this.structs[4] = new Structure(this.paths[4], new float[]{6000, 1500, 0}, 3000, "Roman Colosseum", new float[]{-800, -1500, 0});
    }
    
<br/>

#### Función de dibujado general *draw()*

Esta función es la que se ocupa de mantener el tablero actualizado, y está constituida en cinco secciones: la primera se encarga de comprobar si se ha activado el mensaje de ayuda; la segunda se encarga de comprobar el tamaño actual de la pantalla para saber si la imagen de fondo debe o no ser redimensionada y, de este modo, evitar una excepción; la tercera parte se encarga de comprobar el modo en el que está la aplicación (primera o tercera persona), y, según ello, modificar el *camera()* correspondiente; la cuarta parte se encarga de mostrar el plano del expositor y los mensajes en pantall; y la última parte se encarga de controlar la iluminación y de actualizar los movimientos del persoanje y de la visualización de las estructuras.

        void draw() { 
          //-------Se comprueba si la ayuda está activada-------//
          if (btnHelp){  
            camera(); 
            help.drawTextHelp();
            help.drawSquareHelp(0);
            help.drawStartButton();
            help.drawOwner();
            help.drawControls();
            return;
          }  

          //------Comprobación del tamaño de pantalla y dibujado--------//
          if (width != sizeX || height != sizeY) {
            backG.resize(width, height);      
          }  
          background(backG); 

          //------Comprobación del modo de cámara--------//
          if (fpView) { // Primera persona
            camera(mario.x, mario.y, mario.z,
                   mario.getFarFocus()[0], mario.angleY, mario.getFarFocus()[1],
                   0.0, 1.0, 0.0); // upX, upY, upZ

          }else{ // Tercera persona
            camera(mario.getCloseFocus()[0], mario.y - 100, mario.getCloseFocus()[1],
                  mario.getFarFocus()[0], mario.angleY, mario.getFarFocus()[1],
                  0.0, 1.0, 0.0);      

          }

          //-------Dibujado del espacio y mensajes-------//
          drawPlane();  
          pushMatrix();
          camera();  
          help.drawSquareHelp(0);
          help.drawSystem();
          popMatrix(); 

          //-------Selección de iluminación--------//
          if (keys[4]) {
            lights();
            mode = "NORMAL LIGHT";
          }
          if (keys[5]) {
            pointLight((int)255*red, (int)255*green, (int)255*blue, mouseX, mouseY, 400);
            lightSpecular(100, 100, 100);
            directionalLight(0.8, 0.8, 0.8, 0, 0, -1);
            mode = "SPECULAR LIGHT";
          }
          if (keys[6]) {
            float val = (float) mouseX/(float) width * (float) 255;
            ambientLight( (int) val*red, 255*green, 255*blue);
            directionalLight(50, 200, 50, -1, 0, 0);
            pointLight(204, 153, 0, mouseX, mouseY, 400);
            mode = "SPOT LIGHT";
          }
          if (keys[7]) {
            float val = (float) mouseX/(float) width * (float) 255;
            ambientLight( (int) val*red, 255*green, 255*blue);
            directionalLight(50, 200, 50, -1, 0, 0);
            spotLight(204, 153, 100, mouseX, mouseY, 500, 0, 0, -1, PI/2, 600);
            mode = "POINT LIGHT";
          } 

          if(keys[8]) {    
            ambientLight(20, 20, 20);
            mode = "POINT LIGHT (DARK) --> LEFT CLICK FOR LIGHTS";
            if (mousePressed && mouseButton == LEFT) {
              pointLight(255*red, 255*green, 255*blue, mouseX, mouseY, 400);
              directionalLight(0.8, 0.8, 0.8, 0, 0, -1);
            }    
          }

          //------Visualización y actualización de movimiento---------/
          showStructs();  
          mario.runPerson();  
          moveShape();
        }

<br/>

#### Función de dibujado del plano y estructuras

Estas funciones se encargan de generar el plano sobre el que se sitúan las estructuras, empleando para ello un *beginShape()* junto a su *endShape()*; y de mostrar las estructuras sobre el plano detallado recientemente.

    void drawPlane() {
        pushMatrix();
        fill(0);
        beginShape();    
        vertex(-(widthBox), heightBox/2, depthBox);
        vertex(-(widthBox), heightBox/2, -depthBox);
        vertex((widthBox), heightBox/2, -depthBox);
        vertex((widthBox), heightBox/2, depthBox);
        endShape(CLOSE);  
        popMatrix();
    }

    void showStructs() {
        for (Structure struct : this.structs) {
            struct.runShape();  
        }
    }

<br/>

#### Funciones restantes

Las funciones restantes se corresponden con aquellas encargadas de recoger las pulsaciones de las teclas como *keyPressed()* o *keyReleased()*, además de funciones para capturar las pulsaciones del ratón como *mousePressed()* o *mouseWheel()*; y una especial que se encarga de generar las tres componentes *RGB* para la iluminación.

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
        text("HELP", (width - 50)+5, btnYH+15);
        fill(0);
    }
    
    //------Función que dibuja el modo de iluminación actual-----//
    void drawSystem() {
        fill(255);
        textSize(18);
        text(mode, 10, 20); 
        fill(0);
    }
      
    //------Función que dibuja el botón de inicio-----//
    void drawStartButton() {
        fill(0);
        stroke(255);
        rect(((width/2) - 25), (height/5 + 640), btnWS, btnH);   
        fill(255);
        textSize(14);
        text("CONTINUE", ((width/2) - 25) + 14, (height/5 + 640) + 15);
        fill(0);
    }
    
<br/>
 
#### Clase *Person*

Esta clase se encarga de representar al personaje *Mario Bros.*, empleando para ello la función "loadShape()". Este objeto posee sus tres coordenadas, al igual que sus respectivos ángulos para permitir las rotaciones verticales y horizontales. Además, posee dos métodos de suma importancia para la función *camera()*, la función *getFarFocus()* y *getCloseFocus()*; la primera se encarga de obtener nuevas coordenadas X y Z para el personaje en tercera persona, usando el ángulo de rotación horizontal actual; la segunda se encarga de obtener nuevas coordeandas X y Z para el centro o fondo de la cámara, es decir, la zona que el personaje ve. Se debe calcular ambos puesto que s ehan permitido las rotaciones del personaje, pudiendo desplazarse a la vez tanto en X y Z.

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

<br/>

#### Clase *Structure*

Esta clase se encarga de respresentar cada estructura del expositor, empleando para ello un *loadShape()*, además, cada estructura posee un nombre identificativo, un color inicial y varios parámetros para posicionarla, rotarla y escalarla adecuadamente. Cada estructura posee un nombre que estará situado por encima de cada una de ellas, este nombre siempre estará de frente al personaje, haciendo que sea más fácil su lectura.

    //--------Función que imprime y rota el nombre según el personaje-----------//
    void drawTitle() {
        pushMatrix();
        rotateY(-radians(mario.angle));
        fill(255);
        textSize(200);    
        text(this.title, titlePos[0], titlePos[1], titlePos[2]);
        popMatrix();
    } 
    

Para consultar el código fuente de la aplicación, puede dirigirse al siguiente enlace:

[Consultar código fuente](https://github.com/JoseMAP-99/JoseMAP-99.github.io/tree/master/codes/CUSTOM_SCENE)

<br/>
<br/>

## Resultados obtenidos

A continuación se muestra la ejecución de la aplicación en *Processing* en formato de GIF (figura 5).

![](/images/custom_scene/funcionamiento.gif "Fig. 5: Funcionamiento de la aplicación")

<br/>
<br/>

## Descarga del código fuente

Si desea descargar el código fuente, puede hacerlo desde el siguiente enlace:

[Descarga del código fuente](https://downgit.github.io/#/home?url=https://github.com/JoseMAP-99/JoseMAP-99.github.io/tree/master/codes/CUSTOM_SCENE)

<br/>
<br/>

[^1]: [Página de consulta sobre *Processing*](https://processing.org/)
[^2]: [Página de consulta en *Clara.io*](https://clara.io/)
[^3]: [Página de consulta sobre *Mario Bros.*](https://es.wikipedia.org/wiki/Mario_(personaje))
[^4]: [Página de descarga del modelo (*Mario Bros.*)](https://clara.io/view/d7e2b247-379d-4f0f-a5b9-2c94a4c435b8)


