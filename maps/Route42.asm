	object_const_def
	const ROUTE42_FISHER
	const ROUTE42_POKEFAN_M
	const ROUTE42_SUPER_NERD
	const ROUTE42_POKE_BALL1
	const ROUTE42_POKE_BALL2
	const ROUTE42_SUICUNE
	const ROUTE42_SUICUNE_STATIONARY
	const ROUTE_42_APRICORN_1
	const ROUTE_42_APRICORN_2
	const ROUTE_42_APRICORN_3

Route42_MapScripts:
	def_scene_scripts
	scene_script Route42Noop1Scene, SCENE_ROUTE42_NOOP
	scene_script Route42Noop2Scene, SCENE_ROUTE42_SUICUNE

	def_callbacks
	callback MAPCALLBACK_OBJECTS, Route42Fruittrees

Route42Noop1Scene:
	end

Route42Noop2Scene:
	end

Route42Fruittrees:
	readvar VAR_WEEKDAY
	ifequal TUESDAY, .NoFruit
	ifequal THURSDAY, .NoFruit
	ifequal SATURDAY, .NoFruit
	checkflag ENGINE_DAILY_ROUTE_39_42_TREES
	iftrue .NoFruit
	appear ROUTE_42_APRICORN_1
	appear ROUTE_42_APRICORN_2
	appear ROUTE_42_APRICORN_3
.NoFruit:
	endcallback

Route45StationarySuicuneScript:
    faceplayer
	opentext
	writetext SuicuneText
	cry SUICUNE
	pause 15
	closetext
	loadvar VAR_BATTLETYPE, BATTLETYPE_SUICUNE
	loadwildmon SUICUNE, 65
	startbattle
	disappear ROUTE42_SUICUNE_STATIONARY
	reloadmapafterbattle
	end
	
SuicuneText:
	text "Rrrr!"
	done

Route42SuicuneScript:
	showemote EMOTE_SHOCK, PLAYER, 15
	pause 15
	playsound SFX_WARP_FROM
	applymovement ROUTE42_SUICUNE, Route42SuicuneMovement
	disappear ROUTE42_SUICUNE
	pause 10
	setscene SCENE_ROUTE42_NOOP
	clearevent EVENT_SAW_SUICUNE_ON_ROUTE_36
	setmapscene ROUTE_36, SCENE_ROUTE36_SUICUNE
	end

TrainerFisherTully:
	trainer FISHER, TULLY1, EVENT_BEAT_FISHER_TULLY, FisherTullySeenText, FisherTullyBeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_FISHER_TULLY
	opentext
	checkflag ENGINE_TULLY_HAS_WATER_STONE
	iftrue .HasWaterStone
	checkflag ENGINE_TULLY_READY_FOR_REMATCH
	iftrue .WantsBattle
	checkcellnum PHONE_FISHER_TULLY
	iftrue .NumberAccepted
	checkevent EVENT_TULLY_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedAlready
	writetext FisherTullyAfterBattleText
	promptbutton
	setevent EVENT_TULLY_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber
	sjump .AskForNumber

.AskedAlready:
	scall .AskNumber
.AskForNumber:
	askforphonenumber PHONE_FISHER_TULLY
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	gettrainername STRING_BUFFER_3, FISHER, TULLY1
	scall .RegisteredNumber
	sjump .NumberAccepted

.WantsBattle:
	scall .Rematch
	winlosstext FisherTullyBeatenText, 0
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight3
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight2
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue .LoadFight1
	loadtrainer FISHER, TULLY1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_TULLY_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer FISHER, TULLY2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_TULLY_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer FISHER, TULLY3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_TULLY_READY_FOR_REMATCH
	end

.LoadFight3:
	loadtrainer FISHER, TULLY4
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_TULLY_READY_FOR_REMATCH
	end

.HasWaterStone:
	scall .Gift
	verbosegiveitem WATER_STONE
	iffalse .NoRoom
	clearflag ENGINE_TULLY_HAS_WATER_STONE
	closetext
	end

.NoRoom:
	sjump .PackFull

.AskNumber:
	jumpstd AskNumber1MScript
	end

