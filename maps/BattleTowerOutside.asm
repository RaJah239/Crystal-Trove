BattleTowerOutside_MapEvents:
	def_warp_events
	warp_event  9, 21, PLAYERS_HOUSE_1F, 1
	warp_event 18,  9, BATTLE_TOWER_1F, 1
	warp_event 35, 29, ROUTE_36_RUINS_OF_ALPH_GATE, 2
	warp_event 34, 29, ROUTE_36_RUINS_OF_ALPH_GATE, 1
	warp_event 19,  9, BATTLE_TOWER_1F, 2
	warp_event 44, 21, OAKS_LAB, 1
	warp_event 26, 23, EARLS_POKEMON_ACADEMY, 1
	warp_event 58, 21, GOLDENROD_GAME_CORNER, 1
	warp_event 19, 21, GOLDENROD_NAME_RATER, 1
	warp_event  6, 26, BATTLE_PLAZA_TRAILWAY_GATE, 3
	warp_event  6, 27, BATTLE_PLAZA_TRAILWAY_GATE, 4
	warp_event 63, 27, ROUTE_42_ECRUTEAK_GATE, 2
	warp_event 63, 26, ROUTE_42_ECRUTEAK_GATE, 1
	warp_event 34,  5, BATTLE_PLAZA_SCALD_RIFT_GATE, 1

	def_coord_events

	def_bg_events
	bg_event  7, 21, BGEVENT_READ, PlayersHouseSign
	bg_event 41, 21, BGEVENT_READ, OaksLabSign
	bg_event 30, 23, BGEVENT_READ, EarlsPokemonAcademySign
	bg_event 62, 21, BGEVENT_READ, GameCornerSign
	bg_event 24,  8, BGEVENT_READ, BattleTowerOutsideSign
	bg_event 22, 21, BGEVENT_READ, PokeBrosSign

	object_const_def

	def_object_events

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

BattleTowerOutsideSign:
	jumptext BattleTowerOutsideSignText

BattleTowerOutsideSignText:
	text "Battle Tower"

	para "Take the Ultimate"
	line "Trainer Challenge!"
	done
