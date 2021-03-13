# Planetario mejorado

`Autor: José María Amusquívar Poppe`

Para el desarrollo de esta práctica se ha solicitado la realización de una mejora para el proyecto *Planetario*[^1], realizado en una publicación anterior. Este proyecto consiste en un sistema de planetas, los cuales orbitan al rededor de una estrella central. La mejora realizada sobre este proyecto es la adición de una nave espacial controlable por el usuario a través del sistema planetario, además, se permite cambiar el punto de vista de la cámara, situándolo en la nave espacial (Figura 2) o en una vista general del sistema Solar (Figura 1).

![](/images/planetarium_with_cam/gPrincipal.PNG "Fig. 1: Interfaz de usuario de la aplicación (Vista General)")

![](/images/planetarium_with_cam/vPrincipal.PNG "Fig. 2: Interfaz de usuario de la aplicación (Vista en Primera Persona)")

<br/>

1. TOC
{:toc}

<br/>

## Introducción

El Sistema solar está compuesto por una estrella central, el Sol, que acapara más del 99% de la masa total del sistema, seguido de 8 planetas que ocupan la mayor parte de la masa restante. Estos planetas, ordenados según cercanía al Sol, son: Mercurio, Venus, Tierra, Marte, Júpiter, Saturno, Urano y Neptuno. 

Para poder dibujar estos planetas se puede hacer uso de la primitiva 3D *sphere()* o *createShape(SPHERE)*, señanalando en ambos casos el radio deseado de la esfera, habiendo aplicado una función *translate()* previamente para situar el centro del planeta en el punto requerido.

Finalmente, se ha incorporado tres vistas, en la primera el usuario visualiza el Sistema solar e interactúa con él, en la segunda vista el usuario tiene la posibilidad de crear su propio sistema, alterando para ello el radio de cada planeta y su disposición, y la última vista es, simplemente, un menú de ayuda o manual de uso. En las dos primeras vistas, el usuario puede controlar una nave espacial a través del sistema Solar, pudiendo cambiar la vista general de la cámara a primera persona situado en la nave espacial.

<br/>
<br/>

## Propuesta de diseño

El diseño elegido para este proyecto está constituido por un espacio de dibujo y visualización cuyo fondo se corresponde con el del espacio exterior. 

La primera vista a explicar es la del Sistema solar (vista de visualización), en la que cada planeta gira en sus respectivas órbitas, además de estar presente la Luna, los anillos de Saturno, y el querido Plutón. Cada uno de estos planetas posee una textura única semejante al presente en su superficie, señalando con circunferencias blancas las órbitas que describe cada uno (figura 3). En esta vista, el usuario podrá aplicar un *zoom* a todo el Sistema o, bien, rotarlo verticalmente, también dispondrá de 2 botones situados en la parte superior, el primero, *CHANGE*, tiene la funcionalidad de cambiar del modo visualización al modo de creación, o viseceversa; el segundo botón es el de ayuda, *HELP*, que abre una vista en la que el usuario podrá leer el manual de uso así como los controles disponibles. 

| Vista de visualización |
| - |
| ![](/images/planetarium_with_cam/vVisualizacion.PNG "Fig. 3: Vista del Sistema solar (Primera Persona)") |

La segunda vista se corresponde con la del modo creación, en la que se presenta una estrella central por defecto. En esta vista el usuario podrá añadir los planetas que desee simplemente pulsando *click* izquierdo en la posición requerida, además que podrá limpiar todos los planetas creados o, simplemente, el último, y, también, podrá aumentar o reducir el radio del planeta a crear (figura 4). En esta vista se presentan los mismo botones que en la vista de visualización, con las mismas funcionalidades, además de un contador de planetas y el valor del radio actual.

| Vista de creación |
| - |
| ![](/images/planetarium_with_cam/vCreacion.PNG "Fig. 4: Vista con planetas personalizados (Primera Persona)") |

En las dos vistas mencionadas anteriormente, el usuario puede controlar una nave espacial con el teclado. Entonces, si la vista general de la cámara está activada (figura 1), la nave podrá desplazarse a través del eje *X* e *Y*, en cambio, si la vista en primera persona está activada (figura 2), se añade también el desplazamiento en el eje *Z*, tal como se aprecian en las dos figuras anteriores.

