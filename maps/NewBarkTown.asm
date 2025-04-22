	object_const_def
	const NEWBARKTOWN_TEACHER
	const NEWBARKTOWN_FISHER
	const NEWBARKTOWN_RIVAL
	const NEWBARKTOWN_SCARLET
	const NEWBARKTOWN_SCARLET_SCARLET_BATTLE_WHEN_LEAVING_FOR_LEAGUE

NewBarkTown_MapScripts:
	def_scene_scripts
	scene_script NewBarkTownNoop1Scene, SCENE_NEWBARKTOWN_TEACHER_STOPS_YOU
	scene_script NewBarkTownNoop2Scene, SCENE_NEWBARKTOWN_SCARLET_LEAVES_HOME
	scene_script NewBarkTownNoop3Scene, SCENE_NEWBARKTOWN_SCARLET_BATTLE_WHEN_LEAVING_FOR_LEAGUE
	scene_script NewBarkTownNoop4Scene, SCENE_NEWBARKTOWN_NOOP

	def_callbacks
	callback MAPCALLBACK_NEWMAP, NewBarkTownFlypointCallback

NewBarkTownNoop1Scene:
	end

NewBarkTownNoop2Scene:
	end

NewBarkTownNoop3Scene:
	end

NewBarkTownNoop4Scene:
	end

NewBarkTownFlypointCallback:
	setflag ENGINE_FLYPOINT_NEW_BARK
	clearevent EVENT_FIRST_TIME_BANKING_WITH_MOM
	endcallback

NewBarkTown_TeacherStopsYouScene1:
	playmusic MUSIC_MOM
	turnobject NEWBARKTOWN_TEACHER, LEFT
	opentext
	writetext Text_WaitPlayer
	waitbutton
	closetext
	turnobject PLAYER, RIGHT
	applymovement NEWBARKTOWN_TEACHER, NewBarkTown_TeacherRunsToYouMovement1
	opentext
	writetext Text_WhatDoYouThinkYoureDoing
	waitbutton
	closetext
	follow NEWBARKTOWN_TEACHER, PLAYER
	applymovement NEWBARKTOWN_TEACHER, NewBarkTown_TeacherBringsYouBackMovement1
	stopfollow
	opentext
	writetext Text_ItsDangerousToGoAlone
	waitbutton
	closetext
	special RestartMapMusic
	end

NewBarkTown_TeacherStopsYouScene2:
	playmusic MUSIC_MOM
	turnobject NEWBARKTOWN_TEACHER, LEFT
	opentext
	writetext Text_WaitPlayer
	waitbutton
	closetext
	turnobject PLAYER, RIGHT
	applymovement NEWBARKTOWN_TEACHER, NewBarkTown_TeacherRunsToYouMovement2
	turnobject PLAYER, UP
	opentext
	writetext Text_WhatDoYouThinkYoureDoing
	waitbutton
	closetext
	follow NEWBARKTOWN_TEACHER, PLAYER
	applymovement NEWBARKTOWN_TEACHER, NewBarkTown_TeacherBringsYouBackMovement2
	stopfollow
	opentext
	writetext Text_ItsDangerousToGoAlone
	waitbutton
	closetext
	special RestartMapMusic
	end

NewBarkTownTeacherScript:
	faceplayer
	opentext

;	readvar VAR_PARTYCOUNT
;	ifequal 1, .OnlyHaveOneMonLeft
;	special PlayerGivesAwayAPokemon

	checkevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	iftrue .CallMom
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue .TellMomYoureLeaving
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .MonIsAdorable
	writetext Text_GearIsImpressive
	waitbutton
	closetext
	end
	
;.OnlyHaveOneMonLeft:
;	writetext Text_YouOnlyHaveOneMonLeft
;	waitbutton
;	closetext
;	end

.MonIsAdorable:
	writetext Text_YourMonIsAdorable
	waitbutton
	closetext
	end

.TellMomYoureLeaving:
	writetext Text_TellMomIfLeaving
	waitbutton
	closetext
	end

.CallMom:
	writetext Text_CallMomOnGear
	waitbutton
	closetext
	end

;Text_YouOnlyHaveOneMonLeft:
;	text "You only have 1"
;	line "#MON on you"
;	cont "left!"
;	done

NewBarkTownFisherScript:
	jumptextfaceplayer Text_ElmDiscoveredNewMon

