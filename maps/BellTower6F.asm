	object_const_def
	const TINTOWER6F_POKE_BALL

BellTower6F_MapScripts:
	def_scene_scripts

	def_callbacks

BellTower6FMaxPotion:
	itemball MAX_POTION

BellTower6F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  9, BELL_TOWER_7F, 1
	warp_event 11, 15, BELL_TOWER_5F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  8,  8, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, BellTower6FMaxPotion, EVENT_BELL_TOWER_6F_MAX_POTION
