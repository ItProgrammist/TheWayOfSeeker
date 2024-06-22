extends CharacterBody2D

enum {
	DEFAULT,
	ATTACK,
	CHASE
}

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var seeker 
var direction
var damage = 15

func _ready():
	Signals.connect("seeker_position_update", Callable(self, "_on_seeker_position_update"))

var state: int = 0:
	set(value):
		state = value
		match state:
			DEFAULT:
				default_state()
			ATTACK:
				attack_state()
			
var chase = false
var speed = 80
var health = 60

#@onready var anim = $AnimatedSprite2D
@onready var animPlayer = $AnimationPlayer

@onready var sprite = $AnimatedSprite2D
var alive = true
var seeker_is_damaged = false
#@onready var seeker = $"../../Seeker/Seeker"
@onready var skeleton = $"."


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if state == CHASE:
		chase_state()
	
	#var direction = (seeker.position - self.position).normalized()
	#if alive and seeker_is_damaged == false and health > 0:
		#if chase:
			#velocity.x = direction.x * speed
			#anim.play("Run")
		#
		#else:
			#velocity.x = 0	
			#anim.play("default")
			
		
		#if direction.x < 0:
			#$AnimatedSprite2D.flip_h = true
			#
		#else:
			#$AnimatedSprite2D.flip_h = false
	
	if health <= 0:
		animPlayer.play(("Death"))
		await animPlayer.animation_finished
		queue_free()
	move_and_slide()

func _on_seeker_position_update(seeker_pos):
	seeker = seeker_pos

func _on_detector_body_entered(body):
	chase = true
		

func _on_detector_body_exited(body):
	chase = false

func _on_attack_body_entered(body):
	state = ATTACK
		
		

#func attack(body):
	#seeker_is_damaged = true
	#await get_tree().create_timer(0.7).timeout
	#anim.play("Attack")
	#await anim.animation_finished	
	#if alive and abs(seeker.position.x - skeleton.position.x) <= 60 \
	#and abs(seeker.position.y - skeleton.position.y) <= 15:
			#body.health -= 15
	#seeker_is_damaged = false

func death():
	alive = false
	animPlayer.play(("Death"))
	await animPlayer.animation_finished
	queue_free()

func default_state():
	animPlayer.play("default")
	await get_tree().create_timer(0.7).timeout
	$AttackDirection/Attack/CollisionShape2D.disabled = false	
	state = CHASE

func attack_state():
	animPlayer.play("Attack")
	await animPlayer.animation_finished
	$AttackDirection/Attack/CollisionShape2D.disabled = true
	state = DEFAULT

func chase_state():
	direction = (seeker - self.position).normalized()
	if direction.x < 0:
		sprite.flip_h = true
		$AttackDirection.rotation_degrees = 180
	else:
		sprite.flip_h = false
		$AttackDirection.rotation_degrees = 0
		

func _on_hit_box_area_entered(area):
	Signals.emit_signal("enemy_attack", damage)
