Route40_MapEvents:
	def_warp_events
	warp_event 27,  7, CHERRYGROVE_POKECENTER_1F, 1
	warp_event  9,  5, ROUTE_34_ILEX_FOREST_GATE, 3

	def_coord_events

	def_bg_events
	bg_event 13,  5, BGEVENT_READ, SeaSign

	def_object_events
	object_event  6, 10, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route40Rock, -1
	object_event  6,  8, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route40Rock, -1
	object_event  7,  6, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route40Rock, -1
	object_event  8,  8, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route40Rock, -1

	object_const_def
	const SEA_BIOME_ROCK1
	const SEA_BIOME_ROCK2
	const SEA_BIOME_ROCK3
	const SEA_BIOME_ROCK4

Route40_MapScripts:
	def_scene_scripts

	def_callbacks

Route40Rock:
	jumpstd SmashRockScript

SeaSign:
	jumptext SeaSignText

SeaSignText:
	text "Catch sea dwellers"
	line "in every ripple!"
	done
