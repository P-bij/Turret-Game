class_name HurtboxComponent
extends Area2D

@export var health_componenet: HealthComponent


func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		health_componenet.health -= area.damage
