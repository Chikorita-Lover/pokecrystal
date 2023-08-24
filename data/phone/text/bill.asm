BillPhoneMornGreetingText:
	text "Good morning!"

	para "This is the #-"
	line "MON STORAGE SYSTEM"

	para "ADMINISTRATION"
	line "SERVICE."
	done

BillPhoneDayGreetingText:
	text "Good day!"

	para "This is the #-"
	line "MON STORAGE SYSTEM"

	para "ADMINISTRATION"
	line "SERVICE."
	done

BillPhoneNiteGreetingText:
	text "Good evening!"

	para "This is the #-"
	line "MON STORAGE SYSTEM"

	para "ADMINISTRATION"
	line "SERVICE."
	done

BillPhoneGenericText:
	text "Who's calling?"

	para "<PLAY_G>, is it?"
	line "Hang on a sec…"

	para "<……>"
	line "<……>"
	done

BillPhoneNotFullText:
	text "Thanks for"
	line "waiting!"

	para "<PLAY_G>, your BOX"
	line "has room for @"
	text_ram wStringBuffer3
	text_start
	cont "more #MON."

	para "Get out there and"
	line "fill it up!"
	done

BillPhoneNearlyFullText:
	text "Thanks for"
	line "waiting!"

	para "<PLAY_G>, your BOX"
	line "has room for only"
	cont "@"
	text_ram wStringBuffer3
	text " more #MON."
	done

BillPhoneFullText:
	text "Thanks for"
	line "waiting!"

	para "<PLAY_G>, your BOX"
	line "is full!"
	done

BillPhoneNewlyFullText:
	text "Hi, <PLAY_G>?"
	line "It's me, BILL!"

	para "Thanks for using"
	line "my STORAGE SYSTEM."

	para "That last #MON"
	line "you sent filled"
	cont "your BOX up."
	done

BillPhoneAskChangeBoxText:
	text "Would you like me"
	line "to switch your BOX"
	cont "for you?"
	done

BillPhoneConfirmChangeBoxText:
	text "Great! Your new"
	line "BOX will have room"

	para "for @"
	text_ram wStringBuffer3
	text " more #-"
	line "MON."

	para "Get out there and"
	line "fill it up!"
	done

BillPhoneChangeBoxAllFullText:
	text "Uh oh, <PLAY_G>…"

	para "You don't seem to"
	line "have much free"

	para "space in any of"
	line "your BOXES."

	para "You'll have to"
	line "reach me from a PC"

	para "so we can sort"
	line "this all out, OK?"
	done

BillPhoneDenyChangeBoxText:
	text "Just let me know"
	line "when you'd like to"

	para "have your BOX"
	line "switched, OK?"
	done

BillPhoneHangUpText:
	text "Bye now!"
	done
