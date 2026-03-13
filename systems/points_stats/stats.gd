class_name Stats
extends RefCounted

var shots_fired: int
var miss_percentage: int
var hit_percentage: int

func _init(shots: int, misses: int, hits: int) -> void:
	shots_fired = shots
	miss_percentage = misses
	hit_percentage = hits
