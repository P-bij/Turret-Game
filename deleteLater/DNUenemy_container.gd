extends Node2D

@export var spawn_speed: float = 5.0
@export var explosion_size: float = 2.0

@onready var spawners: Node2D = %EnemyMarkers
@onready var timer: Timer = %Timer

const FALLING_ENEMY_SCENE: PackedScene = preload("res://entities/enemies/falling_enemy.tscn")
const CRAWLING_ENEMY_SCENE: PackedScene = preload("res://entities/enemies/crawling_enemy.tscn")
const PLANE_SCENE: PackedScene = preload("res://entities/enemies/enemy_plane.tscn")
const HELICOPTER_SCENE: PackedScene = preload("res://entities/enemies/enemy_helicopter.tscn")
const EXPLOSION_SCENE: PackedScene = preload("res://assets/effects/explosion.tscn")
const IMPACT_DUST_SCENE: PackedScene = preload("res://assets/effects/impact_dust.tscn")


func _ready() -> void:
	GSignals.queue_the_fireworks.connect(on_death)
	GSignals.falling_enemy_spawn.connect(spawn_falling_enemy)
	GSignals.swap_falling_for_crawling_enemy.connect(spawn_crawling_enemy)
	GSignals.impact.connect(enemy_landing)


func spawn_crawling_enemy(pos:Vector2, _enemy_name: String) -> void: 
	var crawling_enemy: CharacterBody2D = CRAWLING_ENEMY_SCENE.instantiate()
	crawling_enemy.global_position = pos
	add_child(crawling_enemy)


func enemy_landing(pos: Vector2, falling_enemy_name: String) -> void:
	var impact: Sprite2D = IMPACT_DUST_SCENE.instantiate()
	impact.global_position = pos
	impact.enemy_name = falling_enemy_name
	add_child(impact)


func spawn_falling_enemy(pos: Vector2) -> void:
	var falling_enemy: CharacterBody2D = FALLING_ENEMY_SCENE.instantiate()
	add_child(falling_enemy)
	falling_enemy.global_position = pos


func spawn_enemy() -> void:
	timer.start(spawn_speed)
	var spawner:Array = spawners.get_children()
	var rand_spawner: int = randi() % (spawner.size()-1)
	var rand_enemy: int = randi() % 10
	var enemy: Node2D
	if rand_enemy >= 5:
		enemy = HELICOPTER_SCENE.instantiate()
	else:
		enemy = PLANE_SCENE.instantiate()
	enemy.global_position = spawner[rand_spawner].global_position
	add_child(enemy)
	#if rand_spawner >= 5:
		#enemy.scale.x = enemy.scale.x * -1


func _on_timer_timeout() -> void:
	spawn_enemy()


func on_death(pos: Vector2) -> void:
	var explosion: AnimatedSprite2D = EXPLOSION_SCENE.instantiate()
	explosion.position = pos
	explosion.scale = explosion.scale * explosion_size
	add_child(explosion)
