class_name Turret
extends Node2D


func _ready() -> void:
	GSignals.kill_me.connect(death_to_the_turret)


func death_to_the_turret(body_name: String) -> void:
	if body_name == name:
		GSignals.begin_game_over.emit()
		GSignals.queue_the_fireworks.emit(self.global_position)
		queue_free()
