extends Node2D

@onready var missile_scene: PackedScene = preload("res://entities/enemies/missile.tscn")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		spawn_missile(event.position)


func spawn_missile(pos: Vector2) -> void:
	var spawn_x: int
	var turret: Node2D = get_tree().get_first_node_in_group("Player")
	if turret:
		var turret_position = turret.global_position
		if pos.x <= turret_position.x:
			spawn_x = 0
		else:
			spawn_x = 1152
		GSignals.spawn_enemy.emit(Vector2(spawn_x, pos.y), missile_scene)
	
