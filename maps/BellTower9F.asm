	object_const_def
	const TINTOWER9F_POKE_BALL

BellTower9F_MapScripts:
	def_scene_scripts

	def_callbacks

BellTower9FHPUp:
	itemball HP_UP

BellTower9F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 12,  3, BELL_TOWER_8F, 2
	warp_event  2,  5, BELL_TOWER_8F, 3
	warp_event 12,  7, BELL_TOWER_8F, 4
	warp_event  7,  9, BELL_TOWER_ROOF, 1
	warp_event 16,  7, BELL_TOWER_7F, 5
	warp_event  6, 13, BELL_TOWER_8F, 5
	warp_event  8, 13, BELL_TOWER_8F, 6

	def_coord_events

	def_bg_events

	def_object_events
	object_event  9,  1, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, BellTower9FHPUp, EVENT_BELL_TOWER_9F_HP_UP