.RegisteredNumber:
	jumpstd RegisteredNumberMScript
	end

.NumberAccepted:
	jumpstd NumberAcceptedMScript
	end

.NumberDeclined:
	jumpstd NumberDeclinedMScript
	end

.Rematch:
	jumpstd RematchMScript
	end

.Gift:
	jumpstd GiftMScript
	end

.PackFull:
	jumpstd PackFullMScript
	end

TrainerPokemaniacShane:
	trainer POKEMANIAC, SHANE, EVENT_BEAT_POKEMANIAC_SHANE, PokemaniacShaneSeenText, PokemaniacShaneBeatenText, 0, .Script

.Script:
	opentext
	writetext PokemaniacShaneAfterBattleText
	waitbutton
	closetext
	end

TrainerHikerBenjamin:
	trainer HIKER, BENJAMIN, EVENT_BEAT_HIKER_BENJAMIN, HikerBenjaminSeenText, HikerBenjaminBeatenText, 0, .Script

.Script:
	opentext
	writetext HikerBenjaminAfterBattleText
	waitbutton
	closetext
	end

Route42Sign1:
	jumptext Route42Sign1Text

MtMortarSign1:
	jumptext MtMortarSign1Text

MtMortarSign2:
	jumptext MtMortarSign2Text

Route42Sign2:
	jumptext Route42Sign2Text

Route42UltraBall:
	itemball ULTRA_BALL

Route42SuperPotion:
	itemball SUPER_POTION

Route42HiddenMaxPotion:
	hiddenitem MAX_POTION, EVENT_ROUTE_42_HIDDEN_MAX_POTION

Route42SuicuneMovement:
	set_sliding
	fast_jump_step UP
	fast_jump_step UP
	fast_jump_step UP
	fast_jump_step RIGHT
	fast_jump_step RIGHT
	fast_jump_step RIGHT
	remove_sliding
	step_end

FisherTullySeenText:
	text "Let me demonstrate"
	line "the power of the"
	cont "#MON I caught!"
	done

FisherTullyBeatenText:
	text "What? That's not"
	line "right."
	done

FisherTullyAfterBattleText:
	text "I want to become"
	line "the trainer CHAMP"

	para "using the #MON"
	line "I caught."

	para "That's the best"
	line "part of fishing!"
	done

HikerBenjaminSeenText:
	text "Ah, it's good to"
	line "be outside!"
	cont "I feel so free!"
	done

HikerBenjaminBeatenText:
	text "Gahahah!"
	done

HikerBenjaminAfterBattleText:
	text "Losing feels in-"
	line "significant if you"

	para "look up at the big"
	line "sky!"
	done

PokemaniacShaneSeenText:
	text "HEY!"

	para "This is my secret"
	line "place! Get lost,"
	cont "you outsider!"
	done

PokemaniacShaneBeatenText:
	text "I should have used"
	line "my MOON STONE…"
	done

PokemaniacShaneAfterBattleText:
	text "You're working on"
	line "a #DEX?"

	para "Wow, you must know"
	line "some pretty rare"
	cont "#MON!"

	para "May I please see"
	line "it. Please?"
	done

Route42Sign1Text:
	text "ROUTE 42"

	para "ECRUTEAK CITY -"
	line "MAHOGANY TOWN"
	done

MtMortarSign1Text:
	text "MT.MORTAR"

	para "WATERFALL CAVE"
	line "INSIDE"
	done

MtMortarSign2Text:
	text "MT.MORTAR"

	para "WATERFALL CAVE"
	line "INSIDE"
	done

Route42Sign2Text:
	text "ROUTE 42"

	para "ECRUTEAK CITY -"
	line "MAHOGANY TOWN"
	done

Route42ApricornTree1:
	opentext
	getitemname STRING_BUFFER_3, PNK_APRICORN
	writetext Route42BerryTreeText
	promptbutton
	writetext Route42HeyItsBerryApricornText
	promptbutton
	giveitem PNK_APRICORN
	iffalse Route42NoRoomInBag
	disappear ROUTE_42_APRICORN_1
	setflag ENGINE_DAILY_ROUTE_39_42_TREES
	writetext Route42FoundItemText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	end

