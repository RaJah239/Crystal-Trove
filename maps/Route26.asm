	object_const_def
	const ROUTE26_COOLTRAINER_M1
	const ROUTE26_COOLTRAINER_M2
	const ROUTE26_COOLTRAINER_F1
	const ROUTE26_COOLTRAINER_F2
	const ROUTE26_YOUNGSTER
	const ROUTE26_FISHER
	const ROUTE26_POKE_BALL
	const ROUTE_26_BERRY
	const ROUTE_26_APRICORN

Route26_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, Route26Fruittrees

Route26Fruittrees:
	readvar VAR_WEEKDAY
	ifequal TUESDAY, .NoFruit
	ifequal THURSDAY, .NoFruit
	ifequal SATURDAY, .NoFruit
	checkflag ENGINE_DAILY_ROUTE_1_26_TREES
	iftrue .NoFruit
	appear ROUTE_26_BERRY
	appear ROUTE_26_APRICORN
.NoFruit:
	endcallback

TrainerCooltrainermJake:
	trainer COOLTRAINERM, JAKE, EVENT_BEAT_COOLTRAINERM_JAKE, CooltrainermJakeSeenText, CooltrainermJakeBeatenText, 0, .Script

.Script:
	opentext
	writetext CooltrainermJakeAfterBattleText
	waitbutton
	closetext
	end

TrainerCooltrainermGaven3:
	trainer COOLTRAINERM, GAVEN3, EVENT_BEAT_COOLTRAINERM_GAVEN, CooltrainermGaven3SeenText, CooltrainermGaven3BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_COOLTRAINERM_GAVEN
	opentext
	checkevent EVENT_GAVEN_CRYSTAL
	iftrue .RematchGift
	checkflag ENGINE_GAVEN_READY_FOR_REMATCH
	iftrue .WantsBattle
	checkcellnum PHONE_COOLTRAINERM_GAVEN
	iftrue .NumberAccepted
	checkevent EVENT_GAVEN_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedAlready
	writetext CooltrainermGavenAfterText
	promptbutton
	setevent EVENT_GAVEN_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber
	sjump .AskForNumber

.AskedAlready:
	scall .AskNumber
.AskForNumber:
	askforphonenumber PHONE_COOLTRAINERM_GAVEN
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	gettrainername STRING_BUFFER_3, COOLTRAINERM, GAVEN3
	scall .RegisteredNumber
	sjump .NumberAccepted

.WantsBattle:
	scall .Rematch
	winlosstext CooltrainermGaven3BeatenText, 0
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight2
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight1
	loadtrainer COOLTRAINERM, GAVEN3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_GAVEN_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer COOLTRAINERM, GAVEN1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_GAVEN_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer COOLTRAINERM, GAVEN2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_GAVEN_READY_FOR_REMATCH
	opentext
	writetext CooltrainermGavenText_GiveCrytalAfterBattle
	waitbutton
	verbosegiveitem CRYSTAL
	iffalse .PackFull
	closetext
	end

.RematchGift
	writetext CooltrainermGavenAgainText_GiveCrytalAfterBattle
	waitbutton
	verbosegiveitem CRYSTAL
	iffalse .PackFull
	clearevent EVENT_GAVEN_CRYSTAL
	closetext
	end

.PackFull:
	setevent EVENT_GAVEN_CRYSTAL
	jumpstd PackFullMScript
	end

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

TrainerCooltrainerfJoyce:
	trainer COOLTRAINERF, JOYCE, EVENT_BEAT_COOLTRAINERF_JOYCE, CooltrainerfJoyceSeenText, CooltrainerfJoyceBeatenText, 0, .Script

.Script:
	opentext
	writetext CooltrainerfJoyceAfterBattleText
	waitbutton
	closetext
	end

TrainerCooltrainerfBeth1:
	trainer COOLTRAINERF, BETH1, EVENT_BEAT_COOLTRAINERF_BETH, CooltrainerfBeth1SeenText, CooltrainerfBeth1BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_COOLTRAINERF_BETH
	opentext
	checkevent EVENT_BETH_RARE_CANDY
	iftrue .RematchGift
	checkflag ENGINE_BETH_READY_FOR_REMATCH
	iftrue .WantsBattle
	checkcellnum PHONE_COOLTRAINERF_BETH
	iftrue .NumberAccepted
	checkevent EVENT_BETH_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedAlready
	writetext CooltrainerfBethAfterText
	promptbutton
	setevent EVENT_BETH_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber
	sjump .AskForNumber

.AskedAlready:
	scall .AskNumber
