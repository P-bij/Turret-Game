extends EnemyClass

@onready var vel_comp: VelocityComponent = $VelocityComponent
@onready var bomb_marker: Marker2D = $BombMarker2D

func _ready() -> void:
	super()


func _process(_delta: float) -> void:
	var my_direction: Vector2 = transform.x
	var my_velocity: Vector2 = my_direction * speed
	vel_comp.velocity = my_velocity
	vel_comp.move(self)


func turret_reached() -> void:
	Globals.crawling_enemy_plants_bomb.emit(bomb_marker.global_position)
	speed = 0
	await get_tree().create_timer(1.5).timeout
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		turret_reached()


func _on_detection_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Shield"):
		turret_reached()
