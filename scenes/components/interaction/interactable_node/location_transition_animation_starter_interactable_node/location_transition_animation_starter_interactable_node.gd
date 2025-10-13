extends InteractableNode



	
	
		
func interact(interactor):
	super.interact(interactor)
	animation_signal.emit("mario_fade", 0.75)
	animation_signal.emit("location_transition")
	
		
