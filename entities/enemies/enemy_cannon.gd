extends Cannon

var player: StaticBody2D


func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	cannon_sprite.hide()


func _process(_delta: float) -> void:
	if player:
		look_at(player.global_position)
