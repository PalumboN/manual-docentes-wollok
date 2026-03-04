object tamagotchi {
    var edad = 0
    var felicidad = 0

    var estado = ""

    method jugar() {
        if (self.estaCansado()) { estado = "hambriento" }
        else if (self.estaHambriento()) { felicidad -= 2 }
        else { felicidad += 1 }
    }

    method comer() {
        if (self.estaHambriento()) { self.crecer() }
        else if (self.estaCansado()) { felicidad -= 1 }

        if (self.esViejo()) { estado = "cansado" }
    }

    method estaCansado() = estado == "cansado"
    method estaHambriento() = estado == "hambriento"
    

    method esViejo() = edad > 10

    method crecer() {
        edad += 1
        felicidad += 1
        estado = ""
    }
}