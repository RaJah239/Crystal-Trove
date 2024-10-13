    object_const_def
	const BATTLETOWERMART_CLERK_EVOSTONES
	const BATTLETOWERMART_CLERK_TYPE_BOOSTING1
	const BATTLETOWERMART_CLERK_TYPE_BOOSTING2
	const BATTLETOWERMART_CLERK_VITAMINS
	const BATTLETOWERMART_CLERK_BERRIES
	const BATTLETOWERMART_CLERK_BATTLE_ITEMS
	const BATTLETOWERMART_CLERK_UNIQUE_MON_BATTLE_ITEMS
	const BATTLETOWERMART_CLERK_ALL_TMS
	const BATTLETOWERMART_PORYGON_PC

BattleTowerMart_MapScripts:
    def_scene_scripts

    def_callbacks
 
BattleTowerMartEvostonesClerkScript:
	faceplayer
	opentext
	pokemart MARTTYPE_STANDARD, MART_BATTLE_TOWER_EVOSTONES
	closetext
	turnobject BATTLETOWERMART_CLERK_EVOSTONES, DOWN
	end

BattleTowerMartTypeBoosting1ClerkScript:
	faceplayer
	opentext
	pokemart MARTTYPE_STANDARD, MART_BATTLE_TOWER_TYPE_BOOSTING1
	closetext
	turnobject BATTLETOWERMART_CLERK_TYPE_BOOSTING1, DOWN
	end

BattleTowerMartBoosting2ClerkScript:
	faceplayer
	opentext
	pokemart MARTTYPE_STANDARD, MART_BATTLE_TOWER_TYPE_BOOSTING2
	closetext
	turnobject BATTLETOWERMART_CLERK_TYPE_BOOSTING2, DOWN
	end

BattleTowerMartVitaminsClerkScript:
	faceplayer
	opentext
	pokemart MARTTYPE_STANDARD, MART_BATTLE_TOWER_VITAMINS
	closetext
	end

BattleTowerMartBerriesClerkScript:
	faceplayer
	opentext
	pokemart MARTTYPE_STANDARD, MART_BATTLE_TOWER_BERRIES
	closetext
	turnobject BATTLETOWERMART_CLERK_BERRIES, LEFT
	end

BattleTowerMartBattleItemsClerkScript:
	faceplayer
	opentext
	pokemart MARTTYPE_STANDARD, MART_BATTLE_TOWER_BATTLE_ITEMS
	closetext
	end

BattleTowerMartUniqueMonItemsClerkScript:
	faceplayer
	opentext
	pokemart MARTTYPE_STANDARD, MART_BATTLE_TOWER_UNIQUE_MON_BATTLE_ITEMS
	closetext
	turnobject BATTLETOWERMART_CLERK_UNIQUE_MON_BATTLE_ITEMS, RIGHT
	end

BattleTowerMartTMCoinTraderScript:
    faceplayer
    opentext
    special DisplayCoinCaseBalance
    writetext BattleTowerTMMartText
    yesorno
    iffalse .Refused
    checkcoins 9000
    ifequal HAVE_LESS, .NotEnoughCoins
    special CoinsTMTrader
    ifequal 1,  .TMDynamicPunch
    ifequal 2,  .TMHeadbutt
    ifequal 3,  .TMCurse
    ifequal 4,  .TMRollout
    ifequal 5,  .TMRoar
    ifequal 6,  .TMToxic
    ifequal 7,  .TMZapCannon
    ifequal 8,  .TMRockSmash
    ifequal 9,  .TMPsychUp
    ifequal 10, .TMHiddenPower
    ifequal 11, .TMSunnyDay
    ifequal 12, .TMSweetScent
    ifequal 13, .TMSnore
    ifequal 14, .TMBlizzard
    ifequal 15, .TMHyperBeam
    ifequal 16, .TMIcyWind
    ifequal 17, .TMProtect
    ifequal 18, .TMRainDance
    ifequal 19, .TMGigaDrain
    ifequal 20, .TMEndure
    ifequal 21, .TMFrustration
    ifequal 22, .TMSolarbeam
    ifequal 23, .TMIronTail
    ifequal 24, .TMDragonBreadth
    ifequal 25, .TMThunder
    ifequal 26, .TMEarthquake
    ifequal 27, .TMReturn
    ifequal 28, .TMDig
    ifequal 29, .TMPsychic
    ifequal 30, .TMShadowBall
    ifequal 31, .TMMudSlap
    ifequal 32, .TMDoulbeTeam
    ifequal 33, .TMIcePunch
    ifequal 34, .TMSwagger
    ifequal 35, .TMSleepTalk
    ifequal 36, .TMSludgeBomb
    ifequal 37, .TMSandStorm
    ifequal 38, .TMFireBlast
    ifequal 39, .TMSwift
    ifequal 40, .TMDefenseCurl
    ifequal 41, .TMThunderPunch
    ifequal 42, .TMDreamEater
    ifequal 43, .TMDetect
    ifequal 44, .TMRest
    ifequal 45, .TMAttract
    ifequal 46, .TMTheif
    ifequal 47, .TMStealWing
    ifequal 48, .TMFirePunch
    ifequal 49, .TMFuryCutter
    ifequal 50, .TMNightmare
    sjump CancelBuyingTMsScript
    end

.TMDynamicPunch:
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_DYNAMICPUNCH
    ifequal TRUE, .ConcludeTransaction
    closetext
    end

