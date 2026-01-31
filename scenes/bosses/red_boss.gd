extends Node2D
const RED_PROJECTILE = preload("res://scenes/bosses/red_projectile.tscn")

@onready var player: Player = get_tree().get_first_node_in_group("player")
