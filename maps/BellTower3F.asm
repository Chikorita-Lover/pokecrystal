	object_const_def
	const TINTOWER3F_POKE_BALL

BellTower3F_MapScripts:
	def_scene_scripts

	def_callbacks

BellTower3FFullHeal:
	itemball FULL_HEAL

BellTower3F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 10, 14, BELL_TOWER_2F, 1
	warp_event 16,  2, BELL_TOWER_4F, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3, 14, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, BellTower3FFullHeal, EVENT_BELL_TOWER_3F_FULL_HEAL
