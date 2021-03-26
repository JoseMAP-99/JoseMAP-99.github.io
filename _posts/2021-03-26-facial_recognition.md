# Reconocimiento facial

`Autor: José María Amusquívar Poppe`

Para el desarrollo de esta práctica se ha solicitado la realización de una aplicación que sea capaz de combinar la salida gráfica e interacción en respuesta a una captura de vídeo. Para conseguir esto se ha empleado la herramienta [^1]*FaceOSC*, la cual es capaz de detectar la postura y gestos del rostro y enviar dicha información a [^2]*Processing*. Así pues, se ha decidido utilizar estas funcionalidades para actualizar la práctica anterior, [^3]*Escena personalizada*, de tal modo que los movimientos del personaje se puedan realizar mediante gestos faciales (Figura 1).

![](/images/facial_recognition/vPrincipal.PNG "Fig. 1: Interfaz de usuario de la aplicación")

<br/>

1. TOC
{:toc}

<br/>

## Introducción

La práctica a realizar tiene como objetivo familiarizarse con la visión por computador, empleando para ello una entrada gráfica obtenida de una cámara web, la cual será procesada según se requiera. Tal como se mencionó anteriormente, la práctica anterior fue alterada con el fin de añadirle esta mejora, por lo que aún se conserva la mayor parte del programa principal, por lo que si se desea consultar dicha práctica puede dirigirse a su respectivo [^3]*informe*. 

Las partes que fueron alteradas respecto a la aplicación original fue la vista de ayuda, en la que se añadió un submenú adicional en el que se listan los controles faciales para controlar al personaje. Aparte de esto, también se ha añadido en la vista principal una representación en vivo del rostro capturado por la herramienta *FaceOSC*, utilizando puntos y aristas (Figura 2).

![](/images/facial_recognition/vFace.PNG "Fig. 2: Representación de la captura de FaceOSC")

<br/>
<br/>

## Propuesta de diseño

Dado que esta práctica es una mejora de la anterior, el diseño no ha variado mucho respecto a la anterior, salvo los puntos mencionados anteriormente. Por lo que se procederá a explicar sólo aquellos aspectos que se hayan añadido en esta entrega.

En la vista principal se ha añadido una representación, mediante puntos y aristas blancas, del rostro del usuario el cual es directamente capturado por la herramienta *FaceOSC* y enviado a *Processing* en crudo (formato *RAW*) a través del puerto destinado y especificado, en este caso se dejó el que viene por defecto, puerto 8338 (Figura 3). 


| Vista principal |
| - |
| ![](/images/facial_recognition/vVisualizacion.PNG "Fig. 3: Vista general con representación facial") |

La segunda y última vista se trata de la vista de ayuda, la cual fue simplemente modificada para añadir los nuevos controles faciales (Figura 4). 

| Vista de ayuda |
| - |
| ![](/images/facial_recognition/vAyuda.PNG "Fig. 4: Manual de uso y ayuda de la aplicación (FACIAL)") |

Gracias a la detección de gestos y postura que proporciona *FaceOSC*, se consiguió desplazar hacia adelante, rotar horizontalmente y verticalmente la vista del personaje, y cambiar el tipo de iluminación, todo ello utilizando los movimientos de cabeza, cejas o, inclusive, el de la boca, tal como se comenta a continuación en el apartado de controles.

### Controles

Los controles están disponibles desde la vista de ayuda de la aplicación (Figura 4). Los distintos controles disponibles permiten interactuar al usuario con la escena, la ilumniación o el personaje, entre estas interacciones está presente la acción de desplazarse, rotar o cambiar la iluminación de la escena, etre otros.

**PERSONAJE**

* **Levantar ambas cejas:** Desplaza el personaje hacia adelante.

* **Rotar la cabeza hacia derecha o izquierda:** Rota la posición del personaje horizontalmente para un mejor desplazamiento.

* **Rotar la cabeza hacia arriba o abajo:** Rota verticalmente la vista del personaje.

* **Abrir la boca:** Cambia el tipo de iluminación de la escena.

* **Tecla 'R':** Reinicia la posición del personaje.

El resto de controles se mantienen tal y como se configuraron en la práctica anterior.


<br/>
<br/>

## Recursos empleados

Para la realización de esta práctica se ha empleado *Processing*[^2], que se define como un lenguaje de programación y entorno de desarrollo integrado de código abierto basado en Java. Además, se ha empleado modelos *.obj* ya definidos, encontrados en la página *Clara.io*[^4], desde ahí se puede consultar los detalles de todas las figuras presentadas.

Además, para poder realizar la captura de gestos y movimientos faciales, se ha utilizado la herramienta [^1]*FaceOSC*, la cual ha sido desarrollada con *openFrameWorks* y *ofxFaceTracker*. Ambos recursos puedes ser consultados en la página de referencia de dicha herramienta. De tal modo que, para que la aplicación funcione adecuamente, se ha de ejecutar primero esta herramienta, y activar el envío de datos crudos (*RAW*) en sus dos versiones.

