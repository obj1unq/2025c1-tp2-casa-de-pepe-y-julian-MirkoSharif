object electrodomestico {
	
}

object mueble {
	
}

object comida {
	
}

object heladera {
	method precio() = 20000
	
	method categoria() = electrodomestico

	method esDeCategoria(categoria) {
		self.categoria() == categoria
	}
}

object cama {
	method precio() = 8000
	
	method categoria() = mueble

	method esDeCategoria(categoria) {
		self.categoria() == categoria
	}
}

object tiraDeAsado {
	method precio() = 350
	
	method categoria() = comida

	method esDeCategoria(categoria) {
		self.categoria() == categoria
	}
}

object paqueteDeFideos {
	method precio() = 50
	
	method categoria() = comida

	method esDeCategoria(categoria) {
		self.categoria() == categoria
	}
}

object plancha {
	method precio() = 1200
	
	method categoria() = electrodomestico

	method esDeCategoria(categoria) {
		self.categoria() == categoria
	}
}

object casa {
	const compras = []
	var property cuenta = cuentaCorriente 
	
	method comprar(cosa) {
		cuenta.extraer(cosa.precio())
		compras.add(cosa)
	}
	
	method cantidadDeCosasCompradas() = compras.size()
	
	method tieneAlgun(categoria) = compras.any(
		{ cosa => cosa.esDeCategoria(categoria) }
	)
	
	method vieneDeComprar(categoria) = (!compras.isEmpty()) && (compras.last().esDeCategoria(categoria))
	
	method gastoTotal() = compras.sum({ cosa => cosa.precio() })

	method esDerrochona() = self.gastoTotal() >= 9000
	
	method compraMasCara() = compras.max({ cosa => cosa.precio() })
	
	method comprados(categoria) = compras.filter(
		{ cosa => cosa.esDeCategoria(categoria) }
	).asSet()

	method malaEpoca() = compras.all({ cosa => cosa.esDeCategoria(comida) })
	
	method queFaltaComprar(lista) = lista.filter(
		{ cosa => !compras.contains(cosa) }
	)
	
	method faltaComida() = self.comprados(comida).size() < 2
	
	method categoriasCompradas() = compras.map(
		{ cosa => cosa.categoria() }
	).asSet()
}

object cuentaCorriente {
	var property saldo = 0
	
	method depositar(suma) {
		saldo += suma
	}
	
	method validarExtraccion(suma) {
		if (suma > saldo) self.error("No se puede extraer esta suma")
	}
	
	method extraer(suma) {
		self.validarExtraccion(suma)
		saldo -= suma
	}
}

object cuentaConGastos {
	var property saldo = 0
	var property costoOperacion = 0
	
	method depositar(suma) {
		self.validarSumaADepositar(suma)
		saldo += (suma - costoOperacion)
	}

	method puedeDepositar(suma) = suma <= 1000

	method validarSumaADepositar(suma) {
		if (! self.puedeDepositar(suma)) {
			self.error("El deposito excede su limite")
		}
	}
	
	method extraer(suma) {
	    saldo -= suma
	}
}