	object_const_def
	const ECRUTEAKGYM_MORTY
	const ECRUTEAKGYM_SAGE1
	const ECRUTEAKGYM_SAGE2
	const ECRUTEAKGYM_GRANNY1
	const ECRUTEAKGYM_GRANNY2
	const ECRUTEAKGYM_GYM_GUIDE
	const ECRUTEAKGYM_GRAMPS

EcruteakGym_MapScripts:
	def_scene_scripts
	scene_script EcruteakGymForcedToLeaveScene, SCENE_ECRUTEAKGYM_FORCED_TO_LEAVE
	scene_script EcruteakGymNoopScene,          SCENE_ECRUTEAKGYM_NOOP

	def_callbacks
    callback MAPCALLBACK_NEWMAP, ResetEcruteakGymTrainersCallback

ResetEcruteakGymTrainersCallback:
    checkevent EVENT_BEAT_MORTY
    iffalse .ResetTrainers
    endcallback
.ResetTrainers
	clearevent EVENT_BEAT_SAGE_JEFFREY
	clearevent EVENT_BEAT_SAGE_PING
	clearevent EVENT_BEAT_MEDIUM_MARTHA
	clearevent EVENT_BEAT_MEDIUM_GRACE
    endcallback

EcruteakGymForcedToLeaveScene:
	sdefer EcruteakGymClosed
	end

EcruteakGymNoopScene:
	end

EcruteakGymMortyScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_MORTY
	iftrue .FightDone
	writetext MortyIntroText
	waitbutton
	closetext
	winlosstext MortyWinLossText, 0
	loadtrainer MORTY, MORTY1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_MORTY
	opentext
	writetext Text_ReceivedFogBadge
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_FOGBADGE
	readvar VAR_BADGES
	scall EcruteakGymActivateRockets
	setmapscene ECRUTEAK_TIN_TOWER_ENTRANCE, SCENE_ECRUTEAKTINTOWERENTRANCE_NOOP
	setevent EVENT_RANG_CLEAR_BELL_1
	setevent EVENT_RANG_CLEAR_BELL_2
.FightDone:
	checkevent EVENT_GOT_TM30_SHADOW_BALL
	iftrue .GotShadowBall
	setevent EVENT_BEAT_SAGE_JEFFREY
	setevent EVENT_BEAT_SAGE_PING
	setevent EVENT_BEAT_MEDIUM_MARTHA
	setevent EVENT_BEAT_MEDIUM_GRACE
	writetext MortyText_FogBadgeSpeech
	promptbutton
	verbosegiveitem TM_SHADOW_BALL
	iffalse .NoRoomForShadowBall
	setevent EVENT_GOT_TM30_SHADOW_BALL
	writetext MortyText_ShadowBallSpeech
	waitbutton
	closetext
	end

.GotShadowBall:
    checkevent EVENT_BEAT_RED
    iftrue .OfferRematch
; player hasn't beaten RED yet
	writetext MortyFightDoneText
	waitbutton
.NoRoomForShadowBall:
	closetext
	end

.OfferRematch:
    writetext MortyRematchText
    yesorno
    iftrue .DoRematch
    ; keep going if false
	
.DontDoRematch:
    writetext MortyRematchRefuseText
    waitbutton
    closetext
    end

.DoRematch:
    writetext MortyRematchAcceptText
    waitbutton
    closetext
    winlosstext MortyRematchLossText, 0
    loadtrainer MORTY, MORTY2
    startbattle
    reloadmapafterbattle
    setevent EVENT_BEAT_MORTY
    opentext
    writetext MortyRematchAfterText
    waitbutton
    closetext
    end

EcruteakGymActivateRockets:
	ifequal 7, .RadioTowerRockets
	ifequal 6, .GoldenrodRockets
	end

.GoldenrodRockets:
	jumpstd GoldenrodRocketsScript

.RadioTowerRockets:
	jumpstd RadioTowerRocketsScript

EcruteakGymClosed:
	applymovement PLAYER, EcruteakGymPlayerStepUpMovement
	applymovement ECRUTEAKGYM_GRAMPS, EcruteakGymGrampsSlowStepDownMovement
	opentext
	writetext EcruteakGymClosedText
	waitbutton
	closetext
	follow PLAYER, ECRUTEAKGYM_GRAMPS
	applymovement PLAYER, EcruteakGymPlayerSlowStepDownMovement
	stopfollow
	special FadeOutToWhite
	playsound SFX_ENTER_DOOR
	waitsfx
	warp ECRUTEAK_CITY, 6, 27
	end

