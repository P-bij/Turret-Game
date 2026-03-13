class_name DroppedItem
extends Area2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var timer: Timer = $Timer

var sprite_texture: Texture2D
var signal_name: String
var mod_alpha: float = 1
var flavour_text: String

func _ready() -> void:
	if sprite_texture:
		sprite.texture = sprite_texture


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("PlayerBullet") and signal_name:
		Globals[signal_name].emit()
		call_deferred("queue_free")


func _on_timer_timeout() -> void:
	mod_alpha = mod_alpha/2
	if mod_alpha <= .06:
		queue_free()
	set_modulate(Color(1,1,1,mod_alpha))
	#timer.start(.5)


func _on_mouse_entered() -> void:
	if flavour_text:
		Globals.flavour_text_show.emit(flavour_text)


func _on_mouse_exited() -> void:
	Globals.flavour_text_hide.emit()
