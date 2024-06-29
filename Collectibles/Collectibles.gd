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
	call_deferred("add_child", coin)
	
	#var tween = get_tree().create_tween()
	#var tween1 = get_tree().create_tween()
	#tween.tween_property(self, "position", position - Vector2(pos.x, pos.y), 0.3)
	#tween1.tween_property(self, "modulate:a", 0, 0.3)
	#Global.gold += 1
	#tween.tween_callback(queue_free)

func spawn_gold():
	var goldTemp = gold.instantiate()
	#var rng = RandomNumberGenerator.new()
	var randint = randi_range(-1500, 3500)
	goldTemp.position = Vector2(randint, 565)
	add_child(goldTemp)
	
