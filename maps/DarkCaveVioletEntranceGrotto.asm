	object_const_def
	const DARKCAVEWESTGROTTO_GEODUDE
	const DARKCAVEWESTGROTTO_TEDDIURSA
	const DARKCAVEWESTGROTTO_DIGLETT
	const DARKCAVEWESTGROTTO_ZUBAT
	const DARKCAVEWESTGROTTO_MARILL

DarkCaveVioletEntranceGrotto_MapScripts:
    def_scene_scripts

    def_callbacks
 	callback MAPCALLBACK_OBJECTS, DarkCaveWestGrottoPokemonOW
 
DarkCaveWestGrottoPokemonOW:
    checkevent EVENT_INITIALIZED_EVENTS
    iffalse .NoAppear
    random 20 ; random 5 - this makes it always have a Pokemon.
    ifequal 0, .AppearGeodude
    ifequal 1, .AppearTeddiursa
    ifequal 2, .AppearDiglett
    ifequal 3, .AppearZubat
    ifequal 4, .AppearMarill
.NoAppear:
    disappear DARKCAVEWESTGROTTO_GEODUDE
    disappear DARKCAVEWESTGROTTO_TEDDIURSA
    disappear DARKCAVEWESTGROTTO_DIGLETT
    disappear DARKCAVEWESTGROTTO_ZUBAT
    disappear DARKCAVEWESTGROTTO_MARILL
    endcallback

.AppearGeodude:
    disappear DARKCAVEWESTGROTTO_TEDDIURSA
    disappear DARKCAVEWESTGROTTO_DIGLETT
    disappear DARKCAVEWESTGROTTO_ZUBAT
    disappear DARKCAVEWESTGROTTO_MARILL
    appear DARKCAVEWESTGROTTO_GEODUDE
    endcallback

.AppearTeddiursa:
    disappear DARKCAVEWESTGROTTO_GEODUDE
    disappear DARKCAVEWESTGROTTO_DIGLETT
    disappear DARKCAVEWESTGROTTO_ZUBAT
    disappear DARKCAVEWESTGROTTO_MARILL
    appear DARKCAVEWESTGROTTO_TEDDIURSA
    endcallback

.AppearDiglett:
    disappear DARKCAVEWESTGROTTO_GEODUDE
    disappear DARKCAVEWESTGROTTO_ZUBAT
    disappear DARKCAVEWESTGROTTO_MARILL
    disappear DARKCAVEWESTGROTTO_TEDDIURSA
    appear DARKCAVEWESTGROTTO_DIGLETT
    endcallback

.AppearZubat:
    disappear DARKCAVEWESTGROTTO_GEODUDE
    disappear DARKCAVEWESTGROTTO_MARILL
    disappear DARKCAVEWESTGROTTO_TEDDIURSA
    disappear DARKCAVEWESTGROTTO_DIGLETT
    appear DARKCAVEWESTGROTTO_ZUBAT
    endcallback

.AppearMarill:
    disappear DARKCAVEWESTGROTTO_GEODUDE
    disappear DARKCAVEWESTGROTTO_ZUBAT
    disappear DARKCAVEWESTGROTTO_TEDDIURSA
    disappear DARKCAVEWESTGROTTO_DIGLETT
    appear DARKCAVEWESTGROTTO_MARILL
    endcallback

DarkCaveWestGrottoGeodudeScript:
    faceplayer
    cry GEODUDE
    loadwildmon GEODUDE, 9
    loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
    startbattle
    disappear DARKCAVEWESTGROTTO_GEODUDE
    reloadmapafterbattle
    end

DarkCaveWestGrottoTeddiursaScript:
    faceplayer
    cry TEDDIURSA
    loadwildmon TEDDIURSA, 9
    loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
    startbattle
    disappear DARKCAVEWESTGROTTO_TEDDIURSA
    reloadmapafterbattle
    end

DarkCaveWestGrottoDiglettScript:
    faceplayer
    cry DIGLETT
    loadwildmon DIGLETT, 9
    loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
    startbattle
    disappear DARKCAVEWESTGROTTO_DIGLETT
    reloadmapafterbattle
    end

DarkCaveWestGrottoZubatScript:
    faceplayer
    cry ZUBAT
    loadwildmon ZUBAT, 9
    loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
    startbattle
    disappear DARKCAVEWESTGROTTO_ZUBAT
    reloadmapafterbattle
    end

DarkCaveWestGrottoMarillScript:
    faceplayer
    cry MARILL
    loadwildmon MARILL, 9
    loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
    startbattle
    disappear DARKCAVEWESTGROTTO_MARILL
    reloadmapafterbattle
    end

DarkCaveWestGrottoSign:
	jumptext  DarkCaveWestGrottoSignText

DarkCaveWestGrottoSignText:
	text "This GROTTO get"
	line "visited by:"

	para "GEODUDE, DIGLETT,"
	line "ZUBAT, MARILL and"
	cont "TEDDIURSA."
	done

DarkCaveVioletEntranceGrotto_MapEvents:
    db 0, 0 ; filler

    def_warp_events
	warp_event  4,  5, DARK_CAVE_VIOLET_ENTRANCE, 4

    def_coord_events

    def_bg_events
	bg_event  5,  2, BGEVENT_READ, DarkCaveWestGrottoSign

    def_object_events
	object_event  4,  3, SPRITE_GEODUDE_OW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, DarkCaveWestGrottoGeodudeScript, EVENT_DARK_CAVE_WEST_GROTTO_GEODUDE
	object_event  3,  5, SPRITE_TEDDIURSA_OW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, DarkCaveWestGrottoTeddiursaScript, EVENT_DARK_CAVE_WEST_GROTTO_TEDDIURSA
	object_event  4,  4, SPRITE_DIGLETT_OW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, DarkCaveWestGrottoDiglettScript, EVENT_DARK_CAVE_WEST_GROTTO_DIGLETT
	object_event  3,  2, SPRITE_ZUBAT_OW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, DarkCaveWestGrottoZubatScript, EVENT_DARK_CAVE_WEST_GROTTO_ZUBAT
	object_event  2,  3, SPRITE_MARILL_OW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, DarkCaveWestGrottoMarillScript, EVENT_DARK_CAVE_WEST_GROTTO_MARILL
