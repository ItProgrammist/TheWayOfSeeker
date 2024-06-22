extends CharacterBody2D

signal health_changed (new_health)

enum{
	MOVE,
	ATTACK1,
	ATTACK2,
	ATTACK3,
	DAMAGE,
	DEATH
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

var seeker_pos
var armor_index = 1.0
var max_health = 100 * armor_index
var health
var seeker_heat = false
var gold = 0
var seeker_heat_area = false
var state = MOVE
var run_speed = 1
var combo = false
var attack_cooldown = false
var inventory


var regex_enemi = RegEx.new()
	
func _ready():
	create_inventory()
	Signals.connect("enemy_attack", Callable(self, "_on_damage_recieved"))
	health = max_health

func _physics_process(delta):
	
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
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
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

func create_inventory():
	inventory = pre_inv.instantiate()
	add_child(inventory)
	inventory.set_inv_owner(self)

func drop_item(link):
	world.add_lying_item(link, position.x, position.y)
	inventory.remove_item(link)

func update_inventory():
	ui.update_inventory(inventory)

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
	elif direction == 1:
		anim.flip_h = false
	if Input.is_action_pressed("run"):
		run_speed = 2
	else:
		run_speed = 1
	if Input.is_action_just_pressed("attack") and attack_cooldown == false:
		state = ATTACK1
		
func classic_attack():
	if Input.is_action_just_pressed("attack") and combo == true:
		state = ATTACK2
	velocity.x = 0
	anim_player.play("Attack1")
	await anim_player.animation_finished
	attack_freeze()
	state = MOVE

func combo_attack():
	if Input.is_action_just_pressed("attack") and combo == true:
		state = ATTACK3
	anim_player.play("Attack2")
	await anim_player.animation_finished
	state = MOVE

func combo_attack2():
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

func death_state():
	velocity.x = 0
	anim.play("Death")
	await get_tree().create_timer(0.7).timeout
	queue_free()
	#get_tree().change_scene_to_file("res://menu.tscn")
	get_tree().change_scene_to_file.bind("res://menu.tscn").call_deferred()

func _on_damage_recieved(enemy_damage):
	health -= enemy_damage
	emit_signal("health_changed", health)
	state = DAMAGE
	