La tercera vista, ya mencionada anteriormente, es la de ayuda, accesible desde el botón *HELP* o pulsando la tecla 'H' cuando se necesite. En esta vista se explica de forma general cómo funciona la aplicación mostrando los controles disponibles, tanto para el manejo general (figura 5), como para el manejo de la nave (figura 6), el cambio entre estas dos ayudas se realiza pulsando sobre el botón *GENERAL* o *AIRCRAFT*.

| Vista de ayuda |
| - |
| ![](/images/planetarium_with_cam/vAyuda1.PNG "Fig. 5: Manual de uso y ayuda de la aplicación (GENERAL)") |
| - |
| ![](/images/planetarium_with_cam/vAyuda2.PNG "Fig. 6: Manual de uso y ayuda de la aplicación (NAVE ESPACIAL)") |

Para el desarrollo de la nave espacial se ha usado un objeto *.obj* ya definido, encontrado en *Clara.io*[^2]. Este modelo fue cargado a *Processing* empleando la función *loadShape()*, y reescalado a las dimensiones correspondientes, tal como se ve en las imágenes de funcionamiento.

#### Controles

Tal como se ha mencionado anteriormente, los controles están disponibles desde la vista de ayuda de la aplicación (figura 5 y 6). Los distintos controles disponibles permiten interactuar al usuario con el Sistema solar, su propia creación, o con la nave espacial, entre estas interacciones está presenta la acción de rotar, aplicar un *zoom*, alterar el radio del planeta, limpiar los planetas o sólo el último, el desplazamiento de la navea, entre otros.

**GENERAL**

* **Rueda del ratón:** Realiza un *zoom* sobre la figura, según la dirección de la rueda del ratón.

* **Tecla 'S' - 'W' o 'Down' - 'Up':** Rota la figura verticalmente.

* **Tecla 'C':** Cambia el punto de vista de la cámara (GENERAL o NAVE).

**MODO CREACIÓN**

* **Click izquierdo:** Permite crear un nuevo planeta.

* **Click derecho:** Limpia la pantalla eliminando los planetas creados.

* **Tecla '+' - '-':** Aumenta o reduce el radio del siguiente planeta.

* **Tecla 'X':** Elimina el último planeta creado.

**NAVE ESPACIAL**

* **Tecla 'R':** Reinicia las coordenadas a las iniciales, al igual que la cámara.

* **Tecla '8' - '2':** Controla el desplazamiento vertical.

* **Tecla '4' - '6':** Controla el desplazamiento horizontal.

* **Tecla 'M' - 'L':** Primera Persona. Controla avance y retroceso de la nave.


<br/>
<br/>

## Recursos empleados

Para la realización de esta práctica se ha empleado *Processing*[^3], que se define como un lenguaje de programación y entorno de desarrollo integrado de código abierto basado en Java. Este lenguaje se ha utilizado para el desarollo de forma local, sin embargo, para poder publicar el proyecto a través de internet es necesario emplear *p5.js*[^4], que se define como una librería *JavaScript* perteneciente al lado del cliente que posibilita la creación de experiencias interactivas y gráficas, basado en el núcleo de *Processing*.

Por tanto, el proyecto ha sido desarrollado totalmente en *Processing* y, dado que *p5.js* tiene su base en el primero, su respectiva conversión es simple. Para realizar esta conversión se he utilizado la herramienta online *HerokuApp*[^5].

El código del proyecto ha sido alterado en su versión en *p5.js*, debido a que esta librería no posee herramientas idénticas a las de *Processing*, pero sí equivalentes, tal es el caso de la colección *ArrayList* que en *p5.js* puede ser reemplazada sencillamente con un array []. Sin embargo, ha habido cambios más drásticos como es el caso de la librería *Pshape* y sus transformaciones, pues en *p5.js* estas transformaciones no pueden ser asignadas a una variable, y se posibilita el uso de las funciones *push()* y *pop()*.

