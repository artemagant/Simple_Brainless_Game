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
var towers_map = {
	"layer_1": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	"layer_2": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	"layer_3": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	"layer_4": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	"layer_5": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	"layer_6": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	"layer_7": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	"layer_8": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	"layer_9": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	"layer_10":[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	"layer_11":[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	"layer_12":[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	"layer_13":[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	"layer_14":[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	"layer_15":[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	"layer_16":[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	"layer_17":[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	"layer_18":[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
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
	#	"player_health": player_health,
		"money_multiplayer": money_multiplayer,
		
	}
	var json_string = JSON. stringify(game_data)
	save_file.store_line(json_string)
	save_file.close()
# Save varyebles, which we want to save only at the end of round
func wave_save():
	var save_file = FileAccess. open(PATH_TO_SAVE_FILE, FileAccess.WRITE)
	if save_file == null:
		print_debug("Error on loading files")
		return
	var game_data = {
		"player_health": player_health,
		"towers_map": towers_map,
		"money": money,
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
	towers_map = data. get("tower_map")
# function for reset the game
func reset_game():
	wave = 1
	money = 1
	money_multiplayer = 1
	player_health = 75
	save()
