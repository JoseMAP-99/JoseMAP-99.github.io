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


[^1]: [Página de consulta sobre *Minim*](http://code.compartmental.net/tools/minim/)
[^2]: [Página de consulta en *SoundCipher*](http://explodingart.com/soundcipher/)
[^3]: [Página de consulta sobre *Processing*](https://processing.org/)
[^4]: [Página de consulta sobre *ID3*](https://id3.org/)
