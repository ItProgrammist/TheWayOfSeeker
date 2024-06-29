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

var anubis_preload = preload("res://Mobs/anubis/anubis.tscn")
var skeleton_preload = preload("res://Mobs/skeleton/skeleton.tscn")
var golem_preload = preload("res://Mobs/fire_golem/fire_golem.tscn")
var bat_preload = preload("res://Mobs/bat/bat.tscn")
var minotaur_preload = preload("res://Mobs/minotaur_beef/minotaur_beef.tscn")
var ventoss_preload = preload("res://Mobs/ventoss/ventoss.tscn")
var dragon_preload = preload("res://Mobs/dragon/dragon.tscn")
var portal_preload = preload("res://Portal/portal.tscn")


var state = MORNING

func _ready():
	health_bar.max_value = seeker.max_health
	health_bar.value = health_bar.max_value
	light.enabled = true
	Global.day_count = 0
	
	#for i in range(3):
		#var new_item = ItemMachine.generate_item("1")
		#$Items.add_child(new_item)
		#new_item.position = Vector2(randi_range(-1000, 1100), 570)
	


func add_lying_item(i, x, y):
	var new_item = ItemMachine.generate_item(i.get_item_name(), i.get_amount())
	$Items.add_child(new_item)
	new_item.position = Vector2(x, y)
	
func spawn_gold_coin(pos):
	$Collectibles.coin_spawn(pos)

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
		
	if state == MORNING:
		state = EVENING
		spawn_mobs()
	else:
		state = MORNING
		Global.finish_portal = true

func _on_spawner_timeout():
	if Global.count_skeleton < 6:
		Global.count_skeleton += 1
		skeleton_spawn()

func skeleton_spawn():
	if state == EVENING:
		var skeleton = skeleton_preload.instantiate()
		var num = randi_range(0, 2)
		var pos = [-1000, 2000, 3000]
		skeleton.position = Vector2 (pos[num], 570)
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
	if state == EVENING:
		var bat = bat_preload.instantiate()
		var num = randi_range(0, 2)
		var pos = [-1000, 2000, 3000]
		bat.position = Vector2 (pos[num], 570)
		$Mobs.add_child(bat)

func golem_spawn():
	if state == EVENING:
		var golem = golem_preload.instantiate()
		var num = randi_range(0, 2)
		var pos = [-1000, 2000, 3000]
		golem.position = Vector2 (pos[num], 570)
		$Mobs.add_child(golem)

func ventoss_spawn():
	if state == EVENING:
		var ventoss = ventoss_preload.instantiate()
		var num = randi_range(0, 2)
		var pos = [-1000, 2000, 3000]
		ventoss.position = Vector2 (pos[num], 570)
		$Mobs.add_child(ventoss)

func minotaur_spawn():
	if state == EVENING:
		var minotaur = minotaur_preload.instantiate()
		var num = randi_range(0, 2)
		var pos = [-1000, 2000, 3000]
		minotaur.position = Vector2 (pos[num], 570)
		$Mobs.add_child(minotaur)

func dragon_spawn():
	if state == EVENING:
		var dragon = dragon_preload.instantiate()
		var num = randi_range(0, 2)
		var pos = [-1000, 2000, 3000]
		dragon.position = Vector2 (pos[num], 570)
		$Mobs.add_child(dragon)


func _on_seeker_health_changed(new_health):
	health_bar.value = new_health


func _on_spawner_anubis_timeout():
	if Global.count_anubis < 1:
		Global.count_anubis += 1
		anubis_spawn()


func anubis_spawn():
	if state == EVENING:
		var anubis = anubis_preload.instantiate()
		var num = randi_range(0, 2)
		var pos = [-1000, 2000, 3000]
		anubis.position = Vector2 (pos[num], 570)
		$Mobs.add_child(anubis)
		
func spawn_mobs():
	
	Global.day_count += 1
	Global.finish_portal = false
	var portal1 = portal_preload.instantiate()
	var portal2 = portal_preload.instantiate()
	var portal3 = portal_preload.instantiate()
	
	
	portal1.position = Vector2 (-1000, 550)
	$Portal.add_child(portal1)
	
	portal2.position = Vector2 (2000, 550)
	$Portal.add_child(portal2)
	
	portal3.position = Vector2 (3000, 550)
	$Portal.add_child(portal3)
		
	if Global.day_count == 1:
		$Mobs/Spawner_bat.start()

	if Global.day_count == 2:
		$Mobs/Spawner_skeleton.start()
		
	if Global.day_count == 3:
		$Mobs/Spawner_minotaur.start()
			
	if Global.day_count == 4:
		$Mobs/Spawner_golem.start()
		
	if Global.day_count == 5:
		$Mobs/Spawner_ventoss.start()
			
	if Global.day_count == 6:
		$Mobs/Spawner_dragon.start()
		
	if Global.day_count == 7:
		$Mobs/Spawner_anubis.start()

