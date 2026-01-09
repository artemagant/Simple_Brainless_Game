extends Node2D

var first_enemy_scene = preload("res://Scenes/Enemy_car_1.tscn")
var second_enemy_scene = preload("res://Scenes/Enemy_car_2.tscn")
var fird_enemy_scene = preload("res://Scenes/Enemy_car_3.tscn")
var fourth_enemy_scene = preload("res://Scenes/Enemy_car_4.tscn")
var bullet_scene := preload("res://Scenes/towers/bullet.tscn")
var sniper_bullet_scene := preload("res://Scenes/towers/bullet_for_sniper.tscn")

var ghost_towers = {
	"horse": preload("res://Scenes/towers/ghost_tower_horse_1.tscn"),
	"soldier_gun": preload("res://Scenes/towers/ghost_tower_soldier_gun.tscn"),
	"soldier_sniper": preload("res://Scenes/towers/ghost_tower_soldier_sniper.tscn")
}

var tower_horse_scene := preload("res://Scenes/towers/tower_horse_1.tscn")
var tower_soldier_scene := preload("res://Scenes/towers/tower_soldier_gun.tscn")
var tower_soldier_sniper_scene = preload("res://Scenes/towers/tower_soldier_sniper.tscn")

@onready var Wave_Counter_Panel := $HUD/Wave_Counter
@onready var Wave_Counter_Number := $HUD/Wave_Counter/CenterContainer/Number
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_button_pouse_pressed()
	# Change the wave panel size from current wave number, because idk
	
	Wave_Counter_Panel.size.x = Wave_Counter_Number.size.x
	$HUD/game_need/GameControl_Buttons/Pause_Control_Button/Button.icon = load("res://art/Another Different Stuff/Play.png")
	Data. speed_variation = 0
	previous_speed = 5
	RenderingServer. set_default_clear_color("37213B")
	start_wave(Data. wave)
	$Towers.get_children()[1].connect("shoot", create_bullet)
	#$Towers/Tower_soldier_gun.connect("shoot", create_bullet)
	$Towers/Tower_soldier_sniper.connect("sniper_shoot", create_sniper_bullet)
func _process(_delta: float) -> void:
	# Update every labels, that needs in it
	$HUD/game_need/GameControl_Buttons/Speed_Multiplayer_Counter/CenterContainer/Label.text = str(Data. speed_multiplayer) + "x"
	Wave_Counter_Number.text = "wave: " + str(int(Data. wave))
	$HUD/Hp_Counter/CenterContainer/Label. text = str(int(Data. player_health))
	$HUD/Money_counter/CenterContainer/Label.text = str(int(Data. money))

func create_bullet(pos: Vector2, dir: float, bullet_enum: Data. Bullet):
	# idk wthitt, but I trust the guide guy
	var bullet = bullet_scene.instantiate()
	bullet. name = "Bullet_"
	bullet. setup(pos, dir, bullet_enum)
	$Bullets.add_child(bullet)
func create_sniper_bullet(pos: Vector2, dir: float, bullet_enum: Data. Bullet):
	# idk wthitt, but I trust the guide guy
	var bullet = sniper_bullet_scene.instantiate()
	bullet. name = "Bullet_"
	bullet. setup(pos, dir, bullet_enum)
	$Bullets.add_child(bullet)

