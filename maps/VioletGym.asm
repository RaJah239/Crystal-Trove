	object_const_def
	const VIOLETGYM_FALKNER
	const VIOLETGYM_YOUNGSTER1
	const VIOLETGYM_YOUNGSTER2
	const VIOLETGYM_GYM_GUIDE

VioletGym_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, ResetVioletGymTrainersCallback

ResetVioletGymTrainersCallback:
	checkevent EVENT_BEAT_FALKNER
	iffalse .ResetTrainers
	endcallback
.ResetTrainers
	clearevent EVENT_BEAT_BIRD_KEEPER_ROD
	clearevent EVENT_BEAT_BIRD_KEEPER_ABE
	endcallback

VioletGymFalknerScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_HM05_FLASH
	iffalse .RookieTrainer
	checkevent EVENT_BEAT_FALKNER
	iftrue .FightDone
	writetext FalknerIntroText
	waitbutton
	closetext
	winlosstext FalknerWinLossText, 0
	loadtrainer FALKNER, FALKNER1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_FALKNER
	opentext
	writetext ReceivedZephyrBadgeText
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_ZEPHYRBADGE
	readvar VAR_BADGES
	scall VioletGymActivateRockets
.FightDone:
	checkevent EVENT_GOT_TM31_MUD_SLAP
	iftrue .SpeechAfterTM
	setmapscene ELMS_LAB, SCENE_ELMSLAB_NOOP
	specialphonecall SPECIALCALL_ASSISTANT
	writetext FalknerZephyrBadgeText
	promptbutton
	verbosegiveitem TM_MUD_SLAP
	setevent EVENT_GOT_TM31_MUD_SLAP
	writetext FalknerTMMudSlapText
	waitbutton
	closetext
	end

.RookieTrainer
	writetext PlayerisaRookie
	waitbutton
	closetext
	end

.SpeechAfterTM:
	checkevent EVENT_REMATCH_FALKNER
	iftrue .OfferInfinityRematch
	checkevent EVENT_BEAT_RED
	iftrue .OfferRematch
	; player hasn't beaten RED yet
	writetext FalknerFightDoneText
	waitbutton
.NoRoomForMudSlap:
	closetext
	end

.OfferInfinityRematch:
	writetext FalknerInfinityRematchText
	yesorno
	iftrue .DoInfinityRematch
	; keep going if false
	
.DontDoInfinityRematch:
	writetext FalknerRematchRefuseText
	waitbutton
	closetext
	end
	
.DoInfinityRematch:
	writetext FalknerRematchAcceptText
	waitbutton
	closetext
	winlosstext FalknerRematchLossText, FalknerRematchWinText
	loadtrainer FALKNER, FALKNER2
	loadvar VAR_BATTLETYPE, BATTLETYPE_CANLOSE
	startbattle
	reloadmap
	iftrue .AfterYourInfinityRematchDefeat
	sjump .AfterInfinityRematchVictorious

.AfterInfinityRematchVictorious:
	opentext
	writetext FalknerInfinityRematchPlayerVictoryText
	waitbutton
	closetext
	sjump .InfinityRematchFinishBattle

.AfterYourInfinityRematchDefeat:
	opentext
	writetext FalknerInfinityRematchPlayerLossText
	waitbutton
	closetext
.InfinityRematchFinishBattle:
	special HealParty
	end

.OfferRematch:
	writetext FalknerRematchText
	yesorno
	iftrue .DoRematch
	; keep going if false
	
.DontDoRematch:
	writetext FalknerRematchRefuseText
	waitbutton
	closetext
	end
	
.DoRematch:
	writetext FalknerRematchAcceptText
	waitbutton
	closetext
	winlosstext FalknerRematchLossText, FalknerRematchWinText
	loadtrainer FALKNER, FALKNER2
	loadvar VAR_BATTLETYPE, BATTLETYPE_CANLOSE
	startbattle
	reloadmap
	iftrue .AfterYourDefeat
	sjump .AfterVictorious

.AfterVictorious:
	opentext
	writetext FalknerRematchPlayerVictoryText
	waitbutton
	closetext
	sjump .FinishBattle

.AfterYourDefeat:
	opentext
	writetext FalknerRematchPlayerLossText
	waitbutton
	closetext
.FinishBattle:
	special HealParty
	setevent EVENT_REMATCH_FALKNER
	end

VioletGymActivateRockets:
	ifequal 7, .RadioTowerRockets
	ifequal 6, .GoldenrodRockets
	end

.GoldenrodRockets:
	jumpstd GoldenrodRocketsScript

.RadioTowerRockets:
	jumpstd RadioTowerRocketsScript

TrainerBirdKeeperRod:
	trainer BIRD_KEEPER, ROD, EVENT_BEAT_BIRD_KEEPER_ROD, BirdKeeperRodSeenText, BirdKeeperRodBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BirdKeeperRodAfterBattleText
	waitbutton
	closetext
	end

TrainerBirdKeeperAbe:
	trainer BIRD_KEEPER, ABE, EVENT_BEAT_BIRD_KEEPER_ABE, BirdKeeperAbeSeenText, BirdKeeperAbeBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BirdKeeperAbeAfterBattleText
	waitbutton
	closetext
	end

VioletGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_FALKNER
	iftrue .VioletGymGuideWinScript
	writetext VioletGymGuideText
	waitbutton
	closetext
	end

.VioletGymGuideWinScript:
	writetext VioletGymGuideWinText
	waitbutton
	closetext
	end

VioletGymStatue:
	checkflag ENGINE_ZEPHYRBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, FALKNER, FALKNER1
	jumpstd GymStatue2Script

