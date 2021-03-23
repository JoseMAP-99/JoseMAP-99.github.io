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
| ![](/images/custom_scene/vVisualización.PNG "Fig. 2: Vista del expositor (Primera persona)") |

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

[^1]: [Página de consulta sobre *Processing*](https://processing.org/)
[^2]: [Página de consulta en *Clara.io*](https://clara.io/)
[^3]: [Página de consulta sobre *Mario Bros.*](https://es.wikipedia.org/wiki/Mario_(personaje))
[^4]: [Página de descarga del modelo (*Mario Bros.*)](https://clara.io/view/d7e2b247-379d-4f0f-a5b9-2c94a4c435b8)


