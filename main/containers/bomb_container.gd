extends Node2D

@onready var bomb_scene: PackedScene = preload(
	"res://entities/enemies/enemy_bomb.tscn")

var turret: Vector2


func _ready() -> void:
	Globals.crawling_enemy_plants_bomb.connect(plant_the_bomb)
	var turret_group = get_tree().get_nodes_in_group("Player")
	if turret_group:
		turret = get_tree().get_first_node_in_group("Player").global_position


func _shortcut_input(event: InputEvent) -> void:
	if event.is_action_pressed("bomb"):
		plant_the_bomb(turret-Vector2(-100,0))


func plant_the_bomb(pos: Vector2) -> void:
	var bomb: Node2D = bomb_scene.instantiate()
	bomb.global_position = pos
	call_deferred("add_child", bomb)
