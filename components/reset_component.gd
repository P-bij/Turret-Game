@icon("res://assets/icons/reset-icon.png")
extends Node2D

@onready var papa: Node = get_parent()


func _ready() -> void:
	Globals.reset.connect(start_over_again)


func start_over_again() -> void:
	if papa:
		papa.queue_free()
