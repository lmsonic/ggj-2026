class_name WillowBoss extends Node2D

@export var random_respawns: Node2D
@export var required_n_finds:=4
var found:=0
@onready var area: Area2D = $Area2D

func _ready() -> void:
	random_respawns.hide()
	random_respawns.process_mode = Node.PROCESS_MODE_DISABLED

func respawn_random() -> void:
	print(found)
	found +=1
	if found > required_n_finds:
		GameManager.play_cutscene("willow")
		return
	for c:WillowHiddenTile in random_respawns.get_children():
		c.willow_present = false
	var tile: WillowHiddenTile = random_respawns.get_children().pick_random()
	tile.willow_present = true
	print(tile.name)

func on_player_entered(body: Node2D) -> void:
	var player := body as Player
	if player != null:
		area.set_deferred("monitoring",false)
		random_respawns.show()
		random_respawns.process_mode = Node.PROCESS_MODE_INHERIT
		respawn_random()
		hide()
