extends Label

@onready var timer: Timer = $Timer

@export var time_out_seconds: float = 3.0


func _ready() -> void:
	Globals.flavour_text_show.connect(display_flavour_text)
	Globals.flavour_text_hide.connect(hide_flavour_text)


func display_flavour_text(description: String) -> void:
	text = description
	global_position = get_global_mouse_position()
	global_position.x = clamp(global_position.x, 0, 1088)
	global_position.y = clamp(global_position.y, 0, 376)
	visible = true
	timer.start(time_out_seconds)


func hide_flavour_text() -> void:
	visible = false


func _on_timer_timeout() -> void:
	hide_flavour_text()
