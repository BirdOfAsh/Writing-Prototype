extends Node2D


var drawPositionArray : Array[Array] = [ [] ] #Array containing Vector2 arrays pertaining to positions


func drawAt(posToDraw : Vector2):
	drawPositionArray[-1].append(posToDraw) #add a position to the current stroak
		
	drawFromPositionList() #redraw everything


func drawEnd():
	drawPositionArray.append( [] ) #add a new empty array for the next draw stroak


## this function clears the draw and then redraws every line in all stroak lists in the current draw position list
func drawFromPositionList():
	queue_redraw()
	await self.draw
	
	# go through all arrays for each stroak and draw lines connected between the points
	for stroakList : Array[Vector2] in drawPositionArray:
		for drawPosition in range(0,stroakList.size() - 1):
			draw_line(stroakList[drawPosition], stroakList[drawPosition + 1], Color.WHITE, 5)
