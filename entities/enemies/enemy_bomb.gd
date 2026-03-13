extends Node2D

var bomb_death: bool = false


func _ready() -> void:
	Globals.kill_me.connect(death_to_the_bomb)


func death_to_the_bomb(body_name: String) -> void:
	if body_name == name:
		bomb_death = true
		explode()


func explode() -> void:
	Globals.queue_the_fireworks.emit(global_position)
	if bomb_death:
		queue_free()
	else:
		await get_tree().create_timer(.5).timeout
		queue_free()
