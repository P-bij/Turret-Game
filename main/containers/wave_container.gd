extends Node2D

@export var wave_interval: float = 15.0

@onready var wave_timer: Timer = %WaveTimer

var wave1: String = "Wave1Planes"
var wave2: String = "Wave2Helicopters"
var wave3: String = "Wave3Missiles"


#func _ready() -> void:
	#GSignals.begin_the_wave.emit(wave2)
	#wave_timer.start(wave_interval)
#
#
#func _on_wave_timer_timeout() -> void:
	#GSignals.begin_the_wave.emit(wave1)


func _shortcut_input(event: InputEvent) -> void:
	if event.is_action_pressed("wave1"):
		GSignals.begin_the_wave.emit(wave1)
	if event.is_action_pressed("wave2"):
		GSignals.begin_the_wave.emit(wave2)
	if event.is_action_pressed("wave3"):
		GSignals.begin_the_wave.emit(wave3)
