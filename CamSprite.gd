extends Sprite2D

@export var camera_name: String = ""
var camera: CameraFeed

# Called when the node enters the scene tree for the first time.
func _ready():
	print("cameras:")
	for feed in CameraServer.feeds():
		var name = feed.get_name()
		print(name)
		
		# if camera_name is left empty, use the first available camera
		if camera == null and (camera_name == "" or name == camera_name):
			camera = feed
	
	if camera == null:
		print("no matching camera")
		return
		
	print("using camera ", camera, " (", camera.get_name(), ")")
	
	camera.feed_is_active = true
	
	var cam_tex_y = material.get_shader_parameter("camera_y")
	var cam_tex_CbCr = material.get_shader_parameter("camera_CbCr")
	
	cam_tex_y.camera_feed_id = camera.get_id()
	cam_tex_CbCr.camera_feed_id = camera.get_id()
	
	material.set_shader_parameter("camera_y", cam_tex_y)
	material.set_shader_parameter("camera_CbCr", cam_tex_CbCr)

	
