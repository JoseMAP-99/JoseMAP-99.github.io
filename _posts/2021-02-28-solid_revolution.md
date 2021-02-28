# Sólido de revolución

`Autor: José María Amusquívar Poppe`

Para el desarrollo de esta práctica se ha solicitado la realización de una aplicación que permita la creación de cualquier sólido de revolución, cuyo eje de revolución se encuentra en el eje "Y" (figura 1). 

![](/images/solid_revolution/principal.PNG "Fig. 1: Interfaz de usuario de la aplicación")

<br/>

1. TOC
{:toc}

<br/>

## Introducción

Se denomina sólido de revolución a cualquier cuerpo que pueda obtenerse mediante una operación geométrica de rotación de una superficie plana alrededor de una recta que esté contenida en su mismo plano. La figura resultante es un sólido que posee simetría, razón por la cual, para su implementación en *Processing*, se dividirá el tablero en dos secciones con un separador vertical, dejando el lado derecho habilitado para el dibujado de los puntos de la mitad de la figura deseada. Una vez se hayan dibujado los puntos requeridos, el usuario podrá terminar la acción y obtener el sólido de revolución resultante. 

Finalmente, el usuario podrá interactuar de diversas maneras con la figura final o, simplemente, reiniciar el tablero y volver a dibujar unos nuevos puntos.

<br/>
<br/>

## Propuesta de diseño

El diseño elegido para este proyecto está constituido por un tablero de interacción de fondo negro, una línea vertical divisoria blanca situada en la mitad del tablero, además de 2 textos de información y un botón de ayuda o manual de uso de la aplicación. El usuario podrá dibujar todos los puntos que desee en el lado derecho del tablero, los cuales se irán uniendo con una línea blanca, tal como se puede apreciar en la figura 2.

Una vez se hayan dibujado todos los puntos deseados, el usuario deberá hacer click en el lado izquierdo del tablero para mostrar el sólido de revolución generado (figura 3). La figura generada se moverá acorde a la posición del ratón, y, cuando se desee, puede pulsar el click derecho para reiniciar el tablero y habilitar de nuevo la introducción de nuevos puntos.

| Recogida de puntos | Sólido de revolución |
| - | - |
| ![](/images/solid_revolution/solo-puntos.PNG "Fig. 2: Introducción de los puntos de la figura") | ![](/images/solid_revolution/figura.PNG "Fig. 3: Presentación de la figura obtenida")

En la interfaz se ha incluido dos textos informativos, uno de ellos se corresponde con el número de puntos dibujados por el usuario, el otro está relacionado con el relleno de la figura final, pues representa el espaciado existente entre triángulos, por defecto está colocado a 20, sin embargo, éste puede aumentar o disminuirse según se desee.

Y, finalmente, se ha incluido un botón de ayuda dentro de la interfaz, el cual muestra al usuario los controles disponibles y enseña un caso de uso de la aplicación. La aplicación abre esta vista de ayuda en el primer acceso (figura 4).

![](/images/solid_revolution/ayuda.PNG "Fig. 4: Manual de uso y ayuda de la aplicación")

#### Controles

Tal como se ha mencionado anteriormente, los controles están disponibles desde la vista de ayuda de la aplicación (figura 4). Los distintos controles disponibles permiten interactuar al usuario con la figura final, permitiéndole rotarla, aplicarle un *zoom* o añadir o disminuir la separación existente entre triángulos. 

. Click izquierdo: En el lado derecho del tablero, dibuja un nuevo punto. En el lado izquierdo del tablero, genera el sólido de revolución.
. Click derecho: En cualquier parte del tablero, limpia la pantalla eliminando la figura actual y sus puntos.
Rueda del ratón: Realiza un *zoom* sobre la figura, según el sentido del movimiento.
. Tecla 'A'-'D' o 'Left'-'Right.': Cuando la figura está dibujada, rota la figura horizontalmente.
. Tecla 'S'-'W' o 'Down'-'Up': Cuando la figura está dibujada, rota la figura verticalmente.
. Tecla 'M'-'L': Cuando la figura está dibujada, añade o quita separación entre triángulos del relleno.

<br/>
<br/>

## Recursos empleados

Para la realización de esta práctica se ha empleado *Processing*[^1], que se define como un lenguaje de programación y entorno de desarrollo integrado de código abierto basado en Java. Este lenguaje se ha utilizado para el desarollo de forma local, sin embargo, para poder publicar el proyecto a través de internet es necesario emplear *p5.js*[^2], que se define como una librería *JavaScript* perteneciente al lado del cliente que posibilita la creación de experiencias interactivas y gráficas, basado en el núcleo de *Processing*.

Por tanto, el proyecto ha sido desarrollado totalmente en *Processing* y, dado que *p5.js* tiene su base en el primero, su respectiva conversión es simple. Para realizar esta conversión se he utilizado la herramienta online *HerokuApp*[^3].

<br/>
<br/>

## Desarrollo del código

Aquí se explica el código

<br/>
<br/>

### Variables empleadas

<br/>

### Función setup()

<br/>
<br/>

## Resultados obtenidos

Aquí los GIFS

<br/>
<br/>

## Ejcución en vivo

{% include info.html text="Las teclas 'A' y 'D' controlan la pala superior, el curso 'Izquierdo' y 'Derecho' la pala inferior" %}
{% include alert.html text="La ejecución sólo está disponible para ordenadores" %}
{% include alert.html text="Se debe hacer 'click' sobre el recuadro del videojuego para poder jugarlo" %}

<div style="display: flex; justify-content: center">
  <iframe width="605" height="605" src="https://editor.p5js.org/JoseMAP-99/embed/1aYzzBgZt"></iframe>
</div>

<br/>

El juego ha sido recortado, adaptado a P5.js

<br/>
<br/>

## Referencias

[^1]: [Página de consulta sobre *Processing*](https://processing.org/)
[^2]: [Página de consulta sobre *p5.js*](https://p5js.org/)
[^3]: [Página de conversión *Processing* a *p5.js*](https://pde2js.herokuapp.com/)
