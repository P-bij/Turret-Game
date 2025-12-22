extends AnimatedSprite2D


func _ready() -> void:
	var rand : int = randi() % 7
	match rand:
		0: modulate = Color.RED
		1: modulate = Color.ORANGE
		2: modulate = Color.YELLOW
		3: modulate = Color.GREEN
		4: modulate = Color.BLUE
		5: modulate = Color.INDIGO
		6: modulate = Color.PURPLE


func _on_animation_finished() -> void:
	queue_free()
