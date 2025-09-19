BattlePlazaTrailwayGate_MapEvents:
	def_warp_events
	warp_event  0,  4, TRAILWAY, 8
	warp_event  0,  5, TRAILWAY, 9
	warp_event  9,  4, BATTLE_PLAZA, 10
	warp_event  9,  5, BATTLE_PLAZA, 11

	def_coord_events

	def_bg_events

	object_const_def
	const BATTLEPLAZATRAILWAY_OFFICER

	def_object_events
	object_event  5,  2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, BattlePlazaTrailwayGateOfficerScript, -1

BattlePlazaTrailwayGate_MapScripts:
	def_scene_scripts

	def_callbacks

BattlePlazaTrailwayGateOfficerScript:
	jumptext BattlePlazaTrailwayOfficerText

BattlePlazaTrailwayOfficerText:
	text "Go on through."
	done
