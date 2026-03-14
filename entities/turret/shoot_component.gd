class_name ShootComponent
extends Node2D

@export var fire_rate: float = 3.0
@export var subtract_rotation_to_fix: float = deg_to_rad(90)

@onready var cannon: Node2D = %Cannon
@onready var bullet_marker: Marker2D = cannon.bullet_marker
@onready var shoot_timer: Timer = %ShootTimer

const PLAYER_DAMAGE: int = 64
const ENEMY: int = 2
const DROPPED_ITEMS: int = 8
const ENEMY_AND_DROPPED_ITEMS: int = (ENEMY + DROPPED_ITEMS)

var shooting: bool = false


func _process(_delta: float) -> void:
	if Input.is_action_pressed("shoot") and shoot_timer.is_stopped():
		shoot()
	if Input.is_action_just_released("shoot"):
		shooting = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("super") and !shooting:
		Globals.beam.emit(
			bullet_marker.global_position, 
			bullet_marker.global_rotation)


func shoot() -> void:
	shooting = true
	var shoot_cooldown: float = 1 / fire_rate
	Globals.bullet_fired.emit(
		bullet_marker.global_rotation + subtract_rotation_to_fix, 
		bullet_marker.global_position,
		PLAYER_DAMAGE, ENEMY_AND_DROPPED_ITEMS, "PlayerBullet")
	Globals.score_adjustment.emit(get_parent().name, Globals.ShotType.FIRED)
	shoot_timer.start(shoot_cooldown)
