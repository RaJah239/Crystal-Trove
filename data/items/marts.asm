Marts:
; entries correspond to MART_* constants (see constants/mart_constants.asm)
	table_width 2, Marts
	dw MartCherrygrove
	dw MartCherrygroveDex
	dw MartViolet
	dw MartAzalea
	dw MartCianwood
	dw MartGoldenrod2F1
	dw MartGoldenrod2F2
	dw MartGoldenrod3F
	dw MartGoldenrod4F
	dw MartGoldenrod5F1
	dw MartGoldenrod5F2
	dw MartGoldenrod5F3
	dw MartGoldenrod5F4
	dw MartOlivine
	dw MartEcruteak
	dw MartMahogany1
	dw MartMahogany2
	dw MartBlackthorn
	dw MartViridian
	dw MartPewter
	dw MartCerulean
	dw MartLavender
	dw MartVermilion
	dw MartCeladon2F1
	dw MartCeladon2F2
	dw MartCeladon3F
	dw MartCeladon4F
	dw MartCeladon5F1
	dw MartCeladon5F2
	dw MartFuchsia
	dw MartSaffron
	dw MartMtMoon
	dw MartIndigoPlateau
	dw MartUnderground
	dw MartBattleTowerEvostones
	dw MartBattleTowerTypeBoosting1
	dw MartBattleTowerTypeBoosting2
	dw MartBattleTowerVitamins
	dw MartBattleTowerBerries
	dw MartBattleTowerBattleItems
	dw MartBattleTowerUniqueMonBattleItems
	assert_table_length NUM_MARTS

MartCherrygrove:
IF DEF(_DEBUG)
	db 6 ; # items
	db RARE_CANDY
	db MASTER_BALL
ELSE
	db 4 ; # items
ENDC
	db POTION
	db ANTIDOTE
	db PARLYZ_HEAL
	db AWAKENING
	db -1 ; end

MartCherrygroveDex:
IF DEF(_DEBUG)
	db 7 ; # items
	db RARE_CANDY
	db MASTER_BALL
ELSE
	db 5 ; # items
ENDC	
	db POKE_BALL
	db POTION
	db ANTIDOTE
	db PARLYZ_HEAL
	db AWAKENING
	db -1 ; end

MartViolet:
IF DEF(_DEBUG)
	db 12 ; # items
	db RARE_CANDY
	db MASTER_BALL
ELSE
	db 10 ; # items
ENDC	
	db POKE_BALL
	db POTION
	db ESCAPE_ROPE
	db ANTIDOTE
	db PARLYZ_HEAL
	db AWAKENING
	db X_DEFEND
	db X_ATTACK
	db X_SPEED
	db FLOWER_MAIL
	db -1 ; end

MartAzalea:
IF DEF(_DEBUG)
	db 11 ; # items
	db RARE_CANDY
	db MASTER_BALL
ELSE
	db 9 ; # items
ENDC
	db CHARCOAL
	db POKE_BALL
	db POTION
	db SUPER_POTION
	db ESCAPE_ROPE
	db ANTIDOTE
	db PARLYZ_HEAL
	db FLOWER_MAIL
	db -1 ; end

MartCianwood:
IF DEF(_DEBUG)
	db 7 ; # items
	db RARE_CANDY
	db MASTER_BALL
ELSE
	db 5 ; # items
ENDC
	db POTION
	db SUPER_POTION
	db HYPER_POTION
	db FULL_HEAL
	db REVIVE
	db -1 ; end

MartGoldenrod2F1:
IF DEF(_DEBUG)
	db 9 ; # items
	db RARE_CANDY
	db MASTER_BALL
ELSE
	db 7 ; # items
ENDC
	db POTION
	db SUPER_POTION
	db ANTIDOTE
	db PARLYZ_HEAL
	db AWAKENING
	db BURN_HEAL
	db ICE_HEAL
	db -1 ; end

MartGoldenrod2F2:
	db 7 ; # items
	db POKE_BALL
	db GREAT_BALL
	db ESCAPE_ROPE
	db REVIVE
	db FULL_HEAL
	db POKE_DOLL
	db FLOWER_MAIL
	db -1 ; end

