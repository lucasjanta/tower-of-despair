extends Node
class_name State

# Set the base variables
var player : Player
var state_machine : StateMachine

# Set the base functions for the states
func enter(): pass
func exit(): pass
func handle_input(_event): pass
func update(_delta): pass
func physics_update(_delta): pass
