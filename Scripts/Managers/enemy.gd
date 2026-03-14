class_name Enemy extends StaticBody2D

var health: int
var points_awarded: int


func Death() -> void:
	var explosion = Global.explosion_animation.instantiate()
	get_parent().add_child(explosion)
	explosion.transform = self.global_transform
	queue_free()


func Update(_delta: float) -> void:
	if health == 0:
		Global.score += points_awarded
		print(Global.score)
		Death()
	pass
