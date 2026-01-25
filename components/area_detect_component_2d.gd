extends Area2D

var player: StaticBody2D = null
var papa: Node2D
var world_center: Vector2 = Vector2(576, 208)
var on_the_right: bool = false


func _ready() -> void:
	papa = get_parent()
	
	var player_groups: Array = get_tree().get_nodes_in_group("Player")
	if player_groups:
		player = player_groups[0]


func _on_area_entered(area: Area2D) -> void:
	if player:
		var new_velocity: Vector2
		var rot_deg: int = 90
		if on_the_right:
			rot_deg = rot_deg * -1
		new_velocity = area.bullet_velocity.rotated(deg_to_rad(rot_deg))
		GSignals.test_move.emit(new_velocity, papa)


func _on_left_area_2d_area_entered(area: Area2D) -> void:
	on_the_right = false


func _on_right_area_2d_area_entered(area: Area2D) -> void:
	on_the_right = true
