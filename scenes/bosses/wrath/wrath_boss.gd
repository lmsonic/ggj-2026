extends Node2D
const WRATH_PROJECTILE = preload("res://scenes/bosses/wrath/wrath_projectile.tscn")

@export var throw_time:= 1.0
@export var projectile_speed := 400.0
@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var throw_timer: Timer = $ThrowTimer
func _ready() -> void:
	throw_timer.timeout.connect(throw)
	throw_timer.start(throw_time)
	
func throw()->void:
	var pos := player.global_position
	var dir := global_position.direction_to(pos)
	var proj :RigidBody2D = WRATH_PROJECTILE.instantiate()
	var vel := dir * projectile_speed
	proj.global_position = global_position
	proj.linear_velocity = vel
	get_tree().root.add_child(proj)
	pass
