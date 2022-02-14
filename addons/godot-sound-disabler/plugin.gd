tool
extends EditorPlugin

var enabled = true

func cleanup():
	remove_tool_menu_item("Enable editor sounds")
	remove_tool_menu_item("Disable editor sounds")

func activate(ud = null):
	self.cleanup()

	if enabled:
		enabled = false
		ProjectSettings["audio/driver"] = "dummy"
		AudioServer.set_device("dummy")
		AudioServer.lock()
		AudioServer.set_bus_mute(0, true)
		add_tool_menu_item("Enable editor sounds", self, "activate")

	else:
		enabled = true
		AudioServer.unlock()
		AudioServer.set_device("Default")
		ProjectSettings["audio/driver"] = "Default"
		AudioServer.set_bus_mute(0, false)
		add_tool_menu_item("Disable editor sounds", self, "activate")

func _enter_tree():
	enabled = true
	add_tool_menu_item("Disable editor sounds", self, "activate")

func _exit_tree():
	self.cleanup()
