class_name ArcJumpComponent extends Node
@export var boss: LightGreenBoss 
@export var horizontal_speed := 500.0
@export var jump_speed := 500.0
@export var gravity := 50.0
var jump_end:= Vector2.ZERO
var vertical_speed := -1.0
var jump_distance := -1.0
var is_jumping := false
@onready var player :Player = get_tree().get_first_node_in_group("player")
func calculate_distance() -> float:
	var distance := boss.global_position.distance_to(jump_end)
	return distance

func calculate_velocity(delta:float) -> Vector2:
	var dir := boss.global_position.direction_to(jump_end)
	var perp := dir.rotated(-PI / 2.0)
	var velocity := horizontal_speed * dir + vertical_speed * perp
	vertical_speed -= gravity * delta
	return velocity

func jump() -> void:
	jump_end =  player.global_position
	jump_distance = boss.global_position.distance_to(jump_end)
	vertical_speed = jump_speed
	is_jumping = true
