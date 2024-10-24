	object_const_def
	const VIOLETCITY_EARL
	const VIOLETCITY_LASS
	const VIOLETCITY_SUPER_NERD
	const VIOLETCITY_GRAMPS
	const VIOLETCITY_YOUNGSTER
	const VIOLETCITY_POKE_BALL1
	const VIOLETCITY_POKE_BALL2
	const VIOLETCITY_BERRY
	const VIOLETCITY_APRICORN

VioletCity_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, VioletCityFlypointCallback
	callback MAPCALLBACK_OBJECTS, VioletCityFruittrees

VioletCityFlypointCallback:
	setflag ENGINE_FLYPOINT_VIOLET
	endcallback

VioletCityFruittrees:
	readvar VAR_WEEKDAY
	ifequal MONDAY, .NoFruit
	ifequal WEDNESDAY, .NoFruit
	ifequal FRIDAY, .NoFruit
	ifequal SUNDAY, .NoFruit
	checkflag ENGINE_DAILY_ROUTE_31_VIOLET_TREES
	iftrue .NoFruit
	appear VIOLETCITY_BERRY
	appear VIOLETCITY_APRICORN
.NoFruit
	endcallback

VioletCityEarlScript:
	applymovement VIOLETCITY_EARL, VioletCitySpinningEarl_MovementData
	faceplayer
	opentext
	writetext Text_EarlAsksIfYouBeatFalkner
	waitbutton
	closetext
	playmusic MUSIC_SHOW_ME_AROUND
	follow VIOLETCITY_EARL, PLAYER
	applymovement VIOLETCITY_EARL, VioletCityFollowEarl_MovementData
	turnobject PLAYER, RIGHT
	applymovement VIOLETCITY_EARL, VioletCitySpinningEarl_MovementData
	stopfollow
	special RestartMapMusic
	opentext
	writetext Text_HereTeacherIAm
	waitbutton
	closetext
	applymovement VIOLETCITY_EARL, VioletCitySpinningEarl_MovementData
	applymovement VIOLETCITY_EARL, VioletCityFinishFollowEarl_MovementData
	playsound SFX_ENTER_DOOR
	disappear VIOLETCITY_EARL
	clearevent EVENT_EARLS_ACADEMY_EARL
	waitsfx
	end

VioletCityLassScript:
	jumptextfaceplayer VioletCityLassText

VioletCitySuperNerdScript:
	jumptextfaceplayer VioletCitySuperNerdText

VioletCityGrampsScript:
	jumptextfaceplayer VioletCityGrampsText

VioletCityYoungsterScript:
	jumptextfaceplayer VioletCityYoungsterText

VioletCitySign:
	jumptext VioletCitySignText

VioletGymSign:
	jumptext VioletGymSignText

SproutTowerSign:
	jumptext SproutTowerSignText

EarlsPokemonAcademySign:
	jumptext EarlsPokemonAcademySignText

VioletCityPokecenterSign:
	jumpstd PokecenterSignScript

VioletCityMartSign:
	jumpstd MartSignScript

VioletCityPPUp:
	itemball RARE_CANDY

VioletCityRareCandy:
	itemball RARE_CANDY

VioletCityHiddenHyperPotion:
	hiddenitem HYPER_POTION, EVENT_VIOLET_CITY_HIDDEN_HYPER_POTION

VioletCityFollowEarl_MovementData:
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	turn_head RIGHT
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	turn_head LEFT
	step_end

VioletCityFinishFollowEarl_MovementData:
	step UP
	step_end

VioletCitySpinningEarl_MovementData:
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	turn_head LEFT
	step_end

Text_EarlAsksIfYouBeatFalkner:
	text "Hello! You are"
	line "new trainer, yes?"

	para "Then study you"
	line "shall! Follow me!"
	done

Text_HereTeacherIAm:
	text "Here, teacher I"
	line "am. Good it is"
	cont "you study here!"

	para "There are books"
	line "on the tables."

	para "Read them all!"
	done

VioletCityLassText:
	text "Ghosts are rumored"
	line "to appear in"
	cont "SPROUT TOWER."

	para "They said normal-"
	line "type #MON moves"

	para "had no effect on"
	line "ghosts."
	done

VioletCitySuperNerdText:
	text "Hey, you're a"
	line "#MON trainer?"

	para "If you beat the"
	line "GYM LEADER here,"

	para "you'll be ready"
	line "for prime time!"
	done

VioletCityGrampsText:
	text "FALKNER, from the"
	line "VIOLET #MON"

	para "GYM, is a fine"
	line "trainer!"

	para "He inherited his"
	line "father's gym and"

	para "has done a great"
	line "job with it."
	done

VioletCityYoungsterText:
	text "I saw a wiggly"
	line "tree up ahead!"

	para "If you touch it,"
	line "it squirms and"
	cont "dances! Cool!"
	done

