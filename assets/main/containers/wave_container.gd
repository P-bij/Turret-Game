extends Node2D

@export var wave_interval: float = 15.0

@onready var wave_timer: Timer = %WaveTimer

var wave1: String = "Wave1Planes"
var wave2: String = "Wave2Helicopters"


func _ready() -> void:
	GSignals.begin_the_wave.emit(wave2)
	wave_timer.start(wave_interval)


func _on_wave_timer_timeout() -> void:
	GSignals.begin_the_wave.emit(wave1)
