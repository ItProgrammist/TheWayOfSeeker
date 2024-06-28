extends CharacterBody2D

enum {
	DEFAULT,
	ATTACK,
	CHASE,
	DAMAGE,
	DEATH,
	RECOVER
}

#@onready var anim = $AnimatedSprite2D
@onready var animPlayer = $AnimationPlayer
@onready var sprite = $AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var seeker = Vector2.ZERO
var direction = Vector2.ZERO
var enemy_pos

var state: int = 0:
	set(value):
		state = value
		match state:
			DEFAULT:
				default_state()
			ATTACK:
				attack_state()
			CHASE:
				chase_state()
			DAMAGE:
				damage_state()
			DEATH:
				death_state()
			RECOVER:
				recover_state()
			
var chase = false
var speed_base = 30
var speed = 0
var health = 300
var damage = 40

func _ready():
	Signals.connect("seeker_position_update", Callable(self, "_on_seeker_position_update"))
	Signals.connect("player_attack", Callable(self, "_on_damage_recieved"))
	state = CHASE

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	direction = (seeker - self.position).normalized()	
	if direction.x < 0:
		sprite.flip_h = false
		$AttackDirection.rotation_degrees = 200
	else:
		sprite.flip_h = true
		$AttackDirection.rotation_degrees = 0
	velocity.x = direction.x * speed
	
	if health <= 0:
		animPlayer.play(("Death"))
		await animPlayer.animation_finished
		queue_free()
	move_and_slide()
	
	enemy_pos = self.position
	Signals.emit_signal("enemy_position_update", enemy_pos)

# Custom signals
func _on_hit_box_area_entered(area):
	Signals.emit_signal("enemy_attack", damage, enemy_pos)

func _on_seeker_position_update(seeker_pos):
	seeker = seeker_pos

func _on_damage_recieved(player_damage, player_pos):
	if health <= 0:
		state = DEATH
	elif abs(player_pos.x - self.position.x) <= 60 \
	and abs(player_pos.y - self.position.y) <= 20:
		health -= player_damage
		state = DEFAULT
		state = DAMAGE

# In-built signals
func _on_detector_body_entered(body):
	if body.name == "Seeker":
		chase = true
		state = CHASE
		
func _on_detector_body_exited(body):
	if body.name == "Seeker":
		chase = false
		state = DEFAULT
		speed = 0

func _on_attack_body_entered(body):
	state = ATTACK

func death():
	velocity.x = 0	
	speed = 0
	animPlayer.play(("Death"))
	await animPlayer.animation_finished
	queue_free()

func default_state():
	velocity.x = 0
	speed = 0
	animPlayer.play("default")
	await get_tree().create_timer(0.7).timeout
	$AttackDirection/Attack/CollisionShape2D.disabled = false	
	state = CHASE

func attack_state():
	velocity.x = 0	
	speed = 0
	animPlayer.play("default")
	await get_tree().create_timer(0.7).timeout
	animPlayer.play("Attack")
	await animPlayer.animation_finished
	$AttackDirection/Attack/CollisionShape2D.disabled = true
	state = DEFAULT

func chase_state():
	direction = (seeker - self.position).normalized()
	if direction.x < 0:
		sprite.flip_h = true
		$AttackDirection.rotation_degrees = 200
	else:
		sprite.flip_h = false
		$AttackDirection.rotation_degrees = 0
	if chase:
		animPlayer.play("Run")
		speed = speed_base
	else:
		velocity.x = 0
		speed = 0
	
func damage_state():
	#animPlayer.play("Damage")
	#await animPlayer.animation_finished
	state = DEFAULT

func death_state():
	animPlayer.play("Death")
	await animPlayer.animation_finished
	queue_free()
	
func recover_state():
	animPlayer.play("Recover")
	await animPlayer.animation_finished
	state = DEFAULT
