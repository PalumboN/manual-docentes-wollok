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


- Definición de programa en objetos.
  > Un _programa Wollok_ está compuesto por _objetos_ que se conocen por medio de _referencias_.

- Explicación de _diagrama dinámico_.
  > Los objetos son círculos y las referencias son flechas que apuntan siempre a uno de los círculos.
  > El diagrama muestra los objetos vivos con sus _atributos_: referencias que el objeto conoce.
  > Las flechas tienen un nombre.

- Explicación del ejemplo.
  > pepita conoce al 100 por medio de la referencia`energia`.
  > el alpiste conoce al 70 a través de la referencia `granos`.
  > Los número

¡El 100, el 70, y todos los números, también son objetos! 
Al igual que _pepita_, _manzana_ y _alpiste_, declarados por nosotros.

Las referencias pueden ser **variables** (que cambian el objeto al que apuntan a través del tiempo), o **constantes** (que siempre apuntan al mismo objeto).
En el diagrama, las constantes aparecen con un candado 🔒, como en el caso de `granos`.

Para que una referencia cambie, hay que pedírselo al objeto que la posee (de dónde sale la flecha) **enviándole un mensaje**.


### Envío de mensajes

Decimos que: "Los objetos se conocen por medio de referencias y se mandan **mensajes** para comunicarse entre sí".

Y luego le envíamos un mensaje a pepita por la consola:
```bash
> pepita.estaCansada()
✓ false
```

> Una buena didáctica en este punto es preguntar: "¿qué piensan que está pasando?"
> Seguramente lo relacionen con el método de pepita: `method estaCansada() = energia < 50`
> Como la energía de pepita es 100, que NO es menor a 50, entonces es _falso_ que está cansada.

Luego de un poco de debate para romper el hielo, damos una definición de lo que está pasando: le estamos mandando el mensaje `estaCansada()` al objeto `pepita`. 

_Atención a la sintaxis_: siempre es _objeto_, seguido de punto `.`, y luego el mensaje _terminado en paréntesis_ para pasar parámetros (como veremos en un rato).

**Cuando un objeto recibe un _mensaje_, ejecuta el _método_ que tenga la misma _firma_** (en Wollok, que tenga el mismo nombre y cantidad de parámetros).

Es importante resaltar la diferencia entre **mensaje y método**: el mensaje se le envía a un objeto para que "pase algo", mientras el método es la definición de ese "algo que debe pasar".

Una buena forma de mostrar que NO son la misma cosa es enviando un mensaje que no se entienda:

```bash
> pepita.algoQueNoEntiende()
✗ Evaluation Error! pepita does not understand algoQueNoEntiende()
```

Acá el programa produce un **error**, ya que le estamos pidiendo a pepita algo que no entiende.


### Métodos de acción _vs_ de consulta

TOCONTINUE....
