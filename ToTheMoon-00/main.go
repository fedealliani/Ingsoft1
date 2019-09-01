package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"

	"github.com/Ingsoft1/ToTheMoon-00/robot"
)

func preguntarDatosSuelo() (int64, int64) {
	reader := bufio.NewReader(os.Stdin)

	fmt.Println("Inserte el porcentaje dureza de suelo:")
	line, _, _ := reader.ReadLine()
	lineString := string(line)
	dureza, _ := strconv.ParseInt(lineString, 10, 64)
	fmt.Println("Inserte el porcentaje de porosidad de suelo:")
	line, _, _ = reader.ReadLine()
	lineString = string(line)
	porosidad, _ := strconv.ParseInt(lineString, 10, 64)

	return dureza, porosidad
}

func main() {
	robot := robot.CrearRobot()
	sueloObtenido := robot.DeterminarTipoDesuelo(preguntarDatosSuelo())
	robot.Excavar(sueloObtenido)
}
