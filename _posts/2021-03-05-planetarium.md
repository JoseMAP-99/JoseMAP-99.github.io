# Planetario

`Autor: José María Amusquívar Poppe`

Para el desarrollo de esta práctica se ha solicitado la realización de un sistema de planetas, los cuales orbitan al rededor de una estrella central. Para mayor simplicidad, se ha cogido de ejemplo el Sistema solar, en el que el planeta central es el Sol. Dado que replicar a escala las medidas exactas resultaría en un sistema complejo de visualizar, se ha optado por alterar las medidas, tanto las distancias al Sol como los radios de cada planeta (figura 1).

![](/images/planetarium/principal.PNG "Fig. 1: Interfaz de usuario de la aplicación")

<br/>

1. TOC
{:toc}

<br/>

## Introducción

El Sistema solar está compuesto por una estrella central, el Sol, que acapará más de 99% de la masa total del sistema, seguido de 8 planetas que ocupan la mayor parte de la masa restante. Estos planetas, ordenados según cercanía al Sol, son: Mercurio, Venus, Tierra, Marte, Júpiter, Saturno, Urano y Neptuno. 

Para poder dibujar estos planetas se puede hacer uso de la primitiva 3D *sphere()* o *createShape(SPHERE)*, señanalando en ambos casos es radio deseado de la esfera, habiendo aplicado una función *translate()* previamente para situar el centro del planeta en el punto deseado.

Finalmente, se ha incorporado tres vistas, en la primera el usuario visualiza el Sistema solar e interactúa con él, en la segunda vista el usuario tiene la posibilidad de crear su propio sistema, alterando para ello el radio de cada planeta y su disposición, y la última vista es, simplemente, un menú de ayuda o manual de uso.

<br/>
<br/>

## Propuesta de diseño

El diseño elegido para este proyecto está constituido por un espacio de dibujo y visualización cuyo fondo se corresponde con el del espacio exterior. 

La primera vista a explicar es la del Sistema solar (vista de visualización), en la que cada planeta gira en sus respectivas órbitas, además de estar presente la Luna, los anillos de Saturno, y el querido Plutón. Cada uno de estos planetas posee una textura única semejante al presente en su superficie, señalando con circunferencias blancas las órbitas que describe cada uno (figura 2). En esta vista, el usuario podrá aplicar un *zoom* a todo el Sistema o, bien, rotarlo verticalmente, también dispondrá de 2 botones situados en la parte superior, el primero, *CHANGE*, tiene la funcionalidad de cambiar del modo visualización al modo de creación, o viseceversa; el segundo botón es el de ayuda, *HELP*, que abre una vista en la que el usuario podrá leer el manual de uso así como los controles disponibles.

| Vista de visualización |
| - |
| ![](/images/planetarium/vVisualizacion.PNG "Fig. 2: Vista del Sistema solar") |

La segunda vista se corresponde con la del modo creación, en la que se presenta una estrella central por defecto. En esta vista el usuario podrá añadir los planetas que desee simplemente pulsando *click* izquierdo en la posición requerida, además que podrá limpiar todos los planetas creados o, simplemente, el último, y, también, podrá aumentar o reducir el radio del planeta a crear (figura 3). En esta vista se presentan los mismo botones que en la vista de visualización, con las mismas funcionalidades, además de un contador de planetas y el valor del radio actual.

| Vista de creación |
| - |
| ![](/images/planetarium/vCreacion.PNG "Fig. 3: Vista con planetas personalizados") |

La tercera vista, ya mencionada anteriormente, es la de ayuda, accesible desde el botón *HELP* o pulsando la tecla 'H' cuando se necesite. En esta vista se explica de forma general cómo funciona la aplicación mostrando los controles disponibles (figura 4).

| Vista de ayuda |
| - |
| ![](/images/planetarium/vAyuda.PNG "Fig. 4: Manual de uso y ayuda de la aplicación") |

#### Controles

Tal como se ha mencionado anteriormente, los controles están disponibles desde la vista de ayuda de la aplicación (figura 4). Los distintos controles disponibles permiten interactuar al usuario con el Sistema solar o su propia creación, entre estas interacciones está presenta la acción de rotar, aplicar un *zoom*, alterar el radio del planeta, limpiar los planetas o sólo el último, entre otros.

* **Click izquierdo:** Modo creación. Permite crear un nuevo planeta.

