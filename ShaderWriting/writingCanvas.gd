class_name writingCanvas
extends Node2D

@onready var sprite : Sprite2D = $Sprite2D
@onready var sprite_mat : ShaderMaterial = $Sprite2D.material

@export_range(3, 61, 2) var pixelSize : float

var imageSize : Vector2i
var drawTexture : ImageTexture
var activeColor : Color = Color.WHITE


func _ready() -> void:
	SignalBus.connect("updateImageSize", updateImageSize)


func checkToPlacePixel(posToPlace : Vector2i, image : Image):
	if posToPlace.x < 0 or posToPlace.y < 0 or posToPlace.x >= sprite.texture.get_size().x or posToPlace.y >= sprite.texture.get_size().y: #check if within bounds
		return
	
	image.set_pixel(posToPlace.x, posToPlace.y, activeColor)


func updateDrawTexture(pixelPos : Vector2):
	var image : Image = drawTexture.get_image()
	
	var pixelX : int = int(pixelPos.x)
	var pixelY : int =  int(pixelPos.y)
	
	for row in range(-((pixelSize - 1) / 2), (pixelSize - 1) / 2):
		checkToPlacePixel(Vector2i(pixelX + row, pixelY), image)
		for col in range(-((pixelSize - 1) / 2), (pixelSize - 1) / 2):
			checkToPlacePixel(Vector2i(pixelX + row, pixelY + col), image)
	
	drawTexture.update(image)
	
	sprite_mat.set_shader_parameter("drawTexture", drawTexture)


func updateImageSize(size : Vector2i):
	imageSize = size
	drawTexture = ImageTexture.create_from_image(Image.create_empty(imageSize.x, imageSize.y, false, Image.FORMAT_RGBA8))
	sprite.texture = drawTexture
	sprite_mat.set_shader_parameter("drawTexture", drawTexture)


func swapColor():
	match activeColor:
			Color.WHITE:
				activeColor = Color.TRANSPARENT
			Color.TRANSPARENT:
				activeColor = Color.WHITE
