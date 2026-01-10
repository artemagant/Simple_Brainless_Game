extends Node2D

var first_enemy_scene := preload("res://Scenes/Enemy_car_1.tscn")
var second_enemy_scene := preload("res://Scenes/enemy_car_2.tscn")
var fird_enemy_scene := preload("res://Scenes/enemy_car_3.tscn")
var fourth_enemy_scene := preload("res://Scenes/enemy_car_4.tscn")
var labubu_smile_scene := preload("res://Scenes/enemy_labubu_smile.tscn")
var labubu_evil_scene := preload("res://Scenes/enemy_labubu_evil.tscn")
var phone_scene := preload("res://Scenes/enemy_phone.tscn")
var laptop_scene := preload("res://Scenes/enemy_laptop.tscn")
var computer_boss_scene := preload("res://Scenes/enemy_computer_boss.tscn")
var bullet_scene := preload("res://Scenes/towers/bullet.tscn")
var sniper_bullet_scene := preload("res://Scenes/towers/bullet_for_sniper.tscn")

var ghost_towers = {
	"horse": preload("res://Scenes/towers/ghost_tower_horse_1.tscn"),
	"soldier_gun": preload("res://Scenes/towers/ghost_tower_soldier_gun.tscn"),
	"soldier_sniper": preload("res://Scenes/towers/ghost_tower_soldier_sniper.tscn")
}

var tower_horse_scene := preload("res://Scenes/towers/tower_horse_1.tscn")
var tower_soldier_scene := preload("res://Scenes/towers/tower_soldier_gun.tscn")
var tower_soldier_sniper_scene := preload("res://Scenes/towers/tower_soldier_sniper.tscn")

@onready var Wave_Counter_Panel := $HUD/Wave_Counter
@onready var Wave_Counter_Number := $HUD/Wave_Counter/CenterContainer/Number

var color = Color(0.6, 0.6, 0.6)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_button_pouse_pressed()
	# Change the wave panel size from current wave number, because idk
	Wave_Counter_Panel.size.x = Wave_Counter_Number.size.x
	$HUD/game_need/GameControl_Buttons/Pause_Control_Button/Button.icon = load("res://art/Another_Different_Stuff/Play.png")
	Data. speed_variation = 0
	previous_speed = 5
	RenderingServer. set_default_clear_color("37213B")
	start_wave(Data. wave)
	load_towers()
	
