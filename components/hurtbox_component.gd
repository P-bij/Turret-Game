extends Area2D

@export var health:int = 1
@onready var papa:CharacterBody2D = get_parent()


func _on_area_entered(area: Area2D) -> void:
	if  area.is_in_group("PlayerBullet"):
		health -= 1
		if health == 0:
			GSignals.kill_the_enemy.emit(papa)
