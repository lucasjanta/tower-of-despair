extends State
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func enter():
	player = get_parent().get_parent()
	state_machine = get_parent()
	player.velocity.y = player.jump_force
	
func update_animation():
	if player.dir > 0:
		animated_sprite_2d.flip_h = false
	elif player.dir < 0:
		animated_sprite_2d.flip_h = true
	
	if player.velocity.y < 0:
		animated_sprite_2d.play("jump")
	if player.velocity.y > 0:
		animated_sprite_2d.play("fall")
	#if player.is_on_floor():
		#animated_sprite_2d.play("land")
	
		
func physics_update(_delta):
	update_animation()
	player.velocity.x = player.dir * player.speed
	
	if player.is_on_floor():
		state_machine.change_state(state_machine.get_node("IdleState"))

	if Input.is_action_just_pressed("dash") and !player.dash_used:
		state_machine.change_state(state_machine.get_node("DashState"))
		return
