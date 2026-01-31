class_name HealthComponent extends Node

@export var max_health := 3
@onready var health := max_health

signal dead
signal hit
func damage(value: int) -> void:
	health -= value
	prints(health)
	hit.emit()
	if health <= 0:
		die()

func die() -> void:
	dead.emit()
