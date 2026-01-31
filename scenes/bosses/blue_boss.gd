extends Node2D

@export var random_respawn_parent: Node2D
@onready var respawn_time := 2.0
@onready var respawn_timer: Timer = $RespawnTimer
@onready var area: Area2D = $Area2D

func _ready() -> void:
	respawn_timer.timeout.connect(
		func() -> void:
			set_enabled(true)
	)


func respawn_random() -> void:
	var node: Node2D = random_respawn_parent.get_children().pick_random()
	var pos := node.global_position
	global_position = pos
	
func set_enabled(value: bool) -> void:
	visible = value
	area.set_deferred("monitoring", value)
	area.set_collision_mask_value(1, value)
	

func on_player_entered(body: Node2D) -> void:
	var player := body as Player
	if player != null:
		set_enabled(false)
		respawn_random()
		respawn_timer.start(respawn_time)
