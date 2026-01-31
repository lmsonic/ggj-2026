class_name ShakeCameraComponent extends Node

@export var camera: Camera2D

@export var decay := 0.8 # How quickly the shaking stops [0, 1].
@export var max_offset := Vector2(100, 75) # Maximum hor/ver shake in pixels.
@export var max_roll := 0.1 # Maximum rotation in radians (use sparingly).

var trauma := 0.0 # Current shake strength.
var trauma_power := 2 # Trauma exponent. Use [2, 3].

func add_trauma(amount: float) -> void:
	trauma = minf(trauma + amount, 1.0)


func _process(delta: float) -> void:
	if trauma > 0.0:
		trauma = max(trauma - decay * delta, 0.0)
		shake()

func shake() -> void:
	var amount := pow(trauma, trauma_power)
	camera.global_rotation = max_roll * amount * randf_range(-1.0, 1.0)
	camera.offset.x = max_offset.x * amount * randf_range(-1.0, 1.0)
	camera.offset.y = max_offset.y * amount * randf_range(-1.0, 1.0)
