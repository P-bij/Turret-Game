extends EnemyClass

@onready var vel_comp: VelocityComponent = %VelocityComponent

const PARACHUTE_SPEED: int = 50
const DOWN: Vector2 = Vector2.DOWN

func _ready() -> void:
	super()
	GSignals.swap_falling_for_crawling_enemy.connect(kill_me)
	velocity = DOWN * speed
	vel_comp.velocity = velocity


func _process(_delta: float) -> void:
	vel_comp.move(self)


func kill_me(body_name:String) -> void:
	if body_name == self.name:
		queue_free()


func _on_falling_timer_timeout() -> void:
	speed = PARACHUTE_SPEED
	velocity = DOWN * speed
	vel_comp.velocity = velocity

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Ground"):
		vel_comp.decelerate()
		GSignals.impact.emit(global_position, name)
