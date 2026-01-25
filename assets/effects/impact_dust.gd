class_name ImpactDust
extends Sprite2D

@onready var crawling_enemy_scene: PackedScene = preload(
	"res://entities/enemies/crawling_enemy.tscn")

var enemy_name: String


func swap_falling_with_crawling() -> void:
	GSignals.swap_falling_for_crawling_enemy.emit(enemy_name)
	GSignals.spawn_enemy.emit(global_position, crawling_enemy_scene)