Route42ApricornTree2:
	opentext
	getitemname STRING_BUFFER_3, GRN_APRICORN
	writetext Route42BerryTreeText
	promptbutton
	writetext Route42HeyItsBerryApricornText
	promptbutton
	giveitem GRN_APRICORN
	iffalse Route42NoRoomInBag
	disappear ROUTE_42_APRICORN_2
	setflag ENGINE_DAILY_ROUTE_39_42_TREES
	writetext Route42FoundItemText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	end

Route42ApricornTree3:
	opentext
	getitemname STRING_BUFFER_3, YLW_APRICORN
	writetext Route42BerryTreeText
	promptbutton
	writetext Route42HeyItsBerryApricornText
	promptbutton
	giveitem YLW_APRICORN
	iffalse Route42NoRoomInBag
	disappear ROUTE_42_APRICORN_3
	setflag ENGINE_DAILY_ROUTE_39_42_TREES
	writetext Route42FoundItemText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	end

Route42NoBerryOrApricorn:
	opentext
	writetext Route42BerryTreeText
	promptbutton
	writetext Route42NothingHereText
	waitbutton
	closetext
	end

Route42NoRoomInBag:
	writetext Route42NoRoomInBagText
	waitbutton
	closetext
	end

Route42BerryTreeText:
	text_far _FruitBearingTreeText
	text_end

Route42NothingHereText:
	text_far _NothingHereText
	text_end

Route42HeyItsBerryApricornText:
	text "Hey! It's a"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done

Route42FoundItemText:
	text_far _ObtainedFruitText
	text_end

Route42NoRoomInBagText:
	text_far _CantCarryItemText
	text_end

Route42_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  8, ROUTE_42_ECRUTEAK_GATE, 3
	warp_event  0,  9, ROUTE_42_ECRUTEAK_GATE, 4
	warp_event 10,  5, MOUNT_MORTAR_1F_OUTSIDE, 1
	warp_event 28,  9, MOUNT_MORTAR_1F_OUTSIDE, 2
	warp_event 46,  7, MOUNT_MORTAR_1F_OUTSIDE, 3
	warp_event 40, 15, ROUTE_42_GROTTO, 1


	def_coord_events
	coord_event 24, 14, SCENE_ROUTE42_SUICUNE, Route42SuicuneScript

	def_bg_events
	bg_event  4, 10, BGEVENT_READ, Route42Sign1
	bg_event  7,  5, BGEVENT_READ, MtMortarSign1
	bg_event 45,  9, BGEVENT_READ, MtMortarSign2
	bg_event 54,  8, BGEVENT_READ, Route42Sign2
	bg_event 16, 11, BGEVENT_ITEM, Route42HiddenMaxPotion
	bg_event 27, 16, BGEVENT_READ, Route42NoBerryOrApricorn
	bg_event 28, 16, BGEVENT_READ, Route42NoBerryOrApricorn
	bg_event 29, 16, BGEVENT_READ, Route42NoBerryOrApricorn

	def_object_events
	object_event 40, 10, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 1, TrainerFisherTully, -1
	object_event 51,  9, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerHikerBenjamin, -1
	object_event 47,  8, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerPokemaniacShane, -1
	object_event  6,  4, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route42UltraBall, EVENT_ROUTE_42_ULTRA_BALL
	object_event 33,  8, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route42SuperPotion, EVENT_ROUTE_42_SUPER_POTION
	object_event 26, 16, SPRITE_SUICUNE_OW, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_SAW_SUICUNE_ON_ROUTE_42
	object_event 26, 16, SPRITE_SUICUNE_OW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route45StationarySuicuneScript, EVENT_ROUTE_42_STATIONARY_SUICUNE
	object_event 27, 16, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, Route42ApricornTree1, EVENT_ROUTE_42_APRICORN_1
	object_event 28, 16, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route42ApricornTree2, EVENT_ROUTE_42_APRICORN_2
	object_event 29, 16, SPRITE_APRICORN_YELLOW, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route42ApricornTree3, EVENT_ROUTE_42_APRICORN_3
