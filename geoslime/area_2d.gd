extends Area2D
# Plataforma.gd
func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		get_tree().change_scene_to_file("res://Escenas/Nivel2.tscn")