PlayerisaRookie:
	text "New trainer right?"

	para "You may not be"
	line "prepared for your"
	cont "first gym match."

	para "North of my gym" 
	line "is SPROUT TOWER."

	para "Visit ELDER LI and"
	line "return after you"

	para "have earned his"
	line "recognition."
	done

FalknerIntroText:
	text "I'm FALKNER, the"
	line "VIOLET #MON GYM"
	cont "leader!"

	para "People say you can"
	line "clip flying-type"

	para "#MON's wings"
	line "with a jolt of"
	cont "electricity…"

	para "I won't allow such"
	line "insults to bird"
	cont "#MON!"

	para "I'll show you the"
	line "real power of the"

	para "magnificent bird"
	line "#MON!"
	done

FalknerWinLossText:
	text "…Darn! My dad's"
	line "cherished bird"
	cont "#MON…"

	para "All right."
	line "Take this."

	para "It's the official"
	line "#MON LEAGUE"
	cont "ZEPHYRBADGE."
	done

ReceivedZephyrBadgeText:
	text "<PLAYER> received"
	line "ZEPHYRBADGE."

	para "TRADED #MON"
	line "OBEDIENCE & LEVEL"
	cont "CAP UPDATE: L26"
	done

FalknerZephyrBadgeText:
	text "It enables"
	line "#MON to use"

	para "FLASH, if they"
	line "have it, anytime."

	para "Here--take this"
	line "too."
	done

FalknerTMMudSlapText:
	text "By using a TM, a"
	line "#MON will"

	para "instantly learn a"
	line "new move."

	para "Think before you"
	line "act--a TM can be"
	cont "used only once."
	done

FalknerFightDoneText:
	text "There are #MON"
	line "GYMS in cities and"
	cont "towns ahead."

	para "You should test"
	line "your skills there."

	para "I'm going to train"
	line "harder to become"

	para "the greatest bird"
	line "#MON master!"
	done

FalknerRematchText:
	text "FALKNER: Congrats"
	line "on becoming champ-"
	cont "ion, <PLAY_G>!"

	para "But you're not the"
	line "only one who's been"
	cont "flying high."
	
	para "I've worked hard"
	line "since our last" 
	cont "battle."
	
	para "Now my #MON are"
	line "in top shape."
	
	para "Up for a rematch?"
	done 

FalknerInfinityRematchText:
	text "Want to take on my"
	line "bird #MON?"
	done

FalknerRematchAcceptText:
	text "I'll show you the"
	line "real power of the"

	para "magnificent bird"
	line "#MON!"
	done 

FalknerRematchRefuseText:
	text "Sure, next time"
	line "then."
	done 
	
FalknerRematchLossText:
	text "I understand…"
	line "I'll bow out…"
	done

FalknerRematchWinText:
	text "This is the power"
	line "of bird #MON!"
	done

FalknerRematchPlayerVictoryText:
	text "FALKNER: What an"
	line "intense battle!"
	
	para "We've fought hard,"
	line "but you've proven"

	para "once again, that"
	line "you're as tough as"
	cont "ever!"
	
	para "Drop by anytime."
	done 

FalknerRematchPlayerLossText:
	text "FALKNER: You're"
	line "quite tough but my"

	para "bird #MON are"
	line "tougher!"

	para "Drop by anytime."
	done

FalknerInfinityRematchPlayerVictoryText:
	text "FALKNER: What an"
	line "intense battle!"

	para "Drop by anytime."
	done

FalknerInfinityRematchPlayerLossText:
	text "FALKNER: My bird"
	line "#MON are tough!"

	para "Drop by anytime."
	done

BirdKeeperRodSeenText:
	text "The keyword is"
	line "guts!"

	para "Those here are"
	line "training night and"

	para "day to become bird"
	line "#MON masters."

	para "Come on!"
	done

BirdKeeperRodBeatenText:
	text "Gaaah!"
	done

BirdKeeperRodAfterBattleText:
	text "FALKNER's skills"
	line "are for real!"

	para "Don't get cocky!"
	done

BirdKeeperAbeSeenText:
	text "Let me see if you"
	line "are good enough to"
	cont "face FALKNER!"
	done

BirdKeeperAbeBeatenText:
	text "This can't be"
	line "true!"
	done

BirdKeeperAbeAfterBattleText:
	text "This is pathetic,"
	line "losing to some"
	cont "rookie trainer…"
	done

VioletGymGuideText:
	text "Hey! I'm no train-"
	line "er but I can give"
	cont "some advice!"

	para "Believe me!"
	line "If you believe, a"

	para "championship dream"
	line "can come true."

	para "You believe?"
	line "Then listen."

	para "The grass-type is"
	line "weak against the"

	para "flying-type. Keep"
	line "this in mind."
	done

VioletGymGuideWinText:
	text "Nice battle! Keep"
	line "it up, and you'll"

	para "be the CHAMP in no"
	line "time at all!"
	done

VioletGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 15, VIOLET_CITY, 2
	warp_event  5, 15, VIOLET_CITY, 2

	def_coord_events

	def_bg_events
	bg_event  3, 13, BGEVENT_READ, VioletGymStatue
	bg_event  6, 13, BGEVENT_READ, VioletGymStatue

	def_object_events
	object_event  5,  1, SPRITE_FALKNER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, VioletGymFalknerScript, -1
	object_event  7,  6, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 2, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerBirdKeeperRod, -1
	object_event  2, 10, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 2, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerBirdKeeperAbe, -1
	object_event  7, 13, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, VioletGymGuideScript, -1
