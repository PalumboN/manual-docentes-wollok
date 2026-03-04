object pepe { 
    var property categoria = cadete
    var property contrato = basico

    method sueldo() = self.sueldoBase() + contrato.remuneracion(self)

    method sueldoBase() = 1000 + categoria.extra()

}

object cadete { 
    method extra() = 500
}

object gerente { 
    method extra() = 1500
}


object basico {
    method remuneracion(empleado) = 1000
}
object porcentual {
    const porcentaje = 15
    // const empleado = pepe

    method remuneracion(empleado) = empleado.sueldoBase() * porcentaje / 100
}
object presentismo { 
    var property faltas = 0

    method remuneracion(empleado) = empleado.sueldoBase() - faltas * 100
}
