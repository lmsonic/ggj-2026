extends Node2D
const WRATH_PROJECTILE = preload("res://scenes/bosses/wrath/wrath_projectile.tscn")
@export var path_positions:Node2D
@export var throw_time:= 1.0
@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var throw_timer: Timer = $ThrowTimer
@onready var projectiles: Node2D = $Projectiles
func _ready() -> void:
	throw_timer.timeout.connect(throw)
	throw_timer.start(throw_time)

func throw()->void:
	var pos := player.global_position
	var dir := global_position.direction_to(pos)
	var proj :WrathProjectile = WRATH_PROJECTILE.instantiate()
	var vel := dir * proj.projectile_speed
	proj.global_position = global_position
	proj.linear_velocity = vel
	proj.can_respawn=true
	proj.projectiles = projectiles
	projectiles.add_child(proj)
	

func disable() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		call_deferred("disable")
		GameManager.play_cutscene("wrath")
		queue_free()
		
func _on_change_position_timer_timeout() -> void:
	var node :Node2D= path_positions.get_children().pick_random()
	var pos := node.global_position
	var tween := create_tween()
	tween.tween_property(self,"global_position",pos,0.5)