NewBarkTownRivalScript:
	opentext
	writetext NewBarkTownRivalText1
	waitbutton
	closetext
	turnobject NEWBARKTOWN_RIVAL, LEFT
	opentext
	writetext NewBarkTownRivalText2
	waitbutton
	closetext
	follow PLAYER, NEWBARKTOWN_RIVAL
	applymovement PLAYER, NewBarkTown_RivalPushesYouAwayMovement
	stopfollow
	pause 5
	turnobject NEWBARKTOWN_RIVAL, DOWN
	pause 5
	playsound SFX_TACKLE
	applymovement PLAYER, NewBarkTown_RivalShovesYouOutMovement
	applymovement NEWBARKTOWN_RIVAL, NewBarkTown_RivalReturnsToTheShadowsMovement
	end

NewBarkTownSign:
	jumptext NewBarkTownSignText

NewBarkTownPlayersHouseSign:
	jumptext NewBarkTownPlayersHouseSignText

NewBarkTownElmsLabSign:
	jumptext NewBarkTownElmsLabSignText

NewBarkTownElmsHouseSign:
	jumptext NewBarkTownElmsHouseSignText

NewBarkTownScrletsHouseSign:
	jumptext NewBarkTownScrletsHouseSignText

NewBarkTown_TeacherRunsToYouMovement1:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step_end

NewBarkTown_TeacherRunsToYouMovement2:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	turn_head DOWN
	step_end

NewBarkTown_TeacherBringsYouBackMovement1:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	turn_head LEFT
	step_end

NewBarkTown_TeacherBringsYouBackMovement2:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	turn_head LEFT
	step_end

NewBarkTown_RivalPushesYouAwayMovement:
	turn_head UP
	step DOWN
	step_end

NewBarkTown_RivalShovesYouOutMovement:
	turn_head UP
	fix_facing
	jump_step DOWN
	remove_fixed_facing
	step_end

NewBarkTown_RivalReturnsToTheShadowsMovement:
	step RIGHT
	step_end

Text_GearIsImpressive:
	text "Wow, your #GEAR"
	line "is impressive!"

	para "Did your mom get"
	line "it for you?"
	done

Text_WaitPlayer:
	text "Wait, <PLAY_G>!"
	done

Text_WhatDoYouThinkYoureDoing:
	text "What do you think"
	line "you're doing?"
	done

Text_ItsDangerousToGoAlone:
	text "It's dangerous to"
	line "go out without a"
	cont "#MON!"

	para "Wild #MON"
	line "jump out of the"

	para "grass on the way"
	line "to the next town."
	done

Text_YourMonIsAdorable:
	text "Oh! Your #MON"
	line "is adorable!"
	cont "I wish I had one!"
	done

Text_TellMomIfLeaving:
	text "Hi, <PLAY_G>!"
	line "Leaving again?"

	para "You should tell"
	line "your mom if you"
	cont "are leaving."
	done

Text_CallMomOnGear:
	text "Call your mom on"
	line "your #GEAR to"

	para "let her know how"
	line "you're doing."
	done

Text_ElmDiscoveredNewMon:
	text "Yo, <PLAYER>!"

	para "I hear PROF.ELM"
	line "discovered some"
	cont "new #MON."
	done

NewBarkTownRivalText1:
	text "<……>"

	para "So this is the"
	line "famous ELM #MON"
	cont "LAB…"
	done

NewBarkTownRivalText2:
	text "…What are you"
	line "staring at?"
	done

NewBarkTownSignText:
	text "NEW BARK TOWN"

	para "The Town Where the"
	line "Winds of a New"
	cont "Beginning Blow"
	done

NewBarkTownPlayersHouseSignText:
	text "<PLAYER>'s HOUSE"
	done

NewBarkTownElmsLabSignText:
	text "ELM #MON LAB"
	done

NewBarkTownElmsHouseSignText:
	text "ELM'S HOUSE"
	done

NewBarkTownScrletsHouseSignText:
	text "SCARLET'S HOUSE"
	done

