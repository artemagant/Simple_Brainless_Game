extends Node2D

var level_root
var button_sfx
var colors = [
	Color(1.00, 0, 0),
	Color(0.81, 0, 0),
	Color(0.63, 0, 0),
	Color(0.45, 0, 0),
	Color(0.27, 0, 0),
	Color(0.09, 0, 0),
	Color(0, 0.27, 0),
	Color(0, 0.45, 0),
	Color(0, 0.63, 0),
	Color(0, 0.81, 0),
	Color(0, 1.00, 0),
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_root = get_parent().get_parent().get_parent()
	button_sfx = level_root.get_node("Button")
	AudioServer. set_bus_volume_db(0, Data.sfx_volum)
	if Data. sfx_volum > -5:
		AudioServer. set_bus_volume_db(0, Data.sfx_volum)
	else:
		AudioServer. set_bus_volume_db(0, -80)
	change_color()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_minus_pressed(sound= true) -> void:
	if sound:
		button_sfx.pitch_scale = randf_range(0.8, 1.2)
		button_sfx.play()
	if Data. sfx_volum > -5:
		Data. sfx_volum -= 1
		if Data. sfx_volum > -5:
			AudioServer. set_bus_volume_db(0, Data.sfx_volum)
		else:
			AudioServer. set_bus_volume_db(0, -80)
		Data. save_sfx()
		change_color()
func _on_plus_pressed(sound = true) -> void:
	if sound:
		button_sfx.pitch_scale = randf_range(0.8, 1.2)
		button_sfx.play()
	if Data. sfx_volum < 5:
		Data. sfx_volum += 1
		AudioServer. set_bus_volume_db(0, Data.sfx_volum)
		Data. save_sfx()
		change_color()
func change_color():
	$SFX.self_modulate = colors[Data. sfx_volum+5]
