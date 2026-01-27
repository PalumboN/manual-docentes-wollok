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
> El sistema debe ser extensible para nuevos empleados, nuevas categorías de trabajo, y nuevos contratos en el futuro
> 
> 1. Hacer que pepe cambie de categoría (property). Comienza en cadete pero puede cambiar a gerente, y volver a cadete, en cualquier momento.
> 2. Conocer el sueldo base de pepe (polimorfismo)
> 3. Conocer el sueldo (final) de pepe contemplando los posibles contratos
>         - Básico: es siempre de 1000
>         - Porcentual: es el 15 porciento del sueldo base del empleado
>         - Presentismo: Si el empleado no tuvo faltas es de 5000. Si tuvo 5 faltas o más, es de 500. En otro caso, es igual al sueldo base

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

⚽ **Paramos la pelota** para meter algo de teoría sobre lo que tenemos...

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

1. Definición del _atributo_: `var categoria`
1. Método _setter_: `method categoria(unaCategoria)`
1. Método _getter_: `method categoria()`

- Los atributos y métodos se definen y usan de forma distintas
    - Los atributos se definen con `var` o `const`, mientras que los métodos con `method`
    - Los atributos se usan como cualquier referencia, mientras que los métodos a través de envios de mensajes (después de un `.`)
- Los getter y setter tienen distinta firma, debido a sus parámetros
    - Los getters no esperan parámetro y son de consulta: `categoria/0`
    - Los setters esperan el nuevo objeto y son de acción: `categoria/1`
    - Como tienen distintos parámetros, se invoca uno u otro método en base a los parámetros que tiene el mensaje


### Atributos `property`

Como estos métodos son comunes en los lenguajes orientado a objetos, muchos traen una forma de declararlos fácilmente.

En Wollok, se puede usar el modificador `property` en la definición de un atributo para crear sus getters y setters.

El código de `pepe` quedaría así (dejo la versión con comentarios para los estudiantes, pero se sugiere probarlo sin los métodos escritos para que se entienda cómo funciona):

```wlk
object pepe { 

    var property categoria = "asd."

/*
Este código se crea con el "property" del atributo categoria

Está comentado para recordar lo que hace, pero no hace falta escribirlos

GETTER:
    method categoria(unaCategoria) {
        categoria = unaCategoria
    }

SETTER:
    method categoria() = categoria
*/
}
```

Y repetimos las consultas para probar que anda (probar es **siempre** mucho muy importante):

```bash
pepe> :rr
✓ Reloading environment
pepe> pepe.categoria(gerente)
✓ 
pepe> pepe.categoria()
✓ gerente
pepe> pepe.categoria(cadete)
✓ 
pepe> pepe.categoria()
✓ cadete
```


### Posibles discusiones

- `var property` vs `const property`
- ¿Qué pasa si escribo un método getter o setter usando `property`?
- Ahora tengo un getter y antes no, ¿es eso mejor?


## Código final del primer punto

El código final para el primer punto queda en estas pocas líneas

```wlk
object pepe { 

    var property categoria = cadete

}

object cadete { }

object gerente { }
```

Continuemos con el siguiente...



# 3. Segundo requerimiento

Ahora que ya conocemos la metodología, vamos a aplicarla para el segundo punto...

<img width="210" height="190" alt="image" src="https://github.com/user-attachments/assets/60336cd7-92dd-4342-a4ca-a4f98ee9ee84" />

> ¿Cuál es el requerimiento?

_Respuesta:_ conocer el sueldo base de pepe

> ¿Qué mensaje le vamos a enviar a qué objeto?

_Respuesta:_ `pepe.sueldoBase()`

> ¿Es de acción o de consulta?

_Respuesta:_ de consulta

> Ejemplo de consulta

_Respuesta:_ siendo cadete esperaríamos

```bash
> pepe.sueldoBase()
1500
```

#### Comenzamos

Probamos la consulta en la **consola**

```bash
pepe> pepe.sueldoBase()
✗ Evaluation Error!
  wollok.lang.MessageNotUnderstoodExcegption: pepe does not understand sueldoBase()
```

Y **leemos** el error: _pepe no entiende el mensaje `sueldoBase()`_

> ¿Cómo se soluciona?

_Respuesta:_ implementando el método (de consulta) en `pepe`

El enunciado dice que el sueldo base es siempre
- 1000
- más un extra dependiendo de la categoría
    - 500 para cadete
    - 1500 para gerente

