BattlePlazaScaldRiftGate_MapEvents:
	def_warp_events
	warp_event  4,  7, BATTLE_TOWER_OUTSIDE, 14
	warp_event  5,  7, BATTLE_TOWER_OUTSIDE, 14
	warp_event  4,  0, SILVER_CAVE_OUTSIDE, 3
	warp_event  5,  0, SILVER_CAVE_OUTSIDE, 4

	def_coord_events

	def_bg_events

	object_const_def
	const BATTLEPLAZASCALDRIFTGATE_OFFICER

	def_object_events
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, BattlePlazaScaldRiftGateGateOfficerScript, -1

BattlePlazaScaldRiftGate_MapScripts:
	def_scene_scripts

	def_callbacks

BattlePlazaScaldRiftGateGateOfficerScript:
	jumptext BattlePlazaScaldRiftGateGateOfficerScriptText

BattlePlazaScaldRiftGateGateOfficerScriptText:
	text "Go on through!" 
	done	