NewBarkTown_ScarletLeavesHomeScript:
	appear NEWBARKTOWN_SCARLET
	pause 5
	showemote EMOTE_SHOCK, NEWBARKTOWN_SCARLET, 15
	waitsfx
	applymovement NEWBARKTOWN_SCARLET, NewBarkTownScarletApproachesToTellYouSheIsReadyToLeaveMovement
	playmusic MUSIC_SCARLET
	opentext
	writetext NewBarkTownScarletTellsYouSheIsHeadingOutText
	waitbutton
	closetext
	turnobject NEWBARKTOWN_SCARLET, LEFT
	pause 35
	turnobject NEWBARKTOWN_SCARLET, RIGHT
	pause 35
	turnobject NEWBARKTOWN_SCARLET, UP
	opentext
	writetext NewBarkTownScarletTheWorldOutThereIsHugeText
	waitbutton
	closetext
	applymovement NEWBARKTOWN_SCARLET, NewBarkTownScarletLeavesToGoOnHerAdventureMovement
	disappear NEWBARKTOWN_SCARLET
	setevent EVENT_PLAYERS_NEIGHBOR_SCARLET_HOME
	setevent EVENT_PLAYERS_HOUSE_1F_NEIGHBOR
	clearevent EVENT_PLAYERS_NEIGHBORS_HOUSE_NEIGHBOR
	special RestartMapMusic
	setscene SCENE_NEWBARKTOWN_NOOP
	end

NewBarkTownScarletApproachesToTellYouSheIsReadyToLeaveMovement:
	step UP
	step UP
	step LEFT
	step UP
	step UP
	step_end

NewBarkTownScarletLeavesToGoOnHerAdventureMovement:
	step DOWN
	step DOWN
	step LEFT
	step DOWN
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step_end

NewBarkTownScarletTellsYouSheIsHeadingOutText:
	text "I've completed my"
	line "errands. Also… I"
	
	para "got permission to"
	line "leave home now"
	
	para "since I have my"
	line "own #MON."
	
	para "I'm all packed and"
	line "ready to head out!"
	done

NewBarkTownScarletTheWorldOutThereIsHugeText:
	text "The world out"
	line "there must be"
	cont "huge!"
	
	para "Be sure to tell"
	line "your mom before"
	cont "leaving."

	para "I'm certain our"
	line "paths will cross"
	cont "many times."

	para "Let's push each"
	line "other to excel!"
	
	para "Bye <PLAY_G>, I'll"
	line "see you around…"
	done
NewBarkTown_ScarletBattleScript2:
	moveobject NEWBARKTOWN_SCARLET_SCARLET_BATTLE_WHEN_LEAVING_FOR_LEAGUE, 12, 8
	turnobject PLAYER, LEFT
	showemote EMOTE_SHOCK, PLAYER, 15
	turnobject PLAYER, LEFT
	special FadeOutMusic
	pause 15
	appear NEWBARKTOWN_SCARLET_SCARLET_BATTLE_WHEN_LEAVING_FOR_LEAGUE
	applymovement NEWBARKTOWN_SCARLET_SCARLET_BATTLE_WHEN_LEAVING_FOR_LEAGUE, NewBarkTownScarlet2Approaches
	playmusic MUSIC_SCARLET
	opentext
	writetext SoYoureHeadingToTheLeagueLetsBattleText
	waitbutton
	closetext

	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .chikorita
	winlosstext NewBarkTownScarlet_WinText, NewBarkTownScarlet_LossText
	setlasttalked NEWBARKTOWN_SCARLET_SCARLET_BATTLE_WHEN_LEAVING_FOR_LEAGUE
	loadtrainer SCARLET, SCARLET1
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .returnfrombattle

.totodile
	winlosstext NewBarkTownScarlet_WinText, NewBarkTownScarlet_LossText
	setlasttalked NEWBARKTOWN_SCARLET_SCARLET_BATTLE_WHEN_LEAVING_FOR_LEAGUE
	loadtrainer SCARLET, SCARLET2
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .returnfrombattle

.chikorita
	winlosstext NewBarkTownScarlet_WinText, NewBarkTownScarlet_LossText
	setlasttalked NEWBARKTOWN_SCARLET_SCARLET_BATTLE_WHEN_LEAVING_FOR_LEAGUE
	loadtrainer SCARLET, SCARLET3
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .returnfrombattle

.returnfrombattle
	playmusic MUSIC_SCARLET
	opentext
	writetext NewBarkTownScarlet_AfterText
	waitbutton
	closetext
	applymovement NEWBARKTOWN_SCARLET_SCARLET_BATTLE_WHEN_LEAVING_FOR_LEAGUE, NewBarkTownScarletGoesHome
	setevent EVENT_SCARLET_IS_DEFEATED_IN_NEW_BARK_TOWN
	disappear NEWBARKTOWN_SCARLET_SCARLET_BATTLE_WHEN_LEAVING_FOR_LEAGUE
	playmapmusic
	setscene SCENE_NEWBARKTOWN_NOOP
	end

