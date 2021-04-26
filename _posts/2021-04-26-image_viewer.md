# Filtros para imágenes

`Autor: José María Amusquívar Poppe`

Para el desarrollo de esta práctica se ha solicitado la realización de una aplicación que incorpore distintas manipulaciones de *shaders*, empleando para ello el lenguaje de alto nivel *OpenGL Shading Language*[^1], el cual proporciona mayor versatilidad para el desarrollo de renderizados. La aplicación implementada constituye una interfaz de usuario que permite al usuario visualizar imágenes de su disco duro y aplicarles una serie de filtros predefinidos en la aplicación (Figura 1).

![](/images/image_viewer/vPrincipal.PNG "Fig. 1: Interfaz de usuario de la aplicación")

<br/>

1. TOC
{:toc}

<br/>

## Introducción

El proyecto a realizar tiene como objetivo practicar las distintas maneras de ,manipular *shaders* aplicados, en este caso, sobre imágenes proporcionados por el usuario. Para este cometido se emplea el lenguaje *GLSL*, cuya sintaxis es similar a la de *C*[^2], generando un fichero independiente en formato *.glsl*, el cual es cargado con la función *loadShader()* en el entorno de *Processing*[^3]. Así pues, la aplicación carga por defecto todas las imágenes contenidas en la carpeta "data/images/", por lo que será necesario disponer de dicha carpeta con algún fichero de imagen, en formato *.jpg* o *.png*, para que la aplicación funcione adecuadamente. Todas las imágenes sons cargadas en el proyecto y puestas a disposición del usuario mediante acciones de "Next" y "Previous", además de las respectivas teclas que aplican los filtros a las imágenes.



[^1]: [Página de consulta sobre *GLSL*](https://www.khronos.org/opengl/wiki/Core_Language_(GLSL))
[^2]: [Página de consulta en *C*](https://es.wikipedia.org/wiki/C_(lenguaje_de_programaci%C3%B3n))
[^3]: [Página de consulta sobre *Processing*](https://processing.org/)
[^4]: [Página de consulta sobre *ID3*](https://id3.org/)
[^5]: [Página de consulta sobre *TimeUnit*](https://docs.oracle.com/javase/7/docs/api/java/util/concurrent/TimeUnit.html)
[^6]: [Página de consulta sobre *Mixkit*](https://mixkit.co/free-stock-music/)
