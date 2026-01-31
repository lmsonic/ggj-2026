class_name DamagingComponent extends Node

@export var damage_value := 1

func damage(health_component: HealthComponent) -> void:
	health_component.damage(damage_value)
