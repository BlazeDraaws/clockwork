extends Node

class_name PlayerManager
@export var ConnectedPlayer:Node2D

signal _universal_beat_reciever(real_value:float, swinging:bool, is_pull_mode:bool, speed:float, drag:float, notetype:int)
