extends CharacterBody2D

signal health_changed (new_health)

enum{
	MOVE,
	ATTACK1,
	ATTACK2,
	ATTACK3,
	DAMAGE,
	DEATH,
	BLOCK,
	SLIDE
}

const SPEED = 150.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = $AnimatedSprite2D
@onready var anim_player = $AnimationPlayer
@onready var seeker = $"."
@onready var ui = get_viewport().get_node("Level/Inventory/Control")
#@onready var mobs = "res://Mobs/"
@onready var pre_inv = preload("res://UI/invent.tscn")
@onready var pre_item = preload("res://UI/invent_item.tscn")
@onready var world = get_viewport().get_node("Level")
@onready var shop = get_viewport().get_node("Level/Shop2")


var seeker_pos
var armor_index = 1.0
var max_health = 100 * armor_index
var health
var seeker_heat = false
var seeker_heat_area = false
var state = MOVE
var run_speed = 1
var combo = false
var attack_cooldown = false
var inventory
var jump = 1
var direction
var damage_base = 30
var damage_coeff = 1
var damage_curr

var regex_enemi = RegEx.new()

func _ready():
	create_inventory()
	Signals.connect("enemy_attack", Callable(self, "_on_damage_recieved"))
	#Signals.connect("enemy_position_update", Callable(self, "_on_enemy_position_update"))		
	health = max_health
	Global.run_speed = false
	Global.jump = false
	Global.day_count = 0;
	Global.count_bat = 0
	Global.count_skeleton = 0
	Global.count_minotaur = 0
	Global.count_golem = 0
	Global.count_ventoss = 0
	Global.count_dragon = 0
	Global.count_anubis = 0
	armor_index = 1
	damage_coeff = 1

func _physics_process(delta):
	
	damage_curr = damage_base * damage_coeff
	max_health = 100 * armor_index
	
	match state:
		MOVE:
			move_state()
		ATTACK1:
			classic_attack()
		ATTACK2:
			combo_attack()
		ATTACK3:
			combo_attack2()
		DAMAGE:
			damage_state()
		DEATH:
			death_state()
		BLOCK:
			block_state()
		SLIDE:
			slide_state()
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		if Global.jump:
			jump = 1.5
		else:
			jump = 1
		velocity.y = JUMP_VELOCITY * jump
		anim_player.play("Jump")	
			
	if health <= 0:
		health = 0
		state = DEATH

	move_and_slide()
	
	seeker_pos = self.position
	Signals.emit_signal("seeker_position_update", seeker_pos)

		
func pick(item):
	self.inventory.add_item(item)
	return true

func _unhandled_input(event):
	if event.is_action_pressed("inventory"):
		ui.toggle_inventory(inventory)
	if event.is_action_pressed("shop") and (position.x > 950 and position.x < 1050):
		shop.visible = !shop.visible
		

func create_inventory():
	inventory = pre_inv.instantiate()
	add_child(inventory)
	inventory.set_inv_owner(self)

func drop_item(link):
	world.add_lying_item(link, position.x, position.y)
	inventory.remove_item(link)

func update_inventory():
	ui.update_inventory(inventory)

func increase_hp(val):
	self.health = min(self.health + val, self.max_health)
	emit_signal("health_changed", health)

func increase_speed():
	Global.run_speed = true
	$"../Timer_speed".start()

func _on_timer_speed_timeout():
	Global.run_speed = false

func increase_jump():
	Global.jump = true
	$"../Timer_jump".start()

func _on_timer_jump_timeout():
	Global.jump = false

func move_state():
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED * run_speed
		if velocity.y == 0:
			anim_player.play("Run")
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:	
			anim_player.play("default")
			
	if direction == -1:
		anim.flip_h = true
		$AttackDirection.rotation_degrees = 205
		
	elif direction == 1:
		anim.flip_h = false
		$AttackDirection.rotation_degrees = 0
		
	if Input.is_action_pressed("run") and Global.run_speed == false:
		run_speed = 2
		
	else:
		if Global.run_speed == true:
			run_speed = 2.5
		else:
			run_speed = 1
			
	if Input.is_action_just_pressed("attack") and attack_cooldown == false:
		state = ATTACK1
		
	if Input.is_action_pressed("block"):
		state = BLOCK
	
	if Input.is_action_just_pressed("slide") and velocity.x != 0 and velocity.y == 0:
		state = SLIDE
		
func classic_attack():
	damage_coeff = 1
	if Input.is_action_just_pressed("attack") and combo == true:
		state = ATTACK2
	velocity.x = 0
	anim_player.play("Attack1")
	await anim_player.animation_finished
	attack_freeze()
	state = MOVE

func combo_attack():
	damage_coeff = 1.2
	if Input.is_action_just_pressed("attack") and combo == true:
		state = ATTACK3
	anim_player.play("Attack2")
	await anim_player.animation_finished
	state = MOVE

func combo_attack2():
	damage_coeff = 2
	anim_player.play("Attack3")
	await anim_player.animation_finished
	state = MOVE

func combo1():
	combo = true
	await anim_player.animation_finished
	combo = false

func attack_freeze():
	attack_cooldown = true
	await get_tree().create_timer(0.5).timeout
	attack_cooldown = false

func damage_state():
	velocity.x = 0
	anim.play("Damage")
	#await anim.animation_finished
	state = MOVE

func block_state():
	velocity.x = 0
	velocity.y = 0
	anim_player.play("Block")
	if !(Input.is_action_pressed("block")):
		state = MOVE

func slide_state():
	velocity.y = 0
	anim_player.play("Slide")
	await anim_player.animation_finished
	state = MOVE

func death_state():
	velocity.x = 0
	Global.run_speed = false
	Global.jump = false
	Global.day_count = 0;
	Global.count_bat = 0
	Global.count_skeleton = 0
	Global.count_minotaur = 0
	Global.count_golem = 0
	Global.count_ventoss = 0
	Global.count_dragon = 0
	Global.count_anubis = 0
	armor_index = 1
	damage_coeff = 1
	anim.play("Death")
	await get_tree().create_timer(0.7).timeout
	queue_free()
	#get_tree().change_scene_to_file("res://menu.tscn")
	get_tree().change_scene_to_file.bind("res://menu.tscn").call_deferred()

func _on_damage_recieved(enemy_damage, enemy_pos):
	direction = abs(enemy_pos - self.position)
	if state == BLOCK:
			enemy_damage /= 2
	elif state == SLIDE:
		enemy_damage = 0
	if direction.x <= 100:
		health -= enemy_damage
		emit_signal("health_changed", health)
		state = DAMAGE


func _on_hit_box_area_entered(area):
	Signals.emit_signal("player_attack", damage_curr, self.position)
