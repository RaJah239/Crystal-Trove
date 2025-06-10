	object_const_def
	const PLAYERSHOUSE2F_CONSOLE
	const PLAYERSHOUSE2F_DOLL_1
	const PLAYERSHOUSE2F_DOLL_2
	const PLAYERSHOUSE2F_BIG_DOLL
if DEF(_DEBUG)
	const PLAYERSHOUSE2F_TEST
	const PLAYERSHOUSE2F_KANTO_WARP
endc

PlayersHouse2F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, PlayersHouse2FInitializeRoomCallback
	callback MAPCALLBACK_TILES, PlayersHouse2FSetUpTileDecorationsCallback

PlayersHouse2FInitializeRoomCallback:
	special ToggleDecorationsVisibility
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_8
	endcallback

PlayersHouse2FSetUpTileDecorationsCallback:
	special ToggleMaptileDecorations
	endcallback

	db 0, 0, 0 ; unused

PlayersHouseDoll1Script::
	describedecoration DECODESC_LEFT_DOLL

PlayersHouseDoll2Script:
	describedecoration DECODESC_RIGHT_DOLL

PlayersHouseBigDollScript:
	describedecoration DECODESC_BIG_DOLL

PlayersHouseGameConsoleScript:
	describedecoration DECODESC_CONSOLE

PlayersHousePosterScript:
	conditional_event EVENT_PLAYERS_ROOM_POSTER, .Script

.Script:
	describedecoration DECODESC_POSTER

PlayersHouseRadioScript:
if DEF(_DEBUG)
	opentext
	givemoney YOUR_MONEY, MAX_MONEY
	giveitem BICYCLE
	giveitem COIN_CASE
	givecoins MAX_COINS
	giveitem LANTERN
	giveitem HEDGER
	giveitem POWER_GLOVE
	giveitem PADDLE_BOAT
	; good party
	givepoke MEW, 99, LEFTOVERS
	givepoke SMEARGLE, 99, FOCUS_BAND
	givepoke GYARADOS, 99, GOLD_BERRY
	givepoke DIGLETT, 17
	givepoke DITTO, 5, METAL_POWDER
	givepoke ABRA, 5, EVERSTONE
	; first mon shiny
	loadmem wPartyMon1DVs+0, $ea
	loadmem wPartyMon1DVs+1, $aa
	; third mon shiny
	loadmem wPartyMon3DVs+0, $ea
	loadmem wPartyMon3DVs+1, $aa
	; useful moves
	loadmem wPartyMon1Moves+0, ICE_BEAM
	loadmem wPartyMon1Moves+1, THUNDERBOLT
	loadmem wPartyMon1Moves+2, FLAMETHROWER
	; overworld moves
	loadmem wPartyMon1Moves+3, FLY
	loadmem wPartyMon2Moves+0, CUT
	loadmem wPartyMon2Moves+1, SURF
	loadmem wPartyMon2Moves+2, STRENGTH
	loadmem wPartyMon2Moves+3, FLASH
	loadmem wPartyMon3Moves+0, WHIRLPOOL
	loadmem wPartyMon3Moves+1, WATERFALL
	loadmem wPartyMon3Moves+2, HEADBUTT
	loadmem wPartyMon3Moves+3, ROCK_SMASH
	closetext
	; tms for party
	giveitem TM_ROCK_SMASH, 50
	giveitem TM_HEADBUTT, 50
	giveitem TM_DIG, 50
	giveitem TM_HIDDEN_POWER, 50
	; all hms
	giveitem HM_CUT
	giveitem HM_FLY
	giveitem HM_SURF
	giveitem HM_STRENGTH
	giveitem HM_FLASH
	giveitem HM_WHIRLPOOL
	giveitem HM_WATERFALL
	; full pokegear
	setflag ENGINE_POKEGEAR
	setflag ENGINE_PHONE_CARD
	setflag ENGINE_MAP_CARD
	setflag ENGINE_RADIO_CARD
	setflag ENGINE_EXPN_CARD
	; pokedex
	setflag ENGINE_POKEDEX
	; all badges
	setflag ENGINE_ZEPHYRBADGE
	setflag ENGINE_HIVEBADGE
	setflag ENGINE_PLAINBADGE
	setflag ENGINE_FOGBADGE
	setflag ENGINE_STORMBADGE
	setflag ENGINE_MINERALBADGE
	setflag ENGINE_GLACIERBADGE
	setflag ENGINE_RISINGBADGE
	setflag ENGINE_BOULDERBADGE
	setflag ENGINE_CASCADEBADGE
	setflag ENGINE_THUNDERBADGE
	setflag ENGINE_RAINBOWBADGE
	setflag ENGINE_MARSHBADGE
	setflag ENGINE_SOULBADGE
	setflag ENGINE_VOLCANOBADGE
	setflag ENGINE_EARTHBADGE
	; fly points
	setflag ENGINE_FLYPOINT_NEW_BARK
	setflag ENGINE_FLYPOINT_CHERRYGROVE
	setflag ENGINE_FLYPOINT_VIOLET
	setflag ENGINE_FLYPOINT_RUINS_OF_ALPH
	setflag ENGINE_FLYPOINT_AZALEA
	setflag ENGINE_FLYPOINT_GOLDENROD
	setflag ENGINE_FLYPOINT_ECRUTEAK
	setflag ENGINE_FLYPOINT_OLIVINE
	setflag ENGINE_FLYPOINT_CIANWOOD
	setflag ENGINE_FLYPOINT_MAHOGANY
	setflag ENGINE_FLYPOINT_LAKE_OF_RAGE
	setflag ENGINE_FLYPOINT_BLACKTHORN
	setflag ENGINE_FLYPOINT_SILVER_CAVE
	setflag ENGINE_FLYPOINT_INDIGO_PLATEAU
	setflag ENGINE_FLYPOINT_PALLET
	; new fly points
	setflag ENGINE_FLYPOINT_ROUTE_26
	setflag ENGINE_FLYPOINT_UNION_CAVE
	setflag ENGINE_FLYPOINT_NATIONAL_PARK
	setflag ENGINE_FLYPOINT_BATTLE_TOWER
	setflag ENGINE_CREDITS_SKIP
	; magnet train works
	setevent EVENT_RESTORED_POWER_TO_KANTO
	giveitem PASS
	; useful items
	giveitem MAX_REPEL, MAX_ITEM_STACK
	giveitem ESCAPE_ROPE, MAX_ITEM_STACK
	giveitem SACRED_ASH, MAX_ITEM_STACK
	giveitem RARE_CANDY, MAX_ITEM_STACK
	; all balls
	giveitem MASTER_BALL, MAX_ITEM_STACK
	giveitem POKE_BALL, MAX_ITEM_STACK
	giveitem GREAT_BALL, MAX_ITEM_STACK
	giveitem ULTRA_BALL, MAX_ITEM_STACK
	giveitem HEAVY_BALL, MAX_ITEM_STACK
	giveitem LURE_BALL, MAX_ITEM_STACK
	giveitem FAST_BALL, MAX_ITEM_STACK
	giveitem FRIEND_BALL, MAX_ITEM_STACK
	giveitem MOON_BALL, MAX_ITEM_STACK
	giveitem LOVE_BALL, MAX_ITEM_STACK
	; intro events
	addcellnum PHONE_MOM
	setmapscene PLAYERS_HOUSE_1F, $1
	setevent EVENT_PLAYERS_HOUSE_MOM_1
	clearevent EVENT_PLAYERS_HOUSE_MOM_2
	special HealParty
	end
