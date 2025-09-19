CherrygrovePokecenter1F_MapEvents:
	def_warp_events
	warp_event  3,  7, DRIFTSEA, 1
	warp_event  4,  7, DRIFTSEA, 1
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	object_const_def
	const CHERRYGROVEPOKECENTER1F_NURSE
	const CHERRYGROVEPOKECENTER1F_CHANSEY

	def_object_events
	object_event  3,  1, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CherrygrovePokecenter1FNurseScript, -1
	object_event  4,  1, SPRITE_CHANSEY, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CherrygrovePokecenterChanseyScript, -1

CherrygrovePokecenter1F_MapScripts:
	def_scene_scripts

	def_callbacks

CherrygrovePokecenter1FNurseScript:
	jumpstd PokecenterNurseScript

CherrygrovePokecenterChanseyScript:
	jumpstd ChanseyPokeCenterScript
