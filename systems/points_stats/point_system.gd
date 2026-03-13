class_name PointSystem
extends Node

@export var miss_multiplier: int = 3
@export var hit_multiplier: int = 10

var shots_fired: int = 0
var shots_hit: int = 0
var shots_missed: int = 0
var currentShotType: Globals.ShotType = Globals.ShotType.NOTHING

func _ready() -> void:
	Globals.score_adjustment.connect(shots_total)
	Globals.reset.connect(reset_score_and_stats)


func reset_score_and_stats() -> void:
	shots_fired = 0
	shots_hit = 0
	shots_missed = 0
	currentShotType = Globals.ShotType.NOTHING
	shots_total("Turret", currentShotType)


func shots_total(body_name: String, shot_type: Globals.ShotType) -> void:
	if body_name == "Turret":
		currentShotType = shot_type
		match currentShotType:
			Globals.ShotType.FIRED:
				shots_fired += 1
			Globals.ShotType.HIT:
				shots_hit += 1
			Globals.ShotType.MISS:
				shots_missed += 1
			_:
				pass
		Globals.score_update.emit(point_calculation())
		Globals.statistics_update.emit(statistics_calculation())


func point_calculation() -> int:
	var points: int  = (
		(shots_hit*hit_multiplier) -
		(shots_missed*miss_multiplier))
	return points


func statistics_calculation() -> Stats:
	if shots_fired:
		var miss_percentage: int = roundi(
			(float(shots_missed) / float(shots_fired)) * 100)
		var hit_percentage: int = roundi(
			(float(shots_hit) / float(shots_fired)) * 100)
		return Stats.new(shots_fired, miss_percentage, hit_percentage)
	else:
		return Stats.new(0, 0, 0)
