class_name HealthComponent extends Node

@export var max_health := 3
@onready var health := max_health

signal dead

func damage(value: int) -> void:
	health -= value
	prints("current health",health)
	if health <= 0:
		die()

func die() -> void:
	dead.emit()
