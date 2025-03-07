	object_const_def
	const ROUTE44_FISHER1
	const ROUTE44_FISHER2
	const ROUTE44_YOUNGSTER1
	const ROUTE44_SUPER_NERD
	const ROUTE44_YOUNGSTER2
	const ROUTE44_COOLTRAINER_M
	const ROUTE44_COOLTRAINER_F
	const ROUTE44_POKE_BALL1
	const ROUTE44_POKE_BALL2
	const ROUTE44_POKE_BALL3
	const ROUTE44_SUPER_ROD_FISHING_GURU
	const ROUTE_44_BERRY
	const ROUTE_44_APRICORN

Route44_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, Route44Fruittrees

Route44Fruittrees:
	readvar VAR_WEEKDAY
	ifequal TUESDAY, .NoFruit
	ifequal THURSDAY, .NoFruit
	ifequal SATURDAY, .NoFruit
	checkflag ENGINE_DAILY_ROUTE_43_44_TREES
	iftrue .NoFruit
	appear ROUTE_44_BERRY
	appear ROUTE_44_APRICORN
.NoFruit:
	endcallback

TrainerBirdKeeperVance1:
	trainer BIRD_KEEPER, VANCE1, EVENT_BEAT_BIRD_KEEPER_VANCE, BirdKeeperVance1SeenText, BirdKeeperVance1BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_BIRDKEEPER_VANCE
	opentext
	checkevent EVENT_GOT_CARBOS_FROM_VANCE
	iftrue .ReceivedCarbosBefore
	checkflag ENGINE_VANCE_READY_FOR_REMATCH
	iftrue .WantsBattle
	checkcellnum PHONE_BIRDKEEPER_VANCE
	iftrue Route44NumberAcceptedM
	checkevent EVENT_VANCE_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedAlready
	writetext BirdKeeperVanceLegendaryBirdsText
	promptbutton
	setevent EVENT_VANCE_ASKED_FOR_PHONE_NUMBER
	scall Route44AskNumber
	sjump .AskForNumber

.AskedAlready:
	scall Route44AskNumber
.AskForNumber:
	askforphonenumber PHONE_BIRDKEEPER_VANCE
	ifequal PHONE_CONTACT_REFUSED, Route44NumberDeclinedM
	gettrainername STRING_BUFFER_3, BIRD_KEEPER, VANCE1
	scall Route44RegisteredNumberM
	sjump Route44NumberAcceptedM

.WantsBattle:
	scall Route44RematchM
	winlosstext BirdKeeperVance1BeatenText, 0
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight2
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight1
	loadtrainer BIRD_KEEPER, VANCE1
	startbattle
	reloadmapafterbattle
	end

.LoadFight1:
	loadtrainer BIRD_KEEPER, VANCE2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_VANCE_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer BIRD_KEEPER, VANCE3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_VANCE_READY_FOR_REMATCH
	opentext
	writetext VanceRematchGiftText
	waitbutton
	verbosegiveitem CARBOS
	iffalse .PackFull
	closetext
	end

.ReceivedCarbosBefore
	writetext VanceRematchGiftAgainText
	waitbutton
	verbosegiveitem CARBOS
	iffalse .PackFull
	clearevent EVENT_GOT_CARBOS_FROM_VANCE
	closetext
	end

.PackFull:
	setevent EVENT_GOT_CARBOS_FROM_VANCE
	jumpstd PackFullMScript
	end

Route44AskNumber:
	jumpstd AskNumber1MScript
	end

Route44RegisteredNumberM:
	jumpstd RegisteredNumberMScript
	end

Route44NumberAcceptedM:
	jumpstd NumberAcceptedMScript
	end

Route44NumberDeclinedM:
	jumpstd NumberDeclinedMScript
	end

Route44RematchM:
	jumpstd RematchMScript
	end

Route44GiftM:
	jumpstd GiftMScript
	end

Route44PackFullM:
	jumpstd PackFullMScript
	end

VancePackFull:
	setevent EVENT_VANCE_CARBOS
	jumpstd PackFullMScript
	end

