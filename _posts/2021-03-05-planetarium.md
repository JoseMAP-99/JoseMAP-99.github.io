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

![](/images/planetarium/vAyuda.PNG "Fig. 4: Manual de uso y ayuda de la aplicación")

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

El código del proyecto ha sido alterado en su versión en *p5.js*, debido a que esta librería no posee herramientas idénticas a las de *Processing*, pero sí equivalentes, tal es el caso de *PVector* que su equivalente en *p5.js* es la función *createVector()*, o la colección *ArrayList* que en *p5.js* puede ser reemplazada sencillamente con un array []. Sin embargo, ha habido cambios más drásticos como es el caso de la librería *Pshape* y sus transformaciones, pues en *p5.js* estas transformaciones deben ser asignadas mediante una variable y se posibilita el uso de las funciones *push()* y *pop()*.

Entre los cambios realizados de más importancia se encuentra el hecho que, a diferencia de *Processing*, para usar gráficos de esta estilo en *p5.js* es requerido trabajar con *WEBGL*, lo que ocasiona cambios respecto a la orientación de los ejes de coordenadas. Para solventar esto, se empleó un *translate()* para mover el eje de coordenadas a la esquina superior izquierda, tal y como ocurre en *Processing*.

Para obtener el GIF del videojuego se optó por la librería *gifAnimation*, sin embargo, debido a problemas de lentitud en la captura de *frames*, se optó por obtener el GIF grabando la pantalla y pasándolo a dicho formato final.

<br/>
<br/>

## Desarrollo del código

El código de esta práctica se estructura en tres clases: la clase principal, la clase de ayuda y la clase de puntos. La primera alberga los métodos importantes del proyecto, la segunda se trata de un objeto que se encarga de mostrar los textos de la aplicación, y la tercera es un objeto que se encarga de almacenar y tratar los puntos introducidos por el usuario.

A continuación se procederá a explicar el código realizado en *Processing*, empezando con la clase principal:

#### Variables empleadas
Para conseguir que la aplicación funcione adecuadamente, se ha empleado una serie de variables con determinadas funciones, tal y como se puede apreciar en el siguiente fragmento de código:

    //-----------Configuración de pantalla---------//
    int sizeX, sizeY; //Dimensiones de la ventana

    //----------Figuras creadas----------//
    PShape solidoForm, group; //Shape sin relleno, y Shape que agrupa todas las figuras

    //---------Objetos creados----------//
    Points points; // Objeto que trata los puntos introducidos
    Help help; // Objeto que se encarga de mostrar los textos

    //-----------Variables de estado----------//
    boolean printed; // Variable que señala si hay un sólido dibujado
    boolean btnHelp; // Variable que señala si está activa la vista de ayuda

    //-----------Variables de configuración----------//
    int pos, sizePoint; // Número de puntos, y tamaño de puntos a dibujar
    int maxScroll, minScroll, scrollMouse; // Valor máximo y mínimo para la rueda del ratón, y valor actual 
    int nSep; // Variable que guarda la separación existente entre triángulos

    //------------Variable para las pulsaciones de teclas---------//
    boolean [] keys = new boolean[6]; // Variable que almacena las pulsaciones de teclas

<br/>

#### Función *settings()*

Esta función es necesaria si se desea tratar las dimensiones de la ventana como variables, ya que esta función es ejecutada antes que la función *setup()*, consiguiendo así guardar las dimensiones de la ventana en variables para usos futuros.

    void settings() {
      sizeX = 600; 
      sizeY = 600;
      size(sizeX, sizeY, P3D);    
    }
  
<br/>

#### Función *setup()*

En esta función se han inicializado las distintas variables existentes, como el número de puntos actuales, la variable que indica que la ayuda está activada, las variables que determinan el máximo o mínimo de *scroll* disponible o los objetos empleados.

    void setup () { 
      //--------Variables de la figura------//
      pos = 0;
      sizePoint = 2;
      nSep = 20; 

      //-------Variables de estado-----//
      printed = false;
      btnHelp = true;

      //-------Variables relacionadas a la rueda del ratón-----//
      maxScroll = 5; 
      minScroll = -5; 
      scrollMouse = 0;

      //-------Objetos necesarios-------//
      help = new Help();  
      points = new Points();  
    }

