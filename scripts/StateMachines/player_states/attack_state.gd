extends State
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var hitbox: Area2D = $"../../Hitbox"
@onready var hitbox_collision: CollisionShape2D = $"../../Hitbox/CollisionShape2D"



func enter():
	player = get_parent().get_parent()
	state_machine = get_parent()
	
	update_animation()
	
	
func update_animation():
	if animated_sprite_2d.flip_h:
		hitbox.scale.x = -1
	else:
		hitbox.scale.x = 1
	animated_sprite_2d.play("attack")
	
func physics_update(_delta):
	player.velocity.x = (player.speed/3) * player.dir
	if animated_sprite_2d.frame == 3:
		hitbox_collision.disabled = false
	if animated_sprite_2d.frame == 6:
		hitbox_collision.disabled = true
	
		state_machine.change_state(state_machine.get_node("IdleState"))
		return
