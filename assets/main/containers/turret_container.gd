@icon("res://assets/images/turret.png")
extends Node2D

var position_of_my_child: Vector2 

func _ready() -> void:
	var my_child: StaticBody2D = get_child(0)
	position_of_my_child = my_child.global_position
	GSignals.kill_me.connect(game_over_time)


func game_over_time(dead_name: String) -> void:
	if dead_name == name:
		GSignals.queue_the_fireworks.emit(position_of_my_child)
