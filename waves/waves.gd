class_name Waves
extends Node2D

@export var batch_interval: float = 3.0
@export var packed_enemy: PackedScene

@onready var batch_timer: Timer = $BatchTimer
@onready var batches: Node2D = $Batches

var current_batch_count: int
var all_batches: Array[Node] = []


func _ready() -> void:
	all_batches = batches.get_children()
	GSignals.begin_the_wave.connect(begin_wave)


func begin_wave(wave_name: String) -> void:
	if wave_name == name:
		current_batch_count = 0
		spawn_current_batch()


func spawn_current_batch() -> void:
	if current_batch_count >= all_batches.size():
		return
	
	var current_batch: Node = all_batches[current_batch_count]
	for marker in current_batch.get_children():
		if marker is Marker2D:
			GSignals.spawn_enemy.emit(marker.global_position, packed_enemy)
	
	current_batch_count += 1
	
	if current_batch_count < all_batches.size():
		batch_timer.start(batch_interval)


func _on_batch_timer_timeout() -> void:
	spawn_current_batch()
