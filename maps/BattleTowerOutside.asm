BattleTowerOutside_MapEvents:
	def_warp_events
	warp_event  9, 21, PLAYERS_HOUSE_1F, 1
	warp_event 18,  9, BATTLE_TOWER_1F, 1
	warp_event 34, 29, ROUTE_40_BATTLE_TOWER_GATE, 3
	warp_event 35, 29, ROUTE_40_BATTLE_TOWER_GATE, 4
	warp_event 19,  9, BATTLE_TOWER_1F, 2
	warp_event 44, 21, OAKS_LAB, 1
	warp_event 26, 23, EARLS_POKEMON_ACADEMY, 1
	warp_event 58, 21, GOLDENROD_GAME_CORNER, 1
	warp_event 19, 21, GOLDENROD_NAME_RATER, 1
	warp_event  6, 26, ROUTE_38_ECRUTEAK_GATE, 3
	warp_event  6, 27, ROUTE_38_ECRUTEAK_GATE, 4

	def_coord_events

	def_bg_events
	bg_event  7, 21, BGEVENT_READ, PlayersHouseSign
	bg_event 41, 21, BGEVENT_READ, OaksLabSign
	bg_event 30, 23, BGEVENT_READ, EarlsPokemonAcademySign
	bg_event 62, 21, BGEVENT_READ, GameCornerSign
	bg_event 24,  8, BGEVENT_READ, BattleTowerOutsideSign
	bg_event 22, 21, BGEVENT_READ, PokeBrosSign

	object_const_def
	const BATTLETOWEROUTSIDE_STANDING_YOUNGSTER
	const BATTLETOWEROUTSIDE_BEAUTY
	const BATTLETOWEROUTSIDE_SAILOR
	const BATTLETOWEROUTSIDE_LASS

	def_object_events
	object_event 45, 10, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, BattleTowerOutsideYoungsterScript, -1
	object_event 56, 11, SPRITE_BEAUTY, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, BattleTowerOutsideBeautyScript, -1
	object_event 14, 10, SPRITE_SAILOR, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BattleTowerOutsideSailorScript, -1
	object_event 22, 11, SPRITE_LASS, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1

BattleTowerOutside_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, BattleTowerOutsideFlypointCallback

BattleTowerOutsideFlypointCallback:
	setflag ENGINE_FLYPOINT_BATTLE_TOWER
	endcallback

PlayersHouseSign:
	jumptext PlayersHouseSignText

PlayersHouseSignText:
	text "<PLAYER>'s House"
	done

EarlsPokemonAcademySign:
	jumptext EarlsPokemonAcademySignText

EarlsPokemonAcademySignText:
	text "Earl's #mon"
	line "Academy"
	
	para "Learn more than"
	line "just the basics!"
	done

OaksLabSign:
	jumptext OaksLabSignText

OaksLabSignText:
	text "Professor Oak's"
	line "Research Lab"
	done

GameCornerSign:
	jumptext GameCornerSignText

GameCornerSignText:
	text "Game Corner"

	para "Dare to Risk,"
	line "Dare to Win!"
	done

PokeBrosSign:
	jumptext PokeBrosSignText

PokeBrosSignText:
	text "#-Bros."

	para "We can help you"
	line "and your friends!"
	done

BattleTowerOutsideYoungsterScript:
	jumptextfaceplayer BattleTowerOutsideYoungsterText

BattleTowerOutsideYoungsterText:
	text "Wow, the BATTLE"
	line "TOWER is huge!"

	para "There must be many"
	line "kinds of #MON"
	cont "in there!"
	done

BattleTowerOutsideBeautyScript:
	jumptextfaceplayer BattleTowerOutsideBeautyText

BattleTowerOutsideBeautyText:
	text "You can use only"
	line "three #MON."

	para "It's so hard to"
	line "decide which three"

	para "should go into"
	line "battle…"
	done

BattleTowerOutsideSailorScript:
	jumptextfaceplayer BattleTowerOutsideSailorText

BattleTowerOutsideSailorText:
	text "Hehehe, I snuck"
	line "out from work."

	para "I can't bail out"
	line "until I've won!"

	para "I have to win it"
	line "all. That I must!"
	done

BattleTowerOutsideSign:
	jumptext BattleTowerOutsideSignText

BattleTowerOutsideSignText:
	text "BATTLE TOWER"

	para "Take the Ultimate"
	line "Trainer Challenge!"
	done
