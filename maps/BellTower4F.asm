	object_const_def
	const TINTOWER4F_POKE_BALL1
	const TINTOWER4F_POKE_BALL2
	const TINTOWER4F_POKE_BALL3

BellTower4F_MapScripts:
	def_scene_scripts

	def_callbacks

BellTower4FUltraBall:
	itemball ULTRA_BALL

BellTower4FPPUp:
	itemball PP_UP

BellTower4FEscapeRope:
	itemball ESCAPE_ROPE

BellTower4FHiddenMaxPotion:
	hiddenitem MAX_POTION, EVENT_BELL_TOWER_4F_HIDDEN_MAX_POTION

BellTower4F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  4, BELL_TOWER_5F, 2
	warp_event 16,  2, BELL_TOWER_3F, 2
	warp_event  2, 14, BELL_TOWER_5F, 3
	warp_event 17, 15, BELL_TOWER_5F, 4

	def_coord_events

	def_bg_events
	bg_event 11,  6, BGEVENT_ITEM, BellTower4FHiddenMaxPotion

	def_object_events
	object_event 14, 10, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, BellTower4FUltraBall, EVENT_BELL_TOWER_4F_ULTRA_BALL
	object_event 17, 14, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, BellTower4FPPUp, EVENT_BELL_TOWER_4F_PP_UP
	object_event  2, 12, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, BellTower4FEscapeRope, EVENT_BELL_TOWER_4F_ESCAPE_ROPE
