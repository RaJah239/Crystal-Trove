Driftsea_MapEvents:
	def_warp_events
	warp_event 27,  7, DRIFTSEA_POKECENTER_1F, 1
	warp_event  9,  5, ROUTE_34_ILEX_FOREST_GATE, 3

	def_coord_events

	def_bg_events
	bg_event 12,  5, BGEVENT_READ, DriftseaSign
	bg_event 28,  7, BGEVENT_READ, DriftseaPokecenterSign

	def_object_events
	object_event  6, 10, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DriftseaRock, -1
	object_event  6,  8, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DriftseaRock, -1
	object_event  7,  6, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DriftseaRock, -1
	object_event  8,  8, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DriftseaRock, -1

	object_const_def
	const DRIFTSEA_ROCK1
	const DRIFTSEA_ROCK2
	const DRIFTSEA_ROCK3
	const DRIFTSEA_ROCK4

Driftsea_MapScripts:
	def_scene_scripts

	def_callbacks

DriftseaPokecenterSign:
	jumpstd PokecenterSignScript

DriftseaRock:
	jumpstd SmashRockScript

DriftseaSign:
	jumptext DriftseaSignText

DriftseaSignText:
	text "Driftsea"

	para "Catch sea dwellers"
	line "in every ripple!"
	done
