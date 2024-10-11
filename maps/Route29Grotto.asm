    object_const_def
	const ROUTE29GROTTO_PIDGEY
	const ROUTE29GROTTO_HOPPIP
	const ROUTE29GROTTO_LEDYBA
	const ROUTE29GROTTO_SPINARAK
	const ROUTE29GROTTO_HOOTHOOT
   
Route29Grotto_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, Route29GrottoPokemonOW
 
Route29GrottoPokemonOW:
    checkevent EVENT_INITIALIZED_EVENTS
    iffalse .NoAppear
    random 20 ; random 5 - this makes it always have a Pokemon.
    ifequal 0, .AppearSentret
    ifequal 1, .AppearHoppip
    ifequal 2, .AppearLedyba
    ifequal 3, .AppearSpinark
    ifequal 4, .AppearHoothoot
.NoAppear:
    disappear ROUTE29GROTTO_PIDGEY
    disappear ROUTE29GROTTO_HOPPIP
    disappear ROUTE29GROTTO_LEDYBA
    disappear ROUTE29GROTTO_SPINARAK
    disappear ROUTE29GROTTO_HOOTHOOT
    endcallback

.AppearSentret:
    disappear ROUTE29GROTTO_HOPPIP
    disappear ROUTE29GROTTO_LEDYBA
    disappear ROUTE29GROTTO_SPINARAK
    disappear ROUTE29GROTTO_HOOTHOOT
    appear ROUTE29GROTTO_PIDGEY
    endcallback

.AppearHoppip:
    disappear ROUTE29GROTTO_PIDGEY
    disappear ROUTE29GROTTO_LEDYBA
    disappear ROUTE29GROTTO_SPINARAK
    disappear ROUTE29GROTTO_HOOTHOOT
    appear ROUTE29GROTTO_HOPPIP
    endcallback

.AppearLedyba:
    disappear ROUTE29GROTTO_PIDGEY
    disappear ROUTE29GROTTO_SPINARAK
    disappear ROUTE29GROTTO_HOOTHOOT
    disappear ROUTE29GROTTO_HOPPIP
    appear ROUTE29GROTTO_LEDYBA
    endcallback

.AppearSpinark:
    disappear ROUTE29GROTTO_PIDGEY
    disappear ROUTE29GROTTO_HOOTHOOT
    disappear ROUTE29GROTTO_HOPPIP
    disappear ROUTE29GROTTO_LEDYBA
    appear ROUTE29GROTTO_SPINARAK
    endcallback

.AppearHoothoot:
    disappear ROUTE29GROTTO_PIDGEY
    disappear ROUTE29GROTTO_SPINARAK
    disappear ROUTE29GROTTO_HOPPIP
    disappear ROUTE29GROTTO_LEDYBA
    appear ROUTE29GROTTO_HOOTHOOT
    endcallback

Route29GrottoSentretScript:
    faceplayer
    cry PIDGEY
    loadwildmon PIDGEY, 5
    loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
    startbattle
    disappear ROUTE29GROTTO_PIDGEY
    reloadmapafterbattle
    end

Route29GrottoHoppipScript:
    faceplayer
    cry HOPPIP
    loadwildmon HOPPIP, 5
    loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
    startbattle
    disappear ROUTE29GROTTO_HOPPIP
    reloadmapafterbattle
    end

Route29GrottoLedybaScript:
    faceplayer
    cry LEDYBA
    loadwildmon LEDYBA, 5
    loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
    startbattle
    disappear ROUTE29GROTTO_LEDYBA
    reloadmapafterbattle
    end

Route29GrottoSpinarkScript:
    faceplayer
    cry SPINARAK
    loadwildmon SPINARAK, 5
    loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
    startbattle
    disappear ROUTE29GROTTO_SPINARAK
    reloadmapafterbattle
    end

Route29GrottoHoothootScript:
    faceplayer
    cry HOOTHOOT
    loadwildmon HOOTHOOT, 5
    loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
    startbattle
    disappear ROUTE29GROTTO_HOOTHOOT
    reloadmapafterbattle
    end

Route29GrottoSign:
	jumptext  Route29GrottoSignText

Route29GrottoSignText:
	text "This GROTTO get"
	line "visited by:"

	para "PIDGEY, HOOTHOOT,"
	line "LEDYBA, HOPPIP and"
	cont "HOOTHOOT."
	done

Route29Grotto_MapEvents:
    db 0, 0 ; filler

    def_warp_events
	warp_event  4,  6, ROUTE_29, 2
	warp_event  4,  7, ROUTE_29, 3

    def_coord_events

    def_bg_events
	bg_event  8,  9, BGEVENT_READ, Route29GrottoSign

    def_object_events
	object_event  9,  4, SPRITE_PIDGEY_OW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, Route29GrottoSentretScript, EVENT_ROUTE_29_GROTTO_PIDGEY
	object_event  9,  9, SPRITE_HOPPIP_OW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, Route29GrottoHoppipScript, EVENT_ROUTE_29_GROTTO_HOPPIP
	object_event  7,  5, SPRITE_LEDYBA_OW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route29GrottoLedybaScript, EVENT_ROUTE_29_GROTTO_LEDYBA
	object_event  8,  7, SPRITE_SPINARAK_OW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route29GrottoSpinarkScript, EVENT_ROUTE_29_GROTTO_SPINARAK
	object_event  6,  9, SPRITE_HOOTHOOT_OW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, Route29GrottoHoothootScript, EVENT_ROUTE_29_GROTTO_HOOTHOOT
