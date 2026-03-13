class_name PowerupCard
extends Button

@export var powerup: PowerUp
@export var speed: float = .10
@export var shake_position_amount: float = 10.0
@export var shake_rotation_amount: float = .005
@export var pu_choice_time: float = 3.0
@export var shake_time: float = .1

@onready var pu_choice_timer: Timer = %PUChoiseTimer
@onready var pu_text: Label = %PowerupLabel
@onready var pu_icon: TextureRect = %PowerupTextureRect
@onready var shake_timer: Timer = %ShakeTimer
@onready var card_root: HBoxContainer = %CardRoot

var style_box: StyleBoxFlat = StyleBoxFlat.new()
var choosing: bool = false
var focused: bool = false
var red: float = .006
var green: float = .048
var blue: float = .074
var shake_left: bool = false


func _ready() -> void:
	pu_icon.texture = powerup.pu_icon
	pu_text.text = powerup.pu_description
	style_box.bg_color = Color(red, green, blue)
	style_box.set_corner_radius_all(10)
	add_theme_stylebox_override("pressed", style_box) 


func _process(delta: float) -> void:
	if choosing and focused and !pu_choice_timer.is_stopped():
		decrease_color_to_white(delta)


func reset() -> void:
	red = .006
	green = .048
	blue = .074
	style_box.bg_color = Color(red, green, blue)
	pu_choice_timer.stop()
	shake_timer.stop()
	card_root.position.x = 0
	card_root.rotation = 0
	card_root.scale = Vector2(1.0,1.0)


func decrease_color_to_white(delta: float) -> void:
	red += delta*speed
	red = clampf(red,.006,1.0)
	green += delta*speed
	green = clampf(green, .048, 1.0)
	blue += delta*speed
	blue = clampf(blue,.074, 1.0)
	style_box.bg_color = Color(red, green, blue)
	card_root.scale += Vector2(.01,.01)


func shake() -> void:
	if shake_left:
		card_root.position.x += -shake_position_amount
		card_root.rotation = -shake_rotation_amount
		shake_left = false
	else:
		card_root.position.x += shake_position_amount
		card_root.rotation = shake_rotation_amount
		shake_left = true


func _on_button_down() -> void:
	pu_choice_timer.start(pu_choice_time)
	shake_timer.start(shake_time)
	choosing = true


func _on_button_up() -> void:
	reset()
	choosing = false


func _on_pu_choise_timer_timeout() -> void:
	Globals.powerup_picked.emit(powerup.pu_type)


func _on_mouse_entered() -> void:
	focused = true


func _on_mouse_exited() -> void:
	focused = false
	reset()


func _on_rotation_timer_timeout() -> void:
	shake()
