# Arrancamos...

Luego de instalar Wollok, y antes de explicar cualquier concepto, presentamos un ejercicio básico.
Nuestro favorito (e insignia de Wollok) es Pepita...

### Objetivos de esta clase

- Introducir los conceptos de _objetos_ y _referencias_
- Tener una imagen visual del programa por medio del _diagrama dinámico_
- Mandar _mensajes_ que se diferencian entre _acciones_ y _consultas_
- Introducir un objeto _polimórfico_

## Hola Pepita

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


### Objetos y Referencias

- Definición de programa en objetos:
  - "Un _programa Wollok_ está compuesto por _objetos_ que se conocen por medio de _referencias_".

- Explicación de _diagrama dinámico_:
  - Los objetos son círculos y las referencias son flechas que apuntan siempre a uno de los círculos.
  - El diagrama muestra los objetos vivos con sus _atributos_: referencias que el objeto conoce.
  - Las flechas tienen un nombre.

- Explicación del ejemplo:
  - pepita conoce al 100 por medio de la referencia `energia`.
  - El alpiste conoce al 70 a través de la referencia `granos`.
  - Los números también son objetos (que vienen con el lenguaje), por eso son círculos.
  - Existen referencias variables: que cambian el objeto al que apuntan a través del tiempo. O **constantes 🔒**: que siempre apuntan al mismo objeto.

- Algunas preguntas para hacer:
  - ¿La manzana conoce al alpiste?
  - ¿El alpiste conoce a alguien como su `energia`?
  - ¿Pepita conoce al 70?


### Envío de mensajes

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


### Métodos de acción _vs_ de consulta

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



