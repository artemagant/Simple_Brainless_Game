extends Node2D

var first_enemy_scene = preload("res://Scenes/Enemy_car_1.tscn")
var bullet_scene := preload("res://Scenes/towers/bullet.tscn")
@onready var Wave_Counter_Panel := $HUD/Wave_Counter
@onready var Wave_Counter_Number := $HUD/Wave_Counter/CenterContainer/Number
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	Wave_Counter_Number.text = str(Data. wave)
	Wave_Counter_Panel.size.x = 48 + Wave_Counter_Number.size.x
	RenderingServer. set_default_clear_color("37213B")
	start_wave(Data. wave)
	$Towers/Tower_soldier_gun.connect("shoot", create_bullet)

func create_bullet(pos: Vector2, dir: float, bullet_enum: Data. Bullet):
	var bullet = bullet_scene.instantiate()
	bullet. setup(pos, dir, bullet_enum)
	$Bullets.add_child(bullet)

func start_wave(wave):
	var wavee
	if wave == 1:
		wavee = Data. wave_content_level_1.wave_1
	elif wave == 2:
		wavee = Data. wave_content_level_1.wave_2
	while wavee:
		if wavee[0] is int:
			if wavee[0] == 1:
				var follow_path = PathFollow2D. new()
				$Path2D.add_child(follow_path)
				var enemy = first_enemy_scene.instantiate()
				enemy. setup(follow_path)
				follow_path.add_child(enemy)
				wavee. remove_at(0)
			else:
				wavee. remove_at(0)
		elif wavee[0] is float:
			await get_tree().create_timer(wavee[0]).timeout
			wavee. remove_at(0)
	Data. wave += 1
	wave_couldown()
func wave_couldown():
	Wave_Counter_Number.text = str(Data. wave)
	await get_tree().create_timer(1.0).timeout
	start_wave(Data. wave)
