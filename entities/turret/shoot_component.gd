class_name ShootComponent
extends Node2D

@export var fire_rate: float = 3.0
@export var subtract_rotation_to_fix: float = deg_to_rad(90)

@onready var cannon: Node2D = %Cannon
@onready var bullet_marker: Marker2D = cannon.bullet_marker
@onready var shoot_timer: Timer = %ShootTimer


func _shortcut_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") and shoot_timer.is_stopped():
		shoot()


func shoot() -> void:
	var shoot_cooldown: float = 1 / fire_rate
	GSignals.bullet_fired.emit(
		bullet_marker.global_rotation + subtract_rotation_to_fix, 
		bullet_marker.global_position,
		64, 2, "PlayerBullet")
	shoot_timer.start(shoot_cooldown)
