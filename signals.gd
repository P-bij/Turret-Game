extends Node

signal beam(pos: Vector2, rot: float)
signal begin_game_over
signal begin_the_wave(wave_name: String)
signal bullet_fired(
	rot: float, pos: Vector2, layer: int, mask: int, group: String)
signal crawling_enemy_plants_bomb(bomb_position: Vector2)
signal falling_enemy_spawn(position_to_drop_from: Vector2)
signal flip_enemy
signal health_update(new_health_value: float, body_name: String)
signal helicopter_dodge(new_position: Vector2, body: Node2D)
signal helicopter_shoot(t_or_f: bool, target)
signal helicopter_stop(body: Node2D)
signal impact(pos: Vector2, falling_enemy_name: String)
signal kill_me(body: Node2D)
signal max_health_update(new_max_health_value: float, body_name: String)
signal max_health_get
signal move_away_from_the_wall(
	amount_to_move: Vector2, true_or_false: bool, body_name: String)
signal queue_the_fireworks(pos: Vector2)
enum ShotType {NOTHING, FIRED, HIT, MISS}
signal score_adjustment(body_name: String, shot_type: ShotType)
signal score_update(new_score: int)
signal shield_gone
signal spawn_enemy(pos: Vector2, packed_enemy: PackedScene)
signal statistics_update(statistics: Stats)
signal swap_falling_for_crawling_enemy(crawling_enemy_name: String)
signal test_move(pos: Vector2, papa: Node2D)
