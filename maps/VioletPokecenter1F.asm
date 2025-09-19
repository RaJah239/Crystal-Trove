VioletPokecenter1F_MapEvents:
	def_warp_events
	warp_event  3,  7, ROUTE_42, 1
	warp_event  4,  7, ROUTE_42, 1
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	object_const_def
	const VIOLETPOKECENTER1F_NURSE
	const VIOLETPOKECENTER1F_CHANSEY

	def_object_events
	object_event  3,  1, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VioletPokecenterNurse, -1
	object_event  4,  1, SPRITE_CHANSEY, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VioletPokecenterChanseyScript, -1

VioletPokecenter1F_MapScripts:
	def_scene_scripts

	def_callbacks

VioletPokecenterNurse:
	jumpstd PokecenterNurseScript

VioletPokecenterChanseyScript:
	jumpstd ChanseyPokeCenterScript
