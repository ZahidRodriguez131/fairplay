extends Area2D
var duration = 3.0
var speed_boost = 200.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", _on_body_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Personaje":
		body.apply_PowerUp(speed_boost, duration)
		queue_free()
