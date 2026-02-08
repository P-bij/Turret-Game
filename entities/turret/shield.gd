class_name Shield
extends Node2D

@onready var flash_timer: Timer = $Timer

@export var flash_time_seconds: float = .3
@export var damage_intake: float = 100
@export var damage_colour: Color = Color(1.0, 0.0, 0.0, 0.5)
@export var normal_colour: Color = Color(.038, 1, 1, .196)

var scale_start: float = .1
var target_scale_size: Vector2 = Vector2(1,1)
var tween: Tween 
var time_to_scale: float = .25
var death_size: Vector2 = Vector2(.15,.15)


func _ready() -> void:
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	set_modulate(normal_colour)
	set_scale(Vector2(scale_start,scale_start))
	tween.tween_property(self,"scale",Vector2(1,1),time_to_scale)


func _on_hitbox_component_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and damage_intake > 0:
		set_modulate(damage_colour)
		flash_timer.start(flash_time_seconds)
		if damage_intake > area.damage:
			if tween:
				tween.kill()
			tween = get_tree().create_tween()
			var current_scale_size: Vector2 = Vector2(target_scale_size)
			damage_intake -= area.damage
			var scale_subtraction = abs(area.damage/100)
			target_scale_size = current_scale_size - Vector2(scale_subtraction, scale_subtraction)
			tween.tween_property(self,"scale",Vector2(target_scale_size),time_to_scale)
			await tween.finished
			if target_scale_size <= death_size:
				GSignals.shield_gone.emit()
				queue_free()


func _on_timer_timeout() -> void:
		set_modulate(normal_colour)
