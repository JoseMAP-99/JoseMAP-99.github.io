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


[^1]: [Página de consulta sobre *GLSL*](https://www.khronos.org/opengl/wiki/Core_Language_(GLSL))
[^2]: [Página de consulta en *C*](https://es.wikipedia.org/wiki/C_(lenguaje_de_programaci%C3%B3n))
[^3]: [Página de consulta sobre *Processing*](https://processing.org/)
[^4]: [Página de consulta sobre *Pixabay*](https://pixabay.com/es/)