func start_wave(wave):
	var wavee:Array
	# Take the wave content from current wave
	if wave == 1:
		wavee = Data.wave_content_level_1.wave_1.duplicate()
	elif wave == 2:
		wavee = Data. wave_content_level_1.wave_2.duplicate()
	elif wave == 3:
		wavee = Data. wave_content_level_1.wave_3.duplicate()
	elif wave == 4:
		wavee = Data. wave_content_level_1.wave_4.duplicate()
	else:
		return
	# Spawn enemys
	while wavee:
		# If in array first thing is integer, so it means it's a enemy
		if wavee[0] is int and Data. speed_variation != 0:
			# Spawn enemy of it's type
			if wavee[0] == 1:
				
				var follow_path = PathFollow2D. new()
				$Path2D.add_child(follow_path)
				var enemy = first_enemy_scene.instantiate()
				enemy. setup(follow_path)
				enemy. name = "enemy_car_1"
				follow_path.add_child(enemy)
				wavee. remove_at(0)
			elif wavee[0] == 2:
				Data. enemys += 1
				var follow_path = PathFollow2D. new()
				$Path2D.add_child(follow_path)
				var enemy = second_enemy_scene.instantiate()
				enemy. setup(follow_path)
				enemy. name = "enemy_car_2"
				follow_path.add_child(enemy)
				wavee. remove_at(0)
			elif wavee[0] == 3:
				Data. enemys += 1
				var follow_path = PathFollow2D. new()
				$Path2D.add_child(follow_path)
				var enemy = fird_enemy_scene.instantiate()
				enemy. setup(follow_path)
				enemy. name = "enemy_car_2"
				follow_path.add_child(enemy)
				wavee. remove_at(0)
			elif wavee[0] == 4:
				Data. enemys += 1
				var follow_path = PathFollow2D. new()
				$Path2D.add_child(follow_path)
				var enemy = fourth_enemy_scene.instantiate()
				enemy. setup(follow_path)
				enemy. name = "enemy_car_2"
				follow_path.add_child(enemy)
				wavee. remove_at(0)
			# Change enemy type, if it missed
			else:
				wavee[0] = 1
				
				
		# If in array first thing is float, so it means it's a couldown between spawns
		elif wavee[0] is float and Data. speed_variation != 0:
			if Data. speed_multiplayer != 0:
				await get_tree().create_timer(wavee[0]/Data. speed_multiplayer).timeout
				wavee. remove_at(0)
			else:
				await get_tree().create_timer(wavee[0]/previous_speed).timeout
				wavee. remove_at(0)
		await get_tree().create_timer(0.1).timeout
	
	# Wait until all of the enemys dyed
	while true:
		if Data. enemys < 0:
			Data. wave += 1
			Data. save()
			if Data. speed_variation != 0:
				previous_speed = Data. speed_variation
				Data. speed_variation = 0
				$HUD/game_need/GameControl_Buttons/Pause_Control_Button/Button.icon = load("res://art/Another Different Stuff/Play.png")
			break
		else:
			await get_tree().create_timer(0.1).timeout
			continue

	# After wave we call the function, that call this function again, but with little delay 
	wave_couldown()
func wave_couldown():
	# Couldown between waves
	await get_tree().create_timer(3.0).timeout
	start_wave(Data. wave)

# This button open and close the towers shop
var direction = -1
var can_tap = true
func _on_button_pressed() -> void:
	if can_tap:
		can_tap = false
		var tween = create_tween()
		var to_x = $HUD/game_need.offset.x + 80*direction -5*direction
		tween. tween_property($HUD/game_need, "offset:x", to_x, 0.3)
		await tween. finished
		direction *= -1
		if direction == 1:
			$HUD/game_need/Expand_Game_Need_Stuf/Button. icon = load("res://art/Another Different Stuff/Expand_Game_Need_Staf_Button_Icon_2.png")
		else:
			$HUD/game_need/Expand_Game_Need_Stuf/Button.icon = load("res://art/Another Different Stuff/Expand_Game_Need_Staf_Button_Icon.png")
		can_tap = true

# This button pause and unpause game
var previous_speed
func _on_button_pouse_pressed() -> void:
	if settings:
		return
	if Data. speed_variation != 0:
		previous_speed = Data. speed_variation
		Data. speed_variation = 0
		$HUD/game_need/GameControl_Buttons/Pause_Control_Button/Button.icon = load("res://art/Another Different Stuff/Play.png")
	else:
		Data. speed_variation = previous_speed
		$HUD/game_need/GameControl_Buttons/Pause_Control_Button/Button.icon = load("res://art/Another Different Stuff/Stop.png")
		

# This button slow down game
func _on_button_slow_down_pressed() -> void:
	if Data. speed_variation > 1:
		Data. speed_variation -= 1

# This button speed up game
func _on_button_speed_up_pressed() -> void:
	if Data. speed_variation != 0 and Data. speed_variation < 10:
		Data. speed_variation += 1



# Turn on settings panel
var settings = false
func _on_button_settings_pressed() -> void:
	if settings:
		return
	settings = true
	$HUD/Settings. visible = true
	if Data. speed_variation != 0:
		previous_speed = Data. speed_variation
		Data. speed_variation = 0
		$HUD/game_need/GameControl_Buttons/Pause_Control_Button/Button.icon = load("res://art/Another Different Stuff/Play.png")

# Return in the menu
func _on_button_return_to_the_menu_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/menu.tscn")