* **Click derecho:** Modo creación. Limpia la pantalla eliminando los planetas creados.

* **Rueda del ratón:** Realiza un *zoom* sobre la figura, según la dirección de la rueda del ratón.

* **Tecla 'S'-'W' o 'Down'-'Up':** Rota la figura verticalmente.

* **Tecla '+'-'-':** Modo creación. Aumenta o reduce el radio del siguiente planeta.

<br/>
<br/>

## Recursos empleados

Para la realización de esta práctica se ha empleado *Processing*[^1], que se define como un lenguaje de programación y entorno de desarrollo integrado de código abierto basado en Java. Este lenguaje se ha utilizado para el desarollo de forma local, sin embargo, para poder publicar el proyecto a través de internet es necesario emplear *p5.js*[^2], que se define como una librería *JavaScript* perteneciente al lado del cliente que posibilita la creación de experiencias interactivas y gráficas, basado en el núcleo de *Processing*.

Por tanto, el proyecto ha sido desarrollado totalmente en *Processing* y, dado que *p5.js* tiene su base en el primero, su respectiva conversión es simple. Para realizar esta conversión se he utilizado la herramienta online *HerokuApp*[^3].

------------REVISAR con p5.js-------------
El código del proyecto ha sido alterado en su versión en *p5.js*, debido a que esta librería no posee herramientas idénticas a las de *Processing*, pero sí equivalentes, tal es el caso de *PVector* que su equivalente en *p5.js* es la función *createVector()*, o la colección *ArrayList* que en *p5.js* puede ser reemplazada sencillamente con un array []. Sin embargo, ha habido cambios más drásticos como es el caso de la librería *Pshape* y sus transformaciones, pues en *p5.js* estas transformaciones deben ser asignadas mediante una variable y se posibilita el uso de las funciones *push()* y *pop()*.

Entre los cambios realizados de más importancia se encuentra el hecho que, a diferencia de *Processing*, para usar gráficos de esta estilo en *p5.js* es requerido trabajar con *WEBGL*, lo que ocasiona cambios respecto a la orientación de los ejes de coordenadas. Para solventar esto, se empleó un *translate()* para mover el eje de coordenadas a la esquina superior izquierda, tal y como ocurre en *Processing*.
----------REVISAR con p5.js----------------

Para obtener el GIF del videojuego se optó por la librería *gifAnimation*, sin embargo, debido a problemas de lentitud en la captura de *frames*, se optó por obtener el GIF grabando la pantalla y pasándolo a dicho formato final.

<br/>
<br/>

## Desarrollo del código

El código de esta práctica se estructura en cuatro clases: la clase principal, la clase de ayuda, la clase de planetas y la clase Planeta. La primera alberga los métodos importantes del proyecto, la segunda se trata de un objeto que se encarga de mostrar los textos de la aplicación, la tercera es un objeto que se encarga de almacenar y tratar todos los planetas existentes a través de una colección, y la cuarta es un objeto que representa a cada planeta.

A continuación se procederá a explicar el código realizado en *Processing*, empezando con la clase principal:

#### Variables empleadas
Para conseguir que la aplicación funcione adecuadamente, se ha empleado una serie de variables con determinadas funciones, tal y como se puede apreciar en el siguiente fragmento de código:

    //--------Objetos personalizados----------//
    Points points; // Colección de planetas introducidos por el usuario
    Points sats; // Colección de satélites generados para el Sistema solar
    Points solar; // Colección de planetas correspondiente al Sistema solar
    Planet center; // Estrella central por defecto en modo creación
    Help help; // Objeto para mostras mensajes de ayuda

    //-------Variables para el fondo del planetario--------//
    PImage backG;
    int sizeX, sizeY;

    //--------Variables para controlar el zoom aplicado---------//
    float zoom, countZoom, minScroll, maxScroll;

    //-------Variables para controlar el radio de los planetas creados--------//
    int radius, minRadius, maxRadius;

    //-------Variable que controla la roación vertical-------//
    float rotateX;

    //--------Contadores de planetas para ambos modos---------------//
    int pos, posIni;

    //--------Variables de estado----------//
    boolean btnHelp, newDraw;

    //-------Vector para controlar las pulsaciones---------//
    boolean [] keys = new boolean[5];

    //-------Listas de valores para el Sistema solar-----------//
    float [] radiusP, distP; // Radios y distancias al Sol
    String [] paths; // Rutas de texturas de cada planeta

