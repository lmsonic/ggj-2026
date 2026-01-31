extends Node2D

@export var damage := 1
@export var delay := 0.2
@export var lighting_time := 1.5
@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var lighting_timer: Timer = $LightingTimer
const YELLOW_LIGHTING = preload("res://scenes/yellow_lighting.tscn")


func _ready() -> void:
	lighting_timer.timeout.connect(cast_lighting)
	start_casting()
	
func start_casting() -> void:
	lighting_timer.start(lighting_time)

func _process(_delta: float) -> void:
	cast_shadow()

func cast_shadow() -> void:
	var num := lighting_time - lighting_timer.time_left 
	var t := num/lighting_time
	var color := Color.WHITE.darkened(t)
	player.modulate = color

	
func cast_lighting() -> void:
	var pos := player.global_position
	await get_tree().create_timer(delay).timeout
	var lighting: DamageArea = YELLOW_LIGHTING.instantiate()
	lighting.global_position = pos
	get_tree().root.add_child(lighting)
	lighting.spawn()
	lighting_timer.start(lighting_time)
