extends Node2D

@onready var anim_player: AnimationPlayer = %AnimationPlayer

var charged: bool = false

func _ready() -> void:
	GSignals.beam.connect(shoot_beam)


func _shortcut_input(event: InputEvent) -> void:
	if event.is_action_pressed("super"):
		anim_player.play("charging")
	if event.is_action_released("super"):
		if charged:
			anim_player.play("beam")
			charged = false
		else:
			anim_player.play("RESET")


func shoot_beam(pos: Vector2, rot: float) -> void:
	global_position = pos
	global_rotation = rot


func we_are_charged():
	charged = true


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "charging":
		anim_player.stop()
		anim_player.play("charged")