TrainerPsychicPhil:
	trainer PSYCHIC_T, PHIL, EVENT_BEAT_PSYCHIC_PHIL, PsychicPhilSeenText, PsychicPhilBeatenText, 0, .Script

.Script:
	opentext
	writetext PsychicPhilAfterBattleText
	waitbutton
	closetext
	end

TrainerFisherWilton1:
	trainer FISHER, WILTON1, EVENT_BEAT_FISHER_WILTON, FisherWilton1SeenText, FisherWilton1BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_FISHER_WILTON
	opentext
	checkflag ENGINE_WILTON_HAS_ITEM
	iftrue .HasItem
	checkflag ENGINE_WILTON_READY_FOR_REMATCH
	iftrue .WantsBattle
	checkcellnum PHONE_FISHER_WILTON
	iftrue Route44NumberAcceptedM
	checkevent EVENT_WILTON_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedAlready
	writetext FisherWiltonHugePoliwagText
	promptbutton
	setevent EVENT_WILTON_ASKED_FOR_PHONE_NUMBER
	scall Route44AskNumber1
	sjump .AskForNumber

.AskedAlready:
	scall Route44AskNumber1
.AskForNumber:
	askforphonenumber PHONE_FISHER_WILTON
	ifequal PHONE_CONTACT_REFUSED, Route44NumberDeclinedM
	gettrainername STRING_BUFFER_3, FISHER, WILTON1
	scall Route44RegisteredNumberM
	sjump Route44NumberAcceptedM

.WantsBattle:
	scall Route44RematchM
	winlosstext FisherWilton1BeatenText, 0
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight2
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight1
	loadtrainer FISHER, WILTON1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_WILTON_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer FISHER, WILTON2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_WILTON_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer FISHER, WILTON3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_WILTON_READY_FOR_REMATCH
	end

.HasItem:
	scall Route44GiftM
	verbosegiveitem ULTRA_BALL
	iffalse .BagFull
	clearflag ENGINE_WILTON_HAS_ITEM
	closetext
	end

.BagFull:
	setflag ENGINE_WILTON_HAS_ITEM
	jumpstd PackFullMScript
	end

Route44AskNumber1:
	jumpstd AskNumber1MScript
	end

TrainerFisherEdgar:
	trainer FISHER, EDGAR, EVENT_BEAT_FISHER_EDGAR, FisherEdgarSeenText, FisherEdgarBeatenText, 0, .Script

.Script:
	opentext
	writetext FisherEdgarAfterBattleText
	waitbutton
	closetext
	end

TrainerCooltrainerfCybil:
	trainer COOLTRAINERF, CYBIL, EVENT_BEAT_COOLTRAINERF_CYBIL, CooltrainerfCybilSeenText, CooltrainerfCybilBeatenText, 0, .Script

.Script:
	opentext
	writetext CooltrainerfCybilAfterBattleText
	waitbutton
	closetext
	end

TrainerPokemaniacZach:
	trainer POKEMANIAC, ZACH, EVENT_BEAT_POKEMANIAC_ZACH, PokemaniacZachSeenText, PokemaniacZachBeatenText, 0, .Script

.Script:
	opentext
	writetext PokemaniacZachAfterBattleText
	waitbutton
	closetext
	end

TrainerCooltrainermAllen:
	trainer COOLTRAINERM, ALLEN, EVENT_BEAT_COOLTRAINERM_ALLEN, CooltrainermAllenSeenText, CooltrainermAllenBeatenText, 0, .Script

.Script:
	opentext
	writetext CooltrainermAllenAfterBattleText
	waitbutton
	closetext
	end

Route44Sign1:
	jumptext Route44Sign1Text

Route44Sign2:
	jumptext Route44Sign2Text

Route44MaxRevive:
	itemball MAX_REVIVE

Route44UltraBall:
	itemball ULTRA_BALL

Route44MaxRepel:
	itemball NUGGET

Route44HiddenElixer:
	hiddenitem ELIXER, EVENT_ROUTE_44_HIDDEN_ELIXER

FisherWilton1SeenText:
	text "Aack! You made me"
	line "lose a #MON!"

	para "What are you going"
	line "to do about it?"
	done

FisherWilton1BeatenText:
	text "Just forget about"
	line "it."
	done