TrainerSageJeffrey:
	trainer SAGE, JEFFREY, EVENT_BEAT_SAGE_JEFFREY, SageJeffreySeenText, SageJeffreyBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SageJeffreyAfterBattleText
	waitbutton
	closetext
	end

TrainerSagePing:
	trainer SAGE, PING, EVENT_BEAT_SAGE_PING, SagePingSeenText, SagePingBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SagePingAfterBattleText
	waitbutton
	closetext
	end

TrainerMediumMartha:
	trainer MEDIUM, MARTHA, EVENT_BEAT_MEDIUM_MARTHA, MediumMarthaSeenText, MediumMarthaBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext MediumMarthaAfterBattleText
	waitbutton
	closetext
	end

TrainerMediumGrace:
	trainer MEDIUM, GRACE, EVENT_BEAT_MEDIUM_GRACE, MediumGraceSeenText, MediumGraceBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext MediumGraceAfterBattleText
	waitbutton
	closetext
	end

EcruteakGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_MORTY
	iftrue .EcruteakGymGuideWinScript
	writetext EcruteakGymGuideText
	waitbutton
	closetext
	end

.EcruteakGymGuideWinScript:
	writetext EcruteakGymGuideWinText
	waitbutton
	closetext
	end

EcruteakGymStatue:
	checkflag ENGINE_FOGBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, MORTY, MORTY1
	jumpstd GymStatue2Script

EcruteakGymPlayerStepUpMovement:
	step UP
	step_end

EcruteakGymPlayerSlowStepDownMovement:
	fix_facing
	slow_step DOWN
	remove_fixed_facing
	step_end

EcruteakGymGrampsSlowStepDownMovement:
	slow_step DOWN
	step_end

MortyIntroText:
	text "Good of you to"
	line "have come."

	para "Here in ECRUTEAK,"
	line "#MON have been"
	cont "revered."

	para "It's said that a"
	line "rainbow-colored"
	cont "#MON will come"
	cont "down to appear"
	cont "before a truly"
	cont "powerful trainer."

	para "I believed that"
	line "tale, so I have"
	cont "secretly trained"
	cont "here all my life."

	para "As a result, I can"
	line "now see what"
	cont "others cannot."

	para "Just a bit more…"

	para "With a little"
	line "more, I could see"
	cont "a future in which"
	cont "I meet the #MON"
	cont "of rainbow colors."

	para "You're going to"
	line "help me reach that"
	cont "level!"
	done

MortyWinLossText:
	text "I'm not good"
	line "enough yet…"

	para "All right. This"
	line "BADGE is yours."
	done

Text_ReceivedFogBadge:
	text "<PLAYER> received"
	line "FOGBADGE."

	para "TRADED #MON"
	line "OBEDIENCE & LEVEL"
	cont "CAP UPDATE: L50"
	done

MortyText_FogBadgeSpeech:
	text "FOGBADGE enables"
	line "#MON that can"
	cont "learn SURF to tra-"
	cont "verse water out-"
	cont "side of battles."

	para "I want you to have"
	line "this too."
	done

MortyText_ShadowBallSpeech:
	text "It's SHADOW BALL."
	line "It causes damage"
	cont "and may reduce"
	cont "SPCL.DEF."

	para "Use it if it"
	line "appeals to you."
	done

MortyFightDoneText:
	text "I see…"

	para "Your journey has"
	line "taken you to far-"
	cont "away places."

	para "And you have wit-"
	line "nessed much more"
	cont "than I."

	para "I envy you for"
	line "that…"
	done

MortyRematchText:
    text "MORTY: <PLAY_G>, I"
	line "sense your growth."
    
	para "I aim to match"
	line "HO-OH's virtue."
	
	para "And another bout"
	line "between us would"
	cont "beneficial!"
	
	para "Help me push my"
	line "training to the"
	cont "next level!"
	done 
	
MortyRematchAcceptText:
    text "Now witness my"
	line "evolution!"
	done 

MortyRematchRefuseText:
    text "Oh… perhaps"
	line "another time?"
	done 
	
MortyRematchLossText:
    text "How is this"
	line "possible…"
	done
	
MortyRematchAfterText:
    text "MORTY: Lost again…"
	line "Maybe you've got"

	para "more than just"
	line "mere strength."
	done

SageJeffreySeenText:
	text "I spent the spring"
	line "with my #MON."

	para "Then summer, fall"
	line "and winter…"

	para "Then spring came"
	line "again. We have"

	para "lived together"
	line "for a long time."
	done

SageJeffreyBeatenText:
	text "Wins and losses, I"
	line "experienced both."
	done

SageJeffreyAfterBattleText:
	text "Where did #MON"
	line "come from?"
	done

