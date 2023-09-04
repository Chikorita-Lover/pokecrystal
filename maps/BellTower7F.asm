	object_const_def
	const TINTOWER7F_POKE_BALL

BellTower7F_MapScripts:
	def_scene_scripts

	def_callbacks

BellTower7FMaxRevive:
	itemball MAX_REVIVE

BellTower7F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  9, BELL_TOWER_6F, 1
	warp_event 10, 15, BELL_TOWER_8F, 1
	warp_event 12,  7, BELL_TOWER_7F, 4
	warp_event  8,  3, BELL_TOWER_7F, 3
	warp_event  6,  9, BELL_TOWER_9F, 5

	def_coord_events

	def_bg_events

	def_object_events
	object_event 16,  1, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, BellTower7FMaxRevive, EVENT_BELL_TOWER_7F_MAX_REVIVE