<br/>

#### Función de dibujado general *draw()*

Esta función es la que se ocupa de mantener el tablero actualizado, y está constituida en tres secciones: la primera se encarga de comprobar si se ha activado el mensaje de ayuda; la segunda se encarga de dibujar el tablero de juego, el botón de ayuda y los dos textos que aparecen en pantalla (Número de vértices y espaciados de triángulos); y la tercera sección comprueba si hay una figura dibujada en pantalla o no.

    void draw () {
      //-------Se comprueba si la ayuda está activada-------/
      if (btnHelp){  
        help.drawTextHelp();
        return;
      }

      //---------Dibujado del tablero, textos y botón-------//
      drawBoard();  
      help.drawSquareHelp();
      help.drawSpaces();

     //--------Se comprueba si se dibuja el sólido o las líneas-------//
      if (printed){  
        translate(mouseX, mouseY - (points.getYs()[0] - ((points.getYs()[0] - points.getYs()[1])/2)));
        shape(group);   
        moveShape();
      }else{
        drawPoints(0, 1);
      }
    }
    
<br/>

#### Función de dibujado del tablero *drawBoard()*

Esta función únicamente se encarga de pintar el tablero de la aplicación y dibujar la línea vertical divisoria.

    void drawBoard() {
      //------Se pinta el tablero y se dibuja la línea divisoria------//
      background(0);
      stroke(114, 116, 116);
      line(sizeX/2, 0, sizeX/2, sizeY);
    }
    
<br/>

#### Función de dibujado de puntos *drawPoints()*

Esta función se encarga de dibujar los puntos que el usuario introduce en tiempo real, además de trazar una línea de unión entre los puntos introducidos. Además, también comprueba que la línea de trazado no sobrepasa el lado izquierdo del tablero para evitar confusiones al usuario.

    void drawPoints(int xs, int mult) {
      PVector aux;
      PVector last;
      for(int i = 0; i < pos; i++) {
        aux = points.getItem(i);    

        if (i == pos - 1){
          if (mouseX >= sizeX/2){
            line(xs + mult*aux.x, aux.y, mouseX, mouseY);
          }
        }else{
          last = points.getItem(i+1);  
          line(xs + mult*last.x, last.y, xs + mult*aux.x, aux.y);
        }    
        circle(xs + mult*aux.x, aux.y, sizePoint);
      }
    }
    
<br/>

#### Función de dibujado *drawSolid()*

Esta función se encarga de dibujar el sólido de revolución final, realizando las respectivas transformaciones de coordenadas, empleando la función *multVect()*. También se encarga de rellenar la figura con triángulos, para conseguir esto, se genera un *PShape* para cada triángulo generado. Finalmente, para componer estas figuras, se utiliza un *PShape* general determinado como *GROUP*, cuya finalidad es reunir todas las figuras generadas y mostrarlas como una misma. Así pues, para adjuntar una figura en el sólido general, se empleada la función *PShape.addChild()*, tal como se puede apreciar en el fragmento de código siguiente.

    void drawSolid() {
      PVector pt;

      group = createShape(GROUP); // Grupo de PShape general

      solidoForm = createShape(); // Sólido sin relleno
      solidoForm.beginShape(LINES);
      stroke(255);
      solidoForm.strokeWeight(2);

      //-------Generación de las nuevas coordenadas-----------// 
      for (int i = 0; i < pos; i++) {
        for (int rad = 0; rad <= 360; rad+=nSep){
          pt = multVect(points.getItem(i), radians(rad));
          solidoForm.vertex(pt.x, pt.y, pt.z); 
        }    
      } 
      solidoForm.endShape(CLOSE); 

      //-------Variables locales para el cálculo del relleno------//
      PVector actual, actual1, last, last1;
      int nVerRad = 360/nSep;

      PShape triangle;

      //-------Creación de triángulos para el relleno-------//
      for (int i = nVerRad + 1; i < solidoForm.getVertexCount(); i++){
        actual = solidoForm.getVertex(i - 1);
        actual1 = solidoForm.getVertex(i);
        last = solidoForm.getVertex(i - nVerRad - 1);    
        last1 = solidoForm.getVertex(i - nVerRad); 

        triangle = createShape();
        triangle.beginShape(TRIANGLES);    
        triangle.vertex(actual.x, actual.y, actual.z);
        triangle.vertex(actual1.x, actual1.y, actual1.z);
        triangle.vertex(last.x, last.y, last.z);
        triangle.vertex(last1.x, last1.y, last1.z);
        triangle.endShape(CLOSE);  

        group.addChild(triangle); // Se adjunta cada triángulo en la figura final                              
      }
      group.addChild(solidoForm); // Se adjunta la figura sin relleno en la figura final
    }
    