Entre los cambios realizados de más importancia se encuentra el hecho que, a diferencia de *Processing*, para usar gráficos de esta estilo en *p5.js* es requerido trabajar con *WEBGL*, lo que ocasiona cambios respecto a la orientación de los ejes de coordenadas. Para solventar esto, se empleó un *translate()* para mover el eje de coordenadas a la esquina superior izquierda, tal y como ocurre en *Processing*.

Para obtener el GIF del videojuego se optó por la librería *gifAnimation*, sin embargo, debido a problemas de lentitud en la captura de *frames*, se optó por obtener el GIF grabando la pantalla y pasándolo a dicho formato final.

<br/>
<br/>

## Desarrollo del código

El código de esta práctica se estructura en cinco clases: la clase principal, la clase de ayuda, la clase de planetas, la clase Planeta y la clase Nave. La primera alberga los métodos importantes del proyecto, la segunda se trata de un objeto que se encarga de mostrar los textos de la aplicación, la tercera es un objeto que se encarga de almacenar y tratar todos los planetas existentes a través de una colección, la cuarta es un objeto que representa a cada planeta, y la quinta es un objeto que representa a la nave espacial. Dado que esta práctica es una mejora de la anterior (*Planetario*)[^1], sólo se procederá a explicar el código nuevo que se haya añadido.

A continuación se procederá a explicar el código realizado en *Processing*, empezando con la clase principal:

#### Variables empleadas
Para conseguir que la aplicación funcione adecuadamente, se ha empleado una serie de variables con determinadas funciones, tal y como se puede apreciar en el siguiente fragmento de código:

    ...
    //--------Objetos personalizados----------//
    Aircraft nave; // Objeto volador que se controla
    
    //---------Variables de estado---------//
    boolean naveCamara, controlsNave; // Controla el estado de la cámara. Controla si se muestran los controles de la nave    
    ...

<br/>

#### Función *setup()*

En esta función se han inicializado las distintas variables existentes y creado el objeto *Aircraft*.

    void setup() {
      ...
      naveCamara = false; // Falso para iniciar con la cámara general
      controlsNave = false; // Falso para mostrar los controles generales

      //-------Se crean los planetas del Sistema solar------//
      nave = new Aircraft(); // Se crea el objeto
      ...
    }

<br/>

#### Función de dibujado general *draw()*

Esta función es la que se ocupa de mantener el tablero actualizado, y la que se encarga de cambiar el modo de cámara según la variable *naveCamara*. Lo primero que se realiza es comprobar si la vista de ayuda está activa, si lo está, se cambia el modo de cámara al modo general para evitar que la vista de ayuda se vea desconfigurada. Además, el método *help.drawControls()* se encarga de mostrar los controles generales de la aplicación o los controles de la nave espacial, según si se ha pulsado el botón *GENERAL*. 

Posteriormente se comprueba si la vista en primera persona está activa o no, para que, finalmente, la nave se ejeucte con la función *nave.runAircraft()*.

    void draw() {
        //-------Se comprueba si la ayuda está activada-------//
        if (btnHelp){  
            camera(width/2, height/2, 937, // eyeX, eyeY, eyeZ
                   width/2, height/2, 0.0, // centerX, centerY, centerZ
                   0.0, 1.0, 0.0); // upX, upY, upZ
            help.drawTextHelp();
            help.drawSquareHelp();
            help.drawStartButton();
            help.drawControls(); // Dibujado de los controles generales o de la nave
            help.drawOwner();
            return;
        }
        
        //-------Se comprueba si se debe activar la vista en primera persona-------//
        if (naveCamara) {
            camera(nave.x, nave.y, nave.z, // eyeX, eyeY, eyeZ
                width, height/2, nave.z, // centerX, centerY, centerZ 
                0.0, 1.0, 0.0); // upX, upY, upZ
        }else{
            camera(width/2, height/2, 937, // eyeX, eyeY, eyeZ
                width/2, height/2, 0.0, // centerX, centerY, centerZ
                0.0, 1.0, 0.0); // upX, upY, upZ
        }
        
        nave.runAircraft(); // Se ejecuta el renderizado de la nave
        ...
    }
    
<br/>

#### Funciones restantes

Las funciones restantes se corresponden con aquellas encargadas de recoger las pulsaciones de las teclas como *keyPressed()* o *keyReleased()*, además de funciones para capturar las pulsaciones del ratón como *mousePressed()* o *mouseWheel()*.

