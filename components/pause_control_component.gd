class_name PauseControlComponent
extends Node

@export var papa: Node

func pause(true_or_false: bool) -> void:
	papa.set_process_mode(Node.PROCESS_MODE_ALWAYS)
	papa.visible = true_or_false
	get_tree().paused = true_or_false
