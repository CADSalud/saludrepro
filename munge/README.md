
Here you can store any preprocessing or data munging code for your project. For example, if you need to add columns at runtime, merge normalized data sets or globally censor any data points, that code should be stored in the `munge` directory. The preprocessing scripts stored in `munge` will be executed sequentially when you call `load.project()`, so you should append numbers to the filenames to indicate their sequential order.


---

Se crea `salud_reproductiva.db` y las tablas:

  - defunciones: incluye todas las defunciones desde 1998 hasta 2015 y variables de causa, registro, demograficas, etc. 
  
  - causa_defunciones: de esta tabla se obtienen las etiquetas de las variables CAUSA_DEF, LISTA_MEX, GR_LISMEX, LISTA1 y MATERNAS
  
  - naciemientos: 