<br/>

#### Función *setup()*

En esta función se han inicializado las distintas variables existentes, la imagen de fondo, los valores de los planetas del Sistema solar, las variables de control, entre otros. Además, se ha forzado la pantalla completa con *fullScreen(P3D)* para una mejor visualización.

    void setup() {
      fullScreen(P3D); // Obliga a usar pantalla completa

      //------Carga de fondo y dimensiones de la imagen-----//
      backG = loadImage("media/space.jpg");  
      sizeX = backG.width;
      sizeY = backG.height;

      initPlanets(); // Se inicializan los valores el Sistema solar

      rotateX = 0; //Rotación vertical

      //------Radio de los planetas en modo creación------//
      radius = 30;
      minRadius = 20;
      maxRadius = 200;

      //------Zoom aplicado a ambas vistas--------//
      minScroll = -5;
      maxScroll = 10;
      zoom = 1;
      countZoom = 0;

      //------Número de planetas de ambas vistas-------//
      pos = 1; // Vista de creación
      posIni = radiusP.length; // Vista de visualización

      //-----Variables de estado-----//
      btnHelp = true; // Ayuda activada
      newDraw = false; // Modo creación o visualización

      //-------Se crean los planetas del Sistema solar------//
      solar = new Points();
      sats = new Points();
      loadSolar();  

      //------Se crea la estrella central del modo creación-----//
      points = new Points();
      center = new Planet(50, 0, 0); //Radio, distancia al centro, ángulo de inicio
      points.appendItem(center);

      help = new Help(); // Objeto de ayuda
    }

<br/>

#### Función de inicialización *initPlanets()*

En esta función se inicializan los tres vectores que almacenan los datos de cada planeta del Sistema solar, tanto el radio de cada uno, su distancia al Sol y la textura elegida.

        void initPlanets() {
          radiusP = new float[]{80, 8, 12, 12, 18, 35, 30, 23, 22, 5};
          distP = new float[]{0, 100, 140, 170, 250, 325, 425, 500, 575, 625};
          paths = new String[]{"media/sol.png", "media/mercurio.png", 
                               "media/venus.png", "media/tierra.jpg", 
                               "media/marte.jpg", "media/jupiter.jpg",
                               "media/saturno.jpg", "media/urano.jpg",
                               "media/urano.jpg", "media/pluton_casi_planeta.jpg"}; 
        }
        
<br/>

#### Función de creación *loadSolar()*

En esta función se genera un objeto Planeta para cada uno de los planetas y satélites deseados en el Sistema solar. Para cada planeta se emplean sus respectivos valores de los tres vectores inicializados anteriormente, mientras que para cada satélite se aplica un *translate()* a la posición central del planeta actual y se genera un nuevo objeto Planeta que orbitará a su alrededor.

    void loadSolar() {
      Planet pt; 
      Planet sat; 
      for (int i = 0; i < posIni; i++) {
        //----Se crea cada planeta y se asigna su textura----//
        pt = new Planet(radiusP[i], distP[i], random(0, 360));
        solar.appendItem(pt);
        pt.setTexture(loadImage(paths[i]));

        //-----Se crea un satélite para cada planeta-----//
        pushMatrix();
        translate(pt.x, pt.y, pt.z);
        sat = new Planet(5, pt.radius + 5, random(0, 360));    
        sats.appendItem(sat);  
        popMatrix();
      }
    }
    
<br/>

#### Función de dibujado general *draw()*

Esta función es la que se ocupa de mantener el tablero actualizado, y está constituida en tres secciones: la primera se encarga de comprobar si se ha activado el mensaje de ayuda; la segunda se encarga de comrpobar el tamaño actual de la pantalla para saber si la imagen de fondo debe o no ser redimensionada y, de este modo, evitar una excepción; la tercera parte se encagra de comprobar el modo en el que está la aplicación y, según ello, dibujar el Sistema solar o los planetas creados por el usuario.

    void draw() {
      //-------Se comprueba si la ayuda está activada-------//
      if (btnHelp){  
        help.drawTextHelp();
        help.drawSquareHelp();
        help.drawStartButton();
        return;
      }

      //------Comprobación del tamaño de pantalla y dibujado--------//
      if (width != sizeX || height != sizeY) {
        backG.resize(width, height);      
      }

      background(backG);   
      help.drawSquareHelp();
      help.drawNewPlanets();

      //------Modo creación o modo visualización-------//    
      if (newDraw){    
        help.drawInfo();
        drawPlanets(false);    
      }else{
        help.drawSystem();
        drawPlanets(true);
        if (!newDraw) drawSats();
      }
      moveShape();
    }
    
