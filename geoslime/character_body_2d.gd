extends CharacterBody2D

@export var speed := 100.0
@export var jump_velocity := -350.0
@export var gravity := 600.0  # ← Gravedad ajustable

var direction := 1  # 1 = derecha, -1 = izquierda
var current_form := "circulo"
var is_changing_form := false
var wall_contact := false

@onready var sprite := $AnimatedSprite2D
@onready var detector := $Detector

func _ready():
	sprite.play(current_form)
	sprite.flip_h = direction < 0
	if detector:
		detector.body_entered.connect(_on_detector_body_entered)
	else:
		push_error("El nodo 'Detector' no está correctamente asignado.")

func _physics_process(delta):
	# Aplicar gravedad
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0  # Reiniciar al tocar el suelo

	handle_movement()
	handle_jump_and_form()
	move_and_slide()

func handle_movement():
	velocity.x = speed * direction

	# Cambiar dirección SOLO cuando empieza a tocar una pared (no constantemente)
	if is_on_wall():
		if not wall_contact:
			direction *= -1
			sprite.flip_h = direction < 0
			wall_contact = true
	else:
		wall_contact = false

func handle_jump_and_form():
	if is_changing_form:
		return

	# Solo permitir salto/cambio de forma si está en el suelo
	if not is_on_floor():
		return

	if Input.is_action_just_pressed("ui_left"):
		if current_form != "triangulo":
			jump_and_change_form("triangulo")
		else:
			jump_only()

	elif Input.is_action_just_pressed("ui_up"):
		if current_form != "circulo":
			jump_and_change_form("circulo")
		else:
			jump_only()

	elif Input.is_action_just_pressed("ui_right"):
		if current_form != "cuadrado":
			jump_and_change_form("cuadrado")
		else:
			jump_only()

func jump_and_change_form(new_form):
	is_changing_form = true
	velocity.y = jump_velocity
	await get_tree().create_timer(0.1).timeout
	current_form = new_form
	sprite.play(current_form)
	is_changing_form = false

func jump_only():
	velocity.y = jump_velocity

func _on_detector_body_entered(body):
	if not body.has_method("get_forma"):
		return

	var forma_plataforma = body.get_forma()
	var forma_slime = form_to_int(current_form)

	var colisiones = detector.get_overlapping_bodies()
	if body in colisiones and forma_plataforma != forma_slime:
		die()

func die():
	print("¡Slime ha muerto!")
	get_tree().reload_current_scene()

func form_to_int(form: String) -> int:
	match form:
		"circulo": return 0
		"triangulo": return 1
		"cuadrado": return 2
		_: return -1
