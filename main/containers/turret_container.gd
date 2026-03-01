@icon("res://assets/images/turret.png")
extends Node2D

@onready var turret_scene: PackedScene = preload(
	"res://entities/turret/turret.tscn")

var turret: StaticBody2D
var turret_position: Vector2
var min_position: float = 64 # far left position
var max_position: float = 1088 # far right position
var ground_y_position: float = 416.0 # position of the top of the ground


func _ready() -> void:
	position_the_turret()
	GSignals.kill_me.connect(game_over_time)
	GSignals.begin_the_game.connect(position_the_turret)


func position_the_turret() -> void:
	await get_tree().process_frame
	if !turret:
		var rand_pos: float = randf_range(min_position, max_position)
		turret_position = Vector2(rand_pos, ground_y_position)
		turret = turret_scene.instantiate()
		turret.global_position = turret_position
		add_child(turret)


func game_over_time(dead_name: String) -> void:
	if turret:
		if dead_name == name:
			GSignals.queue_the_fireworks.emit(turret_position)
			turret_position = Vector2.ZERO
