Trailway_MapEvents:
	def_warp_events
	warp_event 19, 17, DAY_CARE, 3
	warp_event 13, 29, TRAILWAY_DRIFTSEA_GATE, 1
	warp_event 14, 29, TRAILWAY_DRIFTSEA_GATE, 2
	warp_event 17, 16, DAY_CARE, 1
	warp_event 17, 17, DAY_CARE, 2
	warp_event 25, 18, HATCH_ROOM, 2
	warp_event 25, 19, HATCH_ROOM, 2
	warp_event 21,  8, ROUTE_38_ECRUTEAK_GATE, 1
	warp_event 21,  9, ROUTE_38_ECRUTEAK_GATE, 2
	warp_event  6,  8, TRAILWAY_PARK_GATE, 3
	warp_event  6,  9, TRAILWAY_PARK_GATE, 4

	def_coord_events

	def_bg_events
	bg_event 21,  7, BGEVENT_READ, TrailwaySign
	bg_event  7,  7, BGEVENT_READ, TrailwayNationalParkSign
	bg_event 16, 27, BGEVENT_READ, TrailwayIlexForestSign
	bg_event 16, 15, BGEVENT_READ, DayCareSign

	object_const_def
	const TRAILWAY_DAY_CARE_MON_1
	const TRAILWAY_DAY_CARE_MON_2

	def_object_events
	object_event 19, 20, SPRITE_DAY_CARE_MON_1, SPRITEMOVEDATA_POKEMON, 2, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DayCareMon1Script, EVENT_DAY_CARE_MON_1
	object_event 22, 20, SPRITE_DAY_CARE_MON_2, SPRITEMOVEDATA_POKEMON, 2, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DayCareMon2Script, EVENT_DAY_CARE_MON_2

Trailway_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, TrailwayEggCheckCallback

TrailwayEggCheckCallback:
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

TrailwaySign:
	jumptext TrailwaySignText

TrailwaySignText:
	text "Trailway"

	para "The three way"
	line "intersection"
	done

TrailwayNationalParkSign:
	jumptext TrailwayNationalParkSignText

TrailwayNationalParkSignText:
	text "National Park"
	line "Through The Gate"
	done

DayCareSign:
	jumptext DayCareSignText

DayCareSignText:
	text "Day-Care"

	para "We are masters of"
	line "#mon eggs!"
	done

TrailwayIlexForestSign:
	jumptext TrailwayIlexForestSignText

TrailwayIlexForestSignText:
	text "Driftsea"
	line "Through The Gate"
	done
