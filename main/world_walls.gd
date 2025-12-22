extends Node2D


func _on_left_wall_area_2d_area_entered(area: Area2D) -> void:
	GSignals.move_away_from_the_wall.emit(Vector2(32,0), true, area.get_parent().name)


func _on_top_wall_area_2d_area_entered(area: Area2D) -> void:
	GSignals.move_away_from_the_wall.emit(Vector2(0,32), true, area.get_parent().name)


func _on_right_wall_area_2d_area_entered(area: Area2D) -> void:
	GSignals.move_away_from_the_wall.emit(Vector2(-32,0), true, area.get_parent().name)


func _on_bottom_wall_area_2d_area_entered(area: Area2D) -> void:
	GSignals.move_away_from_the_wall.emit(Vector2(0,-32), true, area.get_parent().name)


func _on_left_wall_area_2d_area_exited(area: Area2D) -> void:
	GSignals.move_away_from_the_wall.emit(Vector2(-32,0), false, area.get_parent().name)


func _on_top_wall_area_2d_area_exited(area: Area2D) -> void:
	GSignals.move_away_from_the_wall.emit(Vector2(0,-32), false, area.get_parent().name)


func _on_right_wall_area_2d_area_exited(area: Area2D) -> void:
	GSignals.move_away_from_the_wall.emit(Vector2(32,0), false, area.get_parent().name)


func _on_bottom_wall_area_2d_area_exited(area: Area2D) -> void:
	GSignals.move_away_from_the_wall.emit(Vector2(0,32), false, area.get_parent().name)
