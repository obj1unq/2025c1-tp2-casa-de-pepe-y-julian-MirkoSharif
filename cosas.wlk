object electrodomestico {
	
}

object mueble {
	
}

object comida {
	
}

object heladera {
	method precio() = 20000
	
	method categoria() = electrodomestico
}

object cama {
	method precio() = 8000
	
	method categoria() = mueble
}

object tiraDeAsado {
	method precio() = 350
	
	method categoria() = comida
}

object paqueteDeFideos {
	method precio() = 50
	
	method categoria() = comida
}

object plancha {
	method precio() = 1200
	
	method categoria() = electrodomestico
}

object casa {
	var property compras = []
	var property cuenta = cuentaCorriente 
	
	method cuenta(_cuenta) {
		cuenta = _cuenta
	}
	
	method comprar(cosa) {
		cuenta.extraer(cosa.precio())
		compras.add(cosa)
	}
	
	method cantidadDeCosasCompradas() = compras.size()
	
	method tieneAlgun(categoria) = compras.any(
		{ cosa => cosa.categoria() == categoria }
	)
	
	method vieneDeComprar(
		categoria
	) = (!compras.isEmpty()) && (compras.last().categoria() == categoria)
	
	method esDerrochona() = compras.sum({ cosa => cosa.precio() }) >= 9000
	
	method compraMasCara() = compras.max({ cosa => cosa.precio() })
	
	method comprados(categoria) = compras.filter(
		{ cosa => cosa.categoria() == categoria }
	).asSet()
	
	method malaEpoca() = compras.all({ cosa => cosa.categoria() == "comida" })
	
	method queFaltaComprar(lista) = lista.filter(
		{ cosa => !compras.contains(cosa) }
	)
	
	method faltaComida() = self.comprados("comida").size() < 2
	
	method categoriasCompradas() = compras.map(
		{ cosa => cosa.categoria() }
	).asSet()
}

object cuentaCorriente {
	var property saldo = 0
	
	method saldo() = saldo
	
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
	
	method saldo() = saldo

	method costoOperacion(_costoOperacion) {
		costoOperacion = _costoOperacion
	}
	
	method depositar(suma) {
		self.validarSumaADepositar(suma)
		saldo += (suma - costoOperacion)
	}

	method validarSumaADepositar(suma) {
		if (suma > 1000) {
			self.error("El deposito excede su limite")
		}
	}
	
	method extraer(suma) {
	    saldo -= suma
	}
}