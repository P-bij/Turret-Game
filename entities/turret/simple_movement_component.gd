class_name SimpleMovement
extends Node2D

@export var speed: float = 2.0
@export var minRot: float = deg_to_rad(180)
@export var maxRot: float = deg_to_rad(360)

@onready var cannon: Node2D = %Cannon

var we_can_move: bool = true


func _process(delta: float) -> void:
	movement(delta)


func movement(delta: float) -> void:
	var direction: float = 0.0
	if we_can_move:
		direction = calculate_mouse_position()
	cannon.rotation += direction * speed * delta
	cannon.rotation = clampf(cannon.rotation, minRot, maxRot)


func calculate_mouse_position() -> float:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var mouse_pos: Vector2 = get_global_mouse_position()
		var target_angle: float = (mouse_pos - cannon.global_position).angle()
		var difference: float = angle_difference(
			cannon.global_rotation, target_angle)
		return signf(difference)
	return 0.0


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("super"):
		we_can_move = false
	if event.is_action_released("super"):
		we_can_move = true
