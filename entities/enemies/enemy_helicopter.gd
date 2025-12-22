extends EnemyClass

# States the helicopter can be in
enum States {HOMING_IN, SHOOTING, DODGING, MOVE_AWAY_FROM_WALL, IDLE}

@export var min_distance_to_player: float = 200.0
@export var max_distance_to_player: float = 400.0
@export var min_distance_from_bullet: float = 50.0
@export var max_distance_from_bullet: float = 100.0
@export var fire_rate: float = 2.0

@onready var vel_comp :VelocityComponent = %VelocityComponent
@onready var bullet_scene: = preload("res://entities/projectiles/bullet.tscn")
@onready var cannon: Node2D = %Cannon
@onready var reload_timer: Timer = %ReloadTimer
@onready var movement_timer: Timer = %MovementTimer

const ROT_FIX:float = deg_to_rad(90)
const BULLET_CAPACITY = 10

var state: States = States.HOMING_IN
var direction_to_target: Vector2
var desired_distance: float 
var player: StaticBody2D 
var target: Vector2
var distance_to_target: float 
var shots_fired: int = 0
var reload_time: float = 1.5
var showtime: bool = false
var total_amount_to_move_from_wall: Vector2 = Vector2(0,0)
var screen_origin = Vector2(0,0)
var screen_limit = Vector2(1152-32,648-32)
var off_screen = false
var min_dodge_time: float = .3
var max_dodge_time: float = 0.6


func _ready() -> void:
	super._ready()
	GSignals.helicopter_dodge.connect(begin_bullet_dodge)
	GSignals.helicopter_stop.connect(stop_the_helicopter)
	GSignals.move_away_from_the_wall.connect(wall_avoidance)
	if get_tree().get_nodes_in_group("Player").is_empty():
		player = null
	else:
		player = get_tree().get_first_node_in_group("Player")
	state_machine(States.HOMING_IN)


func _process(_delta: float) -> void:
	#if showtime:
		#position = position.clamp(Vector2(32,32), Vector2(1152-32,648-32))
	vel_comp.move(self)
	if player == null:
		state = States.IDLE
	match state:
		States.HOMING_IN:
			move_towards_target(States.SHOOTING)
		States.SHOOTING:
			vel_comp.decelerate()
		States.DODGING:
			start_dodging()
		States.MOVE_AWAY_FROM_WALL:
			vel_comp.accelerate_to_velocity(total_amount_to_move_from_wall)
		_:
			vel_comp.decelerate()


func state_machine(new_state) -> void:
	state = new_state
	match state:
		States.HOMING_IN:
			cannon.cannon_sprite.hide()
			target = player.global_position
			movement_calculations(min_distance_to_player, max_distance_to_player)
		States.SHOOTING:
			cannon.cannon_sprite.show()
			var shoot_cooldown :float = 1.0 / fire_rate
			reload_timer.start(shoot_cooldown)
			# Exit conditions handled by signals:
			# - helicopter_dodge (player shoots) -> DODGING
			# - helicopter_stop (player dies) -> IDLE
		States.DODGING:
			cannon.cannon_sprite.hide()
			movement_calculations(min_distance_from_bullet,max_distance_from_bullet)
		States.MOVE_AWAY_FROM_WALL:
			pass
		_:
			cannon.cannon_sprite.hide()
			if distance_to_target:
				if distance_to_target <= desired_distance:
					state_machine(States.SHOOTING)


func start_dodging() -> void:
	var rand_time: float = randf_range(min_dodge_time,max_dodge_time)
	movement_timer.start(rand_time)
	vel_comp.accelerate_to_velocity(direction_to_target)


func move_towards_target(new_state) -> void:
	distance_to_target = global_position.distance_to(target)
	# Either Move towards the turret or stop and shoot
	if distance_to_target > desired_distance:
		vel_comp.accelerate_to_velocity(direction_to_target)
	else:
		state_machine(new_state)


func movement_calculations(min_distance, max_distance) -> void:
	direction_to_target = global_position.direction_to(target)
	desired_distance = randf_range(min_distance, max_distance)


func begin_bullet_dodge(new_target: Vector2, papa: Node2D) -> void:
	if self == papa:
		movement_timer.stop()
		target = new_target
		#direction_to_move = global_position.direction_to(target)
		state_machine(States.DODGING)


func we_dodgin() -> void:
	vel_comp.decelerate()


func we_shootin() -> void:
	if shots_fired < BULLET_CAPACITY:
		shots_fired += 1
		GSignals.bullet_fired.emit(
			cannon.global_rotation + ROT_FIX, 
			cannon.bullet_marker.global_position,
			1, 32, "EnemyBullet")
		state_machine(States.SHOOTING)
	else:
		reload_timer.start(reload_time)
		shots_fired = 0


func stop_the_helicopter(body: Node2D) -> void:
	if self == body:
		state_machine(States.IDLE)


func start_the_helicopter(body: Node2D) -> void:
	if self == body:
		state_machine(States.HOMING_IN)


func wall_avoidance(
	amount_to_move: Vector2, true_or_false: bool, area_name: String) -> void:
	if area_name == name:
		off_screen = true_or_false
		total_amount_to_move_from_wall += amount_to_move 
		if off_screen:
			state_machine(States.MOVE_AWAY_FROM_WALL)
		else:
			state_machine(States.HOMING_IN)


func _on_reload_timer_timeout() -> void:
	we_shootin()


func _on_movement_timer_timeout() -> void:
	we_dodgin()