MartGoldenrod3F:
	db 7 ; # items
	db X_SPEED
	db X_SPECIAL
	db X_DEFEND
	db X_ATTACK
	db DIRE_HIT
	db GUARD_SPEC
	db X_ACCURACY
	db -1 ; end

MartGoldenrod5F1:
	db 3 ; # items
	db TM_THUNDERPUNCH
	db TM_FIRE_PUNCH
	db TM_ICE_PUNCH
	db -1 ; end

MartGoldenrod5F2:
	db 4 ; # items
	db TM_THUNDERPUNCH
	db TM_FIRE_PUNCH
	db TM_ICE_PUNCH
	db TM_HEADBUTT
	db -1 ; end

MartGoldenrod5F3:
	db 4 ; # items
	db TM_THUNDERPUNCH
	db TM_FIRE_PUNCH
	db TM_ICE_PUNCH
	db TM_ROCK_SMASH
	db -1 ; end

MartGoldenrod5F4:
	db 5 ; # items
	db TM_THUNDERPUNCH
	db TM_FIRE_PUNCH
	db TM_ICE_PUNCH
	db TM_HEADBUTT
	db TM_ROCK_SMASH
	db -1 ; end

MartOlivine:
	db 8 ; # items
	db GREAT_BALL
	db SUPER_POTION
	db HYPER_POTION
	db ANTIDOTE
	db PARLYZ_HEAL
	db AWAKENING
	db ICE_HEAL
	db SURF_MAIL
	db -1 ; end

MartEcruteak:
	db 10 ; # items
	db POKE_BALL
	db GREAT_BALL
	db POTION
	db SUPER_POTION
	db ANTIDOTE
	db PARLYZ_HEAL
	db AWAKENING
	db BURN_HEAL
	db ICE_HEAL
	db REVIVE
	db -1 ; end

MartMahogany1:
	db 4 ; # items
	db TINYMUSHROOM
	db SLOWPOKETAIL
	db POKE_BALL
	db POTION
	db -1 ; end

MartMahogany2:
	db 8 ; # items
	db RAGECANDYBAR
	db GREAT_BALL
	db SUPER_POTION
	db HYPER_POTION
	db ANTIDOTE
	db PARLYZ_HEAL
	db REVIVE
	db FLOWER_MAIL
	db -1 ; end

MartBlackthorn:
	db 8 ; # items
	db GREAT_BALL
	db ULTRA_BALL
	db HYPER_POTION
	db MAX_POTION
	db FULL_HEAL
	db REVIVE
	db X_DEFEND
	db X_ATTACK
	db -1 ; end

MartViridian:
	db 9 ; # items
	db ULTRA_BALL
	db HYPER_POTION
	db FULL_HEAL
	db REVIVE
	db ANTIDOTE
	db PARLYZ_HEAL
	db AWAKENING
	db BURN_HEAL
	db FLOWER_MAIL
	db -1 ; end

MartPewter:
	db 6 ; # items
	db GREAT_BALL
	db SUPER_POTION
	db ANTIDOTE
	db PARLYZ_HEAL
	db AWAKENING
	db BURN_HEAL
	db -1 ; end

MartCerulean:
	db 8 ; # items
	db GREAT_BALL
	db ULTRA_BALL
	db SUPER_POTION
	db FULL_HEAL
	db X_DEFEND
	db X_ATTACK
	db DIRE_HIT
	db SURF_MAIL
	db -1 ; end

MartLavender:
	db 7 ; # items
	db GREAT_BALL
	db POTION
	db SUPER_POTION
	db ANTIDOTE
	db PARLYZ_HEAL
	db AWAKENING
	db BURN_HEAL
	db -1 ; end

MartVermilion:
	db 8 ; # items
	db ULTRA_BALL
	db SUPER_POTION
	db HYPER_POTION
	db REVIVE
	db PARLYZ_HEAL
	db AWAKENING
	db BURN_HEAL
	db LITEBLUEMAIL
	db -1 ; end

MartCeladon2F1:
	db 5 ; # items
	db POTION
	db SUPER_POTION
	db HYPER_POTION
	db MAX_POTION
	db REVIVE
	db -1 ; end

MartCeladon2F2:
	db 10 ; # items
	db POKE_BALL
	db GREAT_BALL
	db ULTRA_BALL
	db ESCAPE_ROPE
	db FULL_HEAL
	db ANTIDOTE
	db BURN_HEAL
	db ICE_HEAL
	db AWAKENING
	db PARLYZ_HEAL
	db -1 ; end

