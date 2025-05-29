extends StaticBody2D

@export_enum("CIRCULO", "TRIANGULO", "CUADRADO") var forma: int = 0

func get_forma() -> int:
	return forma
