extends Area2D

enum Owners {PLAYER, ENEMY}

var bullet_layer: int = 0
var bullet_mask: int = 0
var bullet_velocity: Vector2
var my_direction: Vector2
var bullet_speed : float = 500.0
var piercing: bool = false


func _ready() -> void:
	set_collision_mask(bullet_mask)
	set_collision_layer(bullet_layer)


func _process(delta: float) -> void:
	my_direction = -transform.y
	bullet_velocity = my_direction * bullet_speed
	position += bullet_velocity * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_entered(_area: Area2D) -> void:
	if !piercing:
		queue_free()
