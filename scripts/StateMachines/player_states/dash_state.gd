extends State
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var dash_timer: Timer = $dash_timer
@onready var hurtbox_collision: CollisionShape2D = $"../../Hurtbox/CollisionShape2D"


func enter():
	player = get_parent().get_parent()
	state_machine = get_parent()
	update_animation()
	dash_timer.start()
	hurtbox_collision.disabled = true
	player.dash_used = true
	player.cd = 0.0
	if !animated_sprite_2d.flip_h:
		player.velocity.x = player.dash_speed
	else:
		player.velocity.x = -player.dash_speed
	
func update_animation():
	animated_sprite_2d.play("dash")


func _on_dash_timer_timeout() -> void:
	state_machine.change_state(state_machine.get_node("IdleState"))
	return
	
func physics_update(_delta):
	player.velocity.y = 0

func exit():
	hurtbox_collision.disabled = false
