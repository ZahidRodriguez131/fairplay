extends Node2D

@export var enemie: PackedScene  # Exportar la escena del enemigo
var current_enemy: Node2D = null  # Referencia al enemigo actual

func _ready():
	spawn_enemy()  # Generar el primer enemigo al inicio

func spawn_enemy():
	if enemie:
		current_enemy = enemie.instantiate()  # Crear instancia del enemigo
		current_enemy.global_position = global_position  # Colocarlo en el generador
		add_child(current_enemy)  # Agregarlo como hijo del generador
		current_enemy.connect("tree_exited", Callable(self, "_on_enemy_removed"))  # Detectar su eliminación
	else:
		print("Error: No se asignó una escena de Enemigo")

func _on_enemy_removed():
	await get_tree().process_frame  # Espera 1 frame para asegurarse de que el nodo se eliminó
	spawn_enemy()  # Generar un nuevo enemigo
