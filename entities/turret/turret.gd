extends Node2D

@onready var cannon: Node2D = %Cannon
@onready var bullet_marker: Marker2D = cannon.bullet_marker
@onready var timer: Timer = $Timer

@export var speed: float = 2.0
@export var subtract_rotation_to_fix: float = deg_to_rad(90)
@export var minRot: float = deg_to_rad(180)
@export var maxRot: float = deg_to_rad(360)
@export var fire_rate: float = 3.0


func _ready() -> void:
	GSignals.kill_me.connect(death_to_the_turret)


func _process(delta: float) -> void:
	var direction: int = 0
	if Input.is_action_pressed("left"):
		direction = -1
	elif Input.is_action_pressed("right"):
		direction = 1
	
	cannon.rotation += direction * speed * delta
	cannon.rotation = clampf(cannon.rotation, minRot, maxRot)
	
	if Input.is_action_pressed("shoot") and timer.is_stopped():
		shoot()


func shoot() -> void:
	var shoot_cooldown: float = 1 / fire_rate
	GSignals.bullet_fired.emit(
		bullet_marker.global_rotation + subtract_rotation_to_fix, 
		bullet_marker.global_position,
		64, 2, "PlayerBullet")
	timer.start(shoot_cooldown)


func death_to_the_turret(body_name: String) -> void:
	if body_name == name:
		GSignals.begin_game_over.emit()
		GSignals.queue_the_fireworks.emit(self.global_position)
		queue_free()
