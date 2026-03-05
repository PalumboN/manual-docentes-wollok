object tamagotchi {
    var edad = 0
    var felicidad = 10

    var animo = null

    method jugar() {
        if (self.estaCansado()) { animo = "hambriento" }
        else if (self.estaHambriento()) { felicidad -= 2 }
        else { felicidad += 1 }
    }

    method comer() {
        if (self.estaHambriento()) { self.crecer() }
        else if (self.estaCansado()) { felicidad -= 1 }

        if (self.esViejo()) { animo = "cansado" }
    }

    method estaCansado() = animo == "cansado"
    method estaHambriento() = animo == "hambriento"

    method esViejo() = edad > 10

    method crecer() {
        edad += 1
        animo = null
    }
}