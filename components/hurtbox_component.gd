extends Area2D

@export var health:int = 1
@export var bullet_group: String = "PlayerBullet"

@onready var papa:Node2D = get_parent()


func _on_area_entered(area: Area2D) -> void:
	if  area.is_in_group(bullet_group):
		health -= 1
		if health == 0:
			GSignals.kill_me.emit(papa.name)
