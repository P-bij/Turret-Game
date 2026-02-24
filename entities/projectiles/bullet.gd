extends Area2D

@export var hitbox: HitboxComponent 

enum Owners {PLAYER, ENEMY}

var bullet_layer: int = 0
var bullet_mask: int = 0
var bullet_velocity: Vector2
var my_direction: Vector2
var bullet_speed : float = 500.0
var piercing: bool = false
var hit_something: bool = false


func _ready() -> void:
	set_collision_mask(bullet_mask)
	set_collision_layer(bullet_layer)

	hitbox.set_mask(bullet_mask)
	hitbox.set_layer(bullet_layer)


func _process(delta: float) -> void:
	my_direction = -transform.y
	bullet_velocity = my_direction * bullet_speed
	position += bullet_velocity * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if hit_something:
		its_a_hit(true)
	else:
		its_a_hit(false)
	queue_free()


func its_a_hit(hit_or_miss: bool) -> void:
	if is_in_group("PlayerBullet"):
		if hit_or_miss:
			GSignals.score_adjustment.emit(
				"Turret", GSignals.ShotType.HIT)
		else:
			GSignals.score_adjustment.emit(
				"Turret", GSignals.ShotType.MISS)


func _on_area_entered(_area: Area2D) -> void:
	if !piercing:
		its_a_hit(true)
		queue_free()
	else:
		its_a_hit(true)
		hit_something = true
