extends Node2D

var colors : Dictionary[String, Color] =  {"black" : Color.BLACK, "white" : Color.WHITE}
var activeColor : String = "white"

var stroakDict : Dictionary[int, Array] = {0 : []}
var vec2Array : Array[Vector2] = []

func drawAt(posToDraw : Vector2):
	vec2Array.append(posToDraw)
	stroakDict.set(stroakDict.size() - 1, [vec2Array.duplicate(), activeColor])
	
	drawFromPositionList() #redraw everything


func drawEnd() -> void:
	vec2Array.clear()
	stroakDict.set(stroakDict.size(), [[], "transparent"])



## this function clears the draw and then redraws every line in all stroak lists in the current draw position list
func drawFromPositionList() -> void:
	queue_redraw()
	await self.draw
	
	#draw every stroak stored in the dictionary
	for stroak in stroakDict:
		for drawPosition in range(0, stroakDict[stroak][0].size() - 1):
			draw_line(stroakDict[stroak][0][drawPosition], stroakDict[stroak][0][drawPosition + 1], colors[stroakDict[stroak][1]], 5)
	
	#draw current stroak
	for vec2Position in range(0, vec2Array.size() -1):
		draw_line(vec2Array[vec2Position], vec2Array[vec2Position + 1], colors[activeColor], 5)


func swapColor(): #prob a temperary function
	match activeColor:
		
		"white":
			activeColor = "black"
			print("black")
		
		"black":
			activeColor = "white"
			print("White")
