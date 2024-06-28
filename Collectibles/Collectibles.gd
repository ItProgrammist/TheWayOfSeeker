extends Node2D

var gold = preload("res://Collectibles/gold_coin.tscn")

func _on_timer_timeout():
	spawn_gold()

func _ready():
	Signals.connect("enemy_died", Callable (self, "_on_enemy_died"))

func _on_enemy_died(enemy_position):
	for i in randi_range(1, 3):
		coin_spawn(enemy_position)


func coin_spawn(pos):
	var coin = gold.instantiate()
	coin.position = pos
	add_child(coin)


func spawn_gold():
	var goldTemp = gold.instantiate()
	#var rng = RandomNumberGenerator.new()
	var randint = randi_range(-1500, 3500)
	goldTemp.position = Vector2(randint, 565)
	add_child(goldTemp)
	
