extends Lifetime
class_name LifetimeDisappear

func on_lifetime_out():
	owner.queue_free()
