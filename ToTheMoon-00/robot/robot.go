package robot

import (
	"fmt"
	"math"
	"time"

	"github.com/Ingsoft1/ToTheMoon-00/mecha"
	"github.com/Ingsoft1/ToTheMoon-00/pinza"
	"github.com/Ingsoft1/ToTheMoon-00/suelo"
	"github.com/Ingsoft1/ToTheMoon-00/types"
)

// Robot ...
type Robot struct {
	Mecha mecha.Mecha
	Pinza pinza.Pinza
}

// CrearRobot ...
func CrearRobot() Robot {
	return Robot{
		Mecha: mecha.CrearMecha(),
	}
}

// DeterminarTipoDesuelo Determina un tipo de suelo segun sus porcentajes de dureza y porosidad
func (robot *Robot) DeterminarTipoDesuelo(dureza int64, porosidad int64) suelo.Suelo {
	tipoDeSuelo := suelo.Suelos[0]
	for _, sueloActual := range suelo.Suelos {
		diferenciaDureza := math.Abs(float64(sueloActual.Dureza - dureza))
		diferenciaPorosidad := math.Abs(float64(sueloActual.Porosidad - porosidad))

		if diferenciaDureza+diferenciaPorosidad < math.Abs(float64(tipoDeSuelo.Dureza-dureza))+math.Abs(float64(tipoDeSuelo.Porosidad-porosidad)) {
			tipoDeSuelo = sueloActual
		}
	}
	fmt.Printf("Suelo obtenido:%s\n", tipoDeSuelo.Nombre)
	return tipoDeSuelo
}

//Excavar Excava un tipo de suelo dado
func (robot *Robot) Excavar(su suelo.Suelo) {
	var sentido types.Sentido
	var velocidad types.Velocidad
	var duration time.Duration

	switch su {
	case suelo.SueloPiedra:
		sentido = types.SENTIDO_HORARIO
		velocidad = 150
		duration = time.Minute * 10
		break
	case suelo.SueloPolvo:
		sentido = types.SENTIDO_ANTI_HORARIO
		velocidad = 100
		duration = time.Minute * 5
		break
	}

	fmt.Printf("Obteniendo una muestra del %s...\n", su.Nombre)
	robot.abrirPinza()
	robot.girarMecha(sentido, velocidad, duration)
	robot.cerrarPinza()
	robot.girarMecha(!sentido, velocidad, duration)
	robot.abrirPinza()
	fmt.Printf("Muestra obtenida del %s\n", su.Nombre)
}

func (robot *Robot) girarMecha(sentido types.Sentido, velocidad types.Velocidad, duracion time.Duration) {
	sentidoString := "anti-horario"
	if sentido {
		sentidoString = "horario"
	}

	fmt.Printf("Girando mecha en sentido %s a una velocidad de %d rpm durante %s\n", sentidoString, velocidad, duracion.String())
	robot.Mecha.Sentido = sentido
	robot.Mecha.Velocidad = velocidad
	time.Sleep(duracion)
	robot.Mecha.Velocidad = 0
	fmt.Println("Mecha apagada")
}

func (robot *Robot) cerrarPinza() {
	robot.Pinza.Abierta = false
	fmt.Println("Pinza cerrada")
}

func (robot *Robot) abrirPinza() {
	robot.Pinza.Abierta = true
	fmt.Println("Pinza abierta")
}
