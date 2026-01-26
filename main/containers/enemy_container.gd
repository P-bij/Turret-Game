extends Node2D


func _ready() -> void:
	GSignals.spawn_enemy.connect(enemy_spawn)


func enemy_spawn(pos: Vector2, enemy_scene: PackedScene) -> void:
	var enemy: Node2D = enemy_scene.instantiate()
	enemy.global_position = pos
	add_child(enemy)
