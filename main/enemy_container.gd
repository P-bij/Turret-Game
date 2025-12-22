extends Node2D

@onready var plane_scene := preload("res://entities/enemies/enemy_plane.tscn")
@onready var helicopter_scene := preload("res://entities/enemies/enemy_helicopter.tscn")
@onready var explosion_scene := preload("res://assets/effects/explosion.tscn")
@onready var spawners := %EnemyMarkers
@onready var timer := %Timer

@export var spawn_speed : float = 5.0
@export var explosion_size : float = 2.0


func _ready() -> void:
	GSignals.queue_the_fireworks.connect(on_death)


func spawn_enemy() -> void:
	timer.start(spawn_speed)
	var spawner :Array = spawners.get_children()
	var rand_spawner : int = randi() % (spawner.size()-1)
	var rand_enemy : int = randi() & 1
	var enemy: Node2D
	if rand_enemy == 0:
		enemy = helicopter_scene.instantiate()
	else:
		enemy = plane_scene.instantiate()
	enemy.global_position = spawner[rand_spawner].global_position
	add_child(enemy)
	if rand_spawner >= 5:
		#enemy.speed = enemy.speed * -1
		enemy.scale.x = enemy.scale.x * -1


func _on_timer_timeout() -> void:
	spawn_enemy()


func on_death(pos: Vector2) -> void:
	var explosion = explosion_scene.instantiate()
	add_child(explosion)
	explosion.position = pos
	explosion.scale = explosion.scale * explosion_size
	
