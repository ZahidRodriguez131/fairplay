extends Area2D

@export var SPEED: int = 500  # Velocidad de la bala

# Función que se llama cuando el nodo entra en la escena
func _ready():
	$AnimatedSprite2D.play("disparo")  # Reproducir la animación de disparo

# Función que se llama cada frame
func _process(delta):
	# Mover la bala a la derecha o izquierda según la velocidad y el tiempo transcurrido
	global_position.x += SPEED * delta

# Función que se llama cuando el nodo sale de la pantalla
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()  # Eliminar la bala de la escena

# Función para eliminar enemigos
func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.is_in_group("enemie"):
		body.queue_free()
		queue_free()
