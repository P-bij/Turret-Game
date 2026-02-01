class_name HurtboxComponent
extends Area2D

@export var health:int = 1

@onready var papa:Node2D = get_parent()


func _on_area_entered(hitbox: HitboxComponent) -> void:
	if hitbox != null:
		health -= hitbox.damage
		if health <= 0:
			GSignals.kill_me.emit(papa.name)
