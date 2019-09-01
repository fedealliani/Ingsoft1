package mecha

import "github.com/Ingsoft1/ToTheMoon-00/types"

type Mecha struct {
	Sentido   types.Sentido
	Velocidad types.Velocidad
}

func CrearMecha() Mecha {
	return Mecha{
		Velocidad: 0,
	}
}
