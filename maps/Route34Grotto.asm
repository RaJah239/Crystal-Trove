    object_const_def
	const ROUTE34GROTTO_MEOWTH
	const ROUTE34GROTTO_FURRET
	const ROUTE34GROTTO_SNUBBULL
	const ROUTE34GROTTO_KADABRA
	const ROUTE34GROTTO_DROWZEE

Route34Grotto_MapScripts:
    def_scene_scripts

    def_callbacks
 	callback MAPCALLBACK_OBJECTS, Route34GrottoPokemonOW
 
Route34GrottoPokemonOW:
    checkevent EVENT_INITIALIZED_EVENTS
    iffalse .NoAppear
    random 20 ; random 5 - this makes it always have a Pokemon.
    ifequal 0, .AppearMeowth
    ifequal 1, .AppearFurret
    ifequal 2, .AppearSnubbull
    ifequal 3, .AppearKadabra
    ifequal 4, .AppearDrowzee
.NoAppear:
    disappear ROUTE34GROTTO_MEOWTH
    disappear ROUTE34GROTTO_FURRET
    disappear ROUTE34GROTTO_SNUBBULL
    disappear ROUTE34GROTTO_KADABRA
    disappear ROUTE34GROTTO_DROWZEE
    endcallback

.AppearMeowth:
    disappear ROUTE34GROTTO_FURRET
    disappear ROUTE34GROTTO_SNUBBULL
    disappear ROUTE34GROTTO_KADABRA
    disappear ROUTE34GROTTO_DROWZEE
    appear ROUTE34GROTTO_MEOWTH
    endcallback

.AppearFurret:
    disappear ROUTE34GROTTO_MEOWTH
    disappear ROUTE34GROTTO_SNUBBULL
    disappear ROUTE34GROTTO_KADABRA
    disappear ROUTE34GROTTO_DROWZEE
    appear ROUTE34GROTTO_FURRET
    endcallback

.AppearSnubbull:
    disappear ROUTE34GROTTO_MEOWTH
    disappear ROUTE34GROTTO_KADABRA
    disappear ROUTE34GROTTO_DROWZEE
    disappear ROUTE34GROTTO_FURRET
    appear ROUTE34GROTTO_SNUBBULL
    endcallback

.AppearKadabra:
    disappear ROUTE34GROTTO_MEOWTH
    disappear ROUTE34GROTTO_DROWZEE
    disappear ROUTE34GROTTO_FURRET
    disappear ROUTE34GROTTO_SNUBBULL
    appear ROUTE34GROTTO_KADABRA
    endcallback

.AppearDrowzee:
    disappear ROUTE34GROTTO_MEOWTH
    disappear ROUTE34GROTTO_KADABRA
    disappear ROUTE34GROTTO_FURRET
    disappear ROUTE34GROTTO_SNUBBULL
    appear ROUTE34GROTTO_DROWZEE
    endcallback

Route34GrottoMeowthScript:
    faceplayer
    cry MEOWTH
    loadwildmon MEOWTH, 24
    loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
    startbattle
    disappear ROUTE34GROTTO_MEOWTH
    reloadmapafterbattle
    end

Route34GrottoFurretScript:
    faceplayer
    cry FURRET
    loadwildmon FURRET, 24
    loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
    startbattle
    disappear ROUTE34GROTTO_FURRET
    reloadmapafterbattle
    end

Route34GrottoSnubbullScript:
    faceplayer
    cry SNUBBULL
    loadwildmon SNUBBULL, 24
    loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
    startbattle
    disappear ROUTE34GROTTO_SNUBBULL
    reloadmapafterbattle
    end

Route34GrottoKadabraScript:
    faceplayer
    cry KADABRA
    loadwildmon KADABRA, 24
    loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
    startbattle
    disappear ROUTE34GROTTO_KADABRA
    reloadmapafterbattle
    end

Route34GrottoDrowzeeScript:
    faceplayer
    cry DROWZEE
    loadwildmon DROWZEE, 24
    loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
    startbattle
    disappear ROUTE34GROTTO_DROWZEE
    reloadmapafterbattle
    end

Route34GrottoSign:
	jumptext  Route34GrottoSignText

Route34GrottoSignText:
	text "This GROTTO get"
	line "visited by:"

	para "SNUBBULL, KADABRA,"
	line "FURRET, MEOWTH"
	cont "and DROWZEE."
	done

Route34Grotto_MapEvents:
    db 0, 0 ; filler

    def_warp_events
	warp_event  4,  0, ROUTE_34, 6
	warp_event  5,  0, ROUTE_34, 7

    def_coord_events

    def_bg_events
	bg_event  4,  4, BGEVENT_READ, Route34GrottoSign

    def_object_events
	object_event  5,  4, SPRITE_MEOWTH_OW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, Route34GrottoMeowthScript, EVENT_ROUTE_34_GROTTO_MEOWTH
	object_event  7,  3, SPRITE_FURRET_OW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, Route34GrottoFurretScript, EVENT_ROUTE_34_GROTTO_FURRET
	object_event  7,  5, SPRITE_SNUBBULL_OW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route34GrottoSnubbullScript, EVENT_ROUTE_34_GROTTO_SNUBBULL
	object_event  2,  5, SPRITE_KADABRA_OW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, Route34GrottoKadabraScript, EVENT_ROUTE_34_GROTTO_KADABRA
	object_event  2,  2, SPRITE_DROWZEE_OW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, Route34GrottoDrowzeeScript, EVENT_ROUTE_34_GROTTO_DROWZEE
