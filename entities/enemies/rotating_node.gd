extends Node2D
var player: StaticBody2D = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player_group = get_tree().get_nodes_in_group("Player")
	if player_group:
		player = player_group[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player:
		look_at(Vector2(576, 416))
