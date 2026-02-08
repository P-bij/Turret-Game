class_name HurtboxComponent
extends Area2D

@export var health:float = 1

@onready var papa:Node2D = get_parent()


func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		health -= area.damage
		if health <= 0:
			GSignals.kill_me.emit(papa.name)