.AskForNumber:
	askforphonenumber PHONE_COOLTRAINERF_BETH
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	gettrainername STRING_BUFFER_3, COOLTRAINERF, BETH1
	scall .RegisteredNumber
	sjump .NumberAccepted

.WantsBattle:
	scall .Rematch
	winlosstext CooltrainerfBeth1BeatenText, 0
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight2
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight1
	loadtrainer COOLTRAINERF, BETH1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_BETH_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer COOLTRAINERF, BETH2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_BETH_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer COOLTRAINERF, BETH3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_BETH_READY_FOR_REMATCH
	opentext
	writetext CooltrainermBethText_GiveRareCandyAfterBattle
	waitbutton
	verbosegiveitem RARE_CANDY
	iffalse .PackFull
	closetext
	end

.RematchGift
	writetext CooltrainermBethText_AgainGiveRareCandyAfterBattle
	waitbutton
	verbosegiveitem RARE_CANDY
	iffalse .PackFull
	clearevent EVENT_BETH_RARE_CANDY
	closetext
	end

.PackFull:
	setevent EVENT_BETH_RARE_CANDY
	jumpstd PackFullFScript
	end

.AskNumber:
	jumpstd AskNumber1FScript
	end

.RegisteredNumber:
	jumpstd RegisteredNumberFScript
	end

.NumberAccepted:
	jumpstd NumberAcceptedFScript
	end

.NumberDeclined:
	jumpstd NumberDeclinedFScript
	end

.Rematch:
	jumpstd RematchFScript
	end

TrainerPsychicRichard:
	trainer PSYCHIC_T, RICHARD, EVENT_BEAT_PSYCHIC_RICHARD, PsychicRichardSeenText, PsychicRichardBeatenText, 0, .Script

.Script:
	opentext
	writetext PsychicRichardAfterBattleText
	waitbutton
	closetext
	end

TrainerFisherScott:
	trainer FISHER, SCOTT, EVENT_BEAT_FISHER_SCOTT, FisherScottSeenText, FisherScottBeatenText, 0, .Script

.Script:
	opentext
	writetext FisherScottAfterBattleText
	waitbutton
	closetext
	end

Route26Sign:
	jumptext Route26SignText

Route26MaxElixer:
	itemball MAX_ELIXER

CooltrainermJakeSeenText:
	text "I'm making my"
	line "final preparations"

	para "for the #MON"
	line "LEAGUE."
	done

CooltrainermJakeBeatenText:
	text "I blew it!"
	done

CooltrainermJakeAfterBattleText:
	text "It's going to be"
	line "tough to win at"
	cont "the LEAGUE."

	para "I need to do some"
	line "more training."

	para "I hear that the"
	line "LEAGUE's ELITE"

	para "FOUR are tougher"
	line "than GYM LEADERS."
	done

CooltrainermGaven3SeenText:
	text "By experiencing"
	line "tough battles, you"
	cont "gain power."
	done

CooltrainermGaven3BeatenText:
	text "Gaah! Life is even"
	line "tougher!"
	done

CooltrainermGavenAfterText:
	text "To get to #MON"
	line "LEAGUE, you have"

	para "to get through"
	line "VICTORY ROAD."

	para "But VICTORY ROAD"
	line "is tough."

	para "Practically nobody"
	line "goes there!"
	done

CooltrainerfJoyceSeenText:
	text "Since you've come"
	line "this far, you must"
	cont "be good."

	para "I'm going to give"
	line "this battle every-"
	cont "thing I've got!"
	done

CooltrainerfJoyceBeatenText:
	text "No! I don't"
	line "believe this!"
	done

CooltrainerfJoyceAfterBattleText:
	text "I've defeated"
	line "eight GYM LEADERS,"

	para "so I was feeling"
	line "confident."

	para "I'll have to try"
	line "harder next time."
	done

CooltrainerfBeth1SeenText:
	text "I lost to a train-"
	line "er named <RIVAL>."

	para "He was really"
	line "strong, but…"

	para "It was as if he"
	line "absolutely had to"
	cont "win at any cost."

	para "I felt sorry for"
	line "his #MON."
	done

CooltrainerfBeth1BeatenText:
	text "#MON aren't"
	line "tools of war."
	done

CooltrainerfBethAfterText:
	text "#MON are in-"
	line "valuable, lifelong"
	cont "partners."
	done

PsychicRichardSeenText:
	text "Wow, look at all"
	line "those BADGES!"
	cont "I'm impressed."

	para "But you're not"
	line "satisfied by just"

	para "collecting them,"
	line "right?"
	done