FisherWiltonHugePoliwagText:
	text "That #MON that"
	line "got away…"
	cont "It was huge."

	para "I swear it must've"
	line "been 16 feet long!"
	done

FisherEdgarSeenText:
	text "I fish until I"
	line "can't anymore."

	para "I also battle"
	line "until I drop."

	para "That's my"
	line "relationship"
	cont "with my #MON."
	done

FisherEdgarBeatenText:
	text "Hmmmm… "
	line "This isn't right."
	done

FisherEdgarAfterBattleText:
	text "That's 100 wins"
	line "to 101 losses."

	para "I won't battle"
	line "again for a while."
	done

BirdKeeperVance1SeenText:
	text "Do you know about"
	line "the legendary bird"
	cont "#MON?"
	done

BirdKeeperVance1BeatenText:
	text "Whew! You're hot"
	line "stuff."
	done

BirdKeeperVanceLegendaryBirdsText:
	text "ARTICUNO, ZAPDOS"
	line "and MOLTRES are"

	para "the three legend-"
	line "ary bird #MON."

	para "I heard there are"
	line "other legendary"
	cont "birds, though."
	done

VanceRematchGiftText:
	text "Thanks for taking"
	line "me on so often!"

	para "I know! This will"
	line "do as my thanks!"
	done

VanceRematchGiftAgainText:
	text "Can you take my"
	line "gift now? Here!"
	done

PsychicPhilSeenText:
	text "I'm gonna win,"
	line "for sure!"
	done

PsychicPhilBeatenText:
	text "Arrgh… That's a"
	line "shocking loss…"
	done

PsychicPhilAfterBattleText:
	text "It's important to"
	line "have conviction"
	cont "on your side."
	done

PokemaniacZachSeenText:
	text "I'll do anything"
	line "to get my hands on"
	cont "rare #MON!"
	done

PokemaniacZachBeatenText:
	text "Oooh, your #MON"
	line "are so appealing."
	done

PokemaniacZachAfterBattleText:
	text "If a #MON has"
	line "different colors"

	para "from usual, it's"
	line "more valuable."

	para "What? You mean"
	line "that's not true?"
	done

CooltrainermAllenSeenText:
	text "I can tell you're"
	line "a good trainer by"
	cont "looking at you."

	para "I'm good at #-"
	line "MON, and I can see"
	cont "that you are too."
	done

CooltrainermAllenBeatenText:
	text "Tch! It's a total"
	line "loss on my part."
	done

CooltrainermAllenAfterBattleText:
	text "Wow. You have a"
	line "lot of BADGES."

	para "No wonder you're"
	line "so tough."

	para "I wonder if"
	line "ECRUTEAK GYM's"

	para "MORTY is still in"
	line "training?"

	para "He really hammered"
	line "me."
	done

CooltrainerfCybilSeenText:
	text "You look strong."

	para "Good trainers seek"
	line "tough opponents"
	cont "instinctively."
	done

CooltrainerfCybilBeatenText:
	text "Nope! This won't"
	line "do at all."
	done

CooltrainerfCybilAfterBattleText:
	text "We all get better"
	line "by experiencing"
	cont "many battles."

	para "I battled a lot to"
	line "become what I am"
	cont "today--an elite."
	done

Route44Sign1Text:
	text "ROUTE 44"
	line "ICE PATH AHEAD"
	done

Route44Sign2Text:
	text "ROUTE 44"

	para "MAHOGANY TOWN -"
	line "BLACKTHORN CITY"
	done

Route12SuperRodHouseFishingGuruScript1:
	faceplayer
	opentext
	checkevent EVENT_GOT_SUPER_ROD
	iftrue .GotSuperRod
	writetext OfferSuperRodText1
	yesorno
	iffalse .Refused
	writetext GiveSuperRodText1
	promptbutton
	verbosegiveitem SUPER_ROD
	iffalse .NoRoom
	setevent EVENT_GOT_SUPER_ROD
.GotSuperRod:
	writetext GaveSuperRodText1
	waitbutton
	closetext
	end

.Refused:
	writetext DontWantSuperRodText1
	waitbutton
.NoRoom:
	closetext
	end

