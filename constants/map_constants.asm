MACRO newgroup
;\1: group id
	const_skip
	DEF MAPGROUP_\1 EQU const_value
	DEF CURRENT_NUM_MAPGROUP_MAPS EQUS "NUM_\1_MAPS"
	DEF __map_value__ = 1
ENDM

MACRO map_const
;\1: map id
;\2: width: in blocks
;\3: height: in blocks
	DEF GROUP_\1 EQU const_value
	DEF MAP_\1 EQU __map_value__
	DEF __map_value__ += 1
	DEF \1_WIDTH EQU \2
	DEF \1_HEIGHT EQU \3
ENDM

MACRO endgroup
	DEF {CURRENT_NUM_MAPGROUP_MAPS} EQU __map_value__ - 1
	PURGE CURRENT_NUM_MAPGROUP_MAPS
ENDM

; map group ids
; `newgroup` indexes are for:
; - MapGroupPointers (see data/maps/maps.asm)
; - MapGroupRoofs (see data/maps/roofs.asm)
; - OutdoorSprites (see data/maps/outdoor_sprites.asm)
; - RoofPals (see gfx/tilesets/roofs.pal)
; `map_const` indexes are for the sub-tables of MapGroupPointers (see data/maps/maps.asm)
; Each map also has associated data:
; - attributes (see data/maps/attributes.asm)
; - blocks (see data/maps/blocks.asm)
; - scripts and events (see data/maps/scripts.asm)
	const_def

	newgroup OLIVINE                                              ;  1
	map_const OLIVINE_POKECENTER_1F,                        5,  4 ;  1
	map_const OLIVINE_GYM,                                  5,  8 ;  2
	map_const OLIVINE_TIMS_HOUSE,                           4,  4 ;  3
	map_const OLIVINE_PUNISHMENT_SPEECH_HOUSE,              4,  4 ;  5
	map_const OLIVINE_GOOD_ROD_HOUSE,                       4,  4 ;  6
	map_const OLIVINE_CAFE,                                 4,  4 ;  7
	map_const OLIVINE_MART,                                 6,  4 ;  8
	map_const ROUTE_38_ECRUTEAK_GATE,                       5,  4 ;  9
	map_const ROUTE_39_BARN,                                4,  4 ; 10
	map_const ROUTE_39_FARMHOUSE,                           4,  4 ; 11
	map_const ROUTE_38,                                    20,  9 ; 12
	map_const ROUTE_39,                                    10, 25 ; 13
	map_const OLIVINE_CITY,                                20, 18 ; 14
	endgroup

	newgroup MAHOGANY                                             ;  2
	map_const MAHOGANY_RED_GYARADOS_SPEECH_HOUSE,           4,  4 ;  1
	map_const MAHOGANY_GYM,                                 5,  9 ;  2
	map_const MAHOGANY_POKECENTER_1F,                       5,  4 ;  3
	map_const ROUTE_42_ECRUTEAK_GATE,                       5,  4 ;  4
	map_const ROUTE_42,                                    30,  9 ;  5
	map_const ROUTE_44,                                    30,  9 ;  6
	map_const MAHOGANY_TOWN,                               10,  9 ;  7
	map_const MAHOGANY_TRADE_BACK_KID_HOUSE,                4,  4 ;  8
	endgroup

	newgroup DUNGEONS                                             ;  3
	map_const SPROUT_TOWER_1F,                             10,  8 ;  1
	map_const SPROUT_TOWER_2F,                             10,  8 ;  2
	map_const SPROUT_TOWER_3F,                             10,  8 ;  3
	map_const TIN_TOWER_1F,                                10,  9 ;  4
	map_const TIN_TOWER_2F,                                10,  9 ;  5
	map_const TIN_TOWER_3F,                                10,  9 ;  6
	map_const TIN_TOWER_4F,                                10,  9 ;  7
	map_const TIN_TOWER_5F,                                10,  9 ;  8
	map_const TIN_TOWER_6F,                                10,  9 ;  9
	map_const TIN_TOWER_7F,                                10,  9 ; 10
	map_const TIN_TOWER_8F,                                10,  9 ; 11
	map_const TIN_TOWER_9F,                                10,  9 ; 12
	map_const BURNED_TOWER_1F,                             10,  9 ; 13
	map_const BURNED_TOWER_B1F,                            10,  9 ; 14
	map_const NATIONAL_PARK,                               20, 27 ; 15
	map_const NATIONAL_PARK_BUG_CONTEST,                   20, 27 ; 16
	map_const RADIO_TOWER_1F,                               9,  4 ; 17
	map_const RADIO_TOWER_2F,                               9,  4 ; 18
	map_const RADIO_TOWER_3F,                               9,  4 ; 19
	map_const RADIO_TOWER_4F,                               9,  4 ; 20
	map_const RADIO_TOWER_5F,                               9,  4 ; 21
	map_const RUINS_OF_ALPH_OUTSIDE,                       10, 18 ; 22
	map_const RUINS_OF_ALPH_HO_OH_CHAMBER,                  4,  5 ; 23
	map_const RUINS_OF_ALPH_KABUTO_CHAMBER,                 4,  5 ; 24
	map_const RUINS_OF_ALPH_OMANYTE_CHAMBER,                4,  5 ; 25
	map_const RUINS_OF_ALPH_AERODACTYL_CHAMBER,             4,  5 ; 26
	map_const RUINS_OF_ALPH_INNER_CHAMBER,                 10, 14 ; 27
	map_const RUINS_OF_ALPH_RESEARCH_CENTER,                4,  4 ; 28
	map_const RUINS_OF_ALPH_HO_OH_ITEM_ROOM,                4,  5 ; 29
	map_const RUINS_OF_ALPH_KABUTO_ITEM_ROOM,               4,  5 ; 30
	map_const RUINS_OF_ALPH_OMANYTE_ITEM_ROOM,              4,  5 ; 31
	map_const RUINS_OF_ALPH_AERODACTYL_ITEM_ROOM,           4,  5 ; 32
	map_const RUINS_OF_ALPH_HO_OH_WORD_ROOM,               10, 12 ; 33
	map_const RUINS_OF_ALPH_KABUTO_WORD_ROOM,              10,  7 ; 34
	map_const RUINS_OF_ALPH_OMANYTE_WORD_ROOM,             10,  8 ; 35
	map_const RUINS_OF_ALPH_AERODACTYL_WORD_ROOM,          10,  7 ; 36
	map_const UNION_CAVE_1F,                               10, 18 ; 37
	map_const UNION_CAVE_B1F,                              10, 18 ; 38
	map_const UNION_CAVE_B2F,                              10, 18 ; 39
	map_const SLOWPOKE_WELL_B1F,                           10,  9 ; 40
	map_const SLOWPOKE_WELL_B2F,                           10,  9 ; 41
	map_const OLIVINE_LIGHTHOUSE_1F,                       10,  9 ; 42
	map_const OLIVINE_LIGHTHOUSE_2F,                       10,  9 ; 43
	map_const OLIVINE_LIGHTHOUSE_3F,                       10,  9 ; 44
	map_const OLIVINE_LIGHTHOUSE_4F,                       10,  9 ; 45
	map_const OLIVINE_LIGHTHOUSE_5F,                       10,  9 ; 46
	map_const OLIVINE_LIGHTHOUSE_6F,                       10,  9 ; 47
	map_const MAHOGANY_MART_1F,                             4,  4 ; 48
	map_const TEAM_ROCKET_BASE_B1F,                        15,  9 ; 49
	map_const TEAM_ROCKET_BASE_B2F,                        15,  9 ; 50
	map_const TEAM_ROCKET_BASE_B3F,                        15,  9 ; 51
	map_const ILEX_FOREST,                                 15, 27 ; 52
	map_const GOLDENROD_UNDERGROUND,                       15, 18 ; 53
	map_const GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES, 15, 18 ; 54
	map_const GOLDENROD_DEPT_STORE_B1F,                    10,  9 ; 55
	map_const GOLDENROD_UNDERGROUND_WAREHOUSE,             10,  9 ; 56
	map_const MOUNT_MORTAR_1F_OUTSIDE,                     20, 18 ; 57
	map_const MOUNT_MORTAR_1F_INSIDE,                      20, 27 ; 58
	map_const MOUNT_MORTAR_2F_INSIDE,                      20, 18 ; 59
	map_const MOUNT_MORTAR_B1F,                            20, 18 ; 60
	map_const ICE_PATH_1F,                                 20, 18 ; 61
	map_const ICE_PATH_B1F,                                10, 18 ; 62
	map_const ICE_PATH_B2F_MAHOGANY_SIDE,                  10,  9 ; 63
	map_const ICE_PATH_B2F_BLACKTHORN_SIDE,                 5,  9 ; 64
	map_const ICE_PATH_B3F,                                10,  9 ; 65
	map_const WHIRL_ISLAND_NW,                              5,  9 ; 66
	map_const WHIRL_ISLAND_NE,                             10,  9 ; 67
	map_const WHIRL_ISLAND_SW,                             10,  9 ; 68
	map_const WHIRL_ISLAND_CAVE,                            5,  9 ; 69
	map_const WHIRL_ISLAND_SE,                              5,  9 ; 70
	map_const WHIRL_ISLAND_B1F,                            20, 18 ; 71
	map_const WHIRL_ISLAND_B2F,                            10, 18 ; 72
	map_const WHIRL_ISLAND_LUGIA_CHAMBER,                  10,  9 ; 73
	map_const SILVER_CAVE_ROOM_1,                          10, 18 ; 74
	map_const SILVER_CAVE_ROOM_2,                          15, 18 ; 75
	map_const SILVER_CAVE_ROOM_3,                          10, 18 ; 76
	map_const SILVER_CAVE_ITEM_ROOMS,                      10,  9 ; 77
	map_const DARK_CAVE_VIOLET_ENTRANCE,                   20, 18 ; 78
	map_const DARK_CAVE_BLACKTHORN_ENTRANCE,               15, 18 ; 79
	map_const DRAGONS_DEN_1F,                               5,  9 ; 80
	map_const DRAGONS_DEN_B1F,                             20, 18 ; 81
	map_const DRAGON_SHRINE,                                5,  5 ; 82
	map_const TOHJO_FALLS,                                 15,  9 ; 83
	map_const VICTORY_ROAD,                                10, 36 ; 91
	endgroup

	newgroup ECRUTEAK                                             ;  4
	map_const ECRUTEAK_TIN_TOWER_ENTRANCE,                 10,  9 ;  1
	map_const WISE_TRIOS_ROOM,                              4,  4 ;  2
	map_const ECRUTEAK_POKECENTER_1F,                       5,  4 ;  3
	map_const ECRUTEAK_LUGIA_SPEECH_HOUSE,                  4,  4 ;  4
	map_const DANCE_THEATER,                                6,  7 ;  5
	map_const ECRUTEAK_MART,                                6,  4 ;  6
	map_const ECRUTEAK_GYM,                                 5,  9 ;  7
	map_const ECRUTEAK_ITEMFINDER_HOUSE,                    4,  4 ;  8
	map_const ECRUTEAK_CITY,                               20, 18 ;  9
	endgroup

	newgroup BLACKTHORN                                           ;  5
	map_const BLACKTHORN_GYM_1F,                            5,  9 ;  1
	map_const BLACKTHORN_GYM_2F,                            5,  9 ;  2
	map_const BLACKTHORN_DRAGON_SPEECH_HOUSE,               4,  4 ;  3
	map_const BLACKTHORN_EMYS_HOUSE,                        4,  4 ;  4
	map_const BLACKTHORN_MART,                              6,  4 ;  5
	map_const BLACKTHORN_POKECENTER_1F,                     5,  4 ;  6
	map_const MOVE_DELETERS_HOUSE,                          4,  4 ;  7
	map_const ROUTE_45,                                    10, 45 ;  8
	map_const ROUTE_46,                                    10, 18 ;  9
	map_const BLACKTHORN_CITY,                             20, 18 ; 10
	endgroup

	newgroup CINNABAR                                             ;  6
	endgroup

	newgroup CERULEAN                                             ;  7
	endgroup

	newgroup AZALEA                                               ;  8
	map_const AZALEA_POKECENTER_1F,                         5,  4 ;  1
	map_const CHARCOAL_KILN,                                4,  4 ;  2
	map_const AZALEA_MART,                                  6,  4 ;  3
	map_const KURTS_HOUSE,                                  8,  4 ;  4
	map_const AZALEA_GYM,                                   5,  8 ;  5
	map_const ROUTE_33,                                    10,  9 ;  6
	map_const AZALEA_TOWN,                                 20,  9 ;  7
	endgroup

	newgroup LAKE_OF_RAGE                                         ;  9
	map_const LAKE_OF_RAGE_HIDDEN_POWER_HOUSE,              4,  4 ;  1
	map_const LAKE_OF_RAGE_MAGIKARP_HOUSE,                  4,  4 ;  2
	map_const ROUTE_43_MAHOGANY_GATE,                       5,  4 ;  3
	map_const ROUTE_43_GATE,                                5,  4 ;  4
	map_const ROUTE_43,                                    10, 27 ;  5
	map_const LAKE_OF_RAGE,                                20, 18 ;  6
	endgroup

	newgroup VIOLET                                               ; 10
	map_const ROUTE_32,                                    10, 45 ;  1
	map_const ROUTE_35,                                    10, 18 ;  2
	map_const ROUTE_36,                                    30,  9 ;  3
	map_const ROUTE_37,                                    10,  9 ;  4
	map_const VIOLET_CITY,                                 20, 18 ;  5
	map_const VIOLET_MART,                                  6,  4 ;  6
	map_const VIOLET_GYM,                                   5,  8 ;  7
	map_const EARLS_POKEMON_ACADEMY,                        4,  8 ;  8
	map_const VIOLET_NICKNAME_SPEECH_HOUSE,                 4,  4 ;  9
	map_const VIOLET_POKECENTER_1F,                         5,  4 ; 10
	map_const VIOLET_KYLES_HOUSE,                           4,  4 ; 11
	map_const ROUTE_32_RUINS_OF_ALPH_GATE,                  5,  4 ; 12
	map_const ROUTE_32_POKECENTER_1F,                       5,  4 ; 13
	map_const ROUTE_35_GOLDENROD_GATE,                      5,  4 ; 14
	map_const ROUTE_35_NATIONAL_PARK_GATE,                  4,  4 ; 15
	map_const ROUTE_36_RUINS_OF_ALPH_GATE,                  5,  4 ; 16
	map_const ROUTE_36_NATIONAL_PARK_GATE,                  5,  4 ; 17
	endgroup

	newgroup GOLDENROD                                            ; 11
	map_const ROUTE_34,                                    10, 27 ;  1
	map_const GOLDENROD_CITY,                              20, 18 ;  2
	map_const GOLDENROD_GYM,                               10,  9 ;  3
	map_const GOLDENROD_BIKE_SHOP,                          4,  4 ;  4
	map_const GOLDENROD_HAPPINESS_RATER,                    4,  4 ;  5
	map_const BILLS_FAMILYS_HOUSE,                          4,  4 ;  6
	map_const GOLDENROD_MAGNET_TRAIN_STATION,              10,  9 ;  7
	map_const GOLDENROD_FLOWER_SHOP,                        4,  4 ;  8
	map_const GOLDENROD_PP_SPEECH_HOUSE,                    4,  4 ;  9
	map_const GOLDENROD_NAME_RATER,                         4,  4 ; 10
	map_const GOLDENROD_DEPT_STORE_1F,                      8,  4 ; 11
	map_const GOLDENROD_DEPT_STORE_2F,                      8,  4 ; 12
	map_const GOLDENROD_DEPT_STORE_3F,                      8,  4 ; 13
	map_const GOLDENROD_DEPT_STORE_4F,                      8,  4 ; 14
	map_const GOLDENROD_DEPT_STORE_5F,                      8,  4 ; 15
	map_const GOLDENROD_DEPT_STORE_6F,                      8,  4 ; 16
	map_const GOLDENROD_DEPT_STORE_ELEVATOR,                2,  2 ; 17
	map_const GOLDENROD_DEPT_STORE_ROOF,                    8,  4 ; 18
	map_const GOLDENROD_GAME_CORNER,                       10,  7 ; 19
	map_const GOLDENROD_POKECENTER_1F,                      5,  4 ; 20
	map_const POKECOM_CENTER_ADMIN_OFFICE_MOBILE,          16, 16 ; 21
	map_const ILEX_FOREST_AZALEA_GATE,                      5,  4 ; 22
	map_const ROUTE_34_ILEX_FOREST_GATE,                    5,  4 ; 23
	map_const DAY_CARE,                                     5,  4 ; 24
	map_const HATCH_ROOM,                                   3, 68 ; 25
	endgroup

	newgroup VERMILION                                            ; 12
	endgroup

	newgroup PALLET                                               ; 13
	map_const PALLET_TOWN,                                  5,  4 ;  2
	map_const OAKS_LAB,                                     5,  6 ;  6
	endgroup

	newgroup PEWTER                                               ; 14
	endgroup

	newgroup FAST_SHIP                                            ; 15
	map_const OLIVINE_PORT,                                10, 18 ;  1
	map_const OLIVINE_PORT_PASSAGE,                        10,  9 ;  8
	map_const MOUNT_MOON_SQUARE,                           15,  9 ; 10
	map_const MOUNT_MOON_GIFT_SHOP,                         4,  4 ; 11
	map_const TIN_TOWER_ROOF,                              10,  9 ; 12
	endgroup

	newgroup INDIGO                                               ; 16
	map_const ROUTE_23,                                    10,  9 ;  1
	map_const INDIGO_PLATEAU_POKECENTER_1F,                 9,  7 ;  2
	map_const WILLS_ROOM,                                   5,  9 ;  3
	map_const KOGAS_ROOM,                                   5,  9 ;  4
	map_const BRUNOS_ROOM,                                  5,  9 ;  5
	map_const KARENS_ROOM,                                  5,  9 ;  6
	map_const LANCES_ROOM,                                  5, 12 ;  7
	map_const HALL_OF_FAME,                                 5,  7 ;  8
	endgroup

	newgroup FUCHSIA                                              ; 17
	endgroup

	newgroup LAVENDER                                             ; 18
	endgroup

	newgroup SILVER                                               ; 19
	map_const SILVER_CAVE_OUTSIDE,                         20, 18 ;  2
	map_const SILVER_CAVE_POKECENTER_1F,                    5,  4 ;  3
	map_const ROUTE_39_SILVER_CAVE_GATE,                    5,  4 ;  4
	endgroup

	newgroup CABLE_CLUB                                           ; 20
	map_const POKECENTER_2F,                                8,  4 ;  1
	map_const TRADE_CENTER,                                 5,  4 ;  2
	map_const COLOSSEUM,                                    5,  4 ;  3
	map_const TIME_CAPSULE,                                 5,  4 ;  4
	map_const MOBILE_TRADE_ROOM,                            5,  4 ;  5
	map_const MOBILE_BATTLE_ROOM,                           5,  4 ;  6
	endgroup

	newgroup CELADON                                              ; 21

	map_const CELADON_MANSION_1F,                           4,  5 ; 12
	map_const CELADON_MANSION_2F,                           4,  5 ; 13
	map_const CELADON_MANSION_3F,                           4,  5 ; 14
	map_const CELADON_MANSION_ROOF,                         4,  5 ; 15
	map_const CELADON_MANSION_ROOF_HOUSE,                   4,  4 ; 16
	endgroup

	newgroup CIANWOOD                                             ; 22
	map_const ROUTE_40,                                    10, 18 ;  1
	map_const ROUTE_41,                                    25, 27 ;  2
	map_const CIANWOOD_CITY,                               15, 29 ;  3
	map_const MANIAS_HOUSE,                                 4,  4 ;  4
	map_const CIANWOOD_GYM,                                 5,  9 ;  5
	map_const CIANWOOD_POKECENTER_1F,                       5,  4 ;  6
	map_const CIANWOOD_PHARMACY,                            4,  4 ;  7
	map_const CIANWOOD_PHOTO_STUDIO,                        4,  4 ;  8
	map_const CIANWOOD_LUGIA_SPEECH_HOUSE,                  4,  4 ;  9
	map_const POKE_SEERS_HOUSE,                             4,  4 ; 10
	map_const BATTLE_TOWER_1F,                              8,  5 ; 11
	map_const BATTLE_TOWER_BATTLE_ROOM,                     4,  4 ; 12
	map_const BATTLE_TOWER_ELEVATOR,                        2,  2 ; 13
	map_const BATTLE_TOWER_HALLWAY,                        11,  2 ; 14
	map_const ROUTE_40_BATTLE_TOWER_GATE,                   5,  4 ; 15
	map_const BATTLE_TOWER_OUTSIDE,                        10, 14 ; 16
	map_const CIANWOOD_PORT,                              10, 18 ;  17
	map_const CIANWOOD_PORT_PASSAGE,                      10,  9 ;  18
	
	endgroup

	newgroup VIRIDIAN                                             ; 23
	map_const TRAINER_HOUSE_1F,                             5,  7 ;  6
	map_const TRAINER_HOUSE_B1F,                            5,  8 ;  7
	map_const VICTORY_ROAD_GATE,                            6,  9 ; 13
	endgroup

	newgroup NEW_BARK                                             ; 24
	map_const ROUTE_26,                                    10, 54 ;  1
	map_const ROUTE_27,                                    40,  9 ;  2
	map_const ROUTE_29,                                    30,  9 ;  3
	map_const NEW_BARK_TOWN,                               10,  9 ;  4
	map_const ELMS_LAB,                                     5,  6 ;  5
	map_const PLAYERS_HOUSE_1F,                             5,  4 ;  6
	map_const PLAYERS_HOUSE_2F,                             4,  3 ;  7
	map_const PLAYERS_NEIGHBORS_HOUSE,                      4,  4 ;  8
	map_const ELMS_HOUSE,                                   4,  4 ;  9
	map_const ROUTE_26_HEAL_HOUSE,                          4,  4 ; 10
	map_const DAY_OF_WEEK_SIBLINGS_HOUSE,                   4,  4 ; 11
	map_const ROUTE_27_SANDSTORM_HOUSE,                     4,  4 ; 12
	map_const ROUTE_29_ROUTE_46_GATE,                       5,  4 ; 13
	endgroup

	newgroup SAFFRON                                              ; 25
	endgroup

	newgroup CHERRYGROVE                                          ; 26
	map_const ROUTE_30,                                    10, 27 ;  1
	map_const ROUTE_31,                                    20,  9 ;  2
	map_const CHERRYGROVE_CITY,                            20,  9 ;  3
	map_const CHERRYGROVE_MART,                             6,  4 ;  4
	map_const CHERRYGROVE_POKECENTER_1F,                    5,  4 ;  5
	map_const CHERRYGROVE_GYM_SPEECH_HOUSE,                 4,  4 ;  6
	map_const GUIDE_GENTS_HOUSE,                            4,  4 ;  7
	map_const CHERRYGROVE_EVOLUTION_SPEECH_HOUSE,           4,  4 ;  8
	map_const ROUTE_30_BERRY_HOUSE,                         4,  4 ;  9
	map_const MR_POKEMONS_HOUSE,                            4,  4 ; 10
	map_const ROUTE_31_VIOLET_GATE,                         5,  4 ; 11
	endgroup

DEF NUM_MAP_GROUPS EQU const_value ; 26
