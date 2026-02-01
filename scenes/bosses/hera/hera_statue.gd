class_name HeraStatue extends Node2D
@export var hera_boss:HeraBoss
@export var energized_color := Color.ORANGE
@onready var head: Sprite2D = $Head
@onready var sound_component: SoundComponent = $SoundComponent

var energized:=false
@onready var energized_head: Sprite2D = $EnergizedHead
const STATUE_ACTIVATE = preload("res://assets/sfx/statueActivate.wav")

func _ready() -> void:
	hera_boss.add_statue()
	
func energize() -> void:
	if not energized:
		hera_boss.remove_statue()
		energized = true
		energized_head.show()
		head.hide()
		sound_component.play_sound(STATUE_ACTIVATE)
