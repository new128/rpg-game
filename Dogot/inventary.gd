"""
ИНВЕНТАРЮ

Как выгледит инвентарь:
	
				Головной убор
				Плечи: наплечники, плащ
	Оружие		Туловище(и не только ещё ноги и руки это один слот, ПОКА): броня, мантии			Оружие:
				Ботинки

"""

#var inventary = preload("res://inventary.gd")  создание объекта этого класса
var Item = preload("res://item.gd") 

var head = null

var shoulders = null

var weapon = null

var torso = null

var shoes = null # обувь

var consumables = [] # расходники по типу кларетки и фласки в доте. максимально 3 штуки



func _init(head_, shoulders_, weapon_, torso_, shoes_, consumables_):
	var head =  head_

	var shoulders = shoulders_

	var weapon = weapon_

	var torso = torso_

	var shoes = shoes_ # обувь
	
	var consumables = []