NewBarkTown_ScarletBattleScript3:
	turnobject PLAYER, LEFT
	showemote EMOTE_SHOCK, PLAYER, 15
	turnobject PLAYER, LEFT
	special FadeOutMusic
	pause 15
	appear NEWBARKTOWN_SCARLET_SCARLET_BATTLE_WHEN_LEAVING_FOR_LEAGUE
	applymovement NEWBARKTOWN_SCARLET_SCARLET_BATTLE_WHEN_LEAVING_FOR_LEAGUE, NewBarkTownScarlet2Approaches
	playmusic MUSIC_SCARLET
	opentext
	writetext SoYoureHeadingToTheLeagueLetsBattleText
	waitbutton
	closetext

	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .chikorita
	winlosstext NewBarkTownScarlet_WinText, NewBarkTownScarlet_LossText
	setlasttalked NEWBARKTOWN_SCARLET_SCARLET_BATTLE_WHEN_LEAVING_FOR_LEAGUE
	loadtrainer SCARLET, SCARLET1
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .returnfrombattle

.totodile
	winlosstext NewBarkTownScarlet_WinText, NewBarkTownScarlet_LossText
	setlasttalked NEWBARKTOWN_SCARLET_SCARLET_BATTLE_WHEN_LEAVING_FOR_LEAGUE
	loadtrainer SCARLET, SCARLET2
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .returnfrombattle

.chikorita
	winlosstext NewBarkTownScarlet_WinText, NewBarkTownScarlet_LossText
	setlasttalked NEWBARKTOWN_SCARLET_SCARLET_BATTLE_WHEN_LEAVING_FOR_LEAGUE
	loadtrainer SCARLET, SCARLET3
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .returnfrombattle

.returnfrombattle
	playmusic MUSIC_SCARLET
	opentext
	writetext NewBarkTownScarlet_AfterText
	waitbutton
	closetext
	applymovement NEWBARKTOWN_SCARLET_SCARLET_BATTLE_WHEN_LEAVING_FOR_LEAGUE, NewBarkTownScarletGoesHome
	setevent EVENT_SCARLET_IS_DEFEATED_IN_NEW_BARK_TOWN
	disappear NEWBARKTOWN_SCARLET_SCARLET_BATTLE_WHEN_LEAVING_FOR_LEAGUE
	playmapmusic
	setscene SCENE_NEWBARKTOWN_NOOP
	end

NewBarkTown_ScarletBattleScript1:
	moveobject NEWBARKTOWN_SCARLET_SCARLET_BATTLE_WHEN_LEAVING_FOR_LEAGUE, 12, 6
	turnobject PLAYER, LEFT
	showemote EMOTE_SHOCK, PLAYER, 15
	turnobject PLAYER, LEFT
	special FadeOutMusic
	pause 15
	appear NEWBARKTOWN_SCARLET_SCARLET_BATTLE_WHEN_LEAVING_FOR_LEAGUE
	applymovement NEWBARKTOWN_SCARLET_SCARLET_BATTLE_WHEN_LEAVING_FOR_LEAGUE, NewBarkTownScarlet2Approaches
	playmusic MUSIC_SCARLET
	opentext
	writetext SoYoureHeadingToTheLeagueLetsBattleText
	waitbutton
	closetext

	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .chikorita
	winlosstext NewBarkTownScarlet_WinText, NewBarkTownScarlet_LossText
	setlasttalked NEWBARKTOWN_SCARLET_SCARLET_BATTLE_WHEN_LEAVING_FOR_LEAGUE
	loadtrainer SCARLET, SCARLET1
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .returnfrombattle

.totodile
	winlosstext NewBarkTownScarlet_WinText, NewBarkTownScarlet_LossText
	setlasttalked NEWBARKTOWN_SCARLET_SCARLET_BATTLE_WHEN_LEAVING_FOR_LEAGUE
	loadtrainer SCARLET, SCARLET2
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .returnfrombattle

.chikorita
	winlosstext NewBarkTownScarlet_WinText, NewBarkTownScarlet_LossText
	setlasttalked NEWBARKTOWN_SCARLET_SCARLET_BATTLE_WHEN_LEAVING_FOR_LEAGUE
	loadtrainer SCARLET, SCARLET3
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .returnfrombattle

