    object_const_def
    const ROUTE26GROTTO_CHANSEY
    const ROUTE26GROTTO_MR__MIME
    const ROUTE26GROTTO_KANGASKHAN
    const ROUTE26GROTTO_AMPHAROS
    const ROUTE26GROTTO_SHUCKLE

Route26Grotto_MapScripts:
    def_scene_scripts

    def_callbacks
  	callback MAPCALLBACK_OBJECTS, Route26GrottoPokemonOW
 
Route26GrottoPokemonOW:
    checkevent EVENT_INITIALIZED_EVENTS
    iffalse .NoAppear
    random 20 ; random 5 - this makes it always have a Pokemon.
    ifequal 0, .AppearChansey
    ifequal 1, .AppearMrMime
    ifequal 2, .AppearKangaskhan
    ifequal 3, .AppearAMPHAROS
    ifequal 4, .AppearShuckle
.NoAppear:
    disappear ROUTE26GROTTO_CHANSEY
    disappear ROUTE26GROTTO_MR__MIME
    disappear ROUTE26GROTTO_KANGASKHAN
    disappear ROUTE26GROTTO_AMPHAROS
    disappear ROUTE26GROTTO_SHUCKLE
    endcallback

.AppearChansey:
    disappear ROUTE26GROTTO_MR__MIME
    disappear ROUTE26GROTTO_KANGASKHAN
    disappear ROUTE26GROTTO_AMPHAROS
    disappear ROUTE26GROTTO_SHUCKLE
    appear ROUTE26GROTTO_CHANSEY
    endcallback

.AppearMrMime:
    disappear ROUTE26GROTTO_CHANSEY
    disappear ROUTE26GROTTO_KANGASKHAN
    disappear ROUTE26GROTTO_AMPHAROS
    disappear ROUTE26GROTTO_SHUCKLE
    appear ROUTE26GROTTO_MR__MIME
    endcallback

.AppearKangaskhan:
    disappear ROUTE26GROTTO_CHANSEY
    disappear ROUTE26GROTTO_AMPHAROS
    disappear ROUTE26GROTTO_SHUCKLE
    disappear ROUTE26GROTTO_MR__MIME
    appear ROUTE26GROTTO_KANGASKHAN
    endcallback

.AppearAMPHAROS:
    disappear ROUTE26GROTTO_CHANSEY
    disappear ROUTE26GROTTO_SHUCKLE
    disappear ROUTE26GROTTO_MR__MIME
    disappear ROUTE26GROTTO_KANGASKHAN
    appear ROUTE26GROTTO_AMPHAROS
    endcallback

.AppearShuckle:
    disappear ROUTE26GROTTO_CHANSEY
    disappear ROUTE26GROTTO_AMPHAROS
    disappear ROUTE26GROTTO_MR__MIME
    disappear ROUTE26GROTTO_KANGASKHAN
    appear ROUTE26GROTTO_SHUCKLE
    endcallback

Route26GrottoChanseyScript:
    faceplayer
    cry CHANSEY
    loadwildmon CHANSEY, 53
    loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
    startbattle
    disappear ROUTE26GROTTO_CHANSEY
    reloadmapafterbattle
    end

Route26GrottoMrMimeScript:
    faceplayer
    cry MR__MIME
    loadwildmon MR__MIME, 53
    loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
    startbattle
    disappear ROUTE26GROTTO_MR__MIME
    reloadmapafterbattle
    end

Route26GrottoKangaskhanScript:
    faceplayer
    cry KANGASKHAN
    loadwildmon KANGASKHAN, 53
    loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
    startbattle
    disappear ROUTE26GROTTO_KANGASKHAN
    reloadmapafterbattle
    end

Route26GrottoAMPHAROSScript:
    faceplayer
    cry AMPHAROS
    loadwildmon AMPHAROS, 53
    loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
    startbattle
    disappear ROUTE26GROTTO_AMPHAROS
    reloadmapafterbattle
    end

Route26GrottoShuckleScript:
    faceplayer
    cry SHUCKLE
    loadwildmon SHUCKLE, 53
    loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
    startbattle
    disappear ROUTE26GROTTO_SHUCKLE
    reloadmapafterbattle
    end

Route26GrottoSign:
	jumptext  Route26GrottoSignText

Route26GrottoSignText:
	text "This GROTTO get"
	line "visited by:"
	
	para "CHANSEY, AMPHAROS,"
	line "SHUCKLE, MR.MIME"
	cont "and KANGASKHAN."
	done

Route26Grotto_MapEvents:
    db 0, 0 ; filler

    def_warp_events
	warp_event  9,  6, ROUTE_26, 4
	warp_event  9,  7, ROUTE_26, 5

    def_coord_events

    def_bg_events
	bg_event  5,  8, BGEVENT_READ, Route26GrottoSign

    def_object_events
	object_event  4,  7, SPRITE_CHANSEY_OW, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route26GrottoChanseyScript, EVENT_ROUTE_26_GROTTO_CHANSEY
	object_event  7,  7, SPRITE_MR__MIME_OW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route26GrottoMrMimeScript, EVENT_ROUTE_26_GROTTO_MR__MIME
	object_event  7,  9, SPRITE_KANGASKHAN_OW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, Route26GrottoKangaskhanScript, EVENT_ROUTE_26_GROTTO_KANGASKHAN
	object_event  4,  4, SPRITE_AMPHAROS_OW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, Route26GrottoAMPHAROSScript, EVENT_ROUTE_26_GROTTO_AMPHAROS
	object_event  6,  5, SPRITE_SHUCKLE_OW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route26GrottoShuckleScript, EVENT_ROUTE_26_GROTTO_SHUCKLE
