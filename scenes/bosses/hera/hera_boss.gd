class_name HeraBoss extends Node2D
@onready var cloud: Node2D = $Cloud

var statues := 0

func add_statue()-> void:
	statues += 1
	print(statues)
func remove_statue()-> void:
	statues -= 1
	print(statues)
	if statues <= 0:
		cloud.queue_free()
