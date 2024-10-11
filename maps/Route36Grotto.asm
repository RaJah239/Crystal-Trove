    object_const_def
	const ROUTE36GROTTO_BELLSPROUT
	const ROUTE36GROTTO_GROWLITHE
	const ROUTE36GROTTO_GASTLY
	const ROUTE36GROTTO_YANMA
	const ROUTE36GROTTO_HOUNDOUR

Route36Grotto_MapScripts:
    def_scene_scripts

    def_callbacks
  	callback MAPCALLBACK_OBJECTS, Route36GrottoPokemonOW
 
Route36GrottoPokemonOW:
    checkevent EVENT_INITIALIZED_EVENTS
    iffalse .NoAppear
    random 20 ; random 5 - this makes it always have a Pokemon.
    ifequal 0, .AppearBellsprout
    ifequal 1, .AppearGrowlithe
    ifequal 2, .AppearGastly
    ifequal 3, .AppearYanma
    ifequal 4, .AppearHoundour
.NoAppear:
    disappear ROUTE36GROTTO_BELLSPROUT
    disappear ROUTE36GROTTO_GROWLITHE
    disappear ROUTE36GROTTO_GASTLY
    disappear ROUTE36GROTTO_YANMA
    disappear ROUTE36GROTTO_HOUNDOUR
    endcallback

.AppearBellsprout:
    disappear ROUTE36GROTTO_GROWLITHE
    disappear ROUTE36GROTTO_GASTLY
    disappear ROUTE36GROTTO_YANMA
    disappear ROUTE36GROTTO_HOUNDOUR
    appear ROUTE36GROTTO_BELLSPROUT
    endcallback

.AppearGrowlithe:
    disappear ROUTE36GROTTO_BELLSPROUT
    disappear ROUTE36GROTTO_GASTLY
    disappear ROUTE36GROTTO_YANMA
    disappear ROUTE36GROTTO_HOUNDOUR
    appear ROUTE36GROTTO_GROWLITHE
    endcallback

.AppearGastly:
    disappear ROUTE36GROTTO_BELLSPROUT
    disappear ROUTE36GROTTO_YANMA
    disappear ROUTE36GROTTO_HOUNDOUR
    disappear ROUTE36GROTTO_GROWLITHE
    appear ROUTE36GROTTO_GASTLY
    endcallback

.AppearYanma:
    disappear ROUTE36GROTTO_BELLSPROUT
    disappear ROUTE36GROTTO_HOUNDOUR
    disappear ROUTE36GROTTO_GROWLITHE
    disappear ROUTE36GROTTO_GASTLY
    appear ROUTE36GROTTO_YANMA
    endcallback

.AppearHoundour:
    disappear ROUTE36GROTTO_BELLSPROUT
    disappear ROUTE36GROTTO_YANMA
    disappear ROUTE36GROTTO_GROWLITHE
    disappear ROUTE36GROTTO_GASTLY
    appear ROUTE36GROTTO_HOUNDOUR
    endcallback

Route36GrottoBellsproutScript:
    faceplayer
    cry BELLSPROUT
    loadwildmon BELLSPROUT, 8
    loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
    startbattle
    disappear ROUTE36GROTTO_BELLSPROUT
    reloadmapafterbattle
    end

Route36GrottoGrowlitheScript:
    faceplayer
    cry GROWLITHE
    loadwildmon GROWLITHE, 8
    loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
    startbattle
    disappear ROUTE36GROTTO_GROWLITHE
    reloadmapafterbattle
    end

Route36GrottoGASTLYScript:
    faceplayer
    cry GASTLY
    loadwildmon GASTLY, 8
    loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
    startbattle
    disappear ROUTE36GROTTO_GASTLY
    reloadmapafterbattle
    end

Route36GrottoYanmaScript:
    faceplayer
    cry YANMA
    loadwildmon YANMA, 8
    loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
    startbattle
    disappear ROUTE36GROTTO_YANMA
    reloadmapafterbattle
    end

Route36GrottoHoundourScript:
    faceplayer
    cry HOUNDOUR
    loadwildmon HOUNDOUR, 8
    loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
    startbattle
    disappear ROUTE36GROTTO_HOUNDOUR
    reloadmapafterbattle
    end

Route36GrottoSign:
	jumptext  Route36GrottoSignText

Route36GrottoSignText:
	text "This GROTTO get"
	line "visited by:"

	para "HOUNDOUR, YANMA,"
	line "GROWLITHE, GASTLY"
	cont "and BELLSPROUT."
	done

Route36Grotto_MapEvents:
    db 0, 0 ; filler

    def_warp_events
	warp_event  4,  6, ROUTE_36, 5
	warp_event  4,  7, ROUTE_36, 6

    def_coord_events

    def_bg_events
	bg_event  8,  5, BGEVENT_READ, Route36GrottoSign

    def_object_events
	object_event  8,  6, SPRITE_BELLSPROUT_OW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route36GrottoBellsproutScript, EVENT_ROUTE_36_GROTTO_BELLSPROUT
	object_event  8,  7, SPRITE_GROWLITHE_OW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route36GrottoGrowlitheScript, EVENT_ROUTE_36_GROTTO_GROWLITHE
	object_event  7,  6, SPRITE_GASTLY_OW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, Route36GrottoGASTLYScript, EVENT_ROUTE_36_GROTTO_GASTLY
	object_event  7,  9, SPRITE_YANMA_OW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route36GrottoYanmaScript, EVENT_ROUTE_36_GROTTO_YANMA
	object_event  6,  4, SPRITE_HOUNDOUR_OW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route36GrottoHoundourScript, EVENT_ROUTE_36_GROTTO_HOUNDOUR
