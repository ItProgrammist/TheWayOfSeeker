extends Node2D

@onready var light = $DirectionalLight2D
@onready var point_light1 = $PointLight2D
@onready var point_light2 = $PointLight2D2
@onready var item = preload("res://UI/item.tscn")
@onready var health_bar = $CanvasLayer2/HealthBar
@onready var seeker = $Seeker/Seeker


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
	health_bar.max_value = seeker.max_health
	health_bar.value = health_bar.max_value
	light.enabled = true
	
	for i in range(15):
		var num = randi_range(1, 20)
		var new_item = item.instantiate()
		$Items.add_child(new_item)
		new_item.set_item(str(num))
		new_item.position = Vector2(randi_range(-1000, 100), 570)

func get_seeker():
	return $Seeker/Seeker

func _process(_delta):
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
	tween.tween_property(light, "energy", 0.0, 120)
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
	if Global.count_skeleton < 6:
		Global.count_skeleton += 1
		skeleton_spawn()

func skeleton_spawn():
	var skeleton = skeleton_preload.instantiate()
	skeleton.position = Vector2 (-50, 570)
	$Mobs.add_child(skeleton)


func _on_spawner_golem_timeout():
	if Global.count_golem < 3:
		Global.count_golem += 1
		golem_spawn()


func _on_spawner_bat_timeout():
	if Global.count_bat < 7:
		Global.count_bat += 1
		bat_spawn()


func _on_spawner_minotaur_timeout():
	if Global.count_minotaur < 3:
		Global.count_minotaur += 1
		minotaur_spawn()


func _on_spawner_ventoss_timeout():
	if Global.count_ventoss < 3:
		Global.count_ventoss += 1
		ventoss_spawn()


func _on_spawner_dragon_timeout():
	if Global.count_dragon < 1:
		Global.count_dragon += 1
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


func _on_seeker_health_changed(new_health):
	health_bar.value = new_health
