extends Node2D

var skeleton_preload = preload("res://Mobs/skeleton/skeleton.tscn")
var golem_preload = preload("res://Mobs/fire_golem/fire_golem.tscn")
var bat_preload = preload("res://Mobs/bat/bat.tscn")
var minotaur_preload = preload("res://Mobs/minotaur_beef/minotaur_beef.tscn")
var ventoss_preload = preload("res://Mobs/ventoss/ventoss.tscn")
var dragon_preload = preload("res://Mobs/dragon/dragon.tscn")

func _on_spawner_timeout():
	skeleton_spawn()

func skeleton_spawn():
	var skeleton = skeleton_preload.instantiate()
	skeleton.position = Vector2 (-50, 570)
	$Mobs.add_child(skeleton)


func _on_spawner_golem_timeout():
	golem_spawn()


func _on_spawner_bat_timeout():
	bat_spawn()


func _on_spawner_minotaur_timeout():
	minotaur_spawn()


func _on_spawner_ventoss_timeout():
	ventoss_spawn()


func _on_spawner_dragon_timeout():
	dragon_spawn()


func bat_spawn():
	var bat = bat_preload.instantiate()
	bat.position = Vector2 (400, 570)
	$Mobs.add_child(bat)

func golem_spawn():
	var golem = golem_preload.instantiate()
	golem.position = Vector2 (800, 570)
	$Mobs.add_child(golem)

func ventoss_spawn():
	var ventoss = ventoss_preload.instantiate()
	ventoss.position = Vector2 (1000, 570)
	$Mobs.add_child(ventoss)

func minotaur_spawn():
	var minotaur = minotaur_preload.instantiate()
	minotaur.position = Vector2 (1200, 570)
	$Mobs.add_child(minotaur)

func dragon_spawn():
	var dragon = dragon_preload.instantiate()
	dragon.position = Vector2 (1600, 570)
	$Mobs.add_child(dragon)


