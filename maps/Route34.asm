Route34_MapEvents:
	def_warp_events
	warp_event 13, 29, ROUTE_34_ILEX_FOREST_GATE, 1
	warp_event 14, 29, ROUTE_34_ILEX_FOREST_GATE, 2
	warp_event 17, 16, DAY_CARE, 1
	warp_event 17, 17, DAY_CARE, 2
	warp_event 19, 17, DAY_CARE, 3
	warp_event 25, 18, HATCH_ROOM, 2
	warp_event 25, 19, HATCH_ROOM, 2
	def_coord_events

	def_bg_events
	bg_event  7,  7, BGEVENT_READ, Route34Sign
	bg_event 16, 27, BGEVENT_READ, Route34TrainerTips
	bg_event 16, 15, BGEVENT_READ, DayCareSign

	object_const_def
	const ROUTE34_DAY_CARE_MON_1
	const ROUTE34_DAY_CARE_MON_2

	def_object_events
	object_event 19, 20, SPRITE_DAY_CARE_MON_1, SPRITEMOVEDATA_POKEMON, 2, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DayCareMon1Script, EVENT_DAY_CARE_MON_1
	object_event 22, 20, SPRITE_DAY_CARE_MON_2, SPRITEMOVEDATA_POKEMON, 2, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DayCareMon2Script, EVENT_DAY_CARE_MON_2

Route34_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, Route34EggCheckCallback

Route34EggCheckCallback:
	sjump .CheckMon1

.CheckMon1:
	checkflag ENGINE_DAY_CARE_MAN_HAS_MON
	iffalse .HideMon1
	clearevent EVENT_DAY_CARE_MON_1
	sjump .CheckMon2

.HideMon1:
	setevent EVENT_DAY_CARE_MON_1
	sjump .CheckMon2

.CheckMon2:
	checkflag ENGINE_DAY_CARE_LADY_HAS_MON
	iffalse .HideMon2
	clearevent EVENT_DAY_CARE_MON_2
	endcallback

.HideMon2:
	setevent EVENT_DAY_CARE_MON_2
	endcallback

DayCareMon1Script:
	opentext
	special DayCareMon1
	closetext
	end

DayCareMon2Script:
	opentext
	special DayCareMon2
	closetext
	end

Route34Sign:
	jumptext Route34SignText

Route34TrainerTips:
	jumptext Route34TrainerTipsText

DayCareSign:
	jumptext DayCareSignText

Route34IlexForestSignText:
	text "ILEX FOREST"
	line "THROUGH THE GATE"
	done

Route34SignText:
	text "ROUTE 34"

	para "GOLDENROD CITY -"
	line "AZALEA TOWN"

	para "ILEX FOREST"
	line "SOMEWHERE BETWEEN"
	done

Route34TrainerTipsText:
	text "TRAINER TIPS"

	para "BERRY trees grow"
	line "new BERRIES"
	cont "every day."

	para "Make a note of"
	line "which trees bear"
	cont "which BERRIES."
	done

DayCareSignText:
	text "DAY-CARE"

	para "LET US RAISE YOUR"
	line "#MON FOR YOU!"
	done
