class_name HealthComponent
extends Node2D

@export var max_health: float = 1.0

@onready var papa: String = get_parent().name

var health: float = 1.0: set = set_health, get = get_health


func _ready() -> void:
	send_health_stats()
	Globals.max_health_get.connect(send_health_stats)


func send_health_stats() -> void:
	set_max_health(max_health)
	set_health(max_health)


func set_health(value: float) -> void:
	health = value
	check_if_dead()
	Globals.health_update.emit(health, papa)


func get_health() -> float:
	return health


func check_if_dead() -> void:
	var we_dead: bool = health <= 0
	if we_dead:
		Globals.kill_me.emit(papa)


func set_max_health(value: float) -> void:
	max_health = value
	Globals.max_health_update.emit(value, papa)
	