Escribimos la parte fácil:

```wlk
object pepe { 

    var property categoria = cadete

    method sueldoBase() = 1000 + ...

}
```

#### Preguntas gatillo

> ¿Cómo calculamos el extra de la categoría?

_Respuesta:_ si el extra _depende_ de la categoría, **¡lo mejor es preguntárselo a ella!**

```wlk
method sueldoBase() = 1000 + categoria.extra()
```

Terminamos de escribir el método y **volvemos a probar**:

```wlk
pepe> :rr
✓ Reloading environment
pepe> pepe.sueldoBase()
✗ Evaluation Error!
  wollok.lang.MessageNotUnderstoodException: cadete does not understand extra()
    at pepe.pepe.sueldoBase() [pepe.wlk:5]
```

Ahora nos dice que _cadete no entiende el mensaje `extra()`_

También nos muestra el _stack trace_, o sea, dónde se produjo el error: `[pepe.wlk:5]` (con `ctrl + click` nos navega al método que envía el mensaje)

> ¿Cómo se soluciona?

_Respuesta:_ implementando el método en el objeto `cadete`

> ¿Es de acción o de consulta?

_Respuesta:_ consulta. Debería retornar `500`

Lo escribimos

```wlk
object cadete { 
    method extra() = 500
}
```

Y volvemos a probar

```bash
pepe> :rr
✓ Reloading environment
pepe> pepe.sueldoBase()
✓ 1500
```

### ¡Funciona! ¡Bravo!

#### Preguntas gatillo

> ¿Ya terminamos?

_Respuesta:_ no. Todavía falta probar siendo gerente.

Pensar todos los casos de prueba es algo _importante_ que queremos ejercitar y lo vamos a estar practicando la clase que viene

> ¿Y cómo probamos ese caso?

_Respuesta:_ hay que cambiarle la categoria a gerente y preguntarle el sueldo base

```bash
pepe> pepe.categoria(gerente)
✓ 
pepe> pepe.sueldoBase()
✗ Evaluation Error!
  wollok.lang.MessageNotUnderstoodException: gerente does not understand extra()
    at pepe.pepe.sueldoBase() [pepe.wlk:5]
```

Nos dice que _gerente no entiende el mensaje `extra()`_. 
¡Que bueno! que probamos este caso, nos falta implementar parte del código aún.

Implementamos el método que falta:

```wlk
object gerente { 
    method extra() = 1500
}
```

Y **volvemos a probar** todo

```bash
pepe> :rr
✓ Reloading environment
pepe> pepe.sueldoBase()
✓ 1500
pepe> pepe.categoria(gerente)
✓ 
pepe> pepe.sueldoBase()
✓ 2500
```

#### ¡Genial! Ahora sí ya terminamos


## Polimorfismo de Categorías

⚽ **Paramos la pelota** nuevamente para analizar lo que hicimos...

La clave de este punto está en _cómo calculamos el monto extra en base a la categoría_:

```wlk
method sueldoBase() = 1000 + categoria.extra()
```

- **Ignorancia**: Para calcular el sueldo base, pepe _**no** pregunta qué categoría tiene_
    > No pregunto quién es, directamente pido lo que necesito

- **Delegación**: En vez de eso, delega la responsabilidad de "calcular" el extra en la categoría mandándole directamente un mensaje
    > Si el extra depende de la categoría, lo mejor es preguntarle a ella

- **Responsabilidad**: Es responsabilidad de cada categoría el saber cuál es su extra (en base a quién representa el objeto)
    > ¿Quién tiene la responsabilidad de... (calcular el extra)?

#### Polimorfismo

Todas esas ideas se combinan para diseñar una solución con _polimorfismo_, uno de los pilares de la programación orientada a objetos

La clave está en que **`pepe` usa indistintamente a cualquiera de sus categorías**

Beneficios de este diseño:

- _Bajo acoplamiento_: `pepe` no sabe cómo funcionan las categorías por dentro, las categorías tampoco saben lo que hace `pepe`. Solamente se comunican a través de un _contrato_ que es el mensaje `categoria.extra()`
- _Extensividad_: es "fácil" entender cómo agregar más categorías (siempre que entiendan el mensaje `extra/0`, pero sino también es "fácil" adaptar el mensaje a lo que se necesite)

#### Interfaz