<br/>

#### Función de dibujado de los satélites *drawSats()*

Esta función se encarga de dibujar el satélite natural de la Tierra, la Luna, y los anillos de Saturno. Para conseguir esto, se aplica una serie de funciones *translate()* para mover el eje de coordenadas al punto deseado, empleando todo esto dentro de las funciones *pushMatrix()* y *popMatrix()*.

    void drawSats() {
      //-----Se dibuja la Luna-----//  
      Planet planet = sats.getItem(3);        
      pushMatrix();   
      translate(width/2, height/2, -150);
      noFill(); 
      rotateX((-PI/8)+rotateX);
      scale(zoom);
      translate(solar.getItem(3).x, solar.getItem(3).y, solar.getItem(3).z);   
      translate(planet.x, planet.y, planet.z);        
      planet.runPlanet();    
      popMatrix();
      
      //-----Actualización de ángulos y coordenadas------//
      planet.updateAngle();
      planet.updateCoords(); 

      //------Se dibujan los anillos de Saturno-----//
      planet = sats.getItem(6);   
      pushMatrix();   
      translate(width/2, height/2, -150);
      rotateX((-PI/8)+rotateX);      
      scale(zoom);
      translate(solar.getItem(6).x, solar.getItem(6).y, solar.getItem(6).z);        
      rotateX((PI/2.66)+rotateX);

      //----Los anillos están compuestos por varias figuras 'ellipse()'
      stroke(195, 150, 74);
      for (int j = 0; j <= 24; j+=2){        
        ellipse(0, 0, 2*planet.dist+j, (2*planet.dist)+j);
      }

      noStroke();
      popMatrix();  
      
      //-----Actualización de ángulos y coordenadas------//
      planet.updateAngle();
      planet.updateCoords(); 
    }
    
<br/>

#### Función de dibujado de los planetas *drawPlanets()*

Esta función se encarga de dibujar cada planeta, ya sea del Sistema solar o los creados por el usuario, además de ibujar las órbitas que describe cada uno de ellos, empleando la función *ellipse()*. Cada planeta tiene su función *.run()*, la cual se encarga de aplicar un *shape()* de la figura. Al igual que los satélites, los planetas se crean del mismo modo, con la diferencia que se utiliza como punto central la posición del Sol.

    void drawPlanets(boolean isSolar) {
      //-----Se comprueba el modo en el que se encuentra-----//
      int aux = isSolar ? posIni : pos;
      for (int i = 0; i < aux; i++){

        //----Según el modo, se obtiene un planeta de las colecciones-----//
        Planet planet = isSolar ? solar.getItem(i) : points.getItem(i);

        //------Trazado de la óribta--------//
        pushMatrix();
        translate(width/2, height/2, -150);
        rotateX((PI/2.66)+rotateX);
        scale(zoom);
        ellipse(0, 0, 2*planet.dist, (2*planet.dist));
        popMatrix();

        //--------Dibujado del planeta actual--------//
        pushMatrix();   
        translate(width/2, height/2, -150);
        noFill(); 
        rotateX((-PI/8)+rotateX);
        scale(zoom);
        translate(planet.x, planet.y, planet.z);    
        planet.runPlanet();    
        popMatrix();

        //--------Actualización de ángulos y coordenadas----------//
        planet.updateAngle();
        planet.updateCoords();     
      }
    }
    
<br/>

#### Función que comprueba algunas colisiones *checkNewPlanet()*

Esta función se encarga de comprobar si el planeta que se creará colisionará o no con algunos planetas, para este cometido se comprueba el extremo derecho e izquierdo del planeta, comparando si existe algún planeta que ocupe estas posiciones.

    boolean checkNewPlanet(float mouseXPos) {
       float leftPos = 0;
       float rightPos = 0;

       if (mouseXPos > width/2) {
          leftPos = mouseXPos - width/2 - radius;
          rightPos = mouseXPos - width/2 + radius;
       }else{
          leftPos = width/2 - mouseXPos - radius;
          rightPos = width/2 - mouseXPos + radius;
       }

       print("pos " + leftPos + " " + rightPos + "\n");

       for(int i = 0; i < pos; i++) {
         Planet pt = points.getItem(i);
         print((pt.x - pt.radius) + " " + (pt.x + pt.radius) + "\n");
         if (rightPos <= pt.x + pt.radius && rightPos >= pt.x - pt.radius || 
             leftPos >= pt.x - pt.radius && leftPos <= pt.x + pt.radius || 
             rightPos <= -(pt.x + pt.radius) && rightPos >= -(pt.x - pt.radius) ||
             leftPos >= - (pt.x - pt.radius) && leftPos <= -(pt.x + pt.radius)) return false;
       }
       print("------------\n");
       return true;
    }
    
