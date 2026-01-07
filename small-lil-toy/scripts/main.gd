extends Node2D

@onready var fade = $Fade
var current_level = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Data. enemys = -1
	Data. load_game()
	current_level = get_node("level_root")
	fade.visible = true
	load_level(1)
	await _fade(0.0)

func _process(_delta: float) -> void:
	if Data. player_health <= 0:
		Data. player_health = 1
		Data. speed_variation = 0
		await _fade(1.0)
		current_level.queue_free()
		$Losse_screen.visible = true
		await get_tree().create_timer(1.0).timeout
		if Data. record_wave > Data. wave:
			Data. record_wave = Data. wave
		Data. wave = 1
		Data. player_health = 75
		Data. save()
		
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")

func load_level(level):
	if current_level:
		current_level.queue_free()
	var level_path = "res://Scenes/levels/level_%s.tscn" %level
	current_level = load(level_path).instantiate()
	add_child(current_level)
	current_level.name = "level_root"
# Create a fade effect 
func _fade(to_alfa):
	var tween = create_tween()
	tween. tween_property(fade, "modulate:a", to_alfa, 1.0)
	await tween. finished
