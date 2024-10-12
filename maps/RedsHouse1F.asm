	object_const_def
	const REDSHOUSE1F_REDS_MOM
	const REDSHOUSE1F_RED

RedsHouse1F_MapScripts:
	def_scene_scripts
	scene_script RedHouse1FNoopScene ; unusable

	def_callbacks

RedHouse1FNoopScene:
	end

RedsMom:
	faceplayer
	opentext
	checkevent EVENT_REDS_HOUSE_1F_RED_IS_HOME
	iffalse .RedsFinallyHome
	checkevent EVENT_MET_REDS_MOM
	iftrue .MetAlready
	writetext RedsMomText1
	waitbutton
	closetext
	setevent EVENT_MET_REDS_MOM
	turnobject REDSHOUSE1F_REDS_MOM, LEFT
	end
.MetAlready:
	writetext RedsMomText2
	waitbutton
	closetext
	turnobject REDSHOUSE1F_REDS_MOM, LEFT
	end

.RedsFinallyHome
	writetext RedsFinallyHomeText
	waitbutton
	closetext
	turnobject REDSHOUSE1F_REDS_MOM, LEFT
	end

RedsHouse1FTV:
	jumptext RedsHouse1FTVText

RedsHouse1FBookshelf:
	jumpstd PictureBookshelfScript

RedScript:
	faceplayer
	opentext
	writetext RedHomeText
	waitbutton
	closetext
	turnobject REDSHOUSE1F_RED, RIGHT
	end

RedHomeText:
	text "<……>"
	line "<……>"
	done

RedsFinallyHomeText:
	text "RED's finally home!"
	line "I'm so happy!"

	para "A mom will always"
	line "worry about her"
	
	para "children regard-"
	line "less their age."
	
	para "You ought to check"
	line "home regularly."
	done

RedsMomText1:
	text "Hi!"

	para "RED's been away"
	line "for a long time."

	para "He hasn't called"
	line "either, so I have"

	para "no idea where he"
	line "is or what he's"
	cont "been doing."

	para "They say that no"
	line "word is proof that"

	para "he's doing fine,"
	line "but I do worry"
	cont "about him."
	done

RedsMomText2:
	text "I worry about RED"
	line "getting hurt or"

	para "sick, but he's a"
	line "boy. I'm proud"

	para "that he is doing"
	line "what he wants to"

	para "do."
	done

RedsHouse1FTVText:
	text "They have programs"
	line "that aren't shown"
	cont "in JOHTO…"
	done

RedsHouse1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, PALLET_TOWN, 1
	warp_event  3,  7, PALLET_TOWN, 1
	warp_event  7,  0, REDS_HOUSE_2F, 1

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, RedsHouse1FBookshelf
	bg_event  1,  1, BGEVENT_READ, RedsHouse1FBookshelf
	bg_event  2,  1, BGEVENT_READ, RedsHouse1FTV

	def_object_events
	object_event  5,  4, SPRITE_REDS_MOM, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RedsMom, -1
	object_event  2,  4, SPRITE_RED, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RedScript, EVENT_REDS_HOUSE_1F_RED_IS_HOME