extends HBoxContainer

@onready var healthbar_scene: PackedScene = preload("res://UI/health_bar.tscn")

const CONTAINER_CAPACITY: int = 100

var health: float = 0.0
var current_bars: int = 0
var amount_of_bars: int = 1


func _ready() -> void:
	Globals.max_health_update.connect(bars_update)
	Globals.health_update.connect(update_health_bar)
	Globals.max_health_get.emit()


func update_health_bar(new_value: float, body: String) -> void:
	if body == "Turret":
		var containers: Array[Node] = get_children()
		@warning_ignore("narrowing_conversion") # This is on purpose, to round down.
		var full_containers: int = new_value/CONTAINER_CAPACITY
		var remaining_health: float = new_value - (
			full_containers*CONTAINER_CAPACITY)
		for i: int in containers.size():
			if containers[i] is ProgressBar:
				var container: ProgressBar = containers[i]
				if i <= full_containers-1:
					container.value = CONTAINER_CAPACITY
				else:
					# First using the remaining health on the first 
					# non-full container
					container.value = remaining_health
					# Then each subsequent container's value should be zero
					remaining_health = 0 # 


func bars_update(value: float, body_name: String) -> void:
	if body_name == "Turret":
		var new_bar_total = ceil(value/CONTAINER_CAPACITY)
		var bars_to_add: int = new_bar_total - current_bars
		if bars_to_add > current_bars:
			for i: int in bars_to_add:
				create_new_healthbar()
		if bars_to_add == current_bars:
			print("No change")
			pass
		if bars_to_add < current_bars:
			for i: int in abs(bars_to_add):
				delete_healthbar()
		current_bars = new_bar_total


func delete_healthbar() -> void:
	var healthbars: Array[Node] = get_children()
	for i: int in healthbars.size():
		if healthbars[i] is ProgressBar:
			healthbars[i].queue_free()


func create_new_healthbar() -> void:
	var healthbar = healthbar_scene.instantiate()
	add_child(healthbar)
