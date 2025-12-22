extends Area2D

var bullet_position:Vector2
var helicopter_position: Vector2
@export var min_distance: float = 25
@export var max_distance: float = 50.0
@onready var papa := get_parent()

func _on_area_entered(area: Area2D) -> void:
	helicopter_position = global_position
	var area_groups: Array[StringName] = area.get_groups()
	if area_groups:
		var area_group: StringName = area_groups[0]
		print(area_group)
		if area_group == "Plane":
			GSignals.helicopter_dodge.emit(aircraft_detection(area), papa)
		match papa.state:
			papa.States.HOMING_IN:
				match area_group:
					"PlayerBullet":
						GSignals.helicopter_dodge.emit(bullet_detection(area), papa)
					"Enemy":
						GSignals.helicopter_dodge.emit(aircraft_detection(area), papa)
			_:
				if area_group == "PlayerBullet":
						GSignals.helicopter_dodge.emit(bullet_detection(area), papa)


func aircraft_detection(area: Area2D) -> Vector2:
	var other_helicopter_position = area.global_position
	var direction_away = helicopter_position.direction_to(
		other_helicopter_position)
	return perp_movement(direction_away)


func bullet_detection(area: Area2D) -> Vector2:
	var direction = area.my_direction
	return perp_movement(direction)


func perp_movement(dir: Vector2) -> Vector2:
	var rand_direction :int = randi() % 2
	var perpendicular_direction: Vector2
	if rand_direction:
		perpendicular_direction = Vector2(
			dir.y * -1,
			dir.x
		)
	else:
		perpendicular_direction = Vector2(
			dir.y, dir.x * -1
		)
	var dodge_distance = randf_range(min_distance, max_distance)
	var new_position: Vector2 = helicopter_position + (
		perpendicular_direction * dodge_distance)
	return new_position


func _on_area_exited(area: Area2D) -> void:
	var area_groups: Array[StringName] = area.get_groups()
	if area_groups:
		var area_group: StringName = area_groups[0]
		match area_group:
			"Enemy":
				papa.start_the_helicopter(papa)
