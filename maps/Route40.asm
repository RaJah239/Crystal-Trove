Route40_MapEvents:
	def_warp_events
	warp_event  9,  5, ROUTE_34_ILEX_FOREST_GATE, 3

	def_coord_events

	def_bg_events
	bg_event 14, 10, BGEVENT_READ, SeaSign

	def_object_events
	object_event  7, 11, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route40Rock, -1
	object_event  6,  9, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route40Rock, -1
	object_event  7,  8, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route40Rock, -1

	object_const_def
	const ROUTE40_ROCK1
	const ROUTE40_ROCK2
	const ROUTE40_ROCK3

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
