## Filtros para imágenes V2

`Autor: José María Amusquívar Poppe`

Para el desarrollo de esta práctica se ha solicitado la realización de una aplicación que incorpore distintas manipulaciones de *shaders*, empleando para ello el lenguaje de alto nivel *OpenGL Shading Language*[^1], el cual proporciona mayor versatilidad para el desarrollo de renderizados. A diferencia de la práctica anterior, *Filtros para imágenes*[^2], en la que se solicitaba la manipulación de *shaders* de fragmentos, en ésta se solicita la manipulación combinada de *shaders* de tipo fragmento como de tipo vértices. Por esta razón, esta práctica es un añadido respecto a la anterior, tal como se puede apreciar en la figura 1.

![](/images/image_viewer_v2/vPrincipal.PNG "Fig. 1: Interfaz de usuario de la aplicación")

<br/>

1. TOC
{:toc}

<br/>

## Introducción

El proyecto a realizar tiene como objetivo practicar las distintas maneras de manipular *shaders*, en este caso, aplicados sobre imágenes proporcionados por el usuario. Para este cometido se emplea el lenguaje *GLSL*, cuya sintaxis es similar a la de *C*[^3], generando un fichero independiente en formato *.glsl*, el cual es cargado con la función *loadShader()* en el entorno de *Processing*[^4]. Así pues, la aplicación carga por defecto todas las imágenes contenidas en la carpeta "data/images/", por lo que será necesario disponer de dicha carpeta con algún fichero de imagen, en formato *.jpg* o *.png*, para que la aplicación funcione adecuadamente. Todas las imágenes son cargadas en el proyecto y puestas a disposición del usuario mediante acciones de "Next" y "Previous", además de las respectivas teclas que aplican los filtros a las imágenes.

Tal como se ha comentado anteriormente, esta práctica es un añadido de la práctica anterior, dado que, únicamente, se solicita la manipulación de *shaders* de vértices, razón por la cual, simplemente, se han añadido nuevos filtros al visualizador de imágenes ya desarrollado.

<br/>
<br/>

## Propuesta de diseño

El diseño elegido para este proyecto está constituido por dos vistas, una de ayuda y la otra se corresponde con la vista principal de la aplicación. Esta última está constituida por un fondo de pantalla que decora la interfaz final, además de disponer tres botones presentes en pantalla, cada uno con una función específica como cambiar de imagen y el botón de ayuda. Dentro de esta vista también se proporciona textos que representan el nombre de las imágenes, extraídos de su ruta (Figura 2). Esta vista ofrece dos modos de interacción: el filtrado mediante *shaders* de fragmento (práctic aanterior), y un nuevo filtrado mediante *shaders* de fragmento y vértices. Para llevar esta última tarea a cabo, se ha decidido tomar de ejemplo lo visto en clase y crear una esfera sobre la que se aplica la imagen como textura. Así pues, si el usuario decide aplicar alguno de los filtros de fragmento-vértice, esta esfera se verá alterada.

| Vista principal |
| - |
| ![](/images/image_viewer_v2/vVisualizacion.PNG "Fig. 2: Vista general de la aplicación") |

La segunda vista es la de ayuda, accesible desde el botón *HELP* o pulsando la tecla 'H' cuando se necesite. En esta vista se explica de forma general cómo funciona la aplicación mostrando los controles disponibles, tanto los generales (Figura 3), como la información de los *shaders* (Figura 4).

| Vista de ayuda |
| - | -|
| ![](/images/image_viewer_v2/vAyudaV1.PNG "Fig. 3: Manual de uso y ayuda de la aplicación") | ![](/images/image_viewer_v2/vAyudaV2.PNG "Fig. 4: Información sobre los shaders") |

A continuación se presentarán un ejemplo de cada tipo de filtro fragmento-vértice presente en la aplicación.

| Filtros aplicados |
| - | -|
| ![](/images/image_viewer_v2/vAllOptions.PNG "Fig. 5: Lus-Normal-Textura") | ![](/images/image_viewer_v2/vPixeles.PNG "Fig. 6: Movimiento de píxeles") |

#### Controles

Los controles están disponibles desde la vista de ayuda de la aplicación (Figura 3). Los distintos controles disponibles permiten al usuario manipular las imágenes, así como aplicarles filtros, saltarlos, y, obviamente, disfrutar de las imágenes.

**TECLADO**

* **Tecla 'H':** Abre la vista de ayuda.

* **Tecla 'LEFT' - 'RIGHT':** Cambia a la imagen siguiente o anterior.

* **Tecla 'C':** Permite cambiar el tipo de *shader* (Fragmento | Fragmento-Vértice)

**RATÓN**

* **Click sobre 'HELP':** Abre la vista de ayuda.

* **Click izquierdo sobre 'PREV' - 'NEXT':** Cambia al sonido siguiente o anterior.

**FILTROS (FRAGMENTO)**

* **Tecla '1':** Detección de bordes.

* **Tecla '2':** Alteración de píxeles.

* **Tecla '3':** Inversión de colores.

* **Tecla '4':** Deformación circular.

**FILTROS (FRAGMENTO-VÉRTICE)**

* **Tecla '1':** Filtro de luz-normal y textura.

* **Tecla '2':** Alteración de píxeles.

<br/>
<br/>

## Recursos empleados

Para la realización de esta práctica se ha empleado *Processing*[^4], que se define como un lenguaje de programación y entorno de desarrollo integrado de código abierto basado en Java. 

Se ha empleado el languaje *GLSL*[^1], que se define como un lenguaje de alto nivel de sombreado con una sintaxis basada en el lenguaje de programación C.

