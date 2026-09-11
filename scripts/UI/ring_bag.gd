extends PanelContainer
@onready var inv_anim: AnimationPlayer = $InvAnim
@onready var rings_container: GridContainer = $MarginContainer/VBoxContainer/RingsContainer
@onready var player: Player = $"../.."

const RING_BAG_SLOT = preload("uid://o028ktbdtgvh")
var opened := false

func populate_rings(rings : Array[Ring]):
	for child in rings_container.get_children():
		child.free()
	
	for i in player.ring_inventory.size():
		var new_slot = RING_BAG_SLOT.instantiate()
		rings_container.add_child(new_slot)
		new_slot.setup(rings[i])


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ring_bag"):
		if !opened:
			populate_rings(player.ring_inventory)
			inv_anim.play("ring_bag_in")
			opened = true
			get_tree().paused = true
		else:
			inv_anim.play("ring_bag_out")
			opened = false
			get_tree().paused = false

		
		
