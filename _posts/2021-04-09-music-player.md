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

Para la realización de esta práctica se ha empleado *Processing*[^1], que se define como un lenguaje de programación y entorno de desarrollo integrado de código abierto basado en Java. Además, se ha empleado la librería *Minim*[^1] para realizar todas las manipulaciones de sonidos correspondiente.

Para obtener el GIF del videojuego se optó por la librería *gifAnimation*, sin embargo, debido a problemas de lentitud en la captura de *frames*, se optó por obtener el GIF grabando la pantalla y pasándolo a dicho formato final.

<br/>
<br/>

## Desarrollo del código

El código de esta práctica se estructura en cuatro clases: la clase principal, la clase de ayuda, la clase de ficheros y la clase de canciones. La primera alberga los métodos importantes del proyecto, la segunda se trata de un objeto que se encarga de mostrar los textos de la aplicación, la tercera se encarga de leer las rutas de los sonidos de la carpeta "data/music/", y la cuarta clase se encarga de cargar estos sonidos en la aplicación, así como proporcionar distintos mecanismos para los sonidos.

A continuación se procederá a explicar el código realizado en *Processing*, empezando con la clase principal:

#### Variables empleadas

Para conseguir que la aplicación funcione adecuadamente, se ha empleado una serie de variables con determinadas funciones, tal y como se puede apreciar en el siguiente fragmento de código:







[^1]: [Página de consulta sobre *Minim*](http://code.compartmental.net/tools/minim/)
[^2]: [Página de consulta en *SoundCipher*](http://explodingart.com/soundcipher/)
[^3]: [Página de consulta sobre *Processing*](https://processing.org/)
[^4]: [Página de consulta sobre *ID3*](https://id3.org/)
