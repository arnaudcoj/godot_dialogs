
extends ParallaxBackground

export var texture = (Texture)

func _ready():
	if texture:
		get_node("parralax_layer/sprite").set_texture(texture)