También hace falta haber instalado la librería *oscP5* dentro de *Processing*, ésta será la encargada de procesar toda la información que llegue desde *FaceOSC*.

Para obtener el GIF del videojuego se optó por la librería *gifAnimation*, sin embargo, debido a problemas de lentitud en la captura de *frames*, se optó por obtener el GIF grabando la pantalla y pasándolo a dicho formato final.

<br/>
<br/>

## Desarrollo del código

El código de esta práctica se estructura en cuatro clases: la clase principal, la clase de ayuda, la clase de personaje y la clase estructura. La primera alberga los métodos importantes del proyecto, la segunda se trata de un objeto que se encarga de mostrar los textos de la aplicación, la tercera se encarga de generar y controlar todo lo relacionado al personaje de la aplicación, y la última es un objeto que se corresponde con cada una de las estructuras mostradas sobre el expositor. 

Las únicas clases que fueron modificadas en esta versión fue la clase principal y la clase de ayuda, por tanto serán las que se procesa a detallar, empezando con la clase principal:

#### Variables empleadas

Para conseguir que la aplicación funcione adecuadamente, se ha empleado una serie de variables con determinadas funciones, tal y como se puede apreciar en el siguiente fragmento de código:

    //---------Varibales especiales----------------//
    OscP5 oscP5; // Objeto especial de oscP5 en conjunto con FaceOSC
    int found; // Indica si se ha encotrado una cara

    //----------Variables de datos--------------//
    PVector posePosition = new PVector(); // Almacena la posición del rostro
    PVector lastPosePosition = new PVector(); // Posición del rostro para comparar
    float [] eyebrows; // Almacena los valores de las cejas
    float [] lastEyebrows; // Valores de las cejas para comparar
    float mouthHeight; // Almacena los valores de la altura de la boca

    //----------Variables de control------------//
    float tolerance = 1.0; // Nivel de tolerancia entre comparaciones
    boolean closed; // Variable de estado para la boca
    boolean movement; // Variable de estado para el desplazamiento hacia adelante

    //----------Rotaciones del personaje------------//
    int rotateMario; // Rotación horizontal
    int rotateMarioY; // ROtación vertical

    //-----------Variables para representación en vivo----------//
    float[] rawArray; // Almacena todos los puntos en crudo del rostro
    
<br/>

#### Función *setup()*

En esta función se han inicializado las distintas variables existentes, y se ha establecido el tamaño de la pantalla con *size(1000, 10000, P3D)*, debido a que *FaceOSC* se ejecuta a la vez.

    ...
    size(1000, 1000, P3D);     
  
    rawArray = new float[132]; // Array para valores crudos de FaceOSC

    //---------Inicialización del *listener* y sus propiedad--------------//
    oscP5 = new OscP5(this, 8338);
    oscP5.plug(this, "found", "/found");
    oscP5.plug(this, "posePosition", "/pose/position");
    oscP5.plug(this, "poseOrientation", "/pose/orientation");
    oscP5.plug(this, "eyebrowLeftReceived", "/gesture/eyebrow/left");
    oscP5.plug(this, "eyebrowRightReceived", "/gesture/eyebrow/right");
    oscP5.plug(this, "mouthHeightReceived", "/gesture/mouth/height");
    oscP5.plug(this, "rawData", "/raw");

    //------Variables de datos-------//
    eyebrows = new float[2];
    lastEyebrows = new float[2];  
    rotateMario = 0;
    rotateMarioY = 0;

    //------Variables de estado-------//
    closed = true;
    movement = false;
    ...
   
<br/>

#### Función de dibujado general *draw()*

Esta función se encarga de mantener actualizado el tablero de dibujado, además de hacer otras comprobaciones para el correcto funcionamiento de la aplicación. Para esta práctica se ha añadido nuevas comprobaciones en este método, certificando que los gestos recogidos por *FaceOSC* se conecten con las funciones del personaje y la iluminación.

    //------Dibujado del rostro con puntos y aristas-------//
    camera();
    translate(width/11, height/7, 0);
    scale(3);
    drawFacePoints(); 
    drawFacePolygons();

    //-------Se ejecuta cuando encuentra un rostro--------//    
    if(found > 0) {    

      //-------Comprueba el desplazamiento hacia adelante-------//
      if (eyebrows[0] > (lastEyebrows[0] + tolerance) && eyebrows[1] > (lastEyebrows[1] + tolerance)) {
        movement = true;
      }else{
        movement = false;  
      }

      //-------Comprueba la rotación horizontal---------//
      if (posePosition.x > (lastPosePosition.x + 15*tolerance)) {
        rotateMario = -1;
      }else if (posePosition.x < (lastPosePosition.x - 15*tolerance)){
        rotateMario = 1;  
      }else{
        rotateMario = 0;  
      }

      //-------Comprueba la rotación vertical----------//
      if (posePosition.y > (lastPosePosition.y + 15*tolerance)) {
        rotateMarioY = -1;
      }else if (posePosition.y < (lastPosePosition.y - 15*tolerance)){
        rotateMarioY = 1;  
      }else{
        rotateMarioY = 0;  
      }

      //--------Cammbia la iluminación con la boca-------//
      if (mouthHeight > 4 && !closed){
        if (indexFilter > 4) keys[indexFilter-1] = false;
        if (indexFilter == 4) keys[8] = false;
        keys[indexFilter] = true;

        indexFilter++;
        if (indexFilter >= 9) indexFilter = 4;
        closed = true;
      }    
    }
    