func _process(_delta: float) -> void:
	# Update every labels, that needs in it
	$HUD/game_need/GameControl_Buttons/Speed_Multiplayer_Counter/CenterContainer/Label.text = str(Data. speed_multiplayer) + "x"
	Wave_Counter_Number.text = "wave: " + str(int(Data. wave))
	$HUD/Hp_Counter/CenterContainer/Label. text = str(int(Data. player_health))
	$HUD/Money_counter/CenterContainer/Label.text = str(int(Data. money))
	# Highlight towers buy buttons, if they pressed
	if Data. place_tower_index == 0:
		$HUD/game_need/Towers_Manager/Button_To_Buy_Horse_Tower.modulate = Color(1.0, 1.0, 1.0, 1.0)
		$HUD/game_need/Towers_Manager/Button_To_Buy_Soldier_Gun.modulate = Color(1.0, 1.0, 1.0, 1.0)
		$HUD/game_need/Towers_Manager/Button_To_Buy_Soldier_Sniper.modulate = Color(1.0, 1.0, 1.0, 1.0)
	elif Data. place_tower_index == 1:
		$HUD/game_need/Towers_Manager/Button_To_Buy_Horse_Tower.modulate = color
		$HUD/game_need/Towers_Manager/Button_To_Buy_Soldier_Gun.modulate = Color(1.0, 1.0, 1.0, 1.0)
		$HUD/game_need/Towers_Manager/Button_To_Buy_Soldier_Sniper.modulate = Color(1.0, 1.0, 1.0, 1.0)
	elif Data. place_tower_index == 2:
		$HUD/game_need/Towers_Manager/Button_To_Buy_Horse_Tower.modulate = Color(1.0, 1.0, 1.0, 1.0)
		$HUD/game_need/Towers_Manager/Button_To_Buy_Soldier_Gun.modulate = color
		$HUD/game_need/Towers_Manager/Button_To_Buy_Soldier_Sniper.modulate= Color(1.0, 1.0, 1.0, 1.0)
	elif Data. place_tower_index == 3:
		$HUD/game_need/Towers_Manager/Button_To_Buy_Horse_Tower.modulate = Color(1.0, 1.0, 1.0, 1.0)
		$HUD/game_need/Towers_Manager/Button_To_Buy_Soldier_Gun.modulate = Color(1.0, 1.0, 1.0, 1.0)
		$HUD/game_need/Towers_Manager/Button_To_Buy_Soldier_Sniper.modulate = color
	

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
		wavee = Data.wave_content_level_1.wave_1
	elif wave == 2:
		wavee = Data. wave_content_level_1.wave_2
	elif wave == 3:
		wavee = Data. wave_content_level_1.wave_3
	elif wave == 4:
		wavee = Data. wave_content_level_1.wave_4
	elif wave == 5:
		wavee = Data. wave_content_level_1.wave_5
	elif wave == 6:
		wavee = Data. wave_content_level_1.wave_6
	elif wave == 7:
		wavee = Data. wave_content_level_1.wave_7
	elif wave == 8:
		wavee = Data. wave_content_level_1.wave_8
	elif wave == 9:
		wavee = Data. wave_content_level_1.wave_9
	elif wave == 10:
		wavee = Data. wave_content_level_1.wave_10
	elif wave == 11:
		wavee = Data. wave_content_level_1.wave_11
	elif wave == 12:
		wavee = Data. wave_content_level_1.wave_12
	elif wave == 13:
		wavee = Data. wave_content_level_1.wave_13
	elif wave == 14:
		wavee = Data. wave_content_level_1.wave_14
	elif wave == 15:
		wavee = Data. wave_content_level_1.wave_15
	else:
		return
	# Spawn enemys
	for event in wavee:
		if event is int and Data. speed_variation != 0:
			if event == 1:
				var follow_path = PathFollow2D. new()
				$Path2D.add_child(follow_path)
				var enemy = first_enemy_scene.instantiate()
				enemy. setup(follow_path)
				enemy. name = "enemy_car_1"
				follow_path.add_child(enemy)
			elif event == 2:
				var follow_path = PathFollow2D. new()
				$Path2D.add_child(follow_path)
				var enemy = second_enemy_scene.instantiate()
				enemy. setup(follow_path)
				enemy. name = "enemy_car_2"
				follow_path.add_child(enemy)
			elif event == 3:
				var follow_path = PathFollow2D. new()
				$Path2D.add_child(follow_path)
				var enemy = fird_enemy_scene.instantiate()
				enemy. setup(follow_path)
				enemy. name = "enemy_car_2"
				follow_path.add_child(enemy)
			elif event == 4:
				var follow_path = PathFollow2D. new()
				$Path2D.add_child(follow_path)
				var enemy = fourth_enemy_scene.instantiate()
				enemy. setup(follow_path)
				enemy. name = "enemy_car_4"
				follow_path.add_child(enemy)
			elif event == 5:
				var follow_path = PathFollow2D. new()
				$Path2D.add_child(follow_path)
				var enemy = labubu_smile_scene.instantiate()
				enemy. setup(follow_path)
				enemy. name = "enemy_labubu_smile"
				follow_path.add_child(enemy)
			elif event == 6:
				var follow_path = PathFollow2D. new()
				$Path2D.add_child(follow_path)
				var enemy = labubu_evil_scene.instantiate()
				enemy. setup(follow_path)
				enemy. name = "enemy_labubu_evil"
				follow_path.add_child(enemy)
			elif event == 7:
				var follow_path = PathFollow2D. new()
				$Path2D.add_child(follow_path)
				var enemy = phone_scene.instantiate()
				enemy. setup(follow_path)
				enemy. name = "enemy_phone"
				follow_path.add_child(enemy)
			elif event == 8:
				var follow_path = PathFollow2D. new()
				$Path2D.add_child(follow_path)
				var enemy = laptop_scene.instantiate()
				enemy. setup(follow_path)
				enemy. name = "enemy_laptop"
				follow_path.add_child(enemy)
			elif event == 9:
				var follow_path = PathFollow2D. new()
				$Path2D.add_child(follow_path)
				var enemy = computer_boss_scene.instantiate()
				enemy. setup(follow_path)
				enemy. name = "enemy_computer_boss"
				follow_path.add_child(enemy)
		elif event is float and Data. speed_variation != 0:
			await get_tree().create_timer(event/Data. speed_multiplayer).timeout
		else: 
			if Data. speed_variation == 0:
				while Data. speed_variation == 0:
					await get_tree().create_timer(0.1).timeout
	
	# Wait until all of the enemys dyed
	while true:
		var enemys = 0
		var childrens = $Path2D.get_children()
		for path in childrens:
			if path. get_children():
				enemys += 1
			await get_tree().create_timer(0.005).timeout
		if enemys == 0:
			for enemy in childrens:
				enemy. queue_free()
			Data. wave += 1
			Data. money += 25
			Data. save()
			if Data. speed_variation != 0:
				previous_speed = Data. speed_variation
				Data. speed_variation = 0
				$HUD/game_need/GameControl_Buttons/Pause_Control_Button/Button.icon = load("res://art/Another_Different_Stuff/Play.png")
				break

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
			$HUD/game_need/Expand_Game_Need_Stuf/Button. icon = load("res://art/Another_Different_Stuff/Expand_Game_Need_Staf_Button_Icon_2.png")
		else:
			$HUD/game_need/Expand_Game_Need_Stuf/Button.icon = load("res://art/Another_Different_Stuff/Expand_Game_Need_Staf_Button_Icon.png")
		can_tap = true

