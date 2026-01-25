extends Control


func _ready() -> void:
	GSignals.begin_game_over.connect(game_over)
	var screen_size: Vector2 = get_viewport().size
	size = screen_size


func game_over() -> void:
	visible = true
