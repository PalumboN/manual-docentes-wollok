# Polimorfismo

En esta clase vamos a resolver un ejercicio aprovechando el _polimorfismo_.
Veamos todos los objetos involucrados en calcular el sueldo de Pepe...

### Objetivos de esta clase
1. Plantear una solución a un ejercicio aprovechando el _polimorfismo_ 
1. Conceptos de _modelado_
    1. 3 formas de _conocer un objeto_: global, atrobuto o parámetro
    1. Decidir si _"me lo guardo o lo recibo?"_
    1. Objetos que representan cosas más abstractas (a.k.a _objetos chetardos_)
1. _Metodología_ propuesta
    1. ¿Cuál es el _requerimiento_?
    1. _¿Qué mensaje le voy a enviar a qué objeto (y con qué parámetros)?_
        - [TDD](https://es.wikipedia.org/wiki/Desarrollo_guiado_por_pruebas) en la consola
    1. ¿Método de _acción o consulta_?

### Elementos del lenguaje
- `self`
- `property`
- Comandos de la consola: `:r` `:rr`

### Apuntes teóricos
1. [Referencias. Estado. Compartir objetos. Identidad.](https://docs.google.com/document/d/14092iRsXDXih8-q_0UEXIGRSQmGtxL9pay1VXX4ceJg/edit?usp=drive_web)
1. [Introducción a Polimorfismo.](https://docs.google.com/document/d/1X7Sz12e7rbVO1x7uMD7ECjZnT-chELx0ElTPmNvNURU/edit?usp=drive_web)
1. [Atributos como Propiedades.](https://docs.google.com/document/d/1wziW1YY-t94UUAUApydrt-OZ5roq1uY6DT6FduwNGx0/edit?usp=drive_web)

----

# El Sueldo de Pepe

> #TODO Ver qué versión del sueldo de pepe usar como enunciado...
> Código inicial (con las categorías y métodos en blanco de pepe)?
> Pasar por la hoja en blanco?
> Requerimiento de sueldo base?
> O directamente el sueldo con bonos?

Presentamos el principio del enunciado (pepe, categorías y bonos) y el primer requerimiento.
Después se abre un nuevo proyecto en blanco para comenzar...

#### Preguntas gatillo

> ¿Por dónde arrancamos?

Después de hacer un pequeño debate para entrar en calor con el ejercicio y los conceptos básicos de objetos, proponemos nuestra metodología.

### Metodología para encarar un ejercicio

Esta es la metodología que vamos a usar para resolver los ejercicios en toda la cursada:

1. ¿Cuál es el **requerimiento**? (uno, el primero, o el siguiente si ya hay algo resuelto)
    - Focalizamos en _una parte del problema_: "dividir y conquistar"
    - _Respuesta:_ Calcular el sueldo base de pepe
1. ¿**Qué mensaje** vamos a enviar a qué objeto (y con qué parámetros)?
    - Pensamos primero en _cómo vamos a usar_ los objetos (pensar en el _mensaje_ antes que en el _método_)
    - Acá puede salir varias posibilidades, está bueno anotarlas todas para después definir. En ejercicios simples puede que la primero o más natural sea la mejor, pero a medida que la complejidad incremente puede no ser tan obvio.
    - _Respuesta:_ `pepe.sueldoBase()`
1. Escribimos un **ejemplo concreto** del mensaje
    - Lo escribimos en la consola. _Sí, ¡antes de escribir el código!_
    - Vemos que todo rompe porque no está implementado, pero _¡no nos asustamos!_
1. **Acción o consulta**
    - Este es ¿un mensaje de acción o de consulta?
      - Si es acción, _¿qué esperamos que pase?_
      - Si es conuslta, _¿qué esperamos que devuelva?_
    - _Respuesta:_ Es de consulta y para un Pepe gerente esperamos que devuelva `1500`

Proponemos esta metodología porque:
- Focaliza en una parte del problema (y por el momento nos olvidamos del resto)
- Primero piensa en el qué antes que en el cómo
  - O sea, primero pensamos en mensaje antes que en la implementación del método
- Propone un objetivo claro
  - Al escribir el uso en la consola, ya tenemos en claro qué le falta al sistema
  - Le perdemos el miedo a que nos explote un programa en la cara (práctica de _debugging_)
  - El requerimiento se resuelve cuando la consola deje de fallarnos (los errores guían el desarrollo)
- En fin, propone una forma de trabajar **iterativa e incremental**
