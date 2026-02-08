extends Node

signal beam(pos: Vector2, rot: float)
signal begin_game_over
signal begin_the_wave(wave_name: String)
signal bullet_fired(
	rot: float, pos: Vector2, layer: int, mask: int, group: String)
signal falling_enemy_spawn(position_to_drop_from: Vector2)
signal flip_enemy
signal helicopter_dodge(new_position: Vector2, body: Node2D)
signal helicopter_shoot(t_or_f: bool, target)
signal helicopter_stop(body: Node2D)
signal impact(pos: Vector2, falling_enemy_name: String)
signal kill_me(body: Node2D)
signal move_away_from_the_wall(
	amount_to_move: Vector2, true_or_false: bool, body_name: String)
signal queue_the_fireworks(pos: Vector2)
signal shield_gone
signal spawn_enemy(pos: Vector2, packed_enemy: PackedScene)
signal swap_falling_for_crawling_enemy(crawling_enemy_name: String)
signal test_move(pos: Vector2, papa: Node2D)
