extends SubViewport

@onready var writingCanv: writingCanvas = $"writingCanvas"


func setSize(x : int, y : int):
	size.x = x
	size.y = y


func setWritingCanvasPosition():
	writingCanv.position = self.size / 2


func drawAtPosition(drawPosition : Vector2):
	writingCanv.updateDrawTexture(drawPosition)


func swapColor():
	writingCanv.swapColor()
