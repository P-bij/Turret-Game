class_name EnemyClass
extends CharacterBody2D

@export var speed: float = 50.0


func _ready() -> void:
	GSignals.kill_me.connect(_on_death)


func _on_death(body_name: String) -> void:
	if body_name == name:
		GSignals.queue_the_fireworks.emit(global_position)
		queue_free()
