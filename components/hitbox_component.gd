class_name HitboxComponent
extends Area2D

@export var damage: float = 1.0 : set = set_damage, get = get_damage

var hitbox_layer: int = 1 : set = set_layer, get = get_layer
var hitbox_mask: int = 1 : set = set_mask, get = get_mask

func set_damage(value: float) -> void:
	damage = value


func get_damage() -> float:
	return damage

func set_layer(value: int) -> void:
	set_collision_layer(value)


func get_layer() -> int:
	return hitbox_layer


func set_mask(value: int) -> void:
	set_collision_mask(value)


func get_mask() -> int:
	return hitbox_mask