> Hablamos mucho sobre "categorías" pero nunca escribimos una definición sobre eso. Definimos a `gerente` y `cadete`, pero nada relacionado con "categoría". (El único lugar es el nombre del atributo en `pepe`, lo que habla bien sobre nuestra _expresividad_)

Podemos decir que **la `categoria` es cómo `pepe` conoce al objeto a cual preguntarle el `extra`**.
Este conjunto de mensajes por el cual un objeto se comunica con otro se llama **interfaz**

> En este programa, la interfaz `categoria` está constituída solamente por el mensaje `extra/0`


# 4. Último requerimiento


> ¿Cuál es el requerimiento?

_Respuesta:_ conocer el sueldo (final) de pepe teniendo en cuenta su contrato

> ¿Qué mensaje le vamos a enviar a qué objeto?

_Respuesta:_ `pepe.sueldo()`

> ¿Es de acción o de consulta?

_Respuesta:_ de consulta

> Ejemplo de consulta (comenzando por lo más fácil)

_Respuesta:_ siendo cadete (1500) y con un contrato básico (1000) esperaríamos

```bash
> pepe.sueldo()
2500
```

Lo escribimos en la consola para tener el ya conocido error de _no entiende el mensaje_ y ponernos a codear...

## "Yo mismo"

Este punto tiene como objetivo introducir la referencia de todo objeto a sí mismo: `self`

Sin embargo, podemos hacer una solución con las herramientas ya presentadas:

```wlk
object pepe { 

    var property categoria = cadete

    method sueldo() = pepe.sueldoBase()

    method sueldoBase() = 1000 + categoria.extra()

}
```

Y, como siempre, lo probamos:

```bash
pepe> :rr
✓ Reloading environment
> pepe.sueldo()
1500
```

#### Funciona!

Igual el IDE está avisando de algo:

<img width="508" height="244" alt="image" src="https://github.com/user-attachments/assets/8579ac3b-4e11-4baf-9d72-97e837a7eafc" />

### Presentar `self`

> Es una referencia que conocen todos los objetos y que apunta a sí mismos

Cambiar el código para arreglar el aviso y **probar que la consola se sigue comportando igual**

```wlk
method sueldo() = self.sueldoBase()
```

En el diagrama dinámico, las referencias a `self` no aparecen, pero podemos _forzarlas_ definiendo un atributo (`yoMismo`) inicializado en `self` en _todos los objetos_

```wlk
object pepe { 
    const yoMismo = self

    var property categoria = cadete

    method sueldo() = self.sueldoBase()

    method sueldoBase() = 1000 + categoria.extra()

}

object cadete { 
    const yoMismo = self

    method extra() = 500
}

object gerente { 
    const yoMismo = self

    method extra() = 1500
}
```

<img width="532" height="160" alt="image" src="https://github.com/user-attachments/assets/d417acd2-2949-4220-a7d3-fa2f9ce4dda4" />

Acá se visualiza:

- El **"rulo"** que significa una referencia a "sí mismo"
- En un programa prueden existir **muchos atributos con el mismo nombre**, siempre que _salgan_ de objetos distintos
- En el código, la paralabra `self` significa algo distinto **depende en qué objeto esté escrito**

Comentar (o borrar) los atributos `yoMismo` para seguir con el ejercicio

### Posibles discusiones

Algunas aristas que puede tomar esta clase y tocan conceptos importantes

<details>
<summary>Repetir código</summary>

Este punto se puede solucionar sin `self` copy-pasteando la definición de `sueldoBase()`

```wlk
method sueldo() = 1000 + categoria.extra()

method sueldoBase() = 1000 + categoria.extra()
```

Vamos a **evitar repetir lógica** a toda costa, y fomentar soluciones con **reutilización de lógica**

> Si ya existe un componente (método) que resuelve parte de mi problema, lo mejor es aprovecharlo

</details>

<details>
<summary>Romper el requerimiento anterior</summary>

También se podría _renombrar_ el método anterior para que se llame `sueldo()` y continuar desde ahí (de esa forma se evita el código repetido)

```wlk
method sueldo() = 1000 + categoria.extra()
```

Hacer notar que esto rompe con el requierimiento anterior, y que además es contraproducente: **perdemos una abstracción que ya existe**

</details>

<details>
<summary>Romper la sintaxis</summary>

Un error común al comenzar la POO es _olvidarse el receptor_ de un mensaje

