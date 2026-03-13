extends Node2D

@export var chest: DroppableItem


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("powerup"):
		var pos: Vector2 = get_global_mouse_position()
		add_scene(pos, chest.item_icon,chest.item_signal,chest.flavour_text)



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
