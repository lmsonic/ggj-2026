extends Node2D
@onready var agent: NavigationAgent2D = $NavigationAgent2D

@onready var player :Player= get_tree().get_first_node_in_group("player")
@export var visibility_angle := 90.0
@export var movement_speed: float = 100.0
var movement_delta := 0.0
func is_visible_by_player() -> bool:
	var dir := player.global_position.direction_to(global_position)
	var facing_vector := player.facing_vector()
	var angle := absf(dir.angle_to(facing_vector))
	return angle <= deg_to_rad(visibility_angle)

func _ready() -> void:
	agent.velocity_computed.connect(on_velocity_computed)

func on_velocity_computed(safe_velocity:Vector2) -> void:
	global_position = global_position.move_toward(global_position + safe_velocity, movement_delta)


func _physics_process(delta: float) -> void:
	if not is_visible_by_player():
		agent.target_position = player.global_position
		update_navagent(delta)
	else:
		agent.avoidance_enabled = false


func update_navagent(delta:float) -> void:
	if NavigationServer2D.map_get_iteration_id(agent.get_navigation_map()) == 0:
		return
	if agent.is_navigation_finished():
		return
	movement_delta = movement_speed * delta
	var next_path_position: Vector2 = agent.get_next_path_position()
	var new_velocity: Vector2 = global_position.direction_to(next_path_position) * movement_delta
	if agent.avoidance_enabled:
		agent.set_velocity(new_velocity)
	else:
		on_velocity_computed(new_velocity)


	
