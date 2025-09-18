Route38EcruteakGate_MapEvents:
	def_warp_events
	warp_event  0,  4, ROUTE_34, 8
	warp_event  0,  5, ROUTE_34, 9
	warp_event  9,  4, BATTLE_TOWER_OUTSIDE, 10
	warp_event  9,  5, BATTLE_TOWER_OUTSIDE, 11

	def_coord_events

	def_bg_events

	object_const_def
	const ROUTE38ECRUTEAKGATE_OFFICER

	def_object_events
	object_event  5,  2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route38EcruteakGateOfficerScript, -1

Route38EcruteakGate_MapScripts:
	def_scene_scripts

	def_callbacks

Route38EcruteakGateOfficerScript:
	jumptext Route38EcruteakGateOfficerText

Route38EcruteakGateOfficerText:
	text "Go on through."
	done
