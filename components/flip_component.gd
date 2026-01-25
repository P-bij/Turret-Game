extends Node2D

@export var nodes_to_flip: Array[Node2D] = []
@export var continuous_flip: bool = true

var turret: Node2D
var turret_position: Vector2
var is_flipped: bool = false


func _ready() -> void:
	turret = get_tree().get_first_node_in_group("Player")
	if turret:
		turret_position = turret.global_position
		if !continuous_flip:
			check_and_flip()


func check_and_flip() -> void:
	var parent_position: Vector2 = get_parent().global_position
	var should_be_flipped: bool = parent_position.x > turret_position.x
	
	if should_be_flipped != is_flipped:
		flip_nodes()
		is_flipped = should_be_flipped


func flip_nodes() -> void:
	for node:Node2D in nodes_to_flip:
		if node:
			node.scale.x *= -1


func _on_right_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and turret and continuous_flip:
		check_and_flip()


func _on_left_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and turret and continuous_flip:
		check_and_flip()