<br/>

#### Clase *Help*

En esta clase se ha añadido un nuevo método que se encarga de añadir un botón que se encarga de mostrar los controles *GENERALES* de la aplicación, o los controles de la nave espacial (*AIRCRAFT*).
    
    //------Función que dibuja el botón de cambio de controles------//
    void drawControls() {
        fill(0);
        stroke(255);
        rect((width/2) + 140, (height/5) + 280, btnWS, btnH);   
        
        fill(255);
        textSize(14);        
        if (controlsNave) {
            text("AIRCRAFT", ((width/2) + 140) + 14, ((height/5) + 280) + 15);
        }else{
            text("GENERAL", ((width/2) + 140) + 16, ((height/5) + 280) + 15);
        }
        fill(0);
    }
      
<br/>

#### Clase *Aircraft*

Esta clase se encarga de generar un objeto *Aircraft*, el cual será desplazado por el usuario a través del sistema planetario. Este objeto emplea un *PShape* cargado con un objeto *.obj* de una nave espacial. Así pues, en su constructor se definen sus coordenadas, se carga el objeto y se define su velocidad de movimiento. El segundo método mostrado se encarga de dibujar la nave en las nuevas coordenadas, además de aplicarle un *zoom* según se haya solicitado, y unas rotaciones para enderezar el objeto. Aparte de estos métodos, esta clase dispone de actualizadores de coordenadas, así como un método para reiniciar la posición de la nave.

    //----------Constructor de la nave espacial-----------//
    Aircraft() {
        this.x = 50;
        this.y = height/2;
        this.z = 0;

        nave = loadShape("media/nave/space-shuttle-orbiter.obj");

        this.speed = 5;
    }

    //-----------Renderizado de la nave espacial----------//
    void runAircraft() {
        pushMatrix();
        translate(this.x, this.y, this.z);
        scale(0.03*zoom);
        rotateX(PI);
        rotateY(-PI/2);
        shape(nave);
        popMatrix();
    }

<br/>

Para consultar el código fuente de la aplicación, puede dirigirse al siguiente enlace:

[Consultar código fuente](https://github.com/JoseMAP-99/JoseMAP-99.github.io/tree/master/codes/PLANETARIUM_WITH_CAM)

<br/>
<br/>

## Resultados obtenidos

A continuación se muestra la ejecución de la aplicación en *Processing* en formato de GIF (figura 7).

![](/images/planetarium_with_cam/funcionamiento.gif "Fig. 5: Funcionamiento de la aplicación")

<br/>
<br/>

## Ejecución en vivo

Debido a que *p5.js* no posee las mismas herramientas que *Processing*, se ha tenido que alterar la aplicación, con el fin de adaptarlo adecuadamente a esta librería. Los controles modificados se listan a continuación.

{% include info.html text="Las teclas 'M' y 'L' controlan el radio (Modo creación)"%}
{% include info.html text="Las teclas '+' y '-' controlan el zoom"%}
{% include info.html text="Click derecho o 'ENTER' para reiniciar"%}

Debido a sus dimensiones es mejor ejecutarlo en pantalla completa, usando el siguiente enlace:

[Ejecución en pantalla completa](https://editor.p5js.org/JoseMAP-99/full/7vL2bL4ux)

<br/>
<br/>

## Descarga del código fuente

Si desea descargar el código fuente, puede hacerlo desde el siguiente enlace:

[Descarga del código fuente](https://downgit.github.io/#/home?url=https://github.com/JoseMAP-99/JoseMAP-99.github.io/tree/master/codes/PLANETARIUM)

<br/>
<br/>

## Referencias

[^1]: [Práctica anterior realizada](https://josemap-99.github.io/2021/03/05/planetarium.html)
[^2]: [Página de descarga del modelo](https://clara.io/view/5e324073-0853-4b44-973c-b47906450768)
[^3]: [Página de consulta sobre *Processing*](https://processing.org/)
[^4]: [Página de consulta sobre *p5.js*](https://p5js.org/)
[^5]: [Página de conversión *Processing* a *p5.js*](https://pde2js.herokuapp.com/)
