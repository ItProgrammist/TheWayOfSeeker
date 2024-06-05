extends CharacterBody2D


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var chase = false
var speed = 100
var health = 60

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
		if chase == true:
			velocity.x = direction.x * speed
			anim.play("Run")
		
		else:
			velocity.x = 0	
			anim.play("default")
		
		if direction.x < 0:
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
		attack(body)
		
		
		#death()
		

func attack(body):
	seeker_is_damaged = true
	anim.play("Attack")
	await anim.animation_finished
	var seeker_direction = (seeker.position - self.position).normalized()
	var skeleton_direction = (skeleton.position - self.position).normalized()	
	if alive and abs(seeker.position.x - skeleton.position.x) <= 30 \
	and abs(seeker.position.y - skeleton.position.y) <= 15 \
	and not(seeker_direction.x <= 0 and skeleton_direction.x > 0 or seeker_direction.x > 0 and skeleton_direction.x <= 0):
			body.health -= 20
	seeker_is_damaged = false
	

func death():
	alive = false
	anim.play(("Death"))
	await anim.animation_finished
	queue_free()


	
