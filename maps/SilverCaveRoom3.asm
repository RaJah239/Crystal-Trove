	object_const_def
	const SILVERCAVEROOM3_RED

SilverCaveRoom3_MapScripts:
	def_scene_scripts

	def_callbacks

Red:
	special FadeOutMusic
	faceplayer
	opentext
	writetext RedText
	waitbutton
	closetext
	winlosstext RedWinLossText, RedWinLossText
	checkevent EVENT_BEAT_RED
	iftrue .Rematch
; player hasn't beaten RED yet
	loadtrainer RED, RED1
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	setevent EVENT_BEAT_RED
	setevent EVENT_NO_E4_REMATCH_UNTIL_RED_IS_BEATEN
	setevent EVENT_VIRIDIAN_TRAINER_HOUSE_BLOCKER
	specialphonecall SPECIALCALL_RED_BEATEN
	special FadeOutMusic
	opentext
	writetext RedText
	waitbutton
	closetext
	special FadeOutToBlack
	special ReloadSpritesNoPalettes
	disappear SILVERCAVEROOM3_RED
	pause 15
	special FadeInFromBlack
	pause 30
	special HealParty
	reanchormap
	credits
	end

.Rematch:
	loadtrainer RED, RED2
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	special FadeOutMusic
	opentext
	writetext RedText
	waitbutton
	closetext
	special FadeOutToBlack
	special ReloadSpritesNoPalettes
	disappear SILVERCAVEROOM3_RED
	pause 15
	special FadeOutToBlack
	pause 30
	special HealParty
	special BeastsCheck
	iffalse .YouStillNeedToCatchRoamers
	clearevent EVENT_ROUTE_45_RAIKOU
	clearevent EVENT_BURNED_TOWER_ENTEI
	jump .TheRegularStuff
	end

.YouStillNeedToCatchRoamers
	special InitRoamMons
	jump .TheRegularStuff
	end

.TheRegularStuff:
	clearevent EVENT_GOT_ODD_EGG
	clearevent EVENT_ICE_PATH_1F_ARTICUNO
	clearevent EVENT_MOUNTMORTARB1F_ZAPDOS
	clearevent EVENT_VICTORY_ROAD_MOLTRES
	setevent EVENT_FOREST_IS_RESTLESS
	clearevent EVENT_FOUGHT_LUGIA
	clearevent EVENT_WHIRL_ISLAND_LUGIA_CHAMBER_LUGIA
	clearevent EVENT_ROUTE_42_STATIONARY_SUICUNE
	clearevent EVENT_FOUGHT_HO_OH
	clearevent EVENT_TIN_TOWER_ROOF_HO_OH
	clearevent EVENT_RUINSOFALPHHOOHWORDROOM_MEW
	clearevent EVENT_SILVER_CAVE_ITEM_ROOMS_MEWTWO
	refreshscreen
	credits
	end

RedText:
	text "<……>"
	line "<……>"
	done

RedWinLossText:
	text "…"
	done

SilverCaveRoom3_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  9, 33, SILVER_CAVE_ROOM_2, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  9, 10, SPRITE_RED, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Red, EVENT_RED_IN_MT_SILVER