PsychicRichardBeatenText:
	text "Good battle!"
	done

PsychicRichardAfterBattleText:
	text "People and #MON"
	line "grow from their"
	cont "experiences."

	para "Don't get lazy and"
	line "complacent."
	done

FisherScottSeenText:
	text "I'm feeling great"
	line "today!"

	para "I feel like I"
	line "could boot even"
	cont "the LEAGUE CHAMP!"
	done

FisherScottBeatenText:
	text "No! Not in this"
	line "battle!"
	done

FisherScottAfterBattleText:
	text "Just like in fish-"
	line "ing, it's all over"

	para "in #MON if you"
	line "give up."
	done

Route26SignText:
	text "ROUTE 26"

	para "#MON LEAGUE"
	line "RECEPTION GATE"
	done

CooltrainermGavenText_GiveCrytalAfterBattle:
	text "You beat me again!"
	line "Here's a something"
	cont "for your effort!"
	done


CooltrainermGavenAgainText_GiveCrytalAfterBattle:
	text "Ready to receive"
	line "my gift?"
	done

CooltrainermBethText_GiveRareCandyAfterBattle:
	text "You won when I'm"
	line "this strong?"
	
	para "You deserve this!"
	done


CooltrainermBethText_AgainGiveRareCandyAfterBattle:
	text "You're ready for"
	line "this RARE CANDY?"
	done


Route26BerryTree:
	opentext
	getitemname STRING_BUFFER_3, ICE_BERRY
	writetext Route26BerryTreeText
	promptbutton
	writetext Route26HeyItsBerryApricornText
	promptbutton
	giveitem ICE_BERRY
	iffalse Route26NoRoomInBag
	disappear ROUTE_26_BERRY
	setflag ENGINE_DAILY_ROUTE_1_26_TREES
	writetext Route26FoundItemText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	end

Route26ApricornTree:
	opentext
	getitemname STRING_BUFFER_3, BLU_APRICORN
	writetext Route26BerryTreeText
	promptbutton
	writetext Route26HeyItsBerryApricornText
	promptbutton
	giveitem BLU_APRICORN
	iffalse Route26NoRoomInBag
	disappear ROUTE_26_APRICORN
	setflag ENGINE_DAILY_ROUTE_1_26_TREES
	writetext Route26FoundItemText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	end

Route26NoBerryOrApricorn:
	opentext
	writetext Route26BerryTreeText
	promptbutton
	writetext Route26NothingHereText
	waitbutton
	closetext
	end

Route26NoRoomInBag:
	writetext Route26NoRoomInBagText
	waitbutton
	closetext
	end

Route26BerryTreeText:
	text_far _FruitBearingTreeText
	text_end

Route26NothingHereText:
	text_far _NothingHereText
	text_end

Route26HeyItsBerryApricornText:
	text "Hey! It's a"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done

Route26FoundItemText:
	text_far _ObtainedFruitText
	text_end

Route26NoRoomInBagText:
	text_far _CantCarryItemText
	text_end

Route26_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  7,  5, VICTORY_ROAD_GATE, 3
	warp_event 15, 57, ROUTE_26_HEAL_HOUSE, 1
	warp_event  5, 71, DAY_OF_WEEK_SIBLINGS_HOUSE, 1
	warp_event  0, 76, ROUTE_26_GROTTO, 1
	warp_event  0, 77, ROUTE_26_GROTTO, 2

	def_coord_events

	def_bg_events
	bg_event  8,  6, BGEVENT_READ, Route26Sign
	bg_event 13, 53, BGEVENT_READ, Route26NoBerryOrApricorn
	bg_event 14, 54, BGEVENT_READ, Route26NoBerryOrApricorn

	def_object_events
	object_event 14, 24, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, TrainerCooltrainermJake, -1
	object_event  9, 38, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerCooltrainermGaven3, -1
	object_event 10, 56, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerCooltrainerfJoyce, -1
	object_event  5,  8, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 4, TrainerCooltrainerfBeth1, -1
	object_event 13, 79, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, TrainerPsychicRichard, -1
	object_event 10, 92, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerFisherScott, -1
	object_event  9, 15, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route26MaxElixer, EVENT_ROUTE_26_MAX_ELIXER
	object_event 13, 53, SPRITE_BERRY_YELLOW, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_EMOTE, OBJECTTYPE_SCRIPT, 0, Route26BerryTree, EVENT_ROUTE_26_BERRY
	object_event 14, 54, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route26ApricornTree, EVENT_ROUTE_26_APRICORN