.returnfrombattle
	playmusic MUSIC_SCARLET
	opentext
	writetext NewBarkTownScarlet_AfterText
	waitbutton
	closetext
	applymovement NEWBARKTOWN_SCARLET_SCARLET_BATTLE_WHEN_LEAVING_FOR_LEAGUE, NewBarkTownScarletGoesHome
	setevent EVENT_SCARLET_IS_DEFEATED_IN_NEW_BARK_TOWN
	disappear NEWBARKTOWN_SCARLET_SCARLET_BATTLE_WHEN_LEAVING_FOR_LEAGUE
	playmapmusic
	setscene SCENE_NEWBARKTOWN_NOOP
	end

NewBarkTownScarlet2Approaches:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

NewBarkTownScarletGoesHome:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step_end

SoYoureHeadingToTheLeagueLetsBattleText:
	text "SCARLET: Welcome"
	line "home <PLAY_G>!"
	
	para "So you've collect"
	line "all 8 badges in"
	cont "JOHTO?"
	
	para "I have as well but"
	line "I don't think I'm"
	
	para "ready to take on"
	line "on the #MON"
	
	para "LEAGUE yet. First,"
	line "I want test myself"
	
	para "with a battle ag-"
	line "ainst you."
	
	para "Let's go once"
	line "again <PLAY_G>!"
	done

NewBarkTownScarlet_WinText:
	text "Looks like you're"
	line "ready for the"
	cont "#MON LEAGUE!"
	done

NewBarkTownScarlet_LossText:
	text "Looks like I'm"
	line "ready for the"
	cont "#MON LEAGUE!"
	done

NewBarkTownScarlet_AfterText:
	text "SCARLET: That"
	line "battle decided it."

	para "I'm not ready…"
	
	para "I'll train some"
	line "more, then I'll"
	cont "make an attempt."
	
	para "All the best at"
	line "the #MON LEAGUE"
	cont "<PLAY_G>! Bye!"
	done

NewBarkTown_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  6,  3, ELMS_LAB, 1
	warp_event 13,  5, PLAYERS_HOUSE_1F, 1
IF DEF(_DEBUG)
	warp_event  3, 11, RADIO_TOWER_1F, 1
ELSE
	warp_event  3, 11, PLAYERS_NEIGHBORS_HOUSE, 1
ENDC	
	warp_event 11, 13, ELMS_HOUSE, 1

	def_coord_events
	coord_event  1,  8, SCENE_NEWBARKTOWN_TEACHER_STOPS_YOU, NewBarkTown_TeacherStopsYouScene1
	coord_event  1,  9, SCENE_NEWBARKTOWN_TEACHER_STOPS_YOU, NewBarkTown_TeacherStopsYouScene2
	coord_event  6,  4, SCENE_NEWBARKTOWN_SCARLET_LEAVES_HOME, NewBarkTown_ScarletLeavesHomeScript
	coord_event 17,  6, SCENE_NEWBARKTOWN_SCARLET_BATTLE_WHEN_LEAVING_FOR_LEAGUE, NewBarkTown_ScarletBattleScript1
	coord_event 17,  8, SCENE_NEWBARKTOWN_SCARLET_BATTLE_WHEN_LEAVING_FOR_LEAGUE, NewBarkTown_ScarletBattleScript2
	coord_event 17,  9, SCENE_NEWBARKTOWN_SCARLET_BATTLE_WHEN_LEAVING_FOR_LEAGUE, NewBarkTown_ScarletBattleScript3

	def_bg_events
	bg_event  8,  8, BGEVENT_READ, NewBarkTownSign
	bg_event 11,  5, BGEVENT_READ, NewBarkTownPlayersHouseSign
	bg_event  3,  3, BGEVENT_READ, NewBarkTownElmsLabSign
	bg_event  9, 13, BGEVENT_READ, NewBarkTownElmsHouseSign
	bg_event  6, 11, BGEVENT_READ, NewBarkTownScrletsHouseSign

	def_object_events
	object_event  6,  8, SPRITE_TEACHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, NewBarkTownTeacherScript, -1
	object_event 10, 10, SPRITE_FISHER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, NewBarkTownFisherScript, -1
	object_event  3,  2, SPRITE_RIVAL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, NewBarkTownRivalScript, EVENT_RIVAL_NEW_BARK_TOWN
	object_event  7,  9, SPRITE_SCARLET, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_NEW_BARK_TOWN_SCARLET_LEAVES_HOME
	object_event 12,  9, SPRITE_SCARLET, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_NEW_BARK_TOWN_SCARLET_BATTLE_WHEN_LEAVING_FOR_LEAGUE
