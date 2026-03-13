extends Node

@export var drop_table: Array[DroppableItem]

var total_weight: float = 0.0


func _ready() -> void:
	Globals.upgrade_drop.connect(drop_upgrade)
	for item in drop_table:
		total_weight += item.weight


func drop_upgrade(position_of_drop: Vector2) -> void:
	var roll: float = randf_range(0, total_weight)
	for item in drop_table:
		roll -= item.weight
		if roll <= 0:
			if item.item_icon:
				add_scene(
					position_of_drop, 
					item.item_icon,
					item.item_signal,
					item.flavour_text)
			return
	printerr("All weights together equaled to more than zero.", "/n", name)
	return


func add_scene(
	pos: Vector2, 
	item_texture: Texture2D, 
	item_signal: String,
	item_description: String) -> void:
	var item_scene: PackedScene = preload(
		"res://systems/powerups/dropables/dropped_item.tscn")
	var added_item: DroppedItem = item_scene.instantiate()
	added_item.global_position = pos
	added_item.sprite_texture = item_texture
	added_item.signal_name = item_signal
	added_item.flavour_text = item_description
	call_deferred("add_child", added_item)
