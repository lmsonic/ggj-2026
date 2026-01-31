class_name MovementComponent extends Node
@export var player: Player

@export var speed := 100.0

func move(input: Vector2) -> void:
	player.velocity = input * speed
	player.move_and_slide()
