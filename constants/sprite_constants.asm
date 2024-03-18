; sprite ids
; OverworldSprites indexes (see data/sprites/sprites.asm)
	const_def
	const SPRITE_NONE ; 00
	const SPRITE_CHRIS ; 01
	const SPRITE_CHRIS_BIKE ; 02
	const SPRITE_GAMEBOY_KID ; 03
	const SPRITE_RIVAL ; 04
	const SPRITE_OAK ; 05
	const SPRITE_RED ; 06
	const SPRITE_BLUE ; 07
	const SPRITE_BILL ; 08
	const SPRITE_ELDER ; 09
	const SPRITE_JANINE ; 0a
	const SPRITE_KURT ; 0b
	const SPRITE_MOM ; 0c
	const SPRITE_BLAINE ; 0d
	const SPRITE_REDS_MOM ; 0e
	const SPRITE_DAISY ; 0f
	const SPRITE_ELM ; 10
	const SPRITE_WILL ; 11
	const SPRITE_FALKNER ; 12
	const SPRITE_WHITNEY ; 13
	const SPRITE_BUGSY ; 14
	const SPRITE_MORTY ; 15
	const SPRITE_CHUCK ; 16
	const SPRITE_JASMINE ; 17
	const SPRITE_PRYCE ; 18
	const SPRITE_CLAIR ; 19
	const SPRITE_BROCK ; 1a
	const SPRITE_KAREN ; 1b
	const SPRITE_BRUNO ; 1c
	const SPRITE_MISTY ; 1d
	const SPRITE_LANCE ; 1e
	const SPRITE_SURGE ; 1f
	const SPRITE_ERIKA ; 20
	const SPRITE_KOGA ; 21
	const SPRITE_SABRINA ; 22
	const SPRITE_COOLTRAINER_M ; 23
	const SPRITE_COOLTRAINER_F ; 24
	const SPRITE_BUG_CATCHER ; 25
	const SPRITE_TWIN ; 26
	const SPRITE_YOUNGSTER ; 27
	const SPRITE_LASS ; 28
	const SPRITE_TEACHER ; 29
	const SPRITE_BEAUTY ; 2a
	const SPRITE_SUPER_NERD ; 2b
	const SPRITE_ROCKER ; 2c
	const SPRITE_POKEFAN_M ; 2d
	const SPRITE_POKEFAN_F ; 2e
	const SPRITE_GRAMPS ; 2f
	const SPRITE_GRANNY ; 30
	const SPRITE_SWIMMER_GUY ; 31
	const SPRITE_SWIMMER_GIRL ; 32
	const SPRITE_BIG_SNORLAX ; 33
	const SPRITE_SURFING_PIKACHU ; 34
	const SPRITE_ROCKET ; 35
	const SPRITE_ROCKET_GIRL ; 36
	const SPRITE_NURSE ; 37
	const SPRITE_LINK_RECEPTIONIST ; 38
	const SPRITE_CLERK ; 39
	const SPRITE_FISHER ; 3a
	const SPRITE_FISHING_GURU ; 3b
	const SPRITE_SCIENTIST ; 3c
	const SPRITE_KIMONO_GIRL ; 3d
	const SPRITE_SAGE ; 3e
	const SPRITE_GENTLEMAN ; 40
	const SPRITE_BLACK_BELT ; 41
	const SPRITE_RECEPTIONIST ; 42
	const SPRITE_OFFICER ; 43
	const SPRITE_SLOWPOKE ; 45
	const SPRITE_CAPTAIN ; 46
	const SPRITE_BIG_LAPRAS ; 47
	const SPRITE_GYM_GUIDE ; 48
	const SPRITE_SAILOR ; 49
	const SPRITE_BIKER ; 4a
	const SPRITE_PHARMACIST ; 4b
	const SPRITE_MONSTER ; 4c
	const SPRITE_FAIRY ; 4d
	const SPRITE_BIRD ; 4e
	const SPRITE_DRAGON ; 4f
	const SPRITE_BIG_ONIX ; 50
	const SPRITE_N64 ; 51
	const SPRITE_SUDOWOODO ; 52
	const SPRITE_SURF ; 53
	const SPRITE_POKE_BALL ; 54
	const SPRITE_POKEDEX ; 55
	const SPRITE_VIRTUAL_BOY ; 57
	const SPRITE_ROCK ; 59
	const SPRITE_BOULDER ; 5a
	const SPRITE_SNES ; 5b
	const SPRITE_FAMICOM ; 5c
	const SPRITE_FRUIT_TREE ; 5d
	const SPRITE_GOLD_TROPHY ; 5e
	const SPRITE_SILVER_TROPHY ; 5f
	const SPRITE_KRIS ; 60
	const SPRITE_KRIS_BIKE ; 61
	const SPRITE_CHRIS_RUN
	const SPRITE_KRIS_RUN
	const SPRITE_CHRIS_SURF
	const SPRITE_KRIS_SURF
	const SPRITE_CHANSEY_OW
	const SPRITE_PORYGON_OW
	const SPRITE_QWILFISH_OW
	const SPRITE_LANTURN_OW
	const SPRITE_MANTINE_OW
	const SPRITE_SEAKING_OW
	const SPRITE_OCTILLERY_OW
	const SPRITE_DRATINI_OW
	const SPRITE_KINGDRA_OW
	const SPRITE_CORSOLA_OW
	const SPRITE_STARMIE_OW
	const SPRITE_GIOVANNI
	const SPRITE_PROTON
	const SPRITE_PETREL
	const SPRITE_AGATHA
	const SPRITE_LORELEI
	const SPRITE_SCARLET
	const SPRITE_ARIANA
	const SPRITE_ARCHER
	const SPRITE_EUSINE
	const SPRITE_MAXIMA
