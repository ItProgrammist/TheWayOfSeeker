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
	
func load_game():
	var file = FileAccess.open(save_path, FileAccess.READ)
	Global.gold = file.get_var(Global.gold)
	seeker.position.x = file.get_var(seeker.position.x)
	seeker.position.y = file.get_var(seeker.position.y)

func _on_save_pressed():
	save_game()
	game_paused = !game_paused

func _on_load_pressed():
	load_game()
	game_paused = !game_paused