.TMHeadbutt:
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_HEADBUTT
    ifequal TRUE, .ConcludeTransaction
    writetext YoureACollectorText
    waitbutton
    closetext
    end

.TMCurse:
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_CURSE
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMRollout
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_ROLLOUT
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMRoar
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_ROAR
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMToxic
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_TOXIC
    ifequal TRUE, .ConcludeTransaction
    closetext

.TMZapCannon
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_ZAP_CANNON
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMRockSmash
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_ROCK_SMASH
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMPsychUp
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_PSYCH_UP
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMHiddenPower
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_HIDDEN_POWER
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMSunnyDay
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_SUNNY_DAY
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMSweetScent
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_SWEET_SCENT
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMSnore
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_SNORE
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMBlizzard
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_BLIZZARD
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMHyperBeam
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_HYPER_BEAM
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMIcyWind
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_ICY_WIND
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMProtect
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_PROTECT
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMRainDance
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_RAIN_DANCE
    ifequal TRUE, .ConcludeTransaction
    closetext

.TMGigaDrain
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_GIGA_DRAIN
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMEndure
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_ENDURE
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMFrustration
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_FRUSTRATION
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMSolarbeam
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_SOLARBEAM
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMIronTail
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_IRON_TAIL
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMDragonBreadth
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_DRAGONBREATH
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMThunder
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_THUNDER
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMEarthquake
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_EARTHQUAKE
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMReturn
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_RETURN
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMDig
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_DIG
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMPsychic
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_PSYCHIC_M
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMShadowBall
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_SHADOW_BALL
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMMudSlap
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_MUD_SLAP
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMDoulbeTeam
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_DOUBLE_TEAM
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMIcePunch
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_ICE_PUNCH
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMSwagger
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_SWAGGER
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMSleepTalk
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_SLEEP_TALK
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMSludgeBomb
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_SLUDGE_BOMB
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMSandStorm
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_SANDSTORM
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMFireBlast
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_FIRE_BLAST
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMSwift
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_SWIFT
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMDefenseCurl
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_DEFENSE_CURL
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMThunderPunch
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_THUNDERPUNCH
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMDreamEater
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_DREAM_EATER
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMDetect
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_DETECT
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMRest
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_REST
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMAttract
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_ATTRACT
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMTheif
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_THIEF
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMStealWing
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_STEEL_WING
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMFirePunch
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_FIRE_PUNCH
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMFuryCutter
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_FURY_CUTTER
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.TMNightmare
    writetext ExcellentChoiceText
    promptbutton
    verbosegiveitem TM_NIGHTMARE
    ifequal TRUE, .ConcludeTransaction
    waitbutton
    closetext
    end

.ConcludeTransaction:
    takecoins 9000
    waitsfx
    playsound SFX_TRANSACTION
    special DisplayCoinCaseBalance
    writetext ReturnAnytimeText
    waitbutton
    closetext
    end 

.Refused:
    writetext WeAreOpenAlways
    waitbutton
    closetext
    end

.NotEnoughCoins:
    writetext NotEnoughCoinsText
    waitbutton
    closetext
    end

CancelBuyingTMsScript:
    opentext
    writetext ComeAgainAgainText
    waitbutton
    closetext
    end

ComeAgainAgainText:
    text "Please come again!"
    done

BattleTowerTMMartText:
    text "Greetings, welcome"
    line "to the TM counter."

    para "You can purchase"
    line "any TM here for"
    cont "9,000 coins."

    para "Are you in need of"
    line "anything?"
    done

WeAreOpenAlways:
    text "We are open 24/7."
    done

NotEnoughCoinsText:
    text "You don't have"
    line "9,000 coins…"
    done

ExcellentChoiceText:
    text "Excellent choice,"
    line "young master!"
    done

ReturnAnytimeText:
    text "Do pay us a visit"
    line "anytime!"
    done

YoureACollectorText:
	text "You already have"
	line "the maximum of"
	
	para "those. You must be"
	line "a collector!"
	done

BattleTowerMartPorygonPCScript:
	jumpstd PorygonPCScript

BattleTowerMart_MapEvents:
    db 0, 0 ; filler

    def_warp_events
	warp_event  4,  9, BATTLE_TOWER_1F, 4
	warp_event 12,  9, BATTLE_TOWER_1F, 5
	warp_event  3,  9, BATTLE_TOWER_1F, 4
	warp_event 11,  9, BATTLE_TOWER_1F, 5
    def_coord_events

    def_bg_events

    def_object_events
	object_event 13,  1, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, BattleTowerMartEvostonesClerkScript, -1
	object_event  3,  1, SPRITE_KIMONO_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, BattleTowerMartTypeBoosting1ClerkScript, -1
	object_event  2,  1, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, BattleTowerMartBoosting2ClerkScript, -1
	object_event 15,  6, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, BattleTowerMartVitaminsClerkScript, -1
	object_event 15,  5, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, BattleTowerMartBerriesClerkScript, -1
	object_event  0,  6, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, BattleTowerMartBattleItemsClerkScript, -1
	object_event  0,  5, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, BattleTowerMartUniqueMonItemsClerkScript, -1
	object_event 12,  1, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, BattleTowerMartTMCoinTraderScript, -1
	object_event 10,  1, SPRITE_PORYGON_OW, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, BattleTowerMartPorygonPCScript, -1
