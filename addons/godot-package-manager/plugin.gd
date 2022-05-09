tool
extends EditorPlugin

const Main := preload("res://addons/godot-package-manager/main.tscn")
const GPM := preload("res://addons/godot-package-manager/godot_package_manager.gd")

const TOOLBAR_NAME := "Package Manager"

var main

var gpm: GPM

var num_packages_in_update: int = -1

enum PackageOpts {
	Status,
	Update
}
const PACKAGES_BUTTON_NAME := "Packages"
const PURGE_SUBMENU_NAME := "Purge"
var packages_button: MenuButton

const GPM_IDENTIFIER := "[GPM]"
var rtl: RichTextLabel

func _enter_tree():
	main = Main.instance()
	inject_tool(main)

	add_control_to_bottom_panel(main, TOOLBAR_NAME)

func _exit_tree():
	if main != null:
		remove_control_from_bottom_panel(main)
		main.free()

func inject_tool(node: Node) -> void:
	"""
	Inject `tool` at the top of the plugin script
	"""
	var script: Script = node.get_script().duplicate()
	script.source_code = "tool\n%s" % script.source_code
	script.reload(false)
	node.set_script(script)
