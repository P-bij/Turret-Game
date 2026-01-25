class_name VelocityComponent
extends Node2D

@export var knockback_acceleration: float = 15.0
@export var acceleration: float = 10.0

@onready var max_speed: float = get_parent().speed

var velocity: Vector2 = Vector2.ZERO:
	set(value):
		velocity = value
	get():
		return velocity

## Accelerates the current velocity toward a new velocity, respecting the maximum speed.
## @param new_velocity The desired velocity to move toward.
func accelerate_to_velocity(new_velocity: Vector2) -> void:
	var target_velocity: Vector2 = new_velocity.normalized() * max_speed
	velocity = velocity.lerp(target_velocity, 1.0 - exp(-get_process_delta_time() * acceleration))


## Applies a knockback effect based on the positions of two Area2D nodes.
## @param target_body The first Area2D (target of knockback).
## @param source_body The second Area2D (source of knockback).
## @param strength The strength of the knockback effect.
func knockback(target_body: Area2D, source_body: Area2D, strength: float) -> void:
	var direction: Vector2 = target_body.global_position - source_body.global_position
	velocity = Vector2.ZERO
	var target_velocity: Vector2 = direction.normalized() * pow(strength, 2)
	velocity = velocity.lerp(target_velocity, 1.0 - exp(-get_process_delta_time()
	 * pow(knockback_acceleration, 2)))


## Gradually decelerates the object to a complete stop.
func decelerate() -> void:
	accelerate_to_velocity(Vector2.ZERO)


## Moves a CharacterBody2D according to the current velocity.
## @param body The CharacterBody2D to move.
func move(body: CharacterBody2D) -> void:
	body.velocity = velocity
	body.move_and_slide()
