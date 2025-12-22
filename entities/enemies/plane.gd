extends Area2D

@export var speed = 75
@onready var plane_sprite = $Sprite2D

func _process(delta: float) -> void:
	position += transform.x * speed * delta	

func _on_area_entered(_area: Area2D) -> void:
	GSignals.explode_enemy.emit(position)
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
