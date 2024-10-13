	object_const_def
	const SILVERCAVEPOKECENTER1F_NURSE
	const SILVERCAVEPOKECENTER1F_MONEYCOLLECTOR_M
	const SILVERCAVEPOKECENTER1F_MAXIMA
	const SILVERCAVEPOKECENTER1F_CHANSEY

SilverCavePokecenter1F_MapScripts:
	def_scene_scripts
	scene_script SilverCavePokecenter1FScene, SCENE_SILVERCAVEPOKECENTER1F_MAXIMA
	scene_script SilverCavePokecenter1FNoop1, SCENE_SILVERCAVEPOKECENTER1F_NOOP

	def_callbacks

SilverCavePokecenter1FScene:
	sdefer SilverCavePokecenter1MaximaEventScript
       end
SilverCavePokecenter1FNoop1:
       end

SilverCavePokecenter1MaximaEventScript:
	showemote EMOTE_SHOCK, SILVERCAVEPOKECENTER1F_MAXIMA, 15
	turnobject SILVERCAVEPOKECENTER1F_MAXIMA, DOWN
	opentext
	writetext MasterMaximaSpottedText
	waitbutton
	closetext
	applymovement SILVERCAVEPOKECENTER1F_MAXIMA, MasterMaximaWalksToPlayer
	opentext
	writetext MasterMaximaIntroText
    waitbutton
   	closetext
	applymovement SILVERCAVEPOKECENTER1F_MAXIMA, MasterMaximaWalksLeaves
	playsound SFX_ENTER_DOOR
	setscene SCENE_SILVERCAVEPOKECENTER1F_NOOP
	disappear SILVERCAVEPOKECENTER1F_MAXIMA
	setevent EVENT_MET_SILVERCAVEPOKECENTER1F_MAXIMA
	clearevent EVENT_MAXIMA_APPEAR_MT_SILVER_OUTSIDE
	end

MasterMaximaWalksToPlayer:
	step RIGHT
	step DOWN
	step_end

MasterMaximaWalksLeaves:
	step RIGHT
	step DOWN
	step_end

MasterMaximaSpottedText:
	text "Wow, this is rare."
	done

MasterMaximaIntroText:
    text "Why hello there."
	line "I'm MAXIMA."

	para "…"
	
	para "Hm… So you're"
	line "<PLAY_G> you say?"

	para "Delighted to make"
	line "your acquaintance!"

	para "Sorry. I may have"
	line "startled you."

	para "You've certainly"
	line "made if far."
	
	para "I commend you."

	para "I didn't think any-"
	line "one would be here."

	para "I was visiting my"
	line "pal, VICTOR here."

	para "He helps trainers'"
	line "get their #MON"
	cont "to their peak."

	para "I'm sure he'd be"
	line "delighted to meet"
	cont "you."

	para "Say <PLAY_G>…"

	para "Let's have a"
	line "#MON battle!"

	para "Oh? I see."
	
	para "So you're on a"
	line "mission to climb"
	cont "MT.SIVLER you say?"
	
	para "I won't get in your"
	line "way."
	
	para "But, after you're"
	line "done, return and"

	para "let's have one of"
	line "many magnificent"
	cont "battles!"
	
	para "I'll be outside"
	line "meantime."

	para "Bye for now."
	done

SilverCavePokecenter1FNurseScript:
	jumpstd PokecenterNurseScript

SilverCavePokecenter1FMoneyCollectorMScript:
	faceplayer
	opentext
	checkevent SILVERCAVEPOKECENTER1F_MONEYCOLLECTORM
	iftrue .GiveMeAllYourMoney
	writetext MoneyCollectorIntroText
	setevent SILVERCAVEPOKECENTER1F_MONEYCOLLECTORM
	waitbutton
.GiveMeAllYourMoney
	writetext UpForAGoodDealText
	special PlaceMoneyTopRight
	yesorno
	iffalse .Refused
	checkmoney YOUR_MONEY, 999999
	ifequal HAVE_LESS, .MoneyNotAtMax
	writetext ReceivedTrainingKit
	playsound SFX_1ST_PLACE
	pause 100
	waitbutton
	giveitem RARE_CANDY_XC
	giveitem RARE_CANDY, 10
	giveitem HP_UP, 63
	giveitem PROTEIN, 63
	giveitem IRON, 63
	giveitem CALCIUM, 63
	giveitem ZINC, 63
	giveitem CARBOS, 63
	iffalse .NoRoom
	ifequal TRUE, .FinishTransaction
	closetext
	end

