<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/Team-17-Bedu/proyecto">
    <img src="https://github.com/Team-17-Bedu/proyecto/blob/main/img/icono.png" alt="Logo" width="135" height="135">
  </a>

  <h3 align="center"><strong>Países con mayor calidad de vida</strong></h3>

  <p align="center">
    Desarrollo de Mapa Interactivo de los Indices de Desarrollo Humano en el mundo
  </p>

</p>

## Objetivos
* Elaborar un mapa interactivo con el fin de mostrar de la manera mas gráfica los `IDH`.
  
## Requisitos
- RStudio | Jetbrains PyCharm
- R

## Descripcion

Para ello se apoyo las bibliotecas: _`leaflet`_ y _`RColorBrewer`_ . Que permitian desarrollar una aplicaiones interativa en Shiny. 
<br>
Un claro ejemplo del uso de estas librerias se de puede observar en la siguiente imagen:

<p align="center">
  <a href="https://github.com/Team-17-Bedu/proyecto">
    <img src="https://github.com/Team-17-Bedu/proyecto/blob/main/img/Leaflet.PNG">
  </a>
</p>

<br>
_Figura.1_ - Ejemplo de libreria _`leaflet`_.
<br>

Al observar la versatilidad de estas bibliotecas. Se llego a la conclusión de que seria una buena herramienta para observar los indices de desarrollo humano en el trasncurso de los años 1990 a 2019. Llegando al siguiente resultado:

<p align="center">
  <a href="https://github.com/Team-17-Bedu/proyecto">
    <img src="https://github.com/Team-17-Bedu/proyecto/blob/main/img/Resultado.PNG">
  </a>
</p>
<br>
_Figura.2_ - Resultado final de mapa interactivo.
<br>

### Elaboración del mapa.

Para la elaboración del mapa se baso en mapas generados por esta [pagina](https://rstudio.github.io/leaflet/map_widget.html).  Tambien se apoyo de la respectiva documentacion de _Shiny_.
<br>
Primeramente se realizo una cruza de información entre el dataset de los `Indices de Desarrollo Humano` y uno de `coordenadas geograficas`. Para ello, se apoyo de herramientas como _MySQL_ para realizar la operación de _`joins`_ a dichos datasets.
De esta se genero un dataset que contaba con datos geograficos y con registros de los indices de desarrollo por pais.
<br>
Posterior a la generación del dataset con la informacion espacial. Se genero la aplicación _Shiny_. 
<br>
Para su generación se utilizo de referencia el siguiente mapa

<p align="center">
  <a href="https://github.com/Team-17-Bedu/proyecto">
    <img src="https://github.com/Team-17-Bedu/proyecto/blob/main/img/imagen_base.PNG">
  </a>
</p>
<br>
_Figura.3_ -Imagen base para la generación del mapa iteractivo.

Que esta disponible en el siguiente [enlace](https://rstudio.github.io/leaflet/shiny.html). 
<br>
Con base en el proyecto anterior se realizaron las modificaciones necesarias para dara a conocer los resultados de los `IDH` de los periodos de 1990 a 2019. Siendo capaz de cambiar los colores en el despliege de los resultados. Ademas de que cuenta con la capacidad de cambiar entre los respectivos años y poder seleccionar cualquier punto y desplegar el nombre del pais con el respectivo `IDH`. Un ejemplo de tales resultados se puede apreciar en las siguientes imagenes:

<p align="center">
  <a href="https://github.com/Team-17-Bedu/proyecto">
    <img src="https://github.com/Team-17-Bedu/proyecto/blob/main/img/Res_1.PNG">
  </a>
</p>
<br>
_Figura.4_ -Resultado con colores predefinidos.
<br>
<p align="center">
  <a href="https://github.com/Team-17-Bedu/proyecto">
    <img src="https://github.com/Team-17-Bedu/proyecto/blob/main/img/Res_2.PNG">
  </a>
</p>
<br>
_Figura.5_ -Resultado con colores selccionados.
<br>
<p align="center">
  <a href="https://github.com/Team-17-Bedu/proyecto">
    <img src="https://github.com/Team-17-Bedu/proyecto/blob/main/img/Res_3.PNG">
  </a>
</p>
<br>
_Figura.6_ -Resultado con selección de pais.
<br>


## Conclusion 

La generación de elementos visuales que permitan percibir los cambios en cualquier problematica. Permiten al expectador entender mejor la situación a generar conocimiento. Por ello, el equipo 17 se comprometio a la genración de este razonamiento apartir de este tipo de elementos. 
<br>
Aun asi para su implementacion como aplicación de _Shiny_, causo algunos problemas en su etap de producción. Pero se consiguio su objetivo de un despliegue exitoso. <br>
Le invitamos a que si solo quiere interactuar con el mapa generado precione el siguiente [enlace](https://begeistert.shinyapps.io/IDHMap/). Aun asi esta invitado a observar todos los resultados en la siguiente [enlace](https://begeistert.shinyapps.io/Proyecto-Team-17/) 




















