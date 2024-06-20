	object_const_def
	const GOLDENRODNAMERATER_NAME_RATER
	const GOLDENRODNAMERATER_SWARM_GRAMPS
	const GOLDENRODNAMERATER_MOVE_RELEARNER

GoldenrodNameRater_MapScripts:
	def_scene_scripts

	def_callbacks

GoldenrodNameRater:
	faceplayer
	opentext
	special NameRater
	waitbutton
	closetext
	turnobject GOLDENRODNAMERATER_NAME_RATER, LEFT
	end

SwarmGrampsScript:
	faceplayer
	opentext
	checkflag ENGINE_SWARM
	iftrue .skiprandomswarm
	writetext GeneralPreSwarmText
	promptbutton
	random 15
	ifequal 0, .bulbasaur
	ifequal 1, .charmander
	ifequal 2, .squirtle
	ifequal 3, .chikorita
	ifequal 4, .cyndaquil
	ifequal 5, .totodile
	ifequal 6, .pichu
	ifequal 7, .cleffa
	ifequal 8, .igglybuff
	ifequal 9, .togepi
	ifequal 10, .tyrogue
	ifequal 11, .ditto
	ifequal 12, .smoochum
	ifequal 13, .elekid
	ifequal 14, .magby

.bulbasaur
	setflag ENGINE_SWARM
	swarm ROUTE_36
	writetext SwarmBulbasaurText
	waitbutton
	closetext
	end

.charmander
	setflag ENGINE_SWARM
	swarm BURNED_TOWER_1F
	writetext SwarmCharmanderText
	waitbutton
	closetext
	end

.squirtle
	setflag ENGINE_SWARM
	swarm ROUTE_43
	writetext SwarmSquirtleText
	waitbutton
	closetext
	end

.chikorita
	setflag ENGINE_SWARM
	swarm ROUTE_37
	writetext SwarmChikoritaText
	waitbutton
	closetext
	end

.cyndaquil
	setflag ENGINE_SWARM
	swarm ROUTE_39
	writetext SwarmCyndaquilText
	waitbutton
	closetext
	end

.totodile
	setflag ENGINE_SWARM
	swarm ROUTE_42
	writetext SwarmTotodileText
	waitbutton
	closetext
	end

.pichu
	setflag ENGINE_SWARM
	swarm ROUTE_31
	writetext SwarmPichuText
	waitbutton
	closetext
	end

.cleffa
	setflag ENGINE_SWARM
	swarm SLOWPOKE_WELL_B1F
	writetext SwarmCleffaText
	waitbutton
	closetext
	end

.igglybuff
	setflag ENGINE_SWARM
	swarm ROUTE_46
	writetext SwarmIgglybuffText
	waitbutton
	closetext
	end

.togepi
	setflag ENGINE_SWARM
	swarm ROUTE_34
	writetext SwarmTogepiText
	waitbutton
	closetext
	end

.tyrogue
	setflag ENGINE_SWARM
	swarm UNION_CAVE_1F
	writetext SwarmTyrogueText
	waitbutton
	closetext
	end

.ditto
	setflag ENGINE_SWARM
	swarm ROUTE_35
	writetext SwarmDittoText
	waitbutton
	closetext
	end

.smoochum
	setflag ENGINE_SWARM
	swarm DARK_CAVE_VIOLET_ENTRANCE
	writetext SwarmSmoochumText
	waitbutton
	closetext
	end

.elekid
	setflag ENGINE_SWARM
	swarm ROUTE_32
	writetext SwarmElekidText
	waitbutton
	closetext
	end

.magby
	setflag ENGINE_SWARM
	swarm ROUTE_33
	writetext SwarmMagbyText
	waitbutton
	closetext
	end

.skiprandomswarm
	writetext SkipSwarmText
	waitbutton
	closetext
	end

GeneralPreSwarmText:
	text "Let me see…"
	line "What did the news"
	cont "say?"
	done

SwarmBulbasaurText:
	text "There's a swarm of"
	line "BULBASAUR at"
	cont "ROUTE 36!"
	done
	
SwarmCharmanderText:
	text "There's a swarm of"
	line "CHARMANDER in the"
	cont "BURNED TOWER!"
	done
	
SwarmSquirtleText:
	text "There's a swarm of"
	line "SQUIRTLE on"
	cont "ROUTE 43!"
	done

SwarmChikoritaText:
	text "There's a swarm of"
	line "CHIKORITA on"
	cont "ROUTE 37!"
	done

SwarmCyndaquilText:
	text "There's a swarm of"
	line "CYNDAQUIL on"
	cont "ROUTE 39!"
	done

SwarmTotodileText:
	text "There's a swarm of"
	line "TOTODILE on"
	cont "ROUTE 42!"
	done

SwarmPichuText:
	text "There's a swarm of"
	line "PICHU on"
	cont "ROUTE 31!"
	done

SwarmCleffaText:
	text "There's a swarm of"
	line "CLEFFA in the"
	cont "SLOWPOKE WELL!"
	done

SwarmIgglybuffText:
	text "There's a swarm of"
	line "IGGLYBUFF on"
	cont "ROUTE 46!"
	done

SwarmTogepiText:
	text "There's a swarm of"
	line "TOGEPI on"
	cont "ROUTE 34!"
	done

SwarmTyrogueText:
	text "There's a swarm of"
	line "TYROGUE in the"
	cont "UNION CAVE!"
	done

SwarmDittoText:
	text "There's a swarm of"
	line "DITTO on"
	cont "ROUTE 35!"
	done

SwarmSmoochumText:
	text "There's a swarm of"
	line "SMOOCHUM in"
	cont "DARK CAVE!"
	done

SwarmElekidText:
	text "There's a swarm of"
	line "ELEKID on"
	cont "ROUTE 32!"
	done

SwarmMagbyText:
	text "There's a swarm of"
	line "MAGBY on"
	cont "ROUTE 33!"
	done

SkipSwarmText:
	text "You forgot which"
	line "#MON is swarm-"
	cont "ing?"
	
	para "Me too! I'm old."

	para "What I do remember"
	line "is there are 15"
	cont "#MON swarms."

	para "You ought visit"
	line "me again sometime."
	done

MoveRelearnerScript:
	faceplayer
	opentext
	special MoveRelearner
	waitbutton
	closetext
	turnobject GOLDENRODNAMERATER_MOVE_RELEARNER, RIGHT
	end

GoldenrodNameRaterBookshelf:
	jumpstd DifficultBookshelfScript

GoldenrodNameRaterRadio:
	jumpstd Radio2Script

GoldenrodNameRater_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 8
	warp_event  3,  7, GOLDENROD_CITY, 8

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, GoldenrodNameRaterBookshelf
	bg_event  1,  1, BGEVENT_READ, GoldenrodNameRaterBookshelf
	bg_event  7,  1, BGEVENT_READ, GoldenrodNameRaterRadio

	def_object_events
	object_event  5,  3, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_LEFT, 2, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodNameRater, -1
	object_event  2,  4, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, SwarmGrampsScript, -1
	object_event  2,  3, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_RIGHT, 2, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, MoveRelearnerScript, -1