```wlk
method sueldo() = sueldoBase()

method sueldoBase() = 1000 + categoria.extra()
```

Esto marca un error en el IDE

<img width="543" height="109" alt="image" src="https://github.com/user-attachments/assets/a07c5611-3765-4e15-a606-9655018a8dc2" />

Aún así es bueno recordar que en este paradigma (puro), todas las computaciones suceden a partir de enviar un mensaje.

> Un mensaje siempre tiene (necesita de) un **objeto** receptor: `objeto.mensaje()`

</details>


## Segundo polimorfismo

#### Volver a al problema

Esperábamos que nos diera 

```bash
> pepe.sueldo()
2500
```

Pero ahora nos da

```bash
pepe> :rr
✓ Reloading environment
> pepe.sueldo()
1500
```

#### _Hardcodear_ una solución

> Si al resultado le falta 1000, se lo sumamos...

```wlk
method sueldo() = self.sueldoBase() + 1000
```

Y probamos

```bash
pepe> :rr
✓ Reloading environment
> pepe.sueldo()
2500
```

#### Excelente...

> o bueno, no tanto... esta implementación fue para salir del paso, pero no _resuelve_ el enunciado


### Los contratos

Acá buscamos introducir a los distintos _contratos_ de forma **similar a las _categorías_**

- Entender que Pepe debe estar _asociado_ a una de los contratos: básico, porcentual o presentismo
- Se debe poder _elegir (configurar)_ qué contrato tiene Pepe
- El sueldo se debe _calcular a partir del contrato_ (y categoría) configurado(a)

Para eso 

1. Definimos **3 nuevos objetos**

```wlk
object basico {

}

object porcentual {
    
}

object presentismo {
    
}
```

2. Agregamos un **nuevo atributo** en `pepe`

```wlk
var property contrato = basico
```

3. Le **mandamos un mensaje** al `contrato` para calcular el sueldo

```wlk
method sueldo() = self.sueldoBase() + contrato.remuneracion()
```

Probamos qué onda

```bash
pepe> :rr
✓ Reloading environment
> pepe.sueldo()
✗ Evaluation Error!
  wollok.lang.MessageNotUnderstoodException: basico does not understand remuneracion()
    at pepe.pepe.sueldo() [pepe.wlk:5]
```

Y **leemos el error**

> `basico` no entiende el mensaje `remuneracion()`

> ¿Es de acción o de consulta?

_Respuesta:_ de consulta

Implementamos el método con el código necesario para que la prueba funcione como antes

```wlk
object basico {
    method remuneracion() = 1000
}
```

Y probamos

```bash
pepe> :rr
✓ Reloading environment
> pepe.sueldo()
2500
```

#### Al repetir estos pasos buscamos

- que se adopte la _metodología_ de trabajo
- fortalecer el diseño que aprovecha el _polimorfismo_
- mostrar cómo el programa crece de forma _iterativa e incremental_


### Porcentual, ¿nos conocemos?

> Una vez implementado el contrato más fácil, continuamos con el siguiente: `porcentual`

Este punto plantea **el problema de cómo el `porcentual` conoce a `pepe`**

El objetivo es introducir las 3 formas de conocer un objeto desde otro:
- global: la referencia está _hardcodeada_ en el código
- atributo: la referencia está en un _atributo del objeto_
- paramétrico: la referencia viene por _parámetro_

Comenzamos a implementar el método 

#### Global

La primera forma de implementar este punto suele ser la _global_

```wlk
object porcentual {
    const porcentaje = 15
    method remuneracion() = pepe.sueldoBase() * porcentaje / 100
}
```

Probamos, configurando a `pepe` antes

```bash
pepe> pepe.contrato(porcentual)
✓ 
pepe> pepe.sueldo()
✓ 1725
```

Joya!

Además vemos cómo queda el diagrama

<img width="726" height="325" alt="image" src="https://github.com/user-attachments/assets/de7960af-dae0-4e2a-9bb1-613ecc3dba7b" />

Marcamos algunas características de esta solución:
- Referencias unilaterales
- La referencia está en el código del método


#### Atributo


#### Parámetro



- Porcentual: pasar self por parámetro (discutir sobre el sueldo base)
- Pasar por referencia: no hay objetos más pesados que otros


### Diseñar es tomar decisiones

- Presentismo: quién se guarda las faltas?
