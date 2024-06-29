extends Node

@onready var pause_menu = $"../CanvasLayer/PauseMenu"
@onready var seeker = $"../Seeker/Seeker"
var game_paused: bool = false
var save_path = "res://savegame.save"



func _process(_delta):

	if Input.is_action_just_pressed("ui_cancel"):
		game_paused = !game_paused
		
	if game_paused == true:
		get_tree().paused = true
		pause_menu.show()
		
	else:
		get_tree().paused = false
		pause_menu.hide()


func _on_resume_pressed():
	game_paused = !game_paused

func _on_quit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menu.tscn")


func _on_menu_button_pressed():
	game_paused = !game_paused
	

func save_game():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(Global.gold)
	file.store_var(seeker.position.x)
	file.store_var(seeker.position.y)
	file.store_var(Global.count_skeleton)
	file.store_var(Global.count_bat)
	file.store_var(Global.count_golem)
	file.store_var(Global.count_minotaur)
	file.store_var(Global.count_ventoss)
	file.store_var(Global.count_dragon)
	file.store_var(Global.count_anubis)

	file.store_var(Global.run_speed)
	file.store_var(Global.jump)

	file.store_var(Global.helm_load)
	file.store_var(Global.boot_load)
	file.store_var(Global.armour_load)
	file.store_var(Global.weapon_load)

	file.store_var(Global.finish_portal)
	file.store_var(Global.day_count)

	file.store_var(Global.sig)

	file.store_var(Global.helm_hp)
	file.store_var(Global.armour_hp)
	file.store_var(Global.boot_hp)

	for i in Global.items:
		file.store_var(i)
	
func load_game():
	var file = FileAccess.open(save_path, FileAccess.READ)
	Global.gold = file.get_var(Global.gold)
	seeker.position.x = file.get_var(seeker.position.x)
	seeker.position.y = file.get_var(seeker.position.y)
	Global.count_skeleton = file.get_var(Global.count_skeleton)
	Global.count_bat = file.get_var(Global.count_bat)
	Global.count_golem = file.get_var(Global.count_golem)
	Global.count_minotaur = file.get_var(Global.count_minotaur)
	Global.count_ventoss = file.get_var(Global.count_ventoss)
	Global.count_dragon = file.get_var(Global.count_dragon)
	Global.count_anubis = file.get_var(Global.count_anubis)

	Global.run_speed = file.get_var(Global.run_speed)
	Global.jump = file.get_var(Global.jump)

	Global.helm_load = file.get_var(Global.helm_load)
	Global.boot_load = file.get_var(Global.boot_load)
	Global.armour_load = file.get_var(Global.armour_load)
	Global.weapon_load = file.get_var(Global.weapon_load)

	Global.finish_portal = file.get_var(Global.finish_portal)
	Global.day_count = file.get_var(Global.day_count)

	Global.sig = file.get_var(Global.sig)

	Global.helm_hp = file.get_var(Global.helm_hp)
	Global.armour_hp = file.get_var(Global.armour_hp)
	Global.boot_hp = file.get_var(Global.boot_hp)
	
	#for i in range(0, Global.items.size()):
		#print(Global.items[i])
		#Global.items[i] = file.get_var(Global.items[i])
	

#func load_item(save_path):
	#var file = FileAccess.open(save_path, FileAccess.READ)
	#
	#if file!= null:
		#var item_instance = null
		#if save_path.ends_with(".save"):
			#item_instance = load(save_path)
		#
		#if item_instance!= null:
			#file.close()
			#return item_instance
		#else:
			#print("Не удалось загрузить предмет из файла: ", save_path)
	#else:
		#print("Не удалось открыть файл: ", save_path)
	#
	#return null


func _on_save_pressed():
	save_game()
	game_paused = !game_paused

func _on_load_pressed():
	load_game()
	game_paused = !game_paused
	
class Item:
	var name : String
	var amount : int
	
	func load_from_file(file):
		name = file.get_var("name")
		amount = file.get_var("amount")
