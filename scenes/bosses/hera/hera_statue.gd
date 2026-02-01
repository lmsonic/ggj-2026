class_name HeraStatue extends Node2D
@export var hera_boss:HeraBoss
@onready var sprite: Sprite2D = $Sprite
@export var energized_color := Color.ORANGE
var energized:=false
func _ready() -> void:
	hera_boss.add_statue()
func energize() -> void:
	if not energized:
		sprite.modulate = energized_color
		hera_boss.remove_statue()
		energized = true
