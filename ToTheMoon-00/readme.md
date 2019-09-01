En nuestra solución utilizamos el lenguaje GO y modelamos al robot y los suelos con structs. 

El robot conoce el estado de su mecha (velocidad y sentido a girar) y el estado de su pinza (abierta/cerrada) y provee metodos para poder determinar el tipo de suelo en base al porcentaje de dureza y porosidad, tambien provee un metodo para excavar un suelo dado y por ultimo contiene metodos internos para el manejo de la mecha y pinza.

Un tipo de suelo esta modelado por su nombre, su porcentaje de porosidad y su porcentaje de dureza.

Asumimos que el usuario del programa conoce el porcentaje de porosidad y dureza del suelo donde se encuentra el robot.

Flujo del programa (ejecutar con go run main.go):
Se solicita al usuario por línea de comandos que ingrese la dureza y la porosidad del suelo (valores del 0 al 100).
El robot luego determina el tipo de suelo según los parámetros ingresados, y procede a realizar la excavación del mismo.
Para que la excavación se realice correctamente, el robot setea la velocidad, sentido de giro y duración de la mecha según el tipo de suelo determinado, y luego realiza las siguientes acciones en este orden:
1. Abrir pinza
2. Girar mecha (segun sentido, velocidad y duracion determinada)
3. Cerrar pinza
4. Girar mecha (sentido inverso, velocidad y duration determianda)
5. Abrir pinza

Además, para que el usuario obtenga feedback del proceso (y no parezca que el robot no está haciendo nada), el sistema imprime en consola cada acción del robot.