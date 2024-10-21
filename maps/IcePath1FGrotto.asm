    object_const_def
    const ICEPATH1GROTTO_DELIBIRD
    const ICEPATH1GROTTO_SNEASEL
    const ICEPATH1GROTTO_PILOSWINE
    const ICEPATH1GROTTO_CLOYSTER
    const ICEPATH1GROTTO_DEWGONG

IcePath1FGrotto_MapScripts:
    def_scene_scripts

    def_callbacks
  	callback MAPCALLBACK_OBJECTS, IcePath1FGrottoPokemonOW
 
IcePath1FGrottoPokemonOW:
    checkevent EVENT_INITIALIZED_EVENTS
    iffalse .NoAppear
    random 20 ; random 5 - this makes it always have a Pokemon.
    ifequal 0, .AppearDelibird
    ifequal 1, .AppearSneasel
    ifequal 2, .AppearPiloswine
    ifequal 3, .AppearCloyster
    ifequal 4, .AppearDewgong
.NoAppear:
    disappear ICEPATH1GROTTO_DELIBIRD
    disappear ICEPATH1GROTTO_SNEASEL
    disappear ICEPATH1GROTTO_PILOSWINE
    disappear ICEPATH1GROTTO_CLOYSTER
    disappear ICEPATH1GROTTO_DEWGONG
    endcallback

.AppearDelibird:
    disappear ICEPATH1GROTTO_SNEASEL
    disappear ICEPATH1GROTTO_PILOSWINE
    disappear ICEPATH1GROTTO_CLOYSTER
    disappear ICEPATH1GROTTO_DEWGONG
    appear ICEPATH1GROTTO_DELIBIRD
    endcallback

.AppearSneasel:
    disappear ICEPATH1GROTTO_DELIBIRD
    disappear ICEPATH1GROTTO_PILOSWINE
    disappear ICEPATH1GROTTO_CLOYSTER
    disappear ICEPATH1GROTTO_DEWGONG
    appear ICEPATH1GROTTO_SNEASEL
    endcallback

.AppearPiloswine:
    disappear ICEPATH1GROTTO_DELIBIRD
    disappear ICEPATH1GROTTO_CLOYSTER
    disappear ICEPATH1GROTTO_DEWGONG
    disappear ICEPATH1GROTTO_SNEASEL
    appear ICEPATH1GROTTO_PILOSWINE
    endcallback

.AppearCloyster:
    disappear ICEPATH1GROTTO_DELIBIRD
    disappear ICEPATH1GROTTO_DEWGONG
    disappear ICEPATH1GROTTO_SNEASEL
    disappear ICEPATH1GROTTO_PILOSWINE
    appear ICEPATH1GROTTO_CLOYSTER
    endcallback

.AppearDewgong:
    disappear ICEPATH1GROTTO_DELIBIRD
    disappear ICEPATH1GROTTO_CLOYSTER
    disappear ICEPATH1GROTTO_SNEASEL
    disappear ICEPATH1GROTTO_PILOSWINE
    appear ICEPATH1GROTTO_DEWGONG
    endcallback

IcePath1FGrottoDelibirdScript:
    faceplayer
    cry DELIBIRD
    loadwildmon DELIBIRD, 42
    loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
    startbattle
    disappear ICEPATH1GROTTO_DELIBIRD
    reloadmapafterbattle
    end

IcePath1FGrottoSneaselScript:
    faceplayer
    cry SNEASEL
    loadwildmon SNEASEL, 42
    loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
    startbattle
    disappear ICEPATH1GROTTO_SNEASEL
    reloadmapafterbattle
    end

IcePath1FGrottoPiloswineScript:
    faceplayer
    cry PILOSWINE
    loadwildmon PILOSWINE, 42
    loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
    startbattle
    disappear ICEPATH1GROTTO_PILOSWINE
    reloadmapafterbattle
    end

IcePath1FGrottoCloysterScript:
    faceplayer
    cry CLOYSTER
    loadwildmon CLOYSTER, 42
    loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
    startbattle
    disappear ICEPATH1GROTTO_CLOYSTER
    reloadmapafterbattle
    end

IcePath1FGrottoDewgonScript:
    faceplayer
    cry DEWGONG
    loadwildmon DEWGONG, 42
    loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
    startbattle
    disappear ICEPATH1GROTTO_DEWGONG
    reloadmapafterbattle
    end

IcePath1FGrottoSign:
	jumptext  IcePath1FGrottoSignText

IcePath1FGrottoSignText:
	text "This GROTTO get"
	line "visited by:"

	para "CLOYSTER, DEWGONG,"
	line "SNEASEL, DELIBIRD"
	cont "and PILOSWINE."
	done

IcePath1FGrotto_MapEvents:
    db 0, 0 ; filler

    def_warp_events
	warp_event  3,  3, ICE_PATH_1F, 5

    def_coord_events

    def_bg_events
	bg_event  2,  2, BGEVENT_READ, IcePath1FGrottoSign

    def_object_events
	object_event  4,  1, SPRITE_DELIBIRD_MART, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, IcePath1FGrottoDelibirdScript, EVENT_ICE_PATH_1F_GROTTO_DELIBIRD
	object_event  2,  0, SPRITE_SNEASEL_OW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, IcePath1FGrottoSneaselScript, EVENT_ICE_PATH_1F_GROTTO_SNEASEL
	object_event  4,  4, SPRITE_PILOSWINE_OW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, IcePath1FGrottoPiloswineScript, EVENT_ICE_PATH_1F_GROTTO_PILOSWINE
	object_event  1,  4, SPRITE_CLOYSTER_OW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, IcePath1FGrottoCloysterScript, EVENT_ICE_PATH_1F_GROTTO_CLOYSTER
	object_event  1,  1,SPRITE_DEWGONG_OW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, IcePath1FGrottoDewgonScript, EVENT_ICE_PATH_1F_GROTTO_DEWGONG
