extends Node

signal bullet_fired(
	rot : float, pos : Vector2, layer:int, mask:int, group: String)
signal flip_enemy
signal kill_the_enemy(body: Node2D)
signal queue_the_fireworks(pos: Vector2)
signal helicopter_dodge(new_position: Vector2, body: Node2D)
signal helicopter_shoot(t_or_f: bool, target)
signal helicopter_stop(body: Node2D)
signal move_away_from_the_wall(
	amount_to_move: Vector2, true_or_false: bool, body_name: String)
