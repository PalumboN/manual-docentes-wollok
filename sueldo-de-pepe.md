# Polimorfismo

En esta clase vamos a resolver un ejercicio aprovechando el _polimorfismo_.
Veamos todos los objetos involucrados en calcular el sueldo de Pepe...

### Objetivos de esta clase
1. Repaso de los conceptos básicos vistos: objeto, referencia, mensaje (consulta o acción), método, atributo, asignación
1. Plantear una solución a un ejercicio aprovechando el _polimorfismo_ 
1. Conceptos de _modelado_
    1. 3 formas de _conocer un objeto_: global, atributo o parámetro
    1. Decidir si _"me lo guardo o lo recibo?"_
    1. Objetos que representan cosas más abstractas (a.k.a _objetos chetardos_)
1. _Metodología_ propuesta
    1. ¿Cuál es el _requerimiento_?
    1. _¿Qué mensaje le voy a enviar a qué objeto (y con qué parámetros)?_
        - [TDD](https://es.wikipedia.org/wiki/Desarrollo_guiado_por_pruebas) en la consola
        - _Perderle el miedo_ a que el programa explote (errores)
    1. ¿Método de _acción o consulta_?
    1. Implementación

### Elementos del lenguaje
- `self`
- `if`
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
>
> 1. Hacer que pepe cambie de categoría (property). Comienza en cadete pero puede cambiar a gerente, y volver a cadete, en cualquier momento.
> 2. Conocer el sueldo base de pepe (polimorfismo)
> 3. Conocer el sueldo (final) de pepe contemplando los posibles bonos (self)

Presentamos el principio del enunciado (pepe, categorías y bonos) y el primer requerimiento.
Después se abre un nuevo proyecto en blanco para comenzar...

# 1. Cómo encarar un ejercicio

#### Preguntas gatillo

> ¿Por dónde arrancamos?

Después de hacer un pequeño debate para entrar en calor con el ejercicio y repasar los conceptos básicos de objetos, proponemos nuestra metodología.

### Metodología para encarar un ejercicio

Esta es la metodología que vamos a usar para resolver los ejercicios en toda la cursada:

1. ¿Cuál es el **requerimiento**? (uno, el primero, o el siguiente si ya hay algo resuelto)
    - Focalizamos en _una parte del problema_: "dividir y conquistar"
    - _Respuesta:_ Calcular el sueldo base de pepe
1. ¿**Qué mensaje** vamos a enviar a qué objeto (y con qué parámetros)?
    - Pensamos primero en _cómo vamos a usar_ los objetos (pensar en el _mensaje_ antes que en el _método_)
    - Armar una lista de _objetos candidatos_, si es necesario
    - Acá puede salir varias posibilidades, está bueno anotarlas todas para después definir
    - _Respuesta:_ `pepe.cambiarCategoria(gerente)`
1. Escribimos un **ejemplo concreto** del mensaje
    - Lo escribimos en la consola. _Sí, ¡antes de escribir el código!_
    - Vemos que todo rompe porque no está implementado, pero _¡no nos asustamos!_
1. **Acción o consulta**
    - Este es ¿un mensaje de acción o de consulta?
      - Si es acción, _¿qué esperamos que pase?_
      - Si es conuslta, _¿qué esperamos que devuelva?_
    - _Respuesta:_ Es de acción, Pepe debe cambiar su categoría de cadete a gerente.
1. **Implementación**
    - Codear lo necesario para que el ejemplo se comporte como esperamos
    - Pensar si hay más ejemplos para tener en cuenta
      - Implementar lo necesario para el nuevo ejemplo si es necesario
1. Repetir hasta terminar el ejercicio - **Iterar**

Proponemos esta metodología porque:
- Focaliza en una parte del problema (y por el momento nos olvidamos del resto)
- Primero piensa en el qué antes que en el cómo
  - O sea, primero pensamos en mensaje antes que en la implementación del método
- Propone un objetivo claro
  - Al escribir el uso en la consola, ya tenemos en claro qué le falta al sistema
  - Le perdemos el miedo a que nos explote un programa en la cara (práctica de _debugging_)
  - El requerimiento se resuelve cuando la consola deje de fallarnos (los errores guían el desarrollo)
- En fin, propone una forma de trabajar **iterativa e incremental**

# 2. Manos a la obra

Ahora que tenemos un objetivo fijo:
```bash
> pepe.cambiarCategoria(gerente)
✓
```

> ¿Y qué tipo de objeto es `gerente`? ¿Un String o un objeto nuestro? Guiar la solución para definir los objetos `pepe`, `cadete` y `gerente` desde el principio.

Lo probamos para ver los errores e ir resolviéndolos hasta que el programa se comporte como esperamos.

Si comenzamos con un archivo vacío:
```wlk
// pepe.wlk
```

Y con el archivo cargado probamos en la consola:
```bash
pepe> pepe.cambiarCategoria(gerente)
✗ Unknown reference gerente
```

Vemos que nos dice que no encuentra una referencia para `gerente`.
Lo que tiene sentido, porque no definimos ningún objeto con ese nombre (de hecho, no definimos nada todavía).

Así que definimos un objeto que represente al gerente, en su forma más básica:
```wlk
// pepe.wlk

object gerente { }
```

Y _volvemos a probar_. Para eso hay varias opciones:
- Cerrar la consola actual y volver a levantarla :-1:
- Recargar la consola con `:r` y volver a tirar el mensaje (buscar con al fecha arriba ⬆️) :+1_
- **Recargar y re-ejecutar** todo con `:rr` 👌

Vemos que ahora el mensaje de error cambió:
```bash
pepe> pepe.cambiarCategoria(gerente)
✗ Evaluation Error!
  wollok.lang.EvaluationError: Error: Could not resolve reference to pepe
```

Ahora, como es de esperar, falta `pepe`. Volvemos a hacer lo mismo, definiendo un objeto:

```wlk
// pepe.wlk

object pepe { }

object gerente { }
```

Con esto, ya tenemos los objetos que necesitamos definidos, y los podemos ver en el diagrama dinámico:

<img width="405" height="270" alt="image" src="https://github.com/user-attachments/assets/d59a4b9b-7975-43cc-9596-293255f43884" />

Así que _volvemos a probar_ en la consola. (Hay que meterles el **hábito** de la metodología).

```bash
pepe> pepe.cambiarCategoria(gerente)
✗ Evaluation Error!
  wollok.lang.MessageNotUnderstoodException: pepe does not understand cambiarCategoria(arg 0)
```

Ahora el error nos dice que _pepe no entiende el mensaje `cambiarCategoria(arg 0)`_.

#### Acá se pone interesante...

#### Preguntas gatillo

> ¿Qué significa que pepe no entienda el mensaje?

_Respuesta:_ que no tiene definido ningún método con la _firma_ `cambiarCategoria/1`. (El `/1` es una forma de anotar que es un método que espera 1 parámetro. Se puede tener métodos con el mismo nombre y distinta cantidad de parámetros, pero no vamos a entrar en eso ahora).

Así que debemos **definir un método** `method cambiarCategoria(unaCategoria)` en `pepe`.

Y, como habíamos dicho, este debe ser un **método de acción**.
O sea, debe cambiar algo, pero no devolver nada...

> ¿Qué cosa debe cambiar este método?

_Respuesta:_ la categoría de pepe.

El problema es que ahora pepe no tiene nada, es un objeto vacío.
Así que una decisión acá es decir que el objeto `pepe` tiene que conocer a otro objeto como su categoría, o sea, que va a tener un **atributo `cateogria`**.

"Cambiar algo" en objetos es mover (_asignar_) un atributo, lo que sería re-apuntar una flecha en el diagrama dinámico.
Sin embargo, nuestro programa todavía no tiene ninguna flecha.

Pero no desesperemos, sigamos firme con la metodología: escribamos cómo sería el método, y veamos los errores.

```wlk
// pepe.wlk

object pepe { 

    method cambiarCategoria(unaCategoria) {
        categoria = unaCategoria
    }

}

object gerente { }
```

Ya con escribir ese código nos sale un error de que el programa tiene una _referencia desconocida_:

<img width="634" height="310" alt="image" src="https://github.com/user-attachments/assets/1edd1092-a2b3-4c46-8859-175369095c52" />

O sea, el programa no sabe lo que significa el `categoria` a la izquierda de la asignación.

Eso es porque falta definirle el atributo `var categoria`

```wlk
// pepe.wlk

object pepe { 

    var categoria

    method cambiarCategoria(unaCategoria) {
        categoria = unaCategoria
    }

}

object gerente { }
```

Ahora vemos que el error anterior desapareció pero aparece uno nuevo en la definición del atributo, diciendo que _los atributos de los objetos deben ser inicializados_:

<img width="634" height="357" alt="image" src="https://github.com/user-attachments/assets/b969b22c-4a18-484b-ab7f-2bf95f161af7" />

Esto es porque **una referencia siempre debe apuntar a un objeto**, y no puede nunca estar apuntando a "la nada".

Acá Wollok se está dando cuenta que al iniciar el programa el atributo `categoria` no tiene nada asignado, por ende no va a estar apuntando a ningún objeto.

> Wollok fuerza a tener siempre objetos "listo para usarse", y considera que si no tiene un atributo inicializado entonces el objeto no va a poder funcionar como se espera. En Wollok existe el `null`, pero no lo vamos a ver ahora.

Por suerte, el enunciado nos aclara que pepe siempre comienza siendo cadete.

#### Preguntas gatillo

> ¿Cómo hacemos para que pepe comienza siendo cadete?

_Respuesta:_ hay que **crear un nuevo objeto** `cadete` e **inicializar el atributo** `categoria` con él.


Al final el código queda:

```wlk
object pepe { 

    var categoria = cadete

    method cambiarCategoria(unaCategoria) {
        categoria = unaCategoria
    }

}

object cadete { }

object gerente { }
```

Y _volvemos a probar en la consola_:

![Screen Recording 2026-01-12 at 17 10 44](https://github.com/user-attachments/assets/2b039980-c8b1-4074-b3e6-e44b3120f6be)

Vemos que pepe comienza apuntando a `cadete` como su categoría, y lo podemos cambiar a `gerente`.
También podemos volver a la categoría de `cadete` si le mandamos este por parámetro al mensaje `cambiarCategoria`.

### ¡Excelente! Primer punto completado 🚀



## Propiedades - Métodos que no se escriben

**Paramos la pelota** para meter algo de teoría sobre lo que tenemos...

- El **enunciado** nos dice que Pepe puede ser cadete o genrente, y nos pide poder configurar su categoría en cualquier momento
- Para **modelar** eso
    - creamos **3 objetos**: `pepe`, `cadete` y `gerente`
        > círculos en el diagrama dinámico
    - y un **atributo** en `pepe` que _apunta a alguno de los otros 2 objetos_: `categoria`
        > flecha en el diagrama dinámico
- Para poder **cambiar el atributo** de `pepe`: apuntar la flecha `categoria`
    - hay que enviarle un mensaje a `pepe`, por ejemplo: `pepe.cambiarCategoria(gerente)`
        - Esto se conoce como **encapsulamiento**
           > cada objeto es "dueño" de sus atributos y solo ellos pueden _acceder_ a él, tanto para leerlo como para asignarlo.
    - y `pepe` debe implementar un método que asigne la nueva categoría:
```wlk
    method cambiarCategoria(unaCategoria) {
        categoria = unaCategoria
    }
```

### Setters y Getters

> Como el paradigma de objetos propone tener _objetos encapsulados_, o sea, cada uno maneja su estado interno (atributos), los métodos que solo cambian o retornan algún atributo son **muy comunes** en los programas.

Vamos a jugar un poco con el código: 
1. Abrimos una **nueva sesión** de la consola 
1. **Cerramos** el diagrama dinámico (en realidad conviene solo ocultarlo, para poder verlo rápido durante la explicación)
1. Y le cambiamos la categoría a Pepe

```bash
pepe> pepe.cambiarCategoria(gerente)
✓ 
```

#### Preguntas gatillo

> Si no vemos el diagrama ¿cómo sabemos que Pepe cambió de su categoría?

_Respuesta:_ hay que _mandarle un mensaje_ preguntándole su categoría: `pepe.obtenerCategoria()`

> ¿Ese es un mensaje de acción o consulta?

_Respuesta:_ consulta. _Debe retornar_ su categoría, o sea, el objeto apuntado por su atributo

Acá podemos mostrar el diagrama rápidamente para entender que queremos retornar el objeto apuntado (y no un string u otra cosa que lo represente).

También podemos evaluar directamente esos objetos para que se entienda:

```bash
pepe> cadete
✓ cadete
pepe> gerente
✓ gerente
```

Pero si lo consultamos ahora nos da un error diciendo que _no entiende el mensaje_:

```bash
pepe> pepe.obtenerCategoria()
✗ Evaluation Error!
  wollok.lang.MessageNotUnderstoodException: pepe does not understand obtenerCategoria()
```

**Repasamos cómo seguir** a partir de acá:

- No entiende el mensaje porque no implementa un método
- Hay que definir un método en el objeto `pepe` que se llame `obtenerCategoria/0`
- Ese método debe retornar el atributo `categoria`

Lo escribimos (acá solo se presenta el código de `pepe`, el resto queda igual)

```wlk
object pepe { 

    var categoria = cadete

    method cambiarCategoria(unaCategoria) {
        categoria = unaCategoria
    }

    method obtenerCategoria() = categoria

}
```


(podría ser su versión con `{ return ... }`)

Y reevaluamos todo con `:rr` y vemos que ya no explota nada.

Ahora podemos intercalar los _cambiar_ y _obtener_ (podemos limpiar la consola con `ctrl + k` o `ctrl + l` o algo similar):

```bash
pepe> pepe.cambiarCategoria(cadete)
✓ 
pepe> pepe.obtenerCategoria()
✓ cadete
pepe> pepe.cambiarCategoria(gerente)
✓ 
pepe> pepe.obtenerCategoria()
✓ gerente
```

Acá explicamos cómo se conocen (por sus nombres en inglés) estos métodos:

- El método que cambia un atributo por un parámetro se conocen como _setter_: `cambiarCategoria/1`, `cambiarEnergia/1`, `cambiarAlgo/1`
- El método que retorna un atributo (y no tiene parámetros) se conocen como _getter_: `obtenerCategoria/0`, `obtenerEnergia/0`, `obtenerAlgo/0`
- Los lenguajes de programación (y su comunidad) generalmente definen una forma para el nombre de estos métodos
    - por ej: `setCategoria/1` y `getCategoria/0`
    - esto se conoce como **convención**: una forma de nombrar algún elemento del programa en el que _se ponen de acuerdo la comunidad_

La convención de Wollok para los getters y setters es con el mismo nombre del atributo (sin prefijo): `categoria/1` y `categoria/0`

**Modificamos el código**:

```wlk
object pepe { 

    var categoria = cadete

    method categoria(unaCategoria) {
        categoria = unaCategoria
    }

    method categoria() = categoria

}
```

Levantamos una nueva **consola** y volvemos a hacer las consultas con los nuevos nombres:

```bash
pepe> pepe.categoria(gerente)
✓ 
pepe> pepe.categoria()
✓ gerente
pepe> pepe.categoria(cadete)
✓ 
pepe> pepe.categoria()
✓ cadete
```

#### Atención

Resaltar que ahora en el código de pepe hay _3 cosas **distintas**_ que se llaman "categoria":

#TODO

### Posibles discusiones



# 3. Segundo requerimiento

<img width="210" height="190" alt="image" src="https://github.com/user-attachments/assets/60336cd7-92dd-4342-a4ca-a4f98ee9ee84" />

#TODO
Ahora que tenemos un objetivo fijo:
```bash
> pepe.sueldoBase()
1500
```


Vemos que ahora el mensaje de error cambió:
```bash
pepe> pepe.sueldoBase()
✗ Evaluation Error!
  wollok.lang.MessageNotUnderstoodException: pepe does not understand sueldoBase()
```

Diciendo que el objeto `pepe` (¡que ahora sí existe!) _no entiende el mensaje `sueldoBase()`_.

También ya lo podemos ver en el diagrama dinámico:

<img width="298" height="225" alt="image" src="https://github.com/user-attachments/assets/09997c00-3a92-4214-bf69-614c71ea212c" />

#### ¡Bien! Vamos avanzando