# This button pause and unpause game
var previous_speed
func _on_button_pouse_pressed() -> void:
	if settings:
		return
	if Data. speed_variation != 0:
		previous_speed = Data. speed_variation
		Data. speed_variation = 0
		$HUD/game_need/GameControl_Buttons/Pause_Control_Button/Button.icon = load("res://art/Another_Different_Stuff/Play.png")
	else:
		Data. speed_variation = previous_speed
		$HUD/game_need/GameControl_Buttons/Pause_Control_Button/Button.icon = load("res://art/Another_Different_Stuff/Stop.png")
		

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
		$HUD/game_need/GameControl_Buttons/Pause_Control_Button/Button.icon = load("res://art/Another_Different_Stuff/Play.png")

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
# Every place buttons (8)
#
func load_towers():
	var placed_towers = Data. placed_towers
	var tower
	for typee in 8:
		var posss = Data. towers_positions[typee]
		#print(Data. placed_towers[typee])
		if Data. placed_towers[typee] == 0:
			continue
		elif Data. placed_towers[typee] == 1:
			tower = tower_horse_scene.instantiate()
		elif Data. placed_towers[typee] == 2:
			tower = tower_soldier_scene.instantiate()
			tower. connect("shoot", create_bullet)
		elif Data. placed_towers[typee] == 3:
			tower = tower_soldier_sniper_scene.instantiate()
			tower. connect("sniper_shoot", create_sniper_bullet)
		else:
			continue
		$Towers.add_child(tower)
		tower. position = posss
# Submith function
func submith():
	if Data. place_tower_index != 0:
		$HUD/game_need/Submith_Buttons.visible = true
# If button yes was pressed
func yes_pressed():
	# it need for change array of towers
	var index
	if placed:
		index = placed
	elif placed == 0:
		index = placed
	else:
		return
	
	# Spawn the towrrs
	var tower
	if type == 1:
		# Check if enough money
		if Data. money < Data. towers_cost.horse:
			return
		tower = tower_horse_scene.instantiate()
		Data. placed_towers[index] = 1
		Data. money -= Data. towers_cost.horse
	elif type == 2 :
		# Check if enough money 
		if Data. money < Data. towers_cost.soldier_gun:
			return
		tower = tower_soldier_scene.instantiate()
		# Connect shoot signal
		tower. connect("shoot", create_bullet)
		Data. placed_towers[index] = 2
		Data. money -= Data. towers_cost.soldier_gun
	elif type == 3:
		# Check if enough money 
		if Data. money < Data. towers_cost.soldier_sniper:
			return
		tower = tower_soldier_sniper_scene.instantiate()
		# Connect shoot signal
		tower. connect("sniper_shoot", create_sniper_bullet)
		Data. placed_towers[index] = 3
		Data. money -= Data. towers_cost.soldier_sniper
	$HUD/game_need/Submith_Buttons.visible = false
	# Delete the ghost
	var children = get_children()
	for child in children:
		if child. name == "tower_horse_ghost" or child. name. begins_with("tower_horse_ghost"):
			child. queue_free()
	# Add tower to the game
	$Towers.add_child(tower)
	tower. position = poss
	# Reset every varyebles 
	pressed = false
	type = 0
	poss = 0
	namee = 0
	placed = null
