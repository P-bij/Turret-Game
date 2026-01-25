@icon("res://assets/images/plane.png")
extends EnemyClass

@onready var paratrooper_timer: Timer = %ParatrooperTimer
@onready var paratrooper_scene: PackedScene = preload("res://entities/enemies/falling_enemy.tscn")

var paratropper_min_drop_rate: float = 3.0
var paratropper_max_drop_rate: float = 10.0


func _ready() -> void:
	super()
	var paratropper_drop_rate: float = randf_range(
		paratropper_min_drop_rate, paratropper_max_drop_rate
	)
	paratrooper_timer.start(paratropper_drop_rate)


func _process(delta: float) -> void:
	position += transform.x * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_paratrooper_timer_timeout() -> void:
	var paratropper_drop_rate: float = randf_range(
		paratropper_min_drop_rate, paratropper_max_drop_rate
	)
	paratrooper_timer.start(paratropper_drop_rate)
	GSignals.spawn_enemy.emit(global_position, paratrooper_scene)
