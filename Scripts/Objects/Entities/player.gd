extends CharacterBody2D

var speed = 2000
var is_idle = false
var is_moving = false
var last_facing_direction: Vector2 = Vector2.DOWN

var is_interacting = false

var input_direction: Vector2 # reference to the input direction that will be set in _process. 

@onready var interaction_ray = $RayCast2D

# Player stats are here until I figure out if they need to be in a seperate script
var hp: int
var sp: int
var xp: int
var lvl: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Poll input in process instead of physics_process for timing purposes
	input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	update_animation()

	var interaction_direction := last_facing_direction
	if input_direction != Vector2.ZERO:
		interaction_direction = input_direction

	interaction_ray.rotation = interaction_direction.angle()
	

	interaction_ray.force_raycast_update()
	if interaction_ray.is_colliding():
		# print("Test")
		var collider = interaction_ray.get_collider()
		if Input.is_action_just_pressed("Interact"):
			if collider != null and collider.has_method("on_interact"):
				collider.on_interact()

func _physics_process(_delta: float) -> void:
	if not is_interacting:
		velocity = input_direction * speed * _delta
		move_and_slide()

func update_animation() -> void:
	# Reuse existing movement state flags so they can be used elsewhere.
	is_moving = input_direction != Vector2.ZERO
	is_idle = not is_moving
	if not is_interacting:
		if is_moving:
			last_facing_direction = input_direction

		if is_moving:
			if abs(input_direction.x) > abs(input_direction.y):
				if input_direction.x > 0:
					$AnimatedSprite2D.play("Walk Side")
					$AnimatedSprite2D.flip_h = false
				else:
					$AnimatedSprite2D.play("Walk Side")
					$AnimatedSprite2D.flip_h = true
					
			else:
				if input_direction.y > 0:
					$AnimatedSprite2D.play("Walk Forward")
				else:
					$AnimatedSprite2D.play("Walk Back")
		else:
			if abs(last_facing_direction.x) > abs(last_facing_direction.y):
				if last_facing_direction.x > 0:
					$AnimatedSprite2D.play("Idle Side")
					$AnimatedSprite2D.flip_h = false
				else:
					$AnimatedSprite2D.play("Idle Side")
					$AnimatedSprite2D.flip_h = true
					
			else:
				if last_facing_direction.y > 0:
					$AnimatedSprite2D.play("Idle Front")
				else:
					$AnimatedSprite2D.play("Idle Back")