func no_pressed():
	if pressed:
		# Delete the ghost
		var children = get_children()
		for child in children:
			if child. name. begins_with("tower_horse_ghost"):
				child. queue_free()
				break
		# Reset varyebles
		pressed = false
		type = 0
		poss = 0
		namee = 0
		placed = null
		$HUD/game_need/Submith_Buttons.visible = false
func sell():
	if selll or selll == 0:
		for tower in $Towers.get_children():
			# Check for every towers in node Towers and then check if it's position equal to positions we known
			if tower. position == Data. towers_positions[selll]:
				tower. queue_free()
				var cost
				if Data. placed_towers[selll] == 1:
					cost = Data. towers_cost.horse
				elif Data. placed_towers[selll] == 2:
					cost = Data. towers_cost.soldier_gun
				elif Data. placed_towers[selll] == 3:
					cost = Data. towers_cost.soldier_sniper
				Data.money += cost/1.4
				Data. placed_towers[selll] = 0
				selll = null
				$HUD/game_need/Sold_Buttons.visible = false
				return
func no_deal():
	selll = null
	$HUD/game_need/Sold_Buttons.visible = false

var placed
var type
var poss
var namee
var pressed = false
var selll = null

func _on_place_button_1_pressed() -> void:
	if Data. placed_towers[0]:
		no_pressed()
		selll = 0
		$HUD/game_need/Sold_Buttons.visible = true
		return
	if pressed:
		var children = get_children()
		for child in children:
			if child. name. begins_with("tower_horse_ghost"):
				child. queue_free()
				break
	var posss = Data. towers_positions[0]
	if Data. place_tower_index == 1:
		var instantiated = ghost_towers.horse.instantiate()
		add_child(instantiated)
		instantiated. name = "tower_horse_ghost"
		namee = instantiated. name
		instantiated.position = posss
		placed = 0
		type = 1
		poss =posss
		submith()
	elif Data. place_tower_index == 2:
		var instantiated = ghost_towers.soldier_gun.instantiate()
		add_child(instantiated)
		instantiated. name = "tower_horse_ghost"
		namee = instantiated. name
		instantiated.position = posss
		placed = 0
		type = 2
		poss = posss
		submith()
	elif Data. place_tower_index == 3:
		var instantiated = ghost_towers.soldier_sniper.instantiate()
		add_child(instantiated)
		instantiated. name = "tower_horse_ghost"
		namee = instantiated. name
		instantiated.position = posss
		placed = 0
		type = 3
		poss = posss
		submith()
	pressed = true
func _on_place_button_2_pressed() -> void:
	if Data. placed_towers[1]:
		no_pressed()
		selll = 1
		$HUD/game_need/Sold_Buttons.visible = true
		return
	if pressed:
		var children = get_children()
		for child in children:
			if child. name. begins_with("tower_horse_ghost") or child. name == "tower_horse_ghost":
				child. queue_free()
				break
	var posss = Data. towers_positions[1]
	if Data. place_tower_index == 1:
		var instantiated = ghost_towers.horse.instantiate()
		add_child(instantiated)
		instantiated. name = "tower_horse_ghost"
		namee = instantiated. name
		instantiated.position = posss
		placed = 1
		type = 1
		poss = posss
		submith()
	elif Data. place_tower_index == 2:
		var instantiated = ghost_towers.soldier_gun.instantiate()
		add_child(instantiated)
		instantiated. name = "tower_horse_ghost"
		namee = instantiated. name
		instantiated.position = posss
		placed = 1
		type = 2
		poss = posss
		submith()
	elif Data. place_tower_index == 3:
		var instantiated = ghost_towers.soldier_sniper.instantiate()
		add_child(instantiated)
		instantiated. name = "tower_horse_ghost"
		namee = instantiated. name
		instantiated.position = posss
		placed = 1
		type = 3
		poss = posss
		submith()
	pressed = true
