extends Enemy

@onready var state_label: Label = $StateLabel
@onready var state_machine: StateMachine = $StateMachine


@export var player_ref : Player
var ring_max_cd := 5.0
var ring_cd := 0.0
var basic_attack_max_cd := 3.0
var basic_attack_cd := 0.0
var special_attack_max_cd := 5.0
var special_attack_cd := 0.0
var distance_to_player : float

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += delta * 850.0
	move_and_slide()
	
	distance_to_player = global_position.distance_to(player_ref.global_position)

	if ring_cd > 0.0:
		ring_cd -= delta
	else:
		ring_cd = 0.0
		
	if basic_attack_cd > 0.0:
		basic_attack_cd -= delta
	else:
		basic_attack_cd = 0.0
		
	if special_attack_cd > 0.0:
		special_attack_cd -= delta
	else:
		special_attack_cd = 0.0
		
	state_label.text = state_machine.current_state.name
