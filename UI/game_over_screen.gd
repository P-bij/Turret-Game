extends Control

@onready var label: Label = %Label

# if true, the game_over screen can't be closed by the menu button
var game_over: bool = false 
var label_text: String = "Menu"


func _ready() -> void:
	game_over = false
	change_label()
	Globals.begin_game_over.connect(game_end)
	var screen_size: Vector2 = get_viewport().get_visible_rect().size
	set_deferred("size", screen_size)


func change_label() -> void:
	if game_over:
		label_text = "GAME OVER"
		label.label_settings.font_color = Color.RED
	else:
		label_text = "Menu"
		label.label_settings.font_color = Color.ANTIQUE_WHITE
	label.text = label_text


func _shortcut_input(event: InputEvent) -> void:
	if event.is_action_pressed("menu") and !game_over:
		toggle_menu()


func game_end() -> void:
	game_over = true
	change_label()
	toggle_menu()


func toggle_menu() -> void:
	get_tree().paused = not get_tree().paused
	visible = !visible


func _on_start_again_button_pressed() -> void:
	Globals.reset.emit()
	game_over = false
	toggle_menu()
	change_label()
	Globals.begin_the_game.emit()


func _on_quit_button_pressed() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
