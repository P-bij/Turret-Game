extends Node2D

@onready var shield_scene: PackedScene = preload(
	"res://entities/turret/shield.tscn")

var shield_on: bool = false
var turret_pos: Vector2 = Vector2.ZERO


func _ready() -> void:
	GSignals.shield_gone.connect(shield_off)


func _shortcut_input(event: InputEvent) -> void:
	if event.is_action_pressed("shield") and !shield_on:
		if turret_pos == Vector2.ZERO:
			turret_pos = get_tree().get_first_node_in_group("Player").global_position
		create_shield(turret_pos)
		shield_on = true


func create_shield(pos: Vector2) -> void:
	var shield: Shield = shield_scene.instantiate()
	shield.global_position = pos
	add_child(shield)


func shield_off() -> void:
	shield_on = false
