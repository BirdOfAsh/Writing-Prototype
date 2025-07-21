extends CharacterBody3D

@onready var camera : Camera3D = $Camera3D
@onready var page = $Page


var speed : int = 300
var direction : Vector3
var mouseSensitivity = 5


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(delta: float) -> void:
	direction = Vector3.ZERO
	
	if Input.is_action_pressed("Forward"):
		direction.z = -1
	if Input.is_action_pressed("Backward"):
		direction.z = 1
	if Input.is_action_pressed("Right"):
		direction.x = 1
	if Input.is_action_pressed("Left"):
		direction.x = -1
	
	if Input.is_action_just_pressed("Right Click"):
		match Input.mouse_mode:
			0:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
				page.switchStates()
			2:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
				page.switchStates()
	
	if direction != Vector3.ZERO:
		direction = transform.basis * Vector3(direction.x, 0 , direction.z).normalized()
	
	velocity = direction * speed * delta
	move_and_slide()

func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(event.relative.x * -0.005 * mouseSensitivity)
		camera.rotate_x(event.relative.y * -0.005 * mouseSensitivity)
		
		camera.rotation_degrees.x = clampf(camera.rotation_degrees.x, -90, 90)
