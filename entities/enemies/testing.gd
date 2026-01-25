extends EnemyClass
@onready var timer: Timer = %Timer
@onready var velocity_componenet: VelocityComponent = %VelocityComponent

var we_are_moving: bool = false
var target_position: Vector2 = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GSignals.test_move.connect(test_movement)


func _process(_delta: float) -> void:
	velocity_componenet.move(self)
	if we_are_moving:
		velocity_componenet.accelerate_to_velocity(target_position)
	else:
		velocity_componenet.decelerate()


func test_movement(new_pos: Vector2, papa: Node2D) -> void:
	if self == papa:
		timer.start(1)
		we_are_moving = true
		target_position = new_pos


func _on_timer_timeout() -> void:
	we_are_moving = false


func _on_left_area_2d_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