</br>

#### Funciones restantes

Las funciones restantes se corresponden con aquellas encargadas de recoger las pulsaciones de las teclas como *keyPressed()* o *keyReleased()*, además de funciones para capturar las pulsaciones del ratón como *mousePressed()* o *mouseWheel()*.

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

    //-----Función que dibuja los textos en tiempo real en la pantalla de dibujado------//
    void drawInfo() {
        fill(255);
        textSize(18);
        text("Radius: " + radius, 10, 20); 
        text("Planets: " + pos, 10, 40);
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

#### Clase *Points*

Esta clase se encarga de almacenar todos los planetas existentes, empleando para ello una colección del tipo *ArrayList()*. Esta clase tiene sus funciones delegadas para obtener un planeta, añadir uno nuevo, eliminar el último o limpiar toda la lista.

    //-------Función que limpia la lista----------//
    public void clearList(){
      this.points.clear(); 
    }  
    
    //-------Función que elimina el último elemento de la lista---------//
    public void removeLast() {
        this.points.remove(pos - 1);
      }
      
<br/>

#### Clase *Planet*

Esta clase se encarga de generar un objeto Planet, con características como su radios, distancia al centro de rotación, rapidez de movimiento, orientación, así como sus tres componentes X, Y, Z. Esta clase emplea un tipo *PShape* para generar la esfera con todos sus atributos. Este objeto acepta modificaciones a sus atributos, además de aceptar una textura que lo recubra, y otro métodos como *runPlanet()* que muestras la figura por pantalla aplicándole un iluminado con *lights()*. 

Además, existen dos métodos que se encargan de actualizar el estado de la figura actual, ya sea mediante el ángulo de rotación, o las coordenadas X, Z, de la figura. La coordenada Y no se actualiza dado que no sufren cambios en este eje.

    public void runPlanet() {
        rotateY(radians(angle)); 
        lights();
        shape(sphere);
    } 

    public void updateAngle() {
        this.angle += this.orientation * this.fast;
        if (abs(angle) > 360) this.angle = 0;
    }

</br>

Para consultar el código fuente de la aplicación, puede dirigirse al siguiente enlace:

[Consultar código fuente](https://github.com/JoseMAP-99/JoseMAP-99.github.io/tree/master/codes/PLANETARIUM)

<br/>
<br/>

## Resultados obtenidos

A continuación se muestra la ejecución de la aplicación en *Processing* en formato de GIF (figura 5).

![](/images/solid_revolution/funcionamiento.gif "Fig. 5: Funcionamiento de la aplicación")

<br/>
<br/>

## Ejecución en vivo

Debido a que *p5.js* no posee las mismas herramientas que *Processing*, se ha tenido que alterar la aplicación, con el fin de adaptarlo adecuadamente a esta librería. Los controles modificados se listan a continuación.

{% include info.html text="Las teclas '+' y '-' controlan el zoom"%}
{% include info.html text="Click derecho o 'ENTER' para reiniciar"%}

<div style="display: flex; justify-content: center">
  <iframe width="605" height="605" src="https://editor.p5js.org/JoseMAP-99/embed/1aYzzBgZt"></iframe>
</div>

<br/>
<br/>

## Descarga del código fuente

Si desea descargar el código fuente, puede hacerlo desde el siguiente enlace:

[Descarga del código fuente](https://downgit.github.io/#/home?url=https://github.com/JoseMAP-99/JoseMAP-99.github.io/tree/master/codes/SOLID)

<br/>
<br/>

## Referencias

[^1]: [Página de consulta sobre *Processing*](https://processing.org/)
[^2]: [Página de consulta sobre *p5.js*](https://p5js.org/)
[^3]: [Página de conversión *Processing* a *p5.js*](https://pde2js.herokuapp.com/)
