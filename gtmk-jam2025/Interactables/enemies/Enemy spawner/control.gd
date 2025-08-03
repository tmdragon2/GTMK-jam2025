extends Control

var parent: Node

func _ready():
	parent = get_parent()

func _draw():
	var region_rect: Rect2
	region_rect.position = parent.pointA
	region_rect.end = parent.pointB
	
	draw_rect(region_rect, Color.RED,false,1.0 )
	draw_circle(parent.pointA, 5.0, Color.RED, true)
	draw_circle(parent.pointB, 5.0, Color.RED, true)
	draw_string(ThemeDB.fallback_font, parent.pointA + Vector2(10,20), "point 1", HORIZONTAL_ALIGNMENT_LEFT, -1, ThemeDB.fallback_font_size)
	draw_string(ThemeDB.fallback_font, parent.pointB - Vector2(60,15), "point 2", HORIZONTAL_ALIGNMENT_LEFT, -1, ThemeDB.fallback_font_size)

func _process(_delta):
	queue_redraw()