<br/>

#### Funciones *callback()* para *FaceOSC*

Se han añadido diversas funciones que recogen los datos de cada gesto o postura realizado por el usuario y, según el tipo, se realiza una comprobación de variación del dato actual respecto a la anterior. De este modo se puede conocer, por ejemplo, si se debe seguir desplazando o rotando el personaje.

    //------Altura de la boca---------//
    public void mouthHeightReceived(float h) {
      if (mouthHeight <= 4) closed = false;
      mouthHeight = h;
    }

    //-------Ceja izquierda--------//
    public void eyebrowLeftReceived(float f) {
      if (lastEyebrows[0] == 0) {
        lastEyebrows[0] = f;
      }
      if (f > lastEyebrows[0] + tolerance*3 || f < lastEyebrows[0] - tolerance*3) {
        lastEyebrows[0] = f;   
      }
      if (eyebrows[0] < lastEyebrows[0]) {
        lastEyebrows[0] = eyebrows[0];
      }
      eyebrows[0] = f;  
    }

    //--------Ceja derecha---------//
    public void eyebrowRightReceived(float f) {
      if (lastEyebrows[1] == 0) {
        lastEyebrows[1] = f;
      }
      if (f > lastEyebrows[1] + tolerance*3 || f < lastEyebrows[1] - tolerance*3) {
        lastEyebrows[1] = f;   
      }
      if (eyebrows[1] < lastEyebrows[1]) {
        lastEyebrows[1] = eyebrows[1];
      }
      eyebrows[1] = f; 
    }
    
<br/>

#### Funciones restantes

Las funciones restantes se corresponden con aquellas encargadas de recoger las pulsaciones de las teclas como *keyPressed()* o *keyReleased()*, además de funciones para capturar las pulsaciones del ratón como *mousePressed()* o *mouseWheel()*; y una especial que se encarga de generar las tres componentes *RGB* para la iluminación. Además de métodos para recoger los datos crudos de *FaceOSC*, entre otros.

<br/>

#### Clase *Help*

Esta clase es la encargada de mostrar y generar todos los textos de la aplicación, así como los diversos botones existentes, tales como los que se presentan a continuación:

    //-------Se dibuja el botón de cambio de ayuda--------//
    void drawControls() {
      fill(0);
      stroke(255);
      rect((width/2) + 140, (height/5) + 280, btnWS, btnH);   
      fill(255);
      textSize(14);
      if (controls == 1) {
        text("MARIO", ((width/2) + 140) + 25, ((height/5) + 280) + 15);
      }else if (controls == 2){
        text("FACIAL", ((width/2) + 140) + 16, ((height/5) + 280) + 15);
      }else{
        text("GENERAL", ((width/2) + 140) + 16, ((height/5) + 280) + 15);
      }
      fill(0);
    }

El resto de código de la aplicación ha permanecido intacto, por lo que si desea consultarlo, puede dirigirse al informe de la práctica anterior. 
Para consultar el código fuente de la aplicación, puede dirigirse al siguiente enlace:

[Consultar código fuente](https://github.com/JoseMAP-99/JoseMAP-99.github.io/tree/master/codes/FACIAL_CAMERA)

<br/>
<br/>

## Descarga del código fuente

Si desea descargar el código fuente, puede hacerlo desde el siguiente enlace:

[Descarga del código fuente](https://downgit.github.io/#/home?url=https://github.com/JoseMAP-99/JoseMAP-99.github.io/tree/master/codes/FACIAL_CAMERA)

<br/>
<br/>

[^1]: [Página de consulta sobre *FaceOSC*](https://github.com/kylemcdonald/ofxFaceTracker/releases)
[^2]: [Página de consulta sobre *Processing*](https://processing.org/)
[^3]: [Página de consulta sobre la práctica *Escena personalizada*](https://josemap-99.github.io/2021/03/23/custom_scene.html)
[^4]: [Página de consulta en *Clara.io*](https://clara.io/)
