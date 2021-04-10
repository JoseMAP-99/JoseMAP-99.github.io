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


<br/>
<br/>

[^1]: [Página de consulta sobre *Minim*](http://code.compartmental.net/tools/minim/)
[^2]: [Página de consulta en *SoundCipher*](http://explodingart.com/soundcipher/)
[^3]: [Página de consulta sobre *Processing*](https://processing.org/)
