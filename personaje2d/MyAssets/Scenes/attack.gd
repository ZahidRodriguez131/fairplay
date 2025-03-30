extends StaticBody2D
var velocidad : int

func _ready():
	$AnimatedSprite2D.is_playing()

func _process(delta: float):
	global_position.x += velocidad * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
