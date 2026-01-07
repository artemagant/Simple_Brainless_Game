extends Camera2D

var drag: bool
@export var acceleration:= 0.4

# idk wthitt, but I trust the guide guy 
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event. button_index == 1:
		drag = event. pressed
	if event is InputEventMouseMotion:
		if drag:
			position -= event. relative * acceleration
