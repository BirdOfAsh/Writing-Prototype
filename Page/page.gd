extends Node3D

@onready var viewport : SubViewport = %SubViewport
@onready var collisionShape : CollisionShape3D = %CollisionShape3D

@export_range(50.0, 1000, 50.0) var height : float = 500.0
@export_range(50.0, 500.0, 50.0) var width : float = 500.0

var worldMousePos
var origin : Vector2
var difference : Vector2
var drawPosition
var ratio = 500 # the ratio from size to width/length is 500

var transitionTween : Tween
var active : bool = false

## All of these variables are for creating a raycast from the camera
var cam
var mousePos
var stateInSpace
var rayOrigin
var rayEnd
var rayQuery
var resultingRay

var raycastResult


func _ready() -> void:
	viewport.setSize(width, height)
	viewport.setWritingCanvasPosition()
	SignalBus.emit_signal("updateImageSize", Vector2i(int(width / 5), int(height / 5)))
	
	setCollisionShapeSize(width, height)
	getOrigin()


func _process(_delta: float) -> void:
	if Input.is_action_pressed("Left Click"):
		drawPosition = findDifference()
		if drawPosition != null:
			#print(drawPosition)
			viewport.drawAtPosition(drawPosition)

	if Input.is_action_just_pressed("Swap"):
			viewport.swapColor()
	


func raycastOnMousePosition(): #function that creates a raycast from the camera to a space in the 3D world based on the mouse position
	cam = get_viewport().get_camera_3d()
	mousePos = get_viewport().get_mouse_position()
	stateInSpace = get_world_3d().get_direct_space_state()

	
	rayOrigin = cam.project_ray_origin(mousePos)
	rayEnd = rayOrigin + cam.project_ray_normal(mousePos) * 100
	rayQuery = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd, 1) #this last parameter determines which collision layer to hit
	rayQuery.collide_with_areas = true
	
	if (stateInSpace.intersect_ray(rayQuery)) == { }: #if the raycast missed
		return
	
	resultingRay = to_local(stateInSpace.intersect_ray(rayQuery).position)
	return(resultingRay)


func getMouseWorldPosition(): #gets a vector3 based on the camera raycast
	if raycastOnMousePosition() == null:
		return
		
	raycastResult = raycastOnMousePosition()

	
	return Vector2(raycastResult.x,raycastResult.y)


func getOrigin() -> Vector2: #returns a Vector2 of the top left corner of the page's collision shape
	origin = Vector2(collisionShape.position.x - (collisionShape.shape.size.x / 2), collisionShape.position.y - (collisionShape.shape.size.y / 2))
	return origin


func findDifference(): #return the difference from the origin and the point of the mouse
	worldMousePos = getMouseWorldPosition()
	if worldMousePos == null:
		return

	difference = Vector2( abs(worldMousePos.x - getOrigin().x), abs(getOrigin().y + worldMousePos.y) )
	return difference * 100


func setCollisionShapeSize(x : float, y : float):
	collisionShape.shape.size.x = x / ratio
	collisionShape.shape.size.y = y / ratio


func switchStates():
	if active:
		transitionTween = get_tree().create_tween()
		transitionTween.set_parallel()
		transitionTween.tween_property(self, "position", Vector3(-0.782, -0.37, -1.0), 0.25)
		transitionTween.tween_property(self, "rotation_degrees", Vector3(-45, 0, 0), 0.25)
		active = false
	else:
		transitionTween = get_tree().create_tween()
		transitionTween.set_parallel()
		transitionTween.tween_property(self, "position", Vector3(-1, 0.0, -1.272), 0.25)
		transitionTween.tween_property(self, "rotation_degrees", Vector3(0, 0, 0), 0.25)
		active = true
