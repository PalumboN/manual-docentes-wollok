# Arrancamos...

Luego de instalar Wollok, y antes de explicar cualquier concepto, presentamos un ejercicio básico.
Nuestro favorito (e insignia de Wollok) es Pepita...

### Objetivos de esta clase

- Introducir los conceptos de _objetos_ y _referencias_
- Tener una imagen visual del programa por medio del _diagrama dinámico_
- Mandar _mensajes_ que se diferencian entre _acciones_ y _consultas_
- Introducir un objeto _polimórfico_

## Hola Pepita

> TODO: Buscar un repo con el ejercicio inicial: `vola(kms)` y `come(comida)`

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

Decimos que acá, **un programa está compuesto por objetos que se conocen por medio de referencias**.

TOCONTINUE...
