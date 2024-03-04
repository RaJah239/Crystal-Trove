	object_const_def
	const ROUTE31VIOLETGATE_OFFICER
	const ROUTE31VIOLETGATE_FISHING_GURU
	const ROUTE31VIOLETGATE_COOLTRAINER_F

Route31VioletGate_MapScripts:
	def_scene_scripts

	def_callbacks

Route31VioletGateOfficerScript:
	jumptextfaceplayer Route31VioletGateOfficerText

Route31VioletGateCooltrainerFScript:
	jumptextfaceplayer Route31VioletGateCooltrainerFText

Route31VioletGateFishingGuruScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_OLD_ROD
	iftrue .GotOldRod
	writetext Route31VioletGateFishingGuruText_Question
	yesorno
	iffalse .Refused
	writetext Route31VioletGateFishingGuruText_Yes
	promptbutton
	verbosegiveitem OLD_ROD
	writetext Route31VioletGateFishingGuruText_GiveOldRod
	waitbutton
	closetext
	setevent EVENT_GOT_OLD_ROD
	end

.Refused:
	writetext Route31VioletGateFishingGuruText_No
	waitbutton
	closetext
	end

.GotOldRod:
	writetext Route31VioletGateFishingGuruText_After
	waitbutton
	closetext
	end

Route31VioletGateFishingGuruText_Question:
	text "This is a great"
	line "fishing spot."

	para "Unique #MON"
	line "can be scouted"
	cont "via fishing."

	para "I can see that"
	line "I have peaked"
	cont "your interest."

	para "Would you like one"
	line "of my RODS?"
	done

Route31VioletGateFishingGuruText_Yes:
	text "Heh, that's good"
	line "to hear."

	para "Now you're an"
	line "angler too!"
	done

Route31VioletGateFishingGuruText_GiveOldRod:
	text "Fishing is great!"

	para "If there's water,"
	line "be it the sea or a"

	para "stream, try out"
	line "your ROD."
	done

Route31VioletGateFishingGuruText_No:
	text "Oh. That's rather"
	line "disappointing…"
	done

Route31VioletGateFishingGuruText_After:
	text "Yo, kid. How are"
	line "they biting?"
	done

Route31VioletGateOfficerText:
	text "Hi there!"
	line "Did you visit"
	cont "SPROUT TOWER?"
	done

Route31VioletGateCooltrainerFText:
	text "I came too far"
	line "out. I'd better"
	cont "phone home!"
	done

Route31VioletGate_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  4, VIOLET_CITY, 8
	warp_event  0,  5, VIOLET_CITY, 9
	warp_event  9,  4, ROUTE_31, 1
	warp_event  9,  5, ROUTE_31, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route31VioletGateOfficerScript, -1
	object_event  2,  4, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route31VioletGateFishingGuruScript, -1
	object_event  8,  2, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route31VioletGateCooltrainerFScript, -1
