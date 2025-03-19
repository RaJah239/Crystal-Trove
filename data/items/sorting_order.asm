ItemNameOrder:
	table_width 1, ItemNameOrder

	db NO_ITEM      ; 00

	; Items
	db CRYSTAL      ; 01
	db ESCAPE_ROPE  ; 02

	; HP restoring items
	db POTION       ; 03
	db SUPER_POTION ; 04
	db HYPER_POTION ; 05
	db MAX_POTION   ; 06
	db FULL_RESTORE ; 07
	db SACRED_ASH   ; 08

	; Vending Machine Drinks
	db FRESH_WATER  ; 09
	db LEMONADE     ; 0a
	db SODA_POP     ; 0b

	; Other healing related items
	db MOOMOO_MILK  ; 0c
	db RAGECANDYBAR ; 0d

	; Status recovery items
	db ANTIDOTE     ; 0e
	db AWAKENING    ; 0f
	db BURN_HEAL    ; 10
	db ICE_HEAL     ; 11
	db PARLYZ_HEAL  ; 12
	db FULL_HEAL    ; 13
	
	; PP restoring items
	db ETHER        ; 14
	db MAX_ETHER    ; 15
	db ELIXER       ; 16
	db MAX_ELIXER   ; 17
	db REVIVE       ; 18
	db MAX_REVIVE   ; 19

	; Bitter Medicine
	db ENERGY_ROOT  ; 1a
	db ENERGYPOWDER ; 1b
	db HEAL_POWDER  ; 1c
	db REVIVAL_HERB ; 1d

	; Stat altering Battle Items
	db DIRE_HIT     ; 1e
	db GUARD_SPEC   ; 1f
	db POKE_DOLL    ; 20
	db X_ACCURACY   ; 21	
	db X_ATTACK     ; 22
	db X_DEFEND     ; 23
	db X_SPEED      ; 24
	db X_SPECIAL    ; 25

	; Vitamins
	db RARE_CANDY   ; 26
	db RARE_CANDY_XC; 27
	db HP_UP        ; 28
	db PROTEIN      ; 29
	db IRON         ; 30
	db CALCIUM      ; 3a
	db ZINC         ; 3b
	db CARBOS       ; 3c
	
	; Evolution Items
	db DRAGON_SCALE ; 3d
	db FIRE_STONE   ; 3e
	db LEAF_STONE   ; 3f
	db MOON_STONE   ; 40
	db SUN_STONE    ; 41
	db THUNDERSTONE ; 42
	db WATER_STONE  ; 43
	db UP_GRADE     ; 44

	; Boxes
	db NORMAL_BOX   ; 45
	db GORGEOUS_BOX ; 46

	; Fossils
	db DOME_FOSSIL  ; 47
	db HELIX_FOSSIL ; 48
	db OLD_AMBER    ; 49

	; Other items
	db SILVER_LEAF  ; 4a
	db GOLD_LEAF    ; 4b
	db TINYMUSHROOM ; 4c
	db BIG_MUSHROOM ; 4d
	db STARDUST     ; 4e
	db STAR_PIECE   ; 4f
	db PEARL        ; 50
	db BIG_PEARL    ; 51
	db NUGGET       ; 52
	db BRICK_PIECE  ; 53
	db SLOWPOKETAIL ; 54

	; Apricorns
	db BLU_APRICORN ; 55
	db BLK_APRICORN ; 56
	db GRN_APRICORN ; 57
	db PNK_APRICORN ; 58
	db RED_APRICORN ; 59
	db WHT_APRICORN ; 5a
	db YLW_APRICORN ; 5b

	; Mail
	db BLUESKY_MAIL ; 5c
	db EON_MAIL     ; 5d
	db FLOWER_MAIL  ; 5e
	db LITEBLUEMAIL ; 5f
	db LOVELY_MAIL  ; 60
	db MIRAGE_MAIL  ; 61
	db MORPH_MAIL   ; 62
	db MUSIC_MAIL   ; 63
	db PORTRAITMAIL ; 64
	db SURF_MAIL    ; 65

	; Generic Pokéballs
	db POKE_BALL    ; 66
	db GREAT_BALL   ; 67
	db ULTRA_BALL   ; 68
	db MASTER_BALL  ; 69
	
	; Kurt's Pokéballs
	db FAST_BALL    ; 6a
	db FRIEND_BALL  ; 6b
	db HEAVY_BALL   ; 6c
	db LEVEL_BALL   ; 6d
	db LOVE_BALL    ; 6e
	db LURE_BALL    ; 6f
	db MOON_BALL    ; 70
	db PARK_BALL    ; 71
	
	; Berries
	db BERRY        ; 72
	db BITTER_BERRY ; 73
	db BURNT_BERRY  ; 74
	db GOLD_BERRY   ; 75
	db ICE_BERRY    ; 76
	db MINT_BERRY   ; 77
	db MIRACLEBERRY ; 78
	db MYSTERYBERRY ; 79
	db PRZCUREBERRY ; 7a
	db PSNCUREBERRY ; 7b

	; Battle related Held Items
	db AMULET_COIN  ; 7c
	db BERRY_JUICE  ; 7d
	db BERSERK_GENE ; 7e
	db BLACKBELT_I  ; 7f
	db BLACKGLASSES ; 80
	db BRIGHTPOWDER ; 81
	db CHARCOAL     ; 82
	db CLEANSE_TAG  ; 83
	db DRAGON_FANG  ; 84
	db EVERSTONE    ; 85
	db FOCUS_BAND   ; 86
	db HARD_STONE   ; 87
	db KINGS_ROCK   ; 88
	db LEFTOVERS    ; 89
	db LIGHT_BALL   ; 8a
	db LUCKY_EGG    ; 8b
	db LUCKY_PUNCH  ; 8c
	db MAGNET       ; 8d
	db METAL_COAT   ; 8e
	db METAL_POWDER ; 8f
	db MIRACLE_SEED ; 90
	db MYSTIC_WATER ; 91
	db NEVERMELTICE ; 92
	db PINK_BOW     ; 93
	db POISON_BARB  ; 94
	db POLKADOT_BOW ; 95
	db QUICK_CLAW   ; 96
	db SCOPE_LENS   ; 97
	db SHARP_BEAK   ; 98
	db SILVERPOWDER ; 99
	db SMOKE_BALL   ; 9a
	db SOFT_SAND    ; 9b
	db SPELL_TAG    ; 9c
	db STICK        ; 9d
	db THICK_CLUB   ; 9e
	db TWISTEDSPOON ; 9f

	; Permanent Key Items
	; Items that are possibly frequently used
	db BICYCLE      ; a0
	db EXP_SHARE    ; a1
	db EXP_CHARM    ; a2
	db CATCH_CHARM  ; a3
	db SHINY_CHARM  ; a4
	db COIN_CASE    ; a5
	db ITEMFINDER   ; a6

	; Rods
	db OLD_ROD      ; a7
	db GOOD_ROD     ; a8
	db SUPER_ROD    ; a9

	; Items that are possibly seldom used
	db BLUE_CARD    ; aa
	db CLEAR_BELL   ; ab
	db GS_BALL      ; ac
	db PASS         ; ad
	db SILVER_WING  ; ae
	db RAINBOW_WING ; af
	db S_S_TICKET   ; b0
	db TOWN_MAP     ; b1

	; Temporary Key Items
	db BASEMENT_KEY ; b2
	db CARD_KEY     ; b3
	db EGG_TICKET   ; b4
	db LOST_ITEM    ; b5
	db MACHINE_PART ; b6
	db MYSTERY_EGG  ; b7
	db RED_SCALE    ; b8
	db SECRETPOTION ; b9
	db SQUIRTBOTTLE ; ba

	; HM Items - Aside from Lantern, the rest needs to Press A on the overworld to work
	db GEYSER_BOOTS ; bb
	db HEDGER       ; bc
	db LANTERN      ; bd
	db PADDLE_BOAT  ; be
	db POWER_GLOVE  ; bf
	db STABILIZER	; c0

REPT 22
	db $FF ; fill with empty bytes to reach NUM_ITEMS + 1
ENDR

	assert_table_length NUM_ITEMS + 8 ; Needs to be increased if more dummied items are added
	db -1 ; end
