extends StaticBody2D

@export var rectangle: Rect2 = Rect2(0,0,1226,244)

func _ready() -> void:
	queue_redraw()


func _draw() -> void:
	draw_rect(rectangle,Color.PEACH_PUFF)
