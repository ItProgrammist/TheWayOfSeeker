extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = $AnimatedSprite2D
@onready var seeker = $"."
#@onready var mobs = "res://Mobs/"
var health = 100
var seeker_heat = false
var gold = 0
var seeker_heat_area = false

var regex_enemi = RegEx.new()



func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("ui_seeker_attack"):
		anim.play("Attack")
		seeker_heat = true
		classic_attack(true)
		await anim.animation_finished	
		seeker_heat_area = false
		seeker_heat = false
		
	if seeker_heat == false:
		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			anim.play("Jump")

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
			if velocity.y == 0:
				anim.play("Run")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if velocity.y == 0:	
				anim.play("default")
			
		if direction == -1:
			$AnimatedSprite2D.flip_h = true
		elif direction == 1:
			$AnimatedSprite2D.flip_h = false
		if health  <= 0:
			queue_free()
			get_tree().change_scene_to_file("res://menu.tscn")

	move_and_slide()


#func _on_seeker_attack_body_entered(body):
	#regex_enemi.compile("Skeleton.*")
	#await anim.animation_finished
	#if seekaer_heat_area and regex_enemi.search(body.name):
		##classic_attack()
		##var seeker_direction = (seeker.position - self.position).normalized()
		##var enemy_direction = (body.position - self.position).normalized()	
		##if abs(seeker.position.x - body.position.x) <= 30 \
		##and abs(seeker.position.y - body.position.y) <= 15:
		##and not(seeker_direction.x <= 0 and enemy_direction.x > 0 or seeker_direction.x > 0 and enemy_direction.x <= 0):
			#body.health -= 100
	#seeker_heat_area = false

		
func classic_attack(is_physics_process = false):
	if not(is_physics_process):
		seeker_heat = true
		anim.play("Attack")
		await anim.animation_finished
		seeker_heat = false
	seeker_heat_area = true
