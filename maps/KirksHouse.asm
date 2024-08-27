	object_const_def
	const KIRKSHOUSE_ROCKER

KirksHouse_MapScripts:
	def_scene_scripts

	def_callbacks

KirkScript:
	faceplayer
	opentext
	checkevent EVENT_KIRK_TOOK_SHUCKIE_OR_LET_YOU_KEEP_HIM
	iftrue .default_postevent
	checkevent EVENT_GOT_SHUCKIE
	iftrue .alreadyhaveshuckie
	writetext KirkText_AskLookAfterShuckle
	yesorno
	iffalse .refusetotakeshuckie
	special GiveShuckle
	iffalse .partyfull
	writetext KirkText_TakeCareOfShuckle
	promptbutton
	waitsfx
	writetext KirkText_GotShuckle
	playsound SFX_KEY_ITEM
	waitsfx
	closetext
	setevent EVENT_GOT_SHUCKIE
	end

.alreadyhaveshuckie
	checkflag ENGINE_GOT_SHUCKIE_TODAY
	iffalse .returnshuckie
	writetext KirkText_TakeCareOfShuckle
	waitbutton
	closetext
	end

.partyfull
	writetext KirkText_PartyFull
	waitbutton
	closetext
	end

.refusetotakeshuckie
	writetext KirkText_IfHeComesBack
	waitbutton
	closetext
	end

.returnshuckie
	writetext KirkText_CanIHaveMyMonBack
	yesorno
	iffalse .refused
	special ReturnShuckie
	ifequal SHUCKIE_WRONG_MON, .wrong
	ifequal SHUCKIE_REFUSED, .refused
	ifequal SHUCKIE_HAPPY, .superhappy
	ifequal SHUCKIE_FAINTED, .default_postevent
	; SHUCKIE_RETURNED
	writetext KirkText_ThankYou
	waitbutton
	closetext
	setevent EVENT_KIRK_TOOK_SHUCKIE_OR_LET_YOU_KEEP_HIM
	end

.wrong
	writetext KirkText_ShuckleNotThere
	waitbutton
	closetext
	end

.superhappy
	writetext KirkText_ShuckleLikesYou
	waitbutton
	closetext
	setevent EVENT_KIRK_TOOK_SHUCKIE_OR_LET_YOU_KEEP_HIM
	end

.refused
	writetext KirkText_SameAsBeingRobbed
	waitbutton
	closetext
	end

.nothingleft ; unreferenced
	writetext KirkText_ShuckleIsYourLastMon
	waitbutton
	closetext
	end

.default_postevent
	writetext KirkText_HappinessSpeech
	waitbutton
	closetext
	end

KirksHouseUnusedBookshelf: ; unreferenced
	jumpstd PictureBookshelfScript

KirkText_AskLookAfterShuckle:
	text "I, I'm in shock!"

	para "A guy about your"
	line "age with piercing"

	para "eyes and long hair"
	line "came in."

	para "He scared me into"
	line "giving him my"
	cont "prized #MON!"

	para "I still have one"
	line "left, but what if"
	cont "he comes back?"

	para "You look strong."
	line "Could you look"

	para "after my #MON"
	line "for a while?"
	done

KirkText_TakeCareOfShuckle:
	text "Oh, thank you!"

	para "Take good care of"
	line "it, please!"
	done

KirkText_GotShuckle:
	text "<PLAYER> received a"
	line "#MON."
	done

KirkText_PartyFull:
	text "Your #MON party"
	line "is full."
	done

KirkText_IfHeComesBack:
	text "Oh, no… What'll"
	line "I do if he comes"
	cont "back?"
	done

KirkText_CanIHaveMyMonBack:
	text "Hi! How's my #-"
	line "MON?"

	para "I think I'm safe"
	line "now, so may I have"
	cont "it back?"
	done

KirkText_ThankYou:
	text "Thank you!"
	done

KirkText_ShuckleNotThere:
	text "Hey, you don't"
	line "have my #MON"
	cont "with you."
	done

KirkText_ShuckleLikesYou:
	text "My #MON has"
	line "come to like you."

	para "All right, you"
	line "should keep it."

	para "But promise to"
	line "be good to it!"
	done

KirkText_SameAsBeingRobbed:
	text "Oh, no, no… That's"
	line "the same as being"
	cont "robbed."
	done

KirkText_HappinessSpeech:
	text "For #MON, hap-"
	line "piness is being"

	para "with a person who"
	line "treats them well."
	done

KirkText_ShuckleIsYourLastMon:
	text "If I take my #-"
	line "MON back, what are"

	para "you going to use"
	line "in battle?"
	done

KirksHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, CIANWOOD_CITY, 1
	warp_event  3,  7, CIANWOOD_CITY, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  4, SPRITE_ROCKER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, KirkScript, -1
