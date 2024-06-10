extends CharacterBody2D


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var chase = false
var chase_attack = false
var speed = 80
var health = 100

@onready var anim = $AnimatedSprite2D
var alive = true
var seeker_is_damaged = false
@onready var seeker = $"../../Seeker/Seeker"
@onready var skeleton = $"."


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	var direction = (seeker.position - self.position).normalized()
	if alive and seeker_is_damaged == false and health > 0:
		if chase:
			velocity.x = direction.x * speed
			anim.play("default")
		
		else:
			velocity.x = 0	
			anim.play("default")
			
		if chase_attack:
			attack(seeker)
			
		
		if direction.x > 0:
			$AnimatedSprite2D.flip_h = true
			
		else:
			$AnimatedSprite2D.flip_h = false
	
	if health <= 0:
		anim.play(("Death"))
		await anim.animation_finished
		queue_free()
	move_and_slide()

func _on_detector_body_entered(body):
	if body.name == "Seeker":
		chase = true
		



func _on_detector_body_exited(body):
	if body.name == "Seeker":
		chase = false


func _on_death_body_entered(body):
	if body.name == "Seeker":
		body.velocity.y -= 300
		death()

func _on_attack_body_entered(body):
	if body.name == "Seeker":
		chase_attack = true
		chase = false
		
func _on_attack_body_exited(body):
	if body.name == "Seeker":
		chase = true
		chase_attack = false
		
		

func attack(body):
	seeker_is_damaged = true
	await get_tree().create_timer(0.7).timeout
	anim.play("Attack")
	await anim.animation_finished
	var seeker_direction = (seeker.position - self.position).normalized()
	var skeleton_direction = (skeleton.position - self.position).normalized()	
	if alive and abs(seeker.position.x - skeleton.position.x) <= 30 \
	and abs(seeker.position.y - skeleton.position.y) <= 15:
			body.health -= 20
	seeker_is_damaged = false

func death():
	alive = false
	anim.play(("Death"))
	await anim.animation_finished
	queue_free()