Junto al proyecto se adjuntan imágenes de prueba libres de derechos de autor, todas ellas extraídas de la página *Pixabay*[^5].

Para obtener el GIF del videojuego se optó por la librería *gifAnimation*, sin embargo, debido a problemas de lentitud en la captura de *frames*, se optó por obtener el GIF grabando la pantalla y pasándolo a dicho formato final.

<br/>
<br/>

## Desarrollo del código

El código de esta práctica se estructura en cuatro clases: la clase principal, la clase de ayuda, la clase de ficheros y la clase de imágenes. La primera alberga los métodos importantes del proyecto, la segunda se trata de un objeto que se encarga de mostrar los textos de la aplicación, la tercera se encarga de leer las rutas de las imágenes de la carpeta "data/images/", y la cuarta clase se encarga de cargar estas imágenes en la aplicación como *PImage*, así como proporcionar distintos mecanismos de interacción.

Tal como se mencionó, esta práctica es un añadido de la práctica anterior, razón por la cual sólo se explicará el código nuevo que se haya escrito, empezando con la clase principal:

#### Variables empleadas

Para conseguir que la aplicación funcione adecuadamente, se ha empleado una serie de variables con determinadas funciones, tal y como se puede apreciar en el siguiente fragmento de código:

    //-------Variables para shaders (Frag-Vert)------//
    PShader pixelsFV, alloptionsFV;

    //-----Forma esférica (Frag-Vert)-------//
    PShape sphere;

    //-------Ángulo de rotación de la esfera-----//
    float ang = 0.0;

    //------Variables de estado y controles-------//
    boolean onlyFrag, generalControl;
    
</br>

#### Función *setup()*

En esta función se han inicializado las distintas variables existentes, y la forma esférica para los *shaders* de fragmento-vértice.
        
    void setup () {
      ...
      //-------Inicialización de las variables de estado-------//
      onlyFrag = true;
      generalControl = true;

      //-------Forma esférica sobre la que se situará la imagen------//
      sphere = createShape(SPHERE, 180);
      sphere.setStroke(255);
      ...
    }
    
</br>

#### Función de dibujado general *draw()*

Esta función es la que se ocupa de mantener el tablero actualizado, y lo único que se añadió respecto a la práctica anterior fue la comprobación del modo de *shaders* a aplicar, además de mostrar un nuevo texto informativo del modo de *shader* actual.

    void draw () {
      ...
      //-------Se aplica el filtro deseado, y se muestra la imagen------//
      updateFilters();
      if (onlyFrag) {
        image(actual, width/2, height/2); 
      } else {    
        rotateSphere();
      }
      ...
    }
    
</br>

#### Función de actualización *rotateSphere()*

Esta función se encarga de actualizar la posición de la esfera, además de actualizar su respectivo ángulo, como la luz que se proyecta sobre ella.

    void rotateSphere() {  
      pushMatrix(); 
      pointLight(150, 150, 150, width/2, height/2, 400);
      translate(width/2, height/2);
      rotateY(ang);
      shape(sphere);
      ang += 0.005; 
      if (ang > 2*PI) ang = 0.0;
      popMatrix();
    }
    
</br>

#### Funciones restantes

Las funciones restantes se corresponden con aquellas encargadas de recoger las pulsaciones de las teclas como *keyPressed()*, además de funciones para capturar las pulsaciones del ratón como *mousePressed()*, además de una función adicional que se encarga de actualizar la textura de la esfera con la nueva imagen *setTexture()*.

<br/>

#### Clase *Help*

Esta clase se añadió el control de un nuevo botón, el encargado de cambiar los textos en la vista de ayuda.

    void drawControls() {
      fill(0);
      stroke(255);
      rect((width/2) + 140, (height/5) + 220, btnWS, btnH);   
      fill(255);
      textSize(14);
      if (generalControl) {
        text("GENERAL", ((width/2) + 140) + 14, ((height/5) + 220) + 15);
      } else {
        text("SHADERS", ((width/2) + 140) + 14, ((height/5) + 220) + 15);
      }
      fill(0);
    }

El resto de funciones y clases han permanecido intocables. Para consultar el código fuente de la aplicación, puede dirigirse al siguiente enlace:

[Consultar código fuente](https://github.com/JoseMAP-99/JoseMAP-99.github.io/tree/master/codes/IMAGE_VIEWER_V2)

<br/>
<br/>

## Resultados obtenidos

A continuación se muestra la ejecución de la aplicación en *Processing* en formato de GIF (Figura 7).

![](/images/image_viewer_v2/funcionamiento.gif "Fig. 7: Funcionamiento de la aplicación")

<br/>
<br/>

## Descarga del código fuente

Si desea descargar el código fuente, puede hacerlo desde el siguiente enlace:

[Descarga del código fuente](https://downgit.github.io/#/home?url=https://github.com/JoseMAP-99/JoseMAP-99.github.io/tree/master/codes/IMAGE_VIEWER_V2)

<br/>
<br/>

## Referencias

[^1]: [Página de consulta sobre *GLSL*](https://www.khronos.org/opengl/wiki/Core_Language_(GLSL))
[^2]: [Práctica anterior *Filtros para imágenes*](https://josemap-99.github.io/2021/04/26/image_viewer.html)
[^3]: [Página de consulta en *C*](https://es.wikipedia.org/wiki/C_(lenguaje_de_programaci%C3%B3n))
[^4]: [Página de consulta sobre *Processing*](https://processing.org/)
[^5]: [Página de consulta sobre *Pixabay*](https://pixabay.com/es/)
