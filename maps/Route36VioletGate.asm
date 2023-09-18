	object_const_def
	const ROUTE36VIOLETGATE_OFFICER
	const ROUTE36VIOLETGATE_SUPER_NERD

Route36VioletGate_MapScripts:
	def_scene_scripts

	def_callbacks

Route36VioletGateOfficerScript:
	checkevent EVENT_FOUGHT_SUDOWOODO
	iftrue .things_are_busy
	jumptextfaceplayer Route36VioletGateOfficerDontSeePeopleText
.things_are_busy
	jumptextfaceplayer Route36VioletGateOfficerThingsAreBusyText

Route36VioletGateSuperNerdScript:
	jumptextfaceplayer Route36VioletGateSuperNerdText

Route36VioletGateOfficerDontSeePeopleText:
	text "Lately, I don't see"
	line "people coming from"
	cont "GOLDENROD CITY."
	done

Route36VioletGateOfficerThingsAreBusyText:
	text "Things are busy"
  line "lately, because we"
  cont "have many people"

  para "coming from"
  line "GOLDENROD and"
  cont "ECRUTEAK!"
	done

Route36VioletGateSuperNerdText:
	text "Plants are also"
  line "living things!"

  para "They would want to"
  line "move around from"
  cont "time to time!"
	done

Route36VioletGate_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  9,  4, VIOLET_CITY, 10
	warp_event  9,  5, VIOLET_CITY, 11
	warp_event  0,  4, ROUTE_36, 5
	warp_event  0,  5, ROUTE_36, 6

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route36VioletGateOfficerScript, -1
	object_event  3,  5, SPRITE_SUPER_NERD, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route36VioletGateSuperNerdScript, -1
