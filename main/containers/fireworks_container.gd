extends Node2D

@onready var fireworks_scene: PackedScene = preload("res://assets/effects/explosion.tscn")


func _ready() -> void:
	GSignals.queue_the_fireworks.connect(fireworks_ignite)


func fireworks_ignite(pos: Vector2) -> void:
	var fireworks: Node2D = fireworks_scene.instantiate()
	fireworks.global_position = pos
	add_child(fireworks)
