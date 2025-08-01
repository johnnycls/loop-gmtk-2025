extends Node

var COLORS: Dictionary = {
	"red": Color("#f04242"),
	"orange": Color("#f07c42"),
	"blue": Color("#1f8cf9"),
	"green": Color("#06e073"),
	"purple": Color("ccbddb"),
}

var ATTRIBUTES: Dictionary = {
  "attack": {
	"basic_value": 5,
	"increase_value": 2.5,
	"max_level": 10,
	"cost": func(level: int): return 1.2 ** level * 25,
  },
  "defense": {
	"basic_value": 4,
	"increase_value": 2,
	"max_level": 10,
	"cost": func(level: int): return 1.2 ** level * 25,
  },
  "hp": {
	"basic_value": 10,
	"increase_value": 5,
	"max_level": 10,
	"cost": func(level: int): return 1.2 ** level * 25,
  },
  "speed": {
	"basic_value": 1,
	"increase_value": 0.25,
	"max_level": 10,
	"cost": func(level: int): return 1.2 ** level * 25,
  },
};
