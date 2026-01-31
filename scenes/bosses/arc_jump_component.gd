class_name ArcJumpComponent extends Node
@export var boss: LightGreenBoss 
@export var horizontal_speed := 500.0
@export var jump_speed := 500.0
@export var gravity := 50.0
var jump_end:= Vector2.ZERO
var vertical_speed := -1.0
var jump_distance := -1.0
var is_jumping := false

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
	jump_end = get_random_point_over_range(150.0)
	jump_distance = boss.global_position.distance_to(jump_end)
	vertical_speed = jump_speed
	is_jumping = true

func get_random_point_over_range(r: float, max_iters := 5) -> Vector2:
	var range2 := r * r
	var region_rid := boss.navigation_region.get_rid()
	var point := NavigationServer2D.region_get_random_point(region_rid, 1, true)
	var i := 0
	var max_distance := -1.0
	var max_point := Vector2.ZERO
	var distance := point.distance_squared_to(boss.global_position)
	while (distance <= range2):
		point = NavigationServer2D.region_get_random_point(region_rid, 1, true)
		distance = point.distance_squared_to(boss.global_position)
		
		if distance > max_distance:
			max_point = point
			max_distance = distance
		i += 1
		if i > max_iters && distance <= range2:
			return max_point
	return point
