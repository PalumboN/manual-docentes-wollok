# Hola Pepita

Luego de instalar Wollok, y antes de explicar cualquier concepto, presentamos un ejercicio básico.
Nuestro favorito (e insignia de Wollok) es Pepita...

## Objetivos de esta clase

1. Tener una imagen visual de _objetos_ y _referencias_ por medio del _diagrama dinámico_
1. Mandar _mensajes_ que se diferencian entre _acciones_ y _consultas_
1. Concepto de _asignación_ como "apuntar una referencia"
1. Introducir un objeto _polimórfico_

## Elementos del lenguaje
- `object`
- `var` y `const`
- `method` (inline y asignación)
- Envío de mensajes `.`
- Levantar un REPL con la consola

## Apuntes teóricos
1. [Objetos. Mensajes. Métodos.](https://docs.google.com/document/d/1RBfNmKZFKZ90XvfQsN7zhtuUPV2Mvj7t-iyZiL2bClQ/edit?usp=drive_web)
1. [Referencias. Estado. Compartir objetos. Identidad.](https://docs.google.com/document/d/14092iRsXDXih8-q_0UEXIGRSQmGtxL9pay1VXX4ceJg/edit?usp=drive_web)
1. [Introducción a Polimorfismo.](https://docs.google.com/document/d/1X7Sz12e7rbVO1x7uMD7ECjZnT-chELx0ElTPmNvNURU/edit?usp=drive_web)
1. [Objetos básicos. Números. Strings. Fechas. (y más)](https://docs.google.com/document/d/1HiYxLswd4O0MBqnT3jGo2K9e_4FE73RXF_lf8NWVOSE/edit?usp=drive_web)


## Presentación del ejercicio

> #TODO: Buscar un repo con el ejercicio inicial: `vola(kms)` y `come(comida)`

Presentamos los requerimientos del ejercicio: 

> Pepita es una golondrina que tiene energía. Cuando vuela, gasta energía en función de los kilómetros recorridos. Cuando come, aumenta su energía en función de la comida. Pepita está cansada cuando su energía es mejor a 50.

Mostramos directamente el código:

```wlk
object pepita {
  var energia = 100

  method vola(kms) { energia = energia - kms }

  method come(comida) { energia = energia + comida.energia() }

  method estaCansada() = energia < 50

}

object manzana {
  method energia() = 50
}

object alpiste {
  const granos = 70

  method energia() = granos * 2
}
```

Y lo levantamos en la [consola interactiva](https://www.wollok.org/tour/console) para ver el [diagrama dinámico](https://www.wollok.org/tour/dynamicdiagram/).

<img width="446" height="338" alt="image" src="https://github.com/user-attachments/assets/4b4d3e67-8246-4851-b67b-bca46c04aff4" />


## 1. Objetos y Referencias

- Definición de programa en objetos:
  - "Un _programa Wollok_ está compuesto por _objetos_ que se conocen por medio de _referencias_".

- Explicación de _diagrama dinámico_:
  - Los objetos son círculos y las referencias son flechas que apuntan siempre a uno de los círculos.
  - El diagrama muestra los objetos vivos con sus _atributos_: referencias que el objeto conoce.
  - Las flechas tienen un nombre.

- Explicación del ejemplo:
  - pepita conoce al 100 por medio de la referencia `energia`.
  - El alpiste conoce al 70 a través de la referencia `granos`.
  - Los números, que son círculos, también son objetos (que vienen con el lenguaje, por eso tienen otro color).
  - Existen referencias variables: que cambian el objeto al que apuntan a través del tiempo. O **constantes 🔒**: que siempre apuntan al mismo objeto.

- Algunas preguntas para hacer:
  - ¿La manzana conoce al alpiste?
  - ¿El alpiste conoce a alguien como su `energia`?
  - ¿Pepita conoce al 70?


## 2. Envío de mensajes

- Seguimos definiendo un programa en objetos:
  - "Los objetos se conocen por medio de referencias y se mandan **mensajes** para comunicarse entre sí".
  

Le envíamos un mensaje a pepita por la consola:

```bash
> pepita.estaCansada()
✓ false
```

- Consultar la intuición / lógica. Preguntar: "¿qué piensan que está pasando?"
  - La idea es relacionarlo con `method estaCansada() = energia < 50`.
  - Lógicamente: la energía de pepita es 100, que NO es menor a 50, entonces es _falso_ que está cansada.

- Explicación de la expresión `pepita.estaCansada()`
  - le estamos mandando el mensaje `estaCansada()` al objeto `pepita`. 
  - Sintaxis `objeto.mensaje()`. Siempre es _objeto_, seguido de punto `.`, y luego el mensaje _terminado en paréntesis_ para pasar parámetros (como veremos en un rato).

- Mensaje y método
  - **Método _lookup_**: Cuando un objeto recibe un _mensaje_, ejecuta el _método_ que tenga la misma _firma_ (en Wollok, que tenga el mismo nombre y cantidad de parámetros).
  - Diferencia entre mensaje y método: el mensaje se le envía a un objeto para que "pase algo", mientras el método es la definición de ese "algo que debe pasar".
  > Una buena forma de mostrar que NO son la misma cosa es enviando un mensaje que no se entienda:
```bash
> pepita.algoQueNoEntiende()
✗ Evaluation Error! pepita does not understand algoQueNoEntiende()
```
  - Cuando un objeto recibe un mensaje que no entiende se produce un **error**. En este ejemplo, le estamos pidiendo a pepita algo que no entiende.

- Jugar en la consola (#TODO: hacer después?)
  - Decir que los chirimbolos también son mensajes `+ - *` que entienden los números.
  - Evaluar algunas expresiones para mostrar los objetos números, booleanos, strings:
    - `1 + 2` `1 > 2`
    - `true || false`
    - `"hola " + "mundo"`


## 3. Métodos 

- Seguimos definiendo qué es un objeto:
  - Un objeto tiene un **estado** interno definido por sus atributos (los objetos que conoce) y un **comportamiento** definido por sus métodos.


#### Preguntas gatillo

> ¿Qué habría que hacer para que pepita esté cansada?

_Respuesta_: hacer que su atributo `energia` apunte a un objeto menor que 50.

> ¿Y cómo podemos cambiar la referencia `energia`?

_Respuesta_: Hay que pedírselo al objeto que la posee (de dónde sale la flecha) **enviándole un mensaje**.

> ¿Qué otros mensajes le podemos enviar a pepita?

_Respuesta_: `vola(kms)` y `come(comida)`

Le enviamos el mensaje `vola(kms)` para que baje su energía.
_¡Recordá tener visible el diagrama, y de prestar atención a lo que pasa justo cuando mandamos el mensaje!_

```bash
> pepita.vola(10)
✓
```
<img width="450" height="329" alt="image" src="https://github.com/user-attachments/assets/6d6ac85e-a28f-4d37-b7a6-dda4ce8be9c0" />

> [!NOTE]
> Una posible pregunta al ver la transición en el diagrama es preguntarse: **¿dónde se fue el 100?**
> Por ahora diremos que existe un _garbage collector_ (recolector de basura) que se encarga de llevarse los objetos que no están siendo usados.
> Hablaremos más sobre garbage collector a lo largo del curso, sobre todo cuando lleguemos al tema _clases_.


- Definición de `method vola(kms) { energia = energia - kms }`
  - El parámetro `kms` también es una _referencia_, que en `pepita.vola(10)` va a **apuntar** al 10.
  - El _objeto apuntado_ por `energia` (un número) se le manda el _mensaje_ `-` con el _objeto apuntado_ por `kms`.
    - El resultado se _asigna_ como la nueva `energia`, o sea que _esa referencia pasa a apuntar_ al resultado.

- Acción vs Consulta
  - Diferencias entre los mensajes `pepita.estaCansada()` y `pepita.vola(10)`:
    - `estaCansada()` es de consuta -> devuelve un valor (objeto).
    - `vola(kms)` es de acción (una orden, de forma imperativa) -> cambia (tiene efecto) del mundo (diagrama).
  - Como buena práctica, recomendamos tener esta clasificación exclusiva:
    - Si esperamos que un mensaje sea de consulta, que no tenga efecto.
    - Si esperamos que un mensaje tenga efecto, que no devuelva nada.

- Encapsulamiento
  - Cada objeto es dueño de sus atributos
    - "Si queremos cambiar la energía de pepita, hay que pedírselo (órden) a pepita"

- Sintaxis
  - Métodos de consulta
    - Inline (con el `=`): `method estaCansada() = energia < 50`
    - Con llaves `{ }` y `return`: `method estaCansada() { return energia < 50 }`
  - Métodos de acción
    - Siempre con llaves `{ }` y ~~casi~~ nunca con `return`

#### Extra simpático

- Viendo el diagrama, volar lo necesario para que pepita quede con 70 de energía y _sorprenderse_ al vez que tanto `energia` como `gramos` apuntan al mismo objeto.

- Hacer que la energía quede por debajo de 50 y volverle a preguntar `pepita.estaCansada()`


## 4. Polimorfismo

- Seguimos definiendo cómo se usa un objeto:
  - Los mensajes que se le manda a un objeto definen una **interfaz**.

#### Preguntas gatillo

> El método `come(comida)`, ¿es de acción o de consulta?

_Respuesta_: acción. No devuelve nada, esperamos que cambie la energía de pepita.

> ¿Y qué objetos espera por parámetro?

_Respuesta_: una comida, como la manzana o el alpiste.

Hacer que pepita coma ambas comidas, ver el efecto que tiene.

```bash
> pepita.come(manzana)
✓
> pepita.come(alpiste)
✓
```

<img width="448" height="317" alt="image" src="https://github.com/user-attachments/assets/ccf4b125-e612-4381-8c8e-7a101e06a910" />

- Seguir la cadena de mensajes en cada caso: `pepita.come/1` -> `comida.energia/0`
  - Entender qué método `energia()` se ejecuta en cada caso
  - Usar el [debugger](#TODO) para una mejor experiencia

#### Pregunta gatillo

> Si queremos que pepita pueda comer kiwi, ¿qué cambios hay que hacer al programa?

_Respuesta_: tiene que salir 2 cosas claves: meter un **nuevo objeto** `kiwi` que **entienda el mensaje** `energia()`.

- Concepto de _interfaz_: para que un objeto sea una comida, tiene que entender el mensaje `energia()` y devolver un número.

- Mencionar cómo se aprovecha el **polimorfismo**:
  - Ahora pepita puede comer kiwi, pero no tuvimos que tocar a pepita. Extendimos el programa agregando un nuevo _comportamiento_.
  - Los objetos contribuyen (intercambian mensajes) entre sí para producir distintos efectos: la energía aumenta distinta si se come la manzana o el alpiste.
  - Si conocen el `if`, no hay ninguno en nuestra solución.

---

## Ejercicios similares

<details>
<summary>Sobre gustos: https://github.com/wollok/objetosGustos</summary>
Cosas que le gustan a distintas personas.
</details>

<details>
<summary>Jugadores, personajes y elementos: https://github.com/wollok/juegoPersonajesElementos</summary>
Juego con personajes y elementos.
</details>

---

## Wollok Game

<details>
<summary>Titanic: https://github.com/wollok/TitanicGame</summary>
Intro a objetos contando la película de Titanic con Wollok Game.
  
#TODO armar un script para esta clase -> https://www.youtube.com/watch?v=KsagIzpa9Zs&list=PLD2HhVLe8swfrASREMvVy-DRuccfMUvFJ
</details>