else
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .NormalRadio
	checkevent EVENT_LISTENED_TO_INITIAL_RADIO
	iftrue .AbbreviatedRadio
	playmusic MUSIC_POKEMON_TALK
	opentext
	writetext PlayersRadioText1
	pause 45
	writetext PlayersRadioText2
	pause 45
	writetext PlayersRadioText3
	pause 45
	musicfadeout MUSIC_NEW_BARK_TOWN, 16
	writetext PlayersRadioText4
	pause 45
	closetext
	setevent EVENT_LISTENED_TO_INITIAL_RADIO
	end

.NormalRadio:
	jumpstd Radio1Script

.AbbreviatedRadio:
	opentext
	writetext PlayersRadioText4
	pause 45
	closetext
	end
endc

PlayersHouseBookshelfScript:
if DEF(_DEBUG)
	special FadeOutToWhite
	warp CHERRYGROVE_CITY, 29,  4 ; Map, coordinates via Polished Map
	end
else
	jumpstd PictureBookshelfScript
endc

PlayersHousePCScript:
	opentext
	special PlayersHousePC
	closetext
	end

PlayersRadioText1:
	text "PROF.OAK'S #MON"
	line "TALK! Please tune"
	cont "in next time!"
	done

PlayersRadioText2:
	text "#MON CHANNEL!"
	done

PlayersRadioText3:
	text "This is DJ MARY,"
	line "your co-host!"
	done

PlayersRadioText4:
	text "#MON!"
	line "#MON CHANNEL…"
	done

if DEF(_DEBUG)
TestWarpScript:
	faceplayer
	special FadeOutToWhite
	warp PALLET_TOWN, 4,  6 ; Map, coordinates via Polished Map
	end

TestScript:
	faceplayer
	special HealParty
	special BackupPartyHeldItems
	winlosstext TestText, TestText
	loadtrainer RED, RED2
	startbattle
	reloadmap
	special HealParty
	special RestorePartyHeldItems
	end

TestText:
	text "<……>"
	line "<……>"
	done
endc

PlayersHouse2F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  7,  0, PLAYERS_HOUSE_1F, 3

	def_coord_events

	def_bg_events
	bg_event  2,  1, BGEVENT_UP, PlayersHousePCScript
	bg_event  3,  1, BGEVENT_READ, PlayersHouseRadioScript
	bg_event  5,  1, BGEVENT_READ, PlayersHouseBookshelfScript
	bg_event  6,  0, BGEVENT_IFSET, PlayersHousePosterScript

	def_object_events
	object_event  4,  2, SPRITE_CONSOLE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PlayersHouseGameConsoleScript, EVENT_PLAYERS_HOUSE_2F_CONSOLE
	object_event  4,  4, SPRITE_DOLL_1, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PlayersHouseDoll1Script, EVENT_PLAYERS_HOUSE_2F_DOLL_1
	object_event  5,  4, SPRITE_DOLL_2, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PlayersHouseDoll2Script, EVENT_PLAYERS_HOUSE_2F_DOLL_2
	object_event  0,  1, SPRITE_BIG_DOLL, SPRITEMOVEDATA_BIGDOLL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PlayersHouseBigDollScript, EVENT_PLAYERS_HOUSE_2F_BIG_DOLL
if DEF(_DEBUG)
	object_event  4,  2, SPRITE_RED, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, TestScript, -1
	object_event  6,  2, SPRITE_BLUE, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, TestWarpScript, -1
endc
