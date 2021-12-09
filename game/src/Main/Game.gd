extends Node

func _process(delta):
	$CanvasLayer/Score.text = str(Autoload.SCORE_SYSTEM)
