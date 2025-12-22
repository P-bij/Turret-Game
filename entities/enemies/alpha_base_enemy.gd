class_name EnemyClass
extends CharacterBody2D

@onready var sprite: Sprite2D = %Sprite2D
@export var speed: float = 50.0


func _ready() -> void:
	GSignals.kill_the_enemy.connect(_on_death)


func _on_death(body: CharacterBody2D) -> void:
	if body == self:
		GSignals.queue_the_fireworks.emit(global_position)
		queue_free()