# Turn off settings panel
func _on_button_close_settings_pressed() -> void:
	if settings:
		settings = false
		$HUD/Settings. visible = false


#
# Select which tower you will plays system
#
var buy_tower_horse_button_pressed = false
func _on_button_to_buy_horse_tower_pressed() -> void:
	if buy_tower_horse_button_pressed:
		Data. place_tower_index = 0
		buy_tower_horse_button_pressed = false
	else:
		Data. place_tower_index = 1
		buy_tower_horse_button_pressed = true
		buy_tower_soldier_button_pressed = false
		buy_tower_soldier_sniper_button_pressed = false

var buy_tower_soldier_button_pressed = false
func _on_button_to_buy_soldier_tower_pressed() -> void:
	if buy_tower_soldier_button_pressed:
		Data. place_tower_index = 0
		buy_tower_soldier_button_pressed = false
	else:
		Data. place_tower_index = 2
		buy_tower_soldier_button_pressed = true
		buy_tower_soldier_sniper_button_pressed = false
		buy_tower_horse_button_pressed = false
		

var buy_tower_soldier_sniper_button_pressed = false
func _on_button_to_buy_soldier_sniper_pressed() -> void:
	if buy_tower_soldier_sniper_button_pressed:
		Data. place_tower_index = 0
		buy_tower_soldier_sniper_button_pressed = false
	else:
		Data. place_tower_index = 3
		buy_tower_soldier_sniper_button_pressed = true
		buy_tower_horse_button_pressed = false
		buy_tower_soldier_button_pressed = false
#
# Function to place
#

func place_tower(tower_path, pos, cost, can_shoot):
	if Data. money >= cost:
		var towers = get_node_or_null("Towers")
		var instantiated = tower_path.instantiate()
		towers. add_child(instantiated)
		instantiated.position = pos
		Data. money -= cost
		print(1)
		if can_shoot == "soldier_gun":
			$Towers.get_children()[towers. get_children().size() - 1].connect("shoot", create_bullet)
		elif can_shoot == "soldier_sniper":
			$Towers.get_children()[towers. get_children().size() - 1].connect("sniper_shoot", create_bullet)

#
# Every place buttons (8)
#
# Submith function
func submith():
	if Data. place_tower_index != 0:
		$HUD/game_need/Submith_Buttons.visible = true
func yes_pressed():
	if placed == 0:
		$HUD/game_need/Submith_Buttons.visible = false
		var children = get_children()
		for child in children:
			if child. name == "tower_horse_ghost":
				child. queue_free()
				break
		var tower
		if type == 1:
			tower = tower_horse_scene.instantiate()
			Data. placed_towers[0] = 1
		elif type == 2:
			tower = tower_soldier_scene.instantiate()
			tower. connect("shoot", create_bullet)
			Data. placed_towers[0] = 2
		elif type == 3:
			tower = tower_soldier_sniper_scene.instantiate()
			tower. connect("sniper_shoot", create_sniper_bullet)
			Data. placed_towers[0] = 2
		$Towers.add_child(tower)
		tower. position = poss
		pressed = false
		
	
var placed
var type
var poss
var namee
var pressed = false
func _on_place_button_1_pressed() -> void:
	
	if Data. placed_towers[0]:
		return
	if pressed:
		print(1)
		var children = get_children()
		for child in children:
			if child. name. begins_with("tower_horse_ghost"):
				child. queue_free()
				break
	if Data. place_tower_index == 1:
		var instantiated = ghost_towers.horse.instantiate()
		add_child(instantiated)
		instantiated. name = "tower_horse_ghost"
		namee = instantiated. name
		instantiated.position = Vector2(0,60)
		placed = 0
		type = 1
		poss = Vector2(0, 60)
		submith()
	elif Data. place_tower_index == 2:
		var instantiated = ghost_towers.soldier_gun.instantiate()
		add_child(instantiated)
		instantiated. name = "tower_horse_ghost"
		namee = instantiated. name
		instantiated.position = Vector2(0,60)
		placed = 0
		type = 2
		poss = Vector2(0, 60)
		submith()
	elif Data. place_tower_index == 3:
		var instantiated = ghost_towers.soldier_sniper.instantiate()
		add_child(instantiated)
		instantiated. name = "tower_horse_ghost"
		namee = instantiated. name
		instantiated.position = Vector2(0,60)
		placed = 0
		type = 3
		poss = Vector2(0, 60)
		submith()
	pressed = true