.NoRoom:
	writetext MoneyCollectorMNoRoomText
	waitbutton
	closetext
	end

.FinishTransaction:
	takemoney YOUR_MONEY, 999999
	waitsfx
	playsound SFX_TRANSACTION
	special PlaceMoneyTopRight
	writetext ThanksFortheMoneyText
	waitbutton
	closetext
	end 

.Refused:
	writetext DropByAnyTimeText
	waitbutton
	closetext
	end

.MoneyNotAtMax:
	writetext YouNeedToMaxOutYourMoneyText
	waitbutton
	closetext
	end

MoneyCollectorIntroText:
	text "Hello. I'm VICTOR."

	para "<PLAY_G> right?"

	para "Nice to meet you!"

	para "You've been making"
	line "the rounds every-"
	cont "where!"

	para "Your reputation is"
	line "prestigious!"

	para "Making it to this"
	line "point and training"

	para "a new #MON can"
	line "be quite tedious…"

	para "I can help -- but"
	line "for a steep fee!"

	para "For a grand total"
	line "of ¥999,999, you'll"

	para "receive a complete"
	line "TRAINING KIT!"

	para "It consists of 8"
	line "different items,"

	para "when all used on a"
	line "single #MON has"

	para "it reach its max-"
	line "imum potential!"
	
	para "The items are:"

	para "1 x XC CANDY"
	line "10x RARE CANDY"

	para "63x HP UP"
	line "63x PROTEIN"

	para "63x IRON"
	line "63x CALCIUM"

	para "63x ZINC and"
	line "63x CARBOS."

	para "So, you need to"
	line "have space for"
	cont "them all."
	done

UpForAGoodDealText:
	text "VICTOR: Want one"
	line "TRAINING KIT for"
	cont "¥999,999 <PLAY_G>?"
	done

MoneyCollectorMNoRoomText:
	text "You don't seem to"
	line "enough room."

	para "Recall, these are"
	line "the items you need"
	cont "to have space for:"

	para "1 x XC CANDY"
	line "10x RARE CANDY"

	para "63x HP UP"
	line "63x PROTEIN"

	para "63x IRON"
	line "63x CALCIUM"

	para "63x ZINC and"
	line "63x CARBOS."
	done

DropByAnyTimeText:
	text "VICTOR: Drop by"
	line "anytime."
	done

ReceivedTrainingKit:
	text "<PLAY_G> received"
	line "TRAINING KIT!"
	done

ThanksFortheMoneyText:
	text "I know you'll make"
	line "make the most of"
	cont "these items."
	
	para "Drop by anytime!"
	done

YouNeedToMaxOutYourMoneyText:
	text "You're a bit short"
	line "on money…"

	para "My sister, VIOLET,"
	line "is at the INDIGO"
	cont "PLATEAU."

	para "She collects GAME"
	line "CORNER coins."

	para "She'll trade you"
	line "coins for a number"
	cont "of NUGGETS which"
	cont "can be sold off."

	para "Until next time…"
	line "All the best!"
	done

SilverCavePokecenterChanseyScript:
	jumpstd ChanseyPokeCenterScript

SilverCavePokecenter1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, SILVER_CAVE_OUTSIDE, 1
	warp_event  4,  7, SILVER_CAVE_OUTSIDE, 1
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SilverCavePokecenter1FNurseScript, -1
	object_event  1,  5, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 2, 1, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, SilverCavePokecenter1FMoneyCollectorMScript, -1
	object_event  2,  5, SPRITE_MAXIMA, SPRITEMOVEDATA_STANDING_LEFT, 2, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SilverCavePokecenter1MaximaEventScript, EVENT_MET_SILVERCAVEPOKECENTER1F_MAXIMA
	object_event  4,  1, SPRITE_CHANSEY_OW, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SilverCavePokecenterChanseyScript, -1
