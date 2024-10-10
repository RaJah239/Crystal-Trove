	object_const_def
	const RUINSOFALPHHOOHWORDROOM_MEW

RuinsOfAlphHoOhWordRoom_MapScripts:
	def_scene_scripts

	def_callbacks

RuinsOfAlphHoOhWordRoomHooH:
    faceplayer
	opentext
	writetext MewText
	cry MEW
	pause 15
	closetext
	loadvar VAR_BATTLETYPE, BATTLETYPE_SUICUNE
	loadwildmon MEW, 90
	startbattle
	disappear RUINSOFALPHHOOHWORDROOM_MEW
	reloadmapafterbattle
	end
	
MewText:
	text "Myuu…"
	done

RuinsOfAlphHoOhWordRoom_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  9,  9, RUINS_OF_ALPH_HO_OH_ITEM_ROOM, 3
	warp_event 10,  9, RUINS_OF_ALPH_HO_OH_ITEM_ROOM, 4
	warp_event 17, 21, RUINS_OF_ALPH_INNER_CHAMBER, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event 10,  4, SPRITE_MEW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphHoOhWordRoomHooH, EVENT_RUINSOFALPHHOOHWORDROOM_MEW