extends EnemyClass

@onready var vel_comp: VelocityComponent = $VelocityComponent


func _ready() -> void:
	super()



func _process(_delta: float) -> void:
	var my_direction: Vector2 = transform.x
	var my_velocity: Vector2 = my_direction * speed
	vel_comp.velocity = my_velocity
	vel_comp.move(self)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		speed = 0