OfferSuperRodText1:
	text "I'm the FISHING"
	line "GURU's younger"
	cont "brother."

	para "I can see that you"
	line "like fishing."

	para "There's no doubt"
	line "in my mind at all!"

	para "So? I know I'm"
	line "right."
	done

GiveSuperRodText1:
	text "Yes, yes. Just as"
	line "I thought!"

	para "Here, fishing fan!"
	line "Take this--it's a"
	cont "SUPER ROD."
	done

GaveSuperRodText1:
	text "Try your hand at"
	line "fishing wherever"
	cont "there is water."

	para "Remember--you can"
	line "catch different"

	para "#MON using"
	line "different RODS."
	done

DontWantSuperRodText1:
	text "Huh? My own eyes"
	line "deceived me?"
	done

Route44BerryTree:
	opentext
	getitemname STRING_BUFFER_3, BURNT_BERRY
	writetext Route44BerryTreeText
	promptbutton
	writetext Route44HeyItsBerryApricornText
	promptbutton
	giveitem BURNT_BERRY
	iffalse Route44NoRoomInBag
	disappear ROUTE_44_BERRY
	setflag ENGINE_DAILY_ROUTE_43_44_TREES
	writetext Route44FoundItemText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	end

Route44ApricornTree:
	opentext
	getitemname STRING_BUFFER_3, RED_APRICORN
	writetext Route44BerryTreeText
	promptbutton
	writetext Route44HeyItsBerryApricornText
	promptbutton
	giveitem RED_APRICORN
	iffalse Route44NoRoomInBag
	disappear ROUTE_44_APRICORN
	setflag ENGINE_DAILY_ROUTE_43_44_TREES
	writetext Route44FoundItemText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	end

Route44NoBerryOrApricorn:
	opentext
	writetext Route44BerryTreeText
	promptbutton
	writetext Route44NothingHereText
	waitbutton
	closetext
	end

Route44NoRoomInBag:
	writetext Route44NoRoomInBagText
	waitbutton
	closetext
	end

Route44BerryTreeText:
	text_far _FruitBearingTreeText
	text_end

Route44NothingHereText:
	text_far _NothingHereText
	text_end

Route44HeyItsBerryApricornText:
	text "Hey! It's a"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done

Route44FoundItemText:
	text_far _ObtainedFruitText
	text_end

Route44NoRoomInBagText:
	text_far _CantCarryItemText
	text_end

Route44_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 56,  7, ICE_PATH_1F, 1

	def_coord_events

	def_bg_events
	bg_event 53,  7, BGEVENT_READ, Route44Sign1
	bg_event  6, 10, BGEVENT_READ, Route44Sign2
	bg_event 32,  9, BGEVENT_ITEM, Route44HiddenElixer
	bg_event 15,  3, BGEVENT_READ, Route44NoBerryOrApricorn
	bg_event  9,  5, BGEVENT_READ, Route44NoBerryOrApricorn

	def_object_events
	object_event 35,  3, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 1, TrainerFisherWilton1, -1
	object_event 19, 13, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 1, TrainerFisherEdgar, -1
	object_event 10,  9, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerPsychicPhil, -1
	object_event 43,  2, SPRITE_SUPER_NERD, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerPokemaniacZach, -1
	object_event 51,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, TrainerBirdKeeperVance1, -1
	object_event 41, 15, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 5, TrainerCooltrainermAllen, -1
	object_event 31, 14, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 5, TrainerCooltrainerfCybil, -1
	object_event 30,  8, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route44MaxRevive, EVENT_ROUTE_44_MAX_REVIVE
	object_event 45,  4, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route44UltraBall, EVENT_ROUTE_44_ULTRA_BALL
	object_event 14,  9, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route44MaxRepel, EVENT_ROUTE_44_MAX_REPEL
	object_event 42,  5, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route12SuperRodHouseFishingGuruScript1, -1
	object_event 15,  3, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_EMOTE, OBJECTTYPE_SCRIPT, 0, Route44BerryTree, EVENT_ROUTE_44_BERRY
	object_event  9,  5, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route44ApricornTree, EVENT_ROUTE_44_APRICORN