VioletCitySignText:
	text "VIOLET CITY"

	para "The City of"
	line "Nostalgic Scents"
	done

VioletGymSignText:
	text "VIOLET CITY"
	line "#MON GYM"
	cont "LEADER: FALKNER"

	para "The Elegant Master"
	line "of Flying #MON"
	done

SproutTowerSignText:
	text "SPROUT TOWER"

	para "Experience the"
	line "Way of #MON"
	done

EarlsPokemonAcademySignText:
	text "EARL'S #MON"
	line "ACADEMY"
	done

VioletCityBerryTree:
	opentext
	getitemname STRING_BUFFER_3, PRZCUREBERRY
	writetext VioletCityTreeText
	promptbutton
	writetext VioletCityHeyItsBerryApricornText
	promptbutton
	giveitem PRZCUREBERRY
	iffalse VioletCityNoRoomInBag
	disappear VIOLETCITY_BERRY
	setflag ENGINE_DAILY_ROUTE_31_VIOLET_TREES
	writetext VioletCityFoundItemText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	end

VioletCityApricornTree:
	opentext
	getitemname STRING_BUFFER_3, YLW_APRICORN
	writetext VioletCityTreeText
	promptbutton
	writetext VioletCityHeyItsBerryApricornText
	promptbutton
	giveitem YLW_APRICORN
	iffalse VioletCityNoRoomInBag
	disappear VIOLETCITY_APRICORN
	setflag ENGINE_DAILY_ROUTE_31_VIOLET_TREES
	writetext VioletCityFoundItemText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	end

VioletCityNoBerryOrApricorn:
	opentext
	writetext VioletCityTreeText
	promptbutton
	writetext VioletCityNothingHereText
	waitbutton
	closetext
	end

VioletCityNoRoomInBag:
	writetext VioletCityNoRoomInBagText
	waitbutton
	closetext
	end

VioletCityTreeText:
	text_far _FruitBearingTreeText
	text_end

VioletCityNothingHereText:
	text_far _NothingHereText
	text_end

VioletCityHeyItsBerryApricornText:
	text "Hey! It's a"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done

VioletCityFoundItemText:
	text_far _ObtainedFruitText
	text_end

VioletCityNoRoomInBagText:
	text_far _CantCarryItemText
	text_end

VioletCity_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  9, 17, VIOLET_MART, 2
	warp_event 18, 17, VIOLET_GYM, 1
	warp_event 30, 17, EARLS_POKEMON_ACADEMY, 1
	warp_event  3, 15, VIOLET_NICKNAME_SPEECH_HOUSE, 1
	warp_event 31, 25, VIOLET_POKECENTER_1F, 1
	warp_event 21, 29, VIOLET_KYLES_HOUSE, 1
	warp_event 23,  5, SPROUT_TOWER_1F, 1
	warp_event 39, 24, ROUTE_31_VIOLET_GATE, 1
	warp_event 39, 25, ROUTE_31_VIOLET_GATE, 2

	def_coord_events

	def_bg_events
	bg_event 24, 20, BGEVENT_READ, VioletCitySign
	bg_event 15, 17, BGEVENT_READ, VioletGymSign
	bg_event 24,  8, BGEVENT_READ, SproutTowerSign
	bg_event 27, 17, BGEVENT_READ, EarlsPokemonAcademySign
	bg_event 32, 25, BGEVENT_READ, VioletCityPokecenterSign
	bg_event 10, 17, BGEVENT_READ, VioletCityMartSign
	bg_event 37, 14, BGEVENT_ITEM, VioletCityHiddenHyperPotion
	bg_event 14, 29, BGEVENT_READ, VioletCityNoBerryOrApricorn
	bg_event 12, 16, BGEVENT_READ, VioletCityNoBerryOrApricorn

	def_object_events
	object_event 18, 18, SPRITE_FISHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VioletCityEarlScript, EVENT_VIOLET_CITY_EARL
	object_event 28, 28, SPRITE_LASS, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VioletCityLassScript, -1
	object_event 24, 14, SPRITE_SUPER_NERD, SPRITEMOVEDATA_WANDER, 1, 2, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, VioletCitySuperNerdScript, -1
	object_event 13, 15, SPRITE_GRAMPS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VioletCityGrampsScript, -1
	object_event  5, 18, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VioletCityYoungsterScript, -1
	object_event  4,  1, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, VioletCityPPUp, EVENT_VIOLET_CITY_PP_UP
	object_event 35,  5, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, VioletCityRareCandy, EVENT_VIOLET_CITY_RARE_CANDY
	object_event 12, 16, SPRITE_BERRY_YELLOW, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VioletCityBerryTree, EVENT_VIOLET_BERRY
	object_event 14, 29, SPRITE_APRICORN_YELLOW, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VioletCityApricornTree, EVENT_VIOLET_APRICORN