<br/>

#### Función de cambio de coordenadas *multVect()*

Esta función se encarga de generar, a partir de un punto y un determinado grado, obtener unas nuevas coordenadas en tres dimensiones que se añadirán al sólido de revolución.

    public PVector multVect(PVector pt, float theta) {
        PVector res = new PVector();
        res.x = (pt.x - sizeX/2) * cos(theta) - pt.z * sin(theta);
        res.y = pt.y;
        res.z = (pt.x - sizeX/2) * sin(theta) + pt.z * cos(theta);
        return res;
    }
    
<br/>

#### Funciones restantes

Las funciones restantes se corresponden con aquellas encargadas de recoger las pulsaciones de las teclas como *keyPressed()* o *keyReleased()*, además de funciones para capturar las pulsaciones del ratón como *mousePressed()* o *mouseWheel()*.

<br/>

#### Clase *Help*

Esta clase es la encargada de mostrar y generar todos los textos de la aplicación, así como los diversos botones existentes, tales como los que se presentan a continuación:

    //-----Función que dibuja el botón de ayuda-----//
    void drawSquareHelp() {
        fill(0);
        stroke(255);
        rect(btnXH, btnYH, btnWH, btnH);   
        fill(255);
        text("HELP", btnXH+5, btnYH+15);
        fill(0);
    }

    //-----Función que dibuja los textos en tiempo real en la pantalla de dibujado------//
    void drawSpaces() {
        fill(255);
        text("Spaces: " + nSep, 10, 20); 
        text("Points: " + pos, 10, 40);
        fill(0);
    }

    //------Función que dibuja el botón de inicio-----//
    void drawStartButton() {
        fill(0);
        stroke(255);
        rect(btnXS, btnYS, btnWS, btnH);   
        fill(255);
        text("CONTINUE", btnXS+14, btnYS+15);
        fill(0);
    }
      
<br/>

#### Clase *Points*

Esta clase se encarga de almacenar los puntos introducidos (*PVector*) a través de una colección del tipo *ArrayList*. Por tanto, esta clase redefine los métodos de dicha colección, además de proporcionar una función que devuelve aquellos dos puntos cuyo valor Y sea el mayor y el menor de todos, lo cual resulta útil para seleccionar una adecuada función *translate()*.

    //-------Función que limpia la lista----------//
    public void clearList(){
      this.points.clear(); 
    }  
    
    //-------Función que obtiene los puntos con máximo y mínimo 'Y'---------//
    public float[] getYs() {
      float infY = 0;
      float supY = height;
      for(PVector pt : this.points) {
        if (pt.y > infY) {
          infY = pt.y;  
        }

        if (pt.y < supY) {
          supY = pt.y;  
        }
      }
      return new float[] {supY, infY};
    }
      
<br/>

Para consultar el código fuente de la aplicación, puede dirigirse al siguiente enlace:

[Consultar código fuente](https://github.com/JoseMAP-99/JoseMAP-99.github.io/tree/master/codes/SOLID)

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
