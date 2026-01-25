extends Node2D

@onready var impact_scene: PackedScene = preload("res://assets/effects/impact_dust.tscn")


func _ready() -> void:
	GSignals.impact.connect(impact_erupt)


func impact_erupt(pos: Vector2, enemy_name: String) -> void:
	var impact: ImpactDust = impact_scene.instantiate()
	impact.global_position = pos
	impact.enemy_name = enemy_name
	add_child(impact)
