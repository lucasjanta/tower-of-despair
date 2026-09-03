extends CharacterBody2D
class_name Player

var dir : float
@onready var state_machine: StateMachine = $StateMachine
@onready var state_label: Label = $Label

@export var speed : float = 150.0
@export var jump_force : float = -250.0
@export var gravity_force : float = 850.0
@export var dash_speed : float = 300.0
@export var equipped_rings : Array[Ring]
@export var bag_rings : Array[Ring]

func _physics_process(delta: float) -> void:
	dir = Input.get_axis("left", "right")
	
	if !is_on_floor():
		velocity.y += delta * gravity_force
		
	move_and_slide()
	state_label.text = state_machine.current_state.name
