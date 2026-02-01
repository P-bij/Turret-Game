class_name SimpleMovement
extends Node2D

@export var speed: float = 2.0
@export var minRot: float = deg_to_rad(180)
@export var maxRot: float = deg_to_rad(360)

@onready var cannon: Node2D = %Cannon

var we_can_move: bool = true


func _process(delta: float) -> void:
	var direction: int = 0
	if we_can_move:
		if Input.is_action_pressed("left"):
			direction = -1
		elif Input.is_action_pressed("right"):
			direction = 1
	
	cannon.rotation += direction * speed * delta
	cannon.rotation = clampf(cannon.rotation, minRot, maxRot)
