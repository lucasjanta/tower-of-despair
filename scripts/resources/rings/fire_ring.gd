extends Ring
class_name FireRing
const FIREBALL = preload("uid://dactt5mwm51ln")


func use(player: Player) -> void:
	var new_fireball = FIREBALL.instantiate()
	new_fireball.dir = -1 if player.animated_sprite_2d.flip_h else 1
	new_fireball.global_position = player.global_position - Vector2(5, 0) if player.animated_sprite_2d.flip_h else player.global_position + Vector2(5, 0)
	player.get_parent().add_child(new_fireball)
