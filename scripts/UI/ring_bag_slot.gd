extends PanelContainer
@onready var ring_image: TextureRect = $Ring/RingImage
@onready var ring_name_label: Label = $Ring/VBoxContainer/RingNameLabel
@onready var power_stage_label: Label = $Ring/HBoxContainer/PowerStageLabel
@onready var uses_label: Label = $Ring/HBoxContainer/UsesLabel

@onready var ring_container: MarginContainer = $Ring
@onready var empty_container: MarginContainer = $Empty

func setup(ring : Ring):
	if !ring:
		empty_container.visible = true
		ring_container.visible = false
		return
	else:
		empty_container.visible = false
		ring_container.visible = true
		
	ring_name_label.text = ring.ring_name
	match ring.power_stage:
		0:
			power_stage_label.text = "Basic"

		1:
			power_stage_label.text = "Experienced"

		2:
			power_stage_label.text = "Ancient"
	
	uses_label.text = "%s/%s" %[ring.uses, ring.max_uses]
	
	if ring.texture != null:
		ring_image.texture = ring.texture
