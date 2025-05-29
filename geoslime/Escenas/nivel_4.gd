extends Area2D

func _ready():
	# Asegurarte de que reciba eventos del mouse
	input_pickable = true

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		get_tree().change_scene_to_file("res://Escenas/Nivel4.tscn")
