extends State
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"


func enter():
	player = get_parent().get_parent()
	state_machine = get_parent()
	update_animation()
	
func update_animation():
	animated_sprite_2d.play("idle")

func physics_update(_delta):
	if player.dir != 0:
		state_machine.change_state(state_machine.get_node("WalkState"))
		return
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		state_machine.change_state(state_machine.get_node("JumpState"))
		return
	if Input.is_action_just_pressed("attack"):
		state_machine.change_state(state_machine.get_node("AttackState"))
		return
