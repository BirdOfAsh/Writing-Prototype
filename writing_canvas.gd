extends Node2D

var colors : Dictionary[String, Color] =  {"black" : Color.BLACK, "white" : Color.WHITE}
var activeColor : String = "white"

var strokeDict : Dictionary[int, Array] = {0 : []}
var vec2Array : Array[Vector2] = []


func drawAt(posToDraw : Vector2) -> void:
	vec2Array.append(posToDraw)
	strokeDict.set(strokeDict.size() - 1, [vec2Array.duplicate(), activeColor])
	
	drawFromPositionList() #redraw everything


func drawEnd() -> void:
	vec2Array.clear()
	strokeDict.set(strokeDict.size(), [[], "transparent"])


## this function clears the draw and then redraws every line in all stroak lists in the current draw position list
func drawFromPositionList() -> void:
	queue_redraw()
	await self.draw
	
	#draw every stroak stored in the dictionary
	for stroke in strokeDict:
		for drawPosition in range(0, strokeDict[stroke][0].size() - 1):
			draw_line(strokeDict[stroke][0][drawPosition], strokeDict[stroke][0][drawPosition + 1], colors[strokeDict[stroke][1]], 5)


func undoLastStroak():
	if strokeDict.size() - 1 != 0:
		strokeDict.set(strokeDict.size() - 2, strokeDict[strokeDict.size() - 1])
		strokeDict.erase(strokeDict.size() - 1)
		drawFromPositionList()


func swapColor() -> void: #prob a temperary function
	match activeColor:
		
		"white":
			activeColor = "black"
			print("black")
		
		"black":
			activeColor = "white"
			print("white")
