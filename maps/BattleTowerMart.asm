    object_const_def
	const BATTLETOWERMART_CLERK_EVOSTONES
	const BATTLETOWERMART_CLERK_TYPE_BOOSTING1
	const BATTLETOWERMART_CLERK_TYPE_BOOSTING2
	const BATTLETOWERMART_CLERK_VITAMINS
	const BATTLETOWERMART_CLERK_BERRIES
	const BATTLETOWERMART_CLERK_BATTLE_ITEMS
	const BATTLETOWERMART_CLERK_UNIQUE_MON_BATTLE_ITEMS
;	const BATTLETOWERMART_CLERK_ALL_TMS

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
