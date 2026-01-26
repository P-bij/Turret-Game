extends EnemyClass

var arc_height: float # position of mouse's y-axis when clicked
var start_pos: Vector2 # (0, arc_height)
var end_pos: Vector2 # turret position
var t: float = 0.0 # (speed * delta) / total distance
var total_distance: float

func _ready() -> void:
	super()
	start_pos = global_position
	arc_height = start_pos.y
	var turret: Node2D = get_tree().get_first_node_in_group("Player")
	end_pos = turret.global_position
	total_distance = start_pos.distance_to(end_pos)


func _process(delta: float) -> void:
	# to use in formula which rotates the angle of missile 
	# so that it looks at where it's going
	var old_pos = global_position
	
	arc_movement(delta)
	
	# Point towards direction of movement
	var direction = old_pos.direction_to(global_position)
	rotation = direction.angle()


func arc_movement(delta: float) -> void:
	t += (speed * delta) / total_distance
	
	if t >= 1.0:
		# Turret is hit
		GSignals.queue_the_fireworks.emit(global_position)
		queue_free()
		return
	
	# Straight line from spawn to target
	var linear_pos: Vector2 = start_pos.lerp(end_pos, t)
	
	# Arc that peaks at start (t = 0) and falls to zero at end (t=1)
	var arc_offset: float = 4* arc_height * t * (1 - t)
	
	# Position with downard curve
	global_position = linear_pos + Vector2(0, -arc_offset)
