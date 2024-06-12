extends Node2D

@onready var light = $DirectionalLight2D
@onready var point_light1 = $PointLight2D
@onready var point_light2 = $PointLight2D2


enum{
	MORNING,
	DAY,
	EVENING,
	NIGHT
}

var skeleton_preload = preload("res://Mobs/skeleton/skeleton.tscn")
var golem_preload = preload("res://Mobs/fire_golem/fire_golem.tscn")
var bat_preload = preload("res://Mobs/bat/bat.tscn")
var minotaur_preload = preload("res://Mobs/minotaur_beef/minotaur_beef.tscn")
var ventoss_preload = preload("res://Mobs/ventoss/ventoss.tscn")
var dragon_preload = preload("res://Mobs/dragon/dragon.tscn")

var state = MORNING

func _ready():
	light.enabled = true

func _process(delta):
	match state:
		MORNING:
			morning_state()
		#DAY:
			#pass
		EVENING:
			evening_state()
		#NIGHT:
			#pass

func morning_state():
	var tween = get_tree().create_tween()
	tween.tween_property(light, "energy", 0.2, 120)
	var tween1 = get_tree().create_tween()
	tween1.tween_property(point_light1, "energy", 0, 120)
	var tween2 = get_tree().create_tween()
	tween2.tween_property(point_light2, "energy", 0, 120)
func evening_state():
	var tween = get_tree().create_tween()
	tween.tween_property(light, "energy", 0.95, 120)
	var tween1 = get_tree().create_tween()
	tween1.tween_property(point_light1, "energy", 2, 120)
	var tween2 = get_tree().create_tween()
	tween2.tween_property(point_light2, "energy", 2, 120)

func _on_day_night_timeout():
	if state < 3:
		state += 1
	else:
		state = MORNING
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