DEF NUM_OVERWORLD_SPRITES EQU const_value - 1

; SpriteMons indexes (see data/sprites/sprite_mons.asm)
	const_next $77
DEF SPRITE_POKEMON EQU const_value
	const SPRITE_UNOWN ; 80
	const SPRITE_WEEDLE ; 83
	const SPRITE_MAGIKARP ; 88
	const SPRITE_SQUIRTLE ; 89
	const SPRITE_PIKACHU ; 8e
	const SPRITE_CHARMANDER ; 90
	const SPRITE_BULBASAUR ; 93
	const SPRITE_JIGGLYPUFF ; 94
	const SPRITE_MACHOP ; 9a
	const SPRITE_RHYDON ; 9d
	const SPRITE_MOLTRES ; 9e
	const SPRITE_GYARADOS ; a0
	const SPRITE_LUGIA ; a1
	const SPRITE_HO_OH ; a2
; Crystal Trove
	const SPRITE_SANDSHREW_OW
	const SPRITE_CUBONE_OW
	const SPRITE_ONIX_OW
	const SPRITE_WOOPER_OW
	const SPRITE_SENTRET_OW
	const SPRITE_HOPPIP_OW
	const SPRITE_LEDYBA_OW
	const SPRITE_SPINARAK_OW
	const SPRITE_HOOTHOOT_OW
	const SPRITE_GEODUDE_OW
	const SPRITE_RHYDON_OW
	const SPRITE_DIGLETT_OW
	const SPRITE_ZUBAT_OW
	const SPRITE_MARILL_OW
	const SPRITE_XATU_OW
	const SPRITE_GIRAFARIG_OW
	const SPRITE_SMEARGLE_OW
	const SPRITE_EEVEE_OW
	const SPRITE_EXEGGCUTE_OW
	const SPRITE_EKANS_OW
	const SPRITE_SPEAROW_OW
	const SPRITE_VULPIX_OW
	const SPRITE_NIDORAN_M_OW
	const SPRITE_NIDORAN_F_OW
	const SPRITE_SLOWPOKE_OW
	const SPRITE_POLIWHIRL_OW
	const SPRITE_RATICATE_OW
	const SPRITE_WEEZING_OW
	const SPRITE_MUK_OW
	const SPRITE_BUTTERFREE_OW
	const SPRITE_BEEDRILL_OW
	const SPRITE_PINECO_OW
	const SPRITE_ODDISH_OW
	const SPRITE_PARAS_OW
	const SPRITE_MEOWTH_OW
	const SPRITE_PIDGEOTTO_OW
	const SPRITE_SNUBBULL_OW
	const SPRITE_KADABRA_OW
	const SPRITE_DROWZEE_OW
	const SPRITE_SUNKERN_OW
	const SPRITE_PSYDUCK_OW
	const SPRITE_SCYTHER_OW
	const SPRITE_PINSIR_OW
	const SPRITE_VENONAT_OW
	const SPRITE_BELLSPROUT_OW
	const SPRITE_GROWLITHE_OW
	const SPRITE_MAREEP_OW
	const SPRITE_YANMA_OW
	const SPRITE_HOUNDOUR_OW
	const SPRITE_DODRIO_OW
	const SPRITE_RAPIDASH_OW
	const SPRITE_TAUROS_OW
	const SPRITE_MILTANK_OW
	const SPRITE_ELECTRODE_OW
	const SPRITE_GLIGAR_OW
	const SPRITE_MAGNETON_OW
	const SPRITE_MAGCARGO_OW
	const SPRITE_DUNSPARCE_OW
	const SPRITE_MISDREAVUS_OW
	const SPRITE_LICKITUNG_OW
	const SPRITE_AIPOM_OW
	const SPRITE_STANTLER_OW
	const SPRITE_PRIMEAPE_OW
	const SPRITE_MURKROW_OW
	const SPRITE_SUICUNE_OW
	const SPRITE_ENTEI_OW
	const SPRITE_RAIKOU_OW
	const SPRITE_GENGAR_OW
	const SPRITE_TENTACRUEL_OW
	const SPRITE_TEDDIURSA_OW
	const SPRITE_TANGELA_OW
	const SPRITE_FARFETCH_D_OW
	const SPRITE_SKARMORY_OW
	const SPRITE_KANGASKHAN_OW
	const SPRITE_HERACROSS_OW
	const SPRITE_DELIBIRD_OW
	const SPRITE_SNEASEL_OW
	const SPRITE_PILOSWINE_OW
	const SPRITE_CLOYSTER_OW
	const SPRITE_DEWGONG_OW
	const SPRITE_WOBBUFFET_OW
	const SPRITE_KINGLER_OW
	const SPRITE_DONPHAN_OW
	const SPRITE_MR__MIME_OW
	const SPRITE_SHUCKLE_OW
	const SPRITE_LARVITAR_OW
	const SPRITE_ARTICUNO
	const SPRITE_ZAPDOS
	const SPRITE_MEWTWO
	const SPRITE_MEW
DEF NUM_POKEMON_SPRITES EQU const_value - SPRITE_POKEMON

; special GetMonSprite values (see engine/overworld/overworld.asm)
	const_next $f4
	const SPRITE_DAY_CARE_MON_1 ; f4
	const SPRITE_DAY_CARE_MON_2 ; f5

; wVariableSprites indexes (see wram.asm)
	const_next $f6
DEF SPRITE_VARS EQU const_value
	const SPRITE_CONSOLE ; f6
	const SPRITE_DOLL_1 ; f7
	const SPRITE_DOLL_2 ; f8
	const SPRITE_BIG_DOLL ; f9
	const SPRITE_FUCHSIA_GYM_1 ; fa
	const SPRITE_FUCHSIA_GYM_2 ; fb
	const SPRITE_FUCHSIA_GYM_3 ; fc
	const SPRITE_FUCHSIA_GYM_4 ; fd
	const SPRITE_COPYCAT ; fe
	const SPRITE_JANINE_IMPERSONATOR ; ff
