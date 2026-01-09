extends Node
# idk wthitt, but I trust guide guy
enum Bullet {SIGNAL, FIRE, MORTAR_EXPLOSION}

# Varyebles, that I need in different spots, and something from this I will save
var wave = 1
var record_wave = 0
var enemys = 0
var speed_multiplayer = 1
var speed_variation = 5
var player_health = 75
var money = 150
var money_multiplayer = 5.0
var place_tower_index = 0

var placed_towers = [0, 0, 0, 0, 0, 0, 0, 0]

var towers_positions = [Vector2(0, 60), Vector2(72, 108), Vector2(72, 20), Vector2(160,76), Vector2(128, 12),  Vector2(208, 12), Vector2(280, 60),Vector2(280, 108)]
func _process(_delta: float) -> void:
	if speed_variation == 0:
		speed_multiplayer = 0.0
	elif speed_variation == 1:
		speed_multiplayer = 0.2
	elif speed_variation == 2:
		speed_multiplayer = 0.4
	elif speed_variation == 3:
		speed_multiplayer = 0.6
	elif speed_variation == 4:
		speed_multiplayer = 0.8
	elif speed_variation == 5:
		speed_multiplayer = 1.0
	elif speed_variation == 6:
		speed_multiplayer = 1.2
	elif speed_variation == 7:
		speed_multiplayer = 1.4
	elif speed_variation == 8:
		speed_multiplayer = 1.6
	elif speed_variation == 9:
		speed_multiplayer = 1.8
	elif speed_variation == 10:
		speed_multiplayer = 2.0
	else: 
		speed_multiplayer = 1.0

# Every wave content for levels
const wave_content_level_1 = {
	"wave_1": [1, 3.0, 1, 3.0, 1, 3.0, 1, 3.0, 1, 2.5, 1, 2.0, 1, 1.0, 1, 1.0],
	"wave_2": [1, 2.0, 2, 2.0, 1, 1.5, 2, 1.5, 1, 1.0, 2, 1.0, 2, 1.0, 1, 1.0, 1, 1.0],
	"wave_3": [1, 2.0, 2, 1.0, 3, 1.0, 2, 2.0, 2, 2.0, 1, 1.0, 3, 2.0, 2, 1.0, 2, 1.0, 3, 1.0],
	"wave_4": [1, 1.0, 3, 1.5, 4, 3.5, 4, 3.5, 2, 1.0, 2, 1.0, 1, 1.0, 3, 1.5, 4, 4.5, 4, 4.5],
}

var towers_cost = {
	"horse": 75,
	"soldier_gun": 150, 
	"soldier_sniper": 300
}

#
# saving system
#
const PATH_TO_SAVE_FILE = "user://savegame.save" # Save Path

func save(): # Function game save
	var save_file = FileAccess. open(PATH_TO_SAVE_FILE, FileAccess.WRITE)
	if save_file == null:
		print_debug("Error on loading files")
		return
	
	var game_data = { # Every Varyebles, that I will save
		"wave": wave, 
		"record_wave": record_wave,
		"money_multiplayer": money_multiplayer,
		"player_health": player_health,
		"money": money,
		"placed_towers": placed_towers,
	}
	var json_string = JSON. stringify(game_data)
	save_file.store_line(json_string)
	save_file.close()
# Loading every varyebles from data
func load_game():
	if not FileAccess. file_exists(PATH_TO_SAVE_FILE):
		return false
	
	var save_file = FileAccess. open(PATH_TO_SAVE_FILE, FileAccess. READ)
	if save_file == null:
		print_debug("Error on loading files")
		return
	
	var json_string = save_file.get_line()
	save_file.close()
	
	var json = JSON. new()
	var parse_result = json. parse(json_string)
	
	if parse_result != OK:
		print("Ошибка паркинга JSON файла")
		return false
	
	var data = json. data
	
	#
	# get data
	#
	wave = data. get("wave", 1)
	record_wave = data. get("record_wave", 0)
	player_health = data. get("player_health", 75)
	money = data. get("money", 150)
	money_multiplayer = data. get("money_multiplayer", 5.0)
	placed_towers = data. get("placed_towers", [0,0,0,0,0,0,0,0])
# function for reset the game
func reset_game():
	wave = 1
	money = 150
	money_multiplayer = 1
	player_health = 75
	placed_towers = [0,0,0,0,0,0,0,0]
	save()
