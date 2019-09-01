package suelo

//Suelo ...
type Suelo struct {
	Nombre    string
	Dureza    int64
	Porosidad int64
}

var (
	SueloPiedra = Suelo{
		Nombre:    "Suelo de Piedra",
		Dureza:    100,
		Porosidad: 0,
	}

	SueloPolvo = Suelo{
		Nombre:    "Suelo de Polvo",
		Dureza:    0,
		Porosidad: 100,
	}

	SueloIntermedio = Suelo{
		Nombre:    "Suelo intermedio",
		Dureza:    50,
		Porosidad: 50,
	}

	Suelos = []Suelo{
		SueloPiedra,
		SueloPolvo,
		SueloIntermedio,
	}
)
