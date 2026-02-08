class_name Shield
extends Node2D

@onready var flash_timer: Timer = $Timer

@export var flash_time: float = .3
@export var damage_colour: Color = Color(1.0, 0.0, 0.0, 0.5)
@export var normal_colour: Color = Color(.038, 1, 1, .196)
@export var amount_of_damage_it_can_take: float = 100.0

const SCALE_DIVISOR: float = 100.0

var scale_start: Vector2 = Vector2(.01,.01)
var tween: Tween 
var time_to_scale: float = .25
var death_size: float = 15.0 	# When the shield is smaller than the turret 
								# and can't be seen any longer.
var health: float 

func _ready() -> void:
	health = amount_of_damage_it_can_take + death_size 
	create_shield()


func create_shield():
	#shield grows from nothing to full size
	kill_tween()
	tween = get_tree().create_tween()
	set_modulate(normal_colour)
	set_scale(scale_start)
	tween.tween_property(
		self,"scale",Vector2(health,health) / SCALE_DIVISOR,time_to_scale)


func _on_hitbox_component_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and health > 0:
		# flash from red to blue
		set_modulate(damage_colour)
		flash_timer.start(flash_time)
		health -= area.damage
		if health > death_size:
			kill_tween()
			tween = get_tree().create_tween()
			# shrink shield by damage
			tween.tween_property(self,"scale",Vector2(
				health, health)/SCALE_DIVISOR,time_to_scale)
		elif health <= death_size:
			shield_death()


func shield_death() -> void:
	flash_timer.stop()
	GSignals.shield_gone.emit()
	queue_free()


func kill_tween() -> void:
	if tween:
		tween.kill()


func _on_timer_timeout() -> void:
		set_modulate(normal_colour)
