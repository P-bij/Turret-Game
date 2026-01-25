extends Area2D

@export var min_distance: float = 25
@export var max_distance: float = 50.0
@onready var papa: EnemyClass = get_parent()

var player: StaticBody2D = null
var bullet_position:Vector2
var helicopter_position: Vector2
var move_direction: bool = false
var on_the_right: bool = false


func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	helicopter_position = global_position


func _on_area_entered(area: Area2D) -> void:
	var area_groups: Array[StringName] = area.get_groups()
	if area_groups:
		var area_group: StringName = area_groups[0]
		match area_group:
			"PlayerBullet":
				bullet_detection(area)
			"Helicopter":
				helicopter_detection()
			"Plane":
				plane_detection()
			"FallingEnemy":
				falling_enemy_detection(area)


func falling_enemy_detection(area: Area2D):
	var new_velocity = area.get_parent().velocity
	perp_movement(new_velocity)
	


func plane_detection() -> void:
	var my_velocity = Vector2(0,1)
	GSignals.helicopter_dodge.emit(my_velocity, papa)

func helicopter_detection() -> void:
	var my_velocity = papa.velocity
	perp_movement(my_velocity)


func bullet_detection(area: Area2D) -> void:
	var bullet_velocity: Vector2 = area.bullet_velocity
	perp_movement(bullet_velocity)


func perp_movement(vel: Vector2) -> void:
	if player:
		var new_velocity: Vector2
		var rot_deg: int = 90
		if on_the_right:
			rot_deg = rot_deg * -1
		new_velocity = vel.rotated(deg_to_rad(rot_deg))
		GSignals.helicopter_dodge.emit(new_velocity, papa)
	else:
		GSignals.helicopter_stop.emit(papa)


func _on_area_exited(area: Area2D) -> void:
	var area_groups: Array[StringName] = area.get_groups()
	if area_groups:
		var area_group: StringName = area_groups[0]
		match area_group:
			"Enemy":
				papa.start_the_helicopter(papa)


func _on_left_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("PlayerBullet"):
		on_the_right = false


func _on_right_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("PlayerBullet"):
		on_the_right = true
