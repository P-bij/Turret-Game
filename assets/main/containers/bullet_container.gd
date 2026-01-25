extends Node2D

const BULLET_SCENE: PackedScene = preload("res://entities/projectiles/bullet.tscn") 


func _ready() -> void:
	GSignals.bullet_fired.connect(create_bullet)


func create_bullet(
	rot : float, pos : Vector2, layer: int, mask: int, group: String) ->void:
	var bullet: Area2D = BULLET_SCENE.instantiate()
	bullet.global_position = pos
	bullet.global_rotation = rot
	bullet.bullet_layer = layer
	bullet.bullet_mask = mask
	bullet.add_to_group(group)
	add_child(bullet)
	
