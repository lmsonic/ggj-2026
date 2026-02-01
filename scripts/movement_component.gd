class_name MovementComponent extends Node
@export var player: Player
@export var accel := 1000.0
@export var decel := 2000.0
@export var max_speed := 350.0
@onready var speed := max_speed
@export var sprint_enabled := false
@export var sprint_multiplier := 1.8
@export var max_sprint_charge := 1.0
var sprint_charge := 1.0
var sprint_exhausted := false


func move(input: Vector2, delta: float, shift_pressed: bool = false) -> void:

	var is_sprinting := shift_pressed and not sprint_exhausted and sprint_enabled
	if is_sprinting:
		speed = max_speed * sprint_multiplier
		sprint_charge = maxf(sprint_charge - delta, 0.0)
		if sprint_charge <= 0.0:
			sprint_exhausted = true
	else:
		speed = max_speed
		sprint_charge = minf(sprint_charge + delta, max_sprint_charge)
		if sprint_charge >= max_sprint_charge:
			sprint_exhausted = false

		
	if input != Vector2.ZERO:
		player.velocity = player.velocity.move_toward(input * speed, accel * delta)
	else:
		player.velocity = player.velocity.move_toward(Vector2.ZERO, decel * delta)
	player.move_and_slide()
