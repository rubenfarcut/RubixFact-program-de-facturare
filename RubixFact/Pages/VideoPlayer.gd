extends VideoPlayer
func _enter_tree():
	self.play()
func _ready():
	OS.window_maximized=true
func _on_VideoPlayer_finished():
	#warning-ignore:unused_variable
	var ch=SceneTransition.change_scene("res://Pages/facts.tscn")
	