func _on_place_button_3_pressed() -> void:
	if Data. placed_towers[2]:
		no_pressed()
		selll = 2
		$HUD/game_need/Sold_Buttons.visible = true
		return
	if pressed:
		var children = get_children()
		for child in children:
			if child. name. begins_with("tower_horse_ghost") or child. name == "tower_horse_ghost":
				child. queue_free()
				break
	var posss = Data. towers_positions[2]
	if Data. place_tower_index == 1:
		var instantiated = ghost_towers.horse.instantiate()
		add_child(instantiated)
		instantiated. name = "tower_horse_ghost"
		namee = instantiated. name
		instantiated.position = posss
		placed = 2
		type = 1
		poss =posss
		submith()
	elif Data. place_tower_index == 2:
		var instantiated = ghost_towers.soldier_gun.instantiate()
		add_child(instantiated)
		instantiated. name = "tower_horse_ghost"
		namee = instantiated. name
		instantiated.position = posss
		placed = 2
		type = 2
		poss = posss
		submith()
	elif Data. place_tower_index == 3:
		var instantiated = ghost_towers.soldier_sniper.instantiate()
		add_child(instantiated)
		instantiated. name = "tower_horse_ghost"
		namee = instantiated. name
		instantiated.position = posss
		placed = 2
		type = 3
		poss = posss
		submith()
	pressed = true
func _on_place_button_4_pressed() -> void:
	if Data. placed_towers[3]:
		no_pressed()
		selll = 3
		$HUD/game_need/Sold_Buttons.visible = true
		return
	if pressed:
		var children = get_children()
		for child in children:
			if child. name. begins_with("tower_horse_ghost") or child. name == "tower_horse_ghost":
				child. queue_free()
				break
	var posss = Data. towers_positions[3]
	if Data. place_tower_index == 1:
		var instantiated = ghost_towers.horse.instantiate()
		add_child(instantiated)
		instantiated. name = "tower_horse_ghost"
		namee = instantiated. name
		instantiated.position = posss
		placed = 3
		type = 1
		poss =posss
		submith()
	elif Data. place_tower_index == 2:
		var instantiated = ghost_towers.soldier_gun.instantiate()
		add_child(instantiated)
		instantiated. name = "tower_horse_ghost"
		namee = instantiated. name
		instantiated.position = posss
		placed = 3
		type = 2
		poss = posss
		submith()
	elif Data. place_tower_index == 3:
		var instantiated = ghost_towers.soldier_sniper.instantiate()
		add_child(instantiated)
		instantiated. name = "tower_horse_ghost"
		namee = instantiated. name
		instantiated.position = posss
		placed = 3
		type = 3
		poss = posss
		submith()
	pressed = true
func _on_place_button_5_pressed() -> void:
	if Data. placed_towers[4]:
		no_pressed()
		selll = 4
		$HUD/game_need/Sold_Buttons.visible = true
		return
	if pressed:
		var children = get_children()
		for child in children:
			if child. name. begins_with("tower_horse_ghost") or child. name == "tower_horse_ghost":
				child. queue_free()
				break
	var posss = Data. towers_positions[4]
	if Data. place_tower_index == 1:
		var instantiated = ghost_towers.horse.instantiate()
		add_child(instantiated)
		instantiated. name = "tower_horse_ghost"
		namee = instantiated. name
		instantiated.position = posss
		placed = 4
		type = 1
		poss =posss
		submith()
	elif Data. place_tower_index == 2:
		var instantiated = ghost_towers.soldier_gun.instantiate()
		add_child(instantiated)
		instantiated. name = "tower_horse_ghost"
		namee = instantiated. name
		instantiated.position = posss
		placed = 4
		type = 2
		poss = posss
		submith()
	elif Data. place_tower_index == 3:
		var instantiated = ghost_towers.soldier_sniper.instantiate()
		add_child(instantiated)
		instantiated. name = "tower_horse_ghost"
		namee = instantiated. name
		instantiated.position = posss
		placed = 4
		type = 3
		poss = posss
		submith()
	pressed = true