MartCeladon3F:
	db 5 ; # items
	db TM_HIDDEN_POWER
	db TM_SUNNY_DAY
	db TM_PROTECT
	db TM_RAIN_DANCE
	db TM_SANDSTORM
	db -1 ; end

MartCeladon4F:
	db 3 ; # items
	db POKE_DOLL
	db LOVELY_MAIL
	db SURF_MAIL
	db -1 ; end

MartCeladon5F2:
	db 7 ; # items
	db X_ACCURACY
	db GUARD_SPEC
	db DIRE_HIT
	db X_ATTACK
	db X_DEFEND
	db X_SPEED
	db X_SPECIAL
	db -1 ; end

MartFuchsia:
	db 6 ; # items
	db GREAT_BALL
	db ULTRA_BALL
	db SUPER_POTION
	db HYPER_POTION
	db FULL_HEAL
	db FLOWER_MAIL
	db -1 ; end

MartSaffron:
	db 8 ; # items
	db GREAT_BALL
	db ULTRA_BALL
	db HYPER_POTION
	db MAX_POTION
	db FULL_HEAL
	db X_ATTACK
	db X_DEFEND
	db FLOWER_MAIL
	db -1 ; end

MartMtMoon:
	db 5 ; # items
	db POKE_DOLL
	db FRESH_WATER
	db SODA_POP
	db LEMONADE
	db PORTRAITMAIL
	db -1 ; end

MartIndigoPlateau:
	db 6 ; # items
	db ULTRA_BALL
	db HYPER_POTION
	db MAX_POTION
	db FULL_RESTORE
	db REVIVE
	db FULL_HEAL
	db -1 ; end

MartUnderground:
	db 4 ; # items
	db ENERGYPOWDER
	db ENERGY_ROOT
	db HEAL_POWDER
	db REVIVAL_HERB
	db -1 ; end

DefaultMart:
	db 2 ; # items
	db POKE_BALL
	db POTION
	db -1 ; end

MartBattleTowerEvostones:
	db 8 ; # items
	db FIRE_STONE
	db WATER_STONE
	db LEAF_STONE
	db THUNDERSTONE
	db SUN_STONE
	db MOON_STONE
	db EVERSTONE
	db DRAGON_SCALE
	db -1 ; end

MartBattleTowerTypeBoosting1:
	db 10 ; # items
	db PINK_BOW
	db POLKADOT_BOW
	db CHARCOAL
	db MYSTIC_WATER
	db MIRACLE_SEED
	db MAGNET
	db NEVERMELTICE
	db BLACKBELT_I
	db POISON_BARB
	db SOFT_SAND
	db -1 ; end

MartBattleTowerTypeBoosting2:
	db 8 ; # items
	db SHARP_BEAK
	db TWISTEDSPOON
	db SILVERPOWDER
	db HARD_STONE
	db SPELL_TAG
	db DRAGON_FANG
	db BLACKGLASSES
	db METAL_COAT
	db -1 ; end

MartBattleTowerVitamins:
MartCeladon5F1:
MartGoldenrod4F:
	db 6 ; # items
	db HP_UP
	db PROTEIN
	db IRON
	db CALCIUM
	db ZINC
	db CARBOS
	db -1 ; end

MartBattleTowerBerries:
	db 10 ; # items
	db BERRY
	db GOLD_BERRY
	db PSNCUREBERRY
	db PRZCUREBERRY
	db BURNT_BERRY
	db ICE_BERRY
	db BITTER_BERRY
	db MINT_BERRY
	db MYSTERYBERRY
	db MIRACLEBERRY
	db -1 ; end

MartBattleTowerBattleItems:
	db 6 ; # items
	db LEFTOVERS
	db QUICK_CLAW
	db FOCUS_BAND
	db SCOPE_LENS
	db KINGS_ROCK
	db BRIGHTPOWDER
	db -1 ; end

MartBattleTowerUniqueMonBattleItems:
	db 7 ; # items
	db THICK_CLUB
	db LIGHT_BALL
	db STICK
	db METAL_POWDER
	db LUCKY_EGG
	db SMOKE_BALL
	db CLEANSE_TAG
	db -1 ; end