SagePingSeenText:
	text "Can you inflict"
	line "any damage on our"
	cont "#MON?"
	done

SagePingBeatenText:
	text "Ah! Well done!"
	done

SagePingAfterBattleText:
	text "We use only ghost-"
	line "type #MON."

	para "No normal-type"
	line "attack can harm"
	cont "them!"
	done

MediumMarthaSeenText:
	text "I shall win!"
	done

MediumMarthaBeatenText:
	text "I, I, I lost!"
	done

MediumMarthaAfterBattleText:
	text "The one who wants"
	line "to win most--will!"
	done

MediumGraceSeenText:
	text "Stumped by our in-"
	line "visible floor?"

	para "Defeat me if you"
	line "want a hint!"
	done

MediumGraceBeatenText:
	text "Wha-what?"
	done

MediumGraceAfterBattleText:
	text "Fine. I shall tell"
	line "you the secret of"

	para "the invisible"
	line "floor."

	para "The path is right"
	line "before our eyes!"
	done

EcruteakGymGuideText:
	text "The trainers here"
	line "have secret mo-"
	cont "tives."

	para "If you win, they"
	line "may tell you some"

	para "deep secrets about"
	line "ECRUTEAK."
	done

EcruteakGymGuideWinText:
	text "Whew, <PLAYER>."
	line "You did great!"

	para "I was cowering in"
	line "the corner out of"
	cont "pure terror!"
	done

EcruteakGymClosedText:
	text "MORTY, the GYM"
	line "LEADER, is absent."

	para "Sorry, but you'll"
	line "have to leave."

	para "Hohohoho."
	done

EcruteakGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 17, ECRUTEAK_CITY, 10
	warp_event  5, 17, ECRUTEAK_CITY, 10
	warp_event  4, 14, ECRUTEAK_GYM, 4
	warp_event  2,  4, ECRUTEAK_GYM, 3
	warp_event  3,  4, ECRUTEAK_GYM, 3
	warp_event  4,  4, ECRUTEAK_GYM, 3
	warp_event  4,  5, ECRUTEAK_GYM, 3
	warp_event  6,  7, ECRUTEAK_GYM, 3
	warp_event  7,  4, ECRUTEAK_GYM, 3
	warp_event  2,  6, ECRUTEAK_GYM, 3
	warp_event  3,  6, ECRUTEAK_GYM, 3
	warp_event  4,  6, ECRUTEAK_GYM, 3
	warp_event  5,  6, ECRUTEAK_GYM, 3
	warp_event  7,  6, ECRUTEAK_GYM, 3
	warp_event  7,  7, ECRUTEAK_GYM, 3
	warp_event  4,  8, ECRUTEAK_GYM, 3
	warp_event  5,  8, ECRUTEAK_GYM, 3
	warp_event  6,  8, ECRUTEAK_GYM, 3
	warp_event  7,  8, ECRUTEAK_GYM, 3
	warp_event  2,  8, ECRUTEAK_GYM, 3
	warp_event  2,  9, ECRUTEAK_GYM, 3
	warp_event  2, 10, ECRUTEAK_GYM, 3
	warp_event  2, 11, ECRUTEAK_GYM, 3
	warp_event  4, 10, ECRUTEAK_GYM, 3
	warp_event  5, 10, ECRUTEAK_GYM, 3
	warp_event  2, 12, ECRUTEAK_GYM, 3
	warp_event  3, 12, ECRUTEAK_GYM, 3
	warp_event  4, 12, ECRUTEAK_GYM, 3
	warp_event  5, 12, ECRUTEAK_GYM, 3
	warp_event  7, 10, ECRUTEAK_GYM, 3
	warp_event  7, 11, ECRUTEAK_GYM, 3
	warp_event  7, 12, ECRUTEAK_GYM, 3
	warp_event  7, 13, ECRUTEAK_GYM, 3

	def_coord_events

	def_bg_events
	bg_event  3, 15, BGEVENT_READ, EcruteakGymStatue
	bg_event  6, 15, BGEVENT_READ, EcruteakGymStatue

	def_object_events
	object_event  5,  1, SPRITE_MORTY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, EcruteakGymMortyScript, -1
	object_event  2,  7, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerSageJeffrey, -1
	object_event  3, 13, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerSagePing, -1
	object_event  7,  5, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 1, TrainerMediumMartha, -1
	object_event  7,  9, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 1, TrainerMediumGrace, -1
	object_event  7, 15, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, EcruteakGymGuideScript, -1
	object_event  4, 14, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_ECRUTEAK_GYM_GRAMPS
