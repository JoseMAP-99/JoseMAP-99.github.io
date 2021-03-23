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

Esta función es la que se ocupa de mantener el tablero actualizado, y está constituida en tres secciones: la primera se encarga de comprobar si se ha activado el mensaje de ayuda; la segunda se encarga de comrpobar el tamaño actual de la pantalla para saber si la imagen de fondo debe o no ser redimensionada y, de este modo, evitar una excepción; la tercera parte se encagra de comprobar el modo en el que está la aplicación y, según ello, dibujar el Sistema solar o los planetas creados por el usuario.





[^1]: [Página de consulta sobre *Processing*](https://processing.org/)
[^2]: [Página de consulta en *Clara.io*](https://clara.io/)
[^3]: [Página de consulta sobre *Mario Bros.*](https://es.wikipedia.org/wiki/Mario_(personaje))
[^4]: [Página de descarga del modelo (*Mario Bros.*)](https://clara.io/view/d7e2b247-379d-4f0f-a5b9-2c94a4c435b8)


