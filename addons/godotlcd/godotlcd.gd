tool
extends EditorPlugin

func _enter_tree():
    add_custom_type("LCDSprite", "Sprite", preload("lcd_sprite.gd"), preload("icons/icon_sprite.svg"))

func _exit_tree():
    remove_custom_type("LCDSprite")