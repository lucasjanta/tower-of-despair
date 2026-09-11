extends CharacterBody2D
class_name Player

var dir : float
@onready var state_machine: StateMachine = $StateMachine
@onready var state_label: Label = $Label
@onready var player_hud: Control = $CanvasLayer/PlayerHUD
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hit_label: Label = $HitLabel


@export var speed : float = 150.0
@export var jump_force : float = -250.0
@export var gravity_force : float = 850.0
@export var dash_speed : float = 300.0

@export var equipped_rings : Array[Ring] = []
@export var bag_rings : Array[Ring]

@export var max_hp : float = 100.0
var hp : float
var dash_used := false
var dash_cd := 5.0
var cd = 5.0

func _ready() -> void:
	hp = max_hp
	player_hud.update_hp()
	

func _physics_process(delta: float) -> void:
	dir = Input.get_axis("left", "right")
	
	if !is_on_floor():
		velocity.y += delta * gravity_force
		
	move_and_slide()
	state_label.text = state_machine.current_state.name
	if dash_used and cd < dash_cd:
		cd += delta
	if cd >= dash_cd:
		dash_used = false
		cd = dash_cd
		
func take_damage(dmg):
	hp -= dmg
	hit_label.text = str(dmg)
	animation_player.play("take_dmg")
	player_hud.update_hp()
	if hp <= 0.0:
		print("player died")

func equip_ring(ring: Ring) -> void:
	if equipped_rings.size() >= 2:
		return

	equipped_rings.append(ring)
	ring.apply_passive(self)


func unequip_ring(index: int) -> void:
	if index < 0 or index >= equipped_rings.size():
		return

	var ring := equipped_rings[index]

	ring.remove_passive(self)
	equipped_rings.remove_at(index)
	
func use_ring(index: int) -> void:
	if index < 0 or index >= equipped_rings.size():
		return

	var ring := equipped_rings[index]

	if not ring.can_use():
		return

	ring.use(self)
	ring.consume_use()
