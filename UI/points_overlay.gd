extends Control

@onready var points_label: Label = %PointAmountLabel
@onready var hits_label: Label = %HitsPercentageLabel
@onready var misses_label: Label = %MissPercentageLabel
@onready var shots_label: Label = %ShotsLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.score_update.connect(score_print)
	Globals.statistics_update.connect(stats_print)


func score_print(points: int) -> void:
	points_label.text = str(points)


func stats_print(stats: Stats) -> void:
	hits_label.text = str(stats.hit_percentage, "%")
	misses_label.text = str(stats.miss_percentage, "%")
	shots_label.text = str(stats.shots_fired)
