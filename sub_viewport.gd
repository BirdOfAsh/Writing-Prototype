extends SubViewport

@onready var writing_canvas: Node2D = $"Writing Canvas"


func setSize(x : int, y : int):
	size.x = x
	size.y = y


func drawAtPosition(drawPosition : Vector2):
	writing_canvas.drawAt(drawPosition)


func endDraw():
	writing_canvas.drawEnd()


func swapColor():
	writing_canvas.swapColor()