func _on_place_button_6_pressed() -> void:
	if Data. placed_towers[5]:
		no_pressed()
		selll = 5
		$HUD/game_need/Sold_Buttons.visible = true
		return
	if pressed:
		var children = get_children()
		for child in children:
			if child. name. begins_with("tower_horse_ghost") or child. name == "tower_horse_ghost":
				child. queue_free()
				break
	var posss = Data. towers_positions[5]
	if Data. place_tower_index == 1:
		var instantiated = ghost_towers.horse.instantiate()
		add_child(instantiated)
		instantiated. name = "tower_horse_ghost"
		namee = instantiated. name
		instantiated.position = posss
		placed = 5
		type = 1
		poss =posss
		submith()
	elif Data. place_tower_index == 2:
		var instantiated = ghost_towers.soldier_gun.instantiate()
		add_child(instantiated)
		instantiated. name = "tower_horse_ghost"
		namee = instantiated. name
		instantiated.position = posss
		placed = 5
		type = 2
		poss = posss
		submith()
	elif Data. place_tower_index == 3:
		var instantiated = ghost_towers.soldier_sniper.instantiate()
		add_child(instantiated)
		instantiated. name = "tower_horse_ghost"
		namee = instantiated. name
		instantiated.position = posss
		placed = 5
		type = 3
		poss = posss
		submith()
	pressed = true
func _on_place_button_7_pressed() -> void:
	if Data. placed_towers[6]:
		no_pressed()
		selll = 6
		$HUD/game_need/Sold_Buttons.visible = true
		return
	if pressed:
		var children = get_children()
		for child in children:
			if child. name. begins_with("tower_horse_ghost") or child. name == "tower_horse_ghost":
				child. queue_free()
				break
	var posss = Data. towers_positions[6]
	if Data. place_tower_index == 1:
		var instantiated = ghost_towers.horse.instantiate()
		add_child(instantiated)
		instantiated. name = "tower_horse_ghost"
		namee = instantiated. name
		instantiated.position = posss
		placed = 6
		type = 1
		poss =posss
		submith()
	elif Data. place_tower_index == 2:
		var instantiated = ghost_towers.soldier_gun.instantiate()
		add_child(instantiated)
		instantiated. name = "tower_horse_ghost"
		namee = instantiated. name
		instantiated.position = posss
		placed = 6
		type = 2
		poss = posss
		submith()
	elif Data. place_tower_index == 3:
		var instantiated = ghost_towers.soldier_sniper.instantiate()
		add_child(instantiated)
		instantiated. name = "tower_horse_ghost"
		namee = instantiated. name
		instantiated.position = posss
		placed = 6
		type = 3
		poss = posss
		submith()
	pressed = true
func _on_place_button_8_pressed() -> void:
	if Data. placed_towers[7]:
		no_pressed()
		selll = 7
		$HUD/game_need/Sold_Buttons.visible = true
		return
	if pressed:
		var children = get_children()
		for child in children:
			if child. name. begins_with("tower_horse_ghost") or child. name == "tower_horse_ghost":
				child. queue_free()
				break
	var posss = Data. towers_positions[7]
	if Data. place_tower_index == 1:
		var instantiated = ghost_towers.horse.instantiate()
		add_child(instantiated)
		instantiated. name = "tower_horse_ghost"
		namee = instantiated. name
		instantiated.position = posss
		placed = 7
		type = 1
		poss =posss
		submith()
	elif Data. place_tower_index == 2:
		var instantiated = ghost_towers.soldier_gun.instantiate()
		add_child(instantiated)
		instantiated. name = "tower_horse_ghost"
		namee = instantiated. name
		instantiated.position = posss
		placed = 7
		type = 2
		poss = posss
		submith()
	elif Data. place_tower_index == 3:
		var instantiated = ghost_towers.soldier_sniper.instantiate()
		add_child(instantiated)
		instantiated. name = "tower_horse_ghost"
		namee = instantiated. name
		instantiated.position = posss
		placed = 7
		type = 3
		poss = posss
		submith()
	pressed = true